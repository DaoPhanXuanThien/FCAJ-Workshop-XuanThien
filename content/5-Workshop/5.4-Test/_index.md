---
title: "Testing & Verification"
date: 2026-07-09
weight: 4
chapter: false
pre: " <b> 5.4. </b> "
---

### System Testing and Result Verification

After deploying the serverless infrastructure and database, we perform functional testing to verify the end-to-end data flow from the client interface to the backend processing services.

---

#### 1. Authentication via Amazon Cognito
Access the system Dashboard. The login interface is integrated with Amazon Cognito User Pool to handle user authentication.

![Cognito Login UI](/images/5-Workshop/5.4-Test/image1.png)

*Observation:* Since the trader's account was previously created in the User Pool, the login process is direct and secure.

---

#### 2. Financial Management Dashboard
Upon successful login, the Dashboard displays the list of monitored stock symbols. Initially, the Dashboard only shows seed data (e.g., the `FPT` symbol).

![Initial Dashboard](/images/5-Workshop/5.4-Test/image2.png)

---

#### 3. Analyzing a New Stock Symbol
To trigger analysis, the trader selects the desired stock ticker (e.g., `VNM` - Vinamilk) from the dashboard control and clicks the **Phân tích (Analyze)** button.

![Selecting stock symbol VNM](/images/5-Workshop/5.4-Test/image3.png)

---

#### 4. Backend Asynchronous Processing
When clicking **Analyze**, the system triggers the following asynchronous flow:
1.  **API Gateway** receives the client request and invokes the **Ingestion Lambda**.
2.  **Ingestion Lambda** calls the Yahoo Finance API to fetch historical and current stock data for `VNM`.
3.  The raw data is stored as a JSON object in **Amazon S3**.
4.  S3 fires an Event Notification that pushes a message into the **Amazon SQS Queue**.
5.  **Processing Lambda** is triggered by the SQS queue, polls the message, reads the raw data from S3, and computes technical indicators (RSI, MACD, MA20, MA50, Volume).

*   **SQS Queue status during processing:**
    
    ![SQS Queue status](/images/5-Workshop/5.4-Test/image4.png)
    
    ![SQS Queue Details](/images/5-Workshop/5.4-Test/image5.png)

*After the Processing Lambda finishes processing:* The number of messages in the SQS queue drops to 0 (as shown below), indicating successful message consumption.

![SQS Queue empty after processing](/images/5-Workshop/5.4-Test/image6.png)

---

#### 5. Storing Analysis Results in Amazon DynamoDB
After calculating the technical indicators and calling the GenAI model for recommendations, the final output is written to the DynamoDB table `Stock_reports_1`.

![DynamoDB database record](/images/5-Workshop/5.4-Test/image7.png)

---

#### 6. Displaying Analysis Reports on the Dashboard
Returning to the Dashboard, the analysis for `VNM` appears along with detailed technical indicators.

![Dashboard displaying VNM](/images/5-Workshop/5.4-Test/image8.png)
*(Image displays a list of 3 stock symbols successfully analyzed on the Dashboard)*

![Dashboard details](/images/5-Workshop/5.4-Test/image9.png)

---

#### 7. Checking System Logs in Amazon CloudWatch
Navigate to Amazon CloudWatch Logs to inspect the detailed execution logs of the Processing Lambda and troubleshoot errors.

![CloudWatch logs screen](/images/5-Workshop/5.4-Test/image10.png)

Logs indicate that the execution completed successfully, matching the predefined business logic.

![Detailed execution logs](/images/5-Workshop/5.4-Test/image11.png)

---

#### 8. Bedrock Token Quota Limit Exceeded Error
During testing, the system logged an error from Amazon Bedrock: **"Too many tokens per day, please try again."** (Token limit exceeded for the day).

![Bedrock quota limit error](/images/5-Workshop/5.4-Test/image12.png)

*   **Cause:** Default AWS account limits applied to the Claude model.
*   **Consequence:** When encountering this error, the system triggers a fallback mechanism, assigning a default confidence score of `68` (which is below the threshold of `75` required for automatic distribution) to prevent system crashes.
    
    ![Fallback data in DynamoDB](/images/5-Workshop/5.4-Test/image13.png)

*   **Resolution:** Submit a Request Quota to increase limits for Claude 3.5 Sonnet v2 via the Amazon Bedrock console.
    
    ![Request Quota console interface](/images/5-Workshop/5.4-Test/image14.png)

---

#### 9. Human-in-the-Loop Review
Once the Bedrock quota issue is resolved, Claude successfully returns analysis with higher confidence scores. Reports with clear signals like **STRONG BUY** or **STRONG SELL** are audited by the trader on the Dashboard before they click the button to send the final recommendation report to the client's email.

![Dashboard after quota increase](/images/5-Workshop/5.4-Test/image15.png)

![Trader approval interface](/images/5-Workshop/5.4-Test/image16.png)
