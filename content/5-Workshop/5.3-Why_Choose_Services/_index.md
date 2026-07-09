---
title: "Why Choose These Services?"
date: 2026-07-09
weight: 3
chapter: false
pre: " <b> 5.3. </b> "
---

### Why Choose These Services for the Project?

The architecture model was selected based on four key criteria: **low cost**, **deployment simplicity**, **utilization of Managed/Serverless services**, and **high scalability**.

---

#### 1. Cost Efficiency
Services such as Lambda, S3, SQS, DynamoDB, API Gateway, CloudFront, and SES align perfectly with the pay-as-you-go model. The system does not require renting servers running continuously, keeping the initial cost extremely low and ideal for student projects.

*Example:* When user traffic is low, Lambda only incurs costs per request, SQS charges per message, DynamoDB charges based on storage and read/write capacity, and S3 charges by data size. This makes the system significantly cheaper than running a 24/7 EC2 instance.

---

#### 2. Simplicity and Serverless Architecture
The project leverages a serverless architecture to minimize operational overhead. Instead of manually provisioning servers, installing runtimes, managing scaling, updating operating systems, and monitoring resources, the core components are deployed using serverless services:
*   **AWS Lambda:** Executes backend logic.
*   **Amazon API Gateway:** Exposes API endpoints.
*   **Amazon S3:** Stores raw data and hosts the static frontend.
*   **Amazon SQS:** Handles asynchronous message queuing.
*   **Amazon DynamoDB:** Stores analysis reports and results.

Consequently, the team can focus entirely on the core business logic: fetching stock data, calculating technical indicators, invoking Amazon Bedrock, and building the trader approval workflow.

---

#### 3. Managed Services
Most services in the model are managed services, meaning AWS takes responsibility for operating the underlying infrastructure. This increases system stability and reduces operational risks.

Specifically:
*   **Amazon Bedrock:** Integrates AI reasoning without having to deploy and optimize machine learning models.
*   **Amazon DynamoDB:** Provides high-performance NoSQL database storage without database server administration.
*   **Amazon SQS:** Decouples system processes without the need to build and maintain message queues.
*   **Amazon SES:** Sends reliable email notifications without configuring mail servers.
*   **AWS KMS:** Manages data encryption keys without designing custom encryption mechanisms.

---

#### 4. Scalability
The architecture scales seamlessly because components are decoupled by task. As the number of monitored stocks or users increases, the system can scale components independently without impacting the overall design.

*Example:*
*   If many users send requests simultaneously, API Gateway and Lambda automatically scale to handle concurrent requests.
*   If data volume spikes, SQS buffers messages for the Processing Lambda to consume gradually, preventing system overload.
*   If more reports need to be saved, DynamoDB and S3 scale automatically to handle the storage and throughput.
*   If dashboard traffic increases, CloudFront caches and delivers the frontend faster, reducing S3 load.
*   If security needs to be tightened, AWS WAF rules can be dynamically added to block malicious requests in real-time.

---

### Future Enhancements

1.  **Expand Data Sources:** Currently, the system only relies on Yahoo Finance. Future iterations can integrate additional financial data APIs to cross-reference prices, increase reliability, and support near real-time data.
2.  **Enhance AI Analysis Model:** Amazon Bedrock currently analyzes basic technical indicators. Future upgrades can incorporate advanced indicators such as Bollinger Bands, Stochastic, ADX, or ATR to provide richer context to the AI for more accurate recommendations.
3.  **Real-Time Alerts:** Implement automatic alerting features that notify traders or clients via email/Telegram when a stock price crosses a set threshold, RSI hits overbought/oversold regions, or MACD crossovers occur.
4.  **Refine User Management:** Implement fine-grained access control (RBAC) separating roles for **Admins** (system administration), **Traders** (reviewing and approving AI recommendations), and **Customers** (receiving final reports or viewing recommendation history).
5.  **Tighten Security:** Implement advanced security layers such as CloudWatch Alarms, advanced AWS WAF rules, IP rate-limiting, and comprehensive audit logs using AWS CloudTrail.
6.  **Optimize Cost and Performance:** Monitor resource spending via AWS Cost Explorer, optimize prompt sizing to minimize input tokens sent to Bedrock, cache frequently requested stock data, and fine-tune Lambda RAM and Timeout settings.
7.  **Upgrade Dashboard UI:** Enhance the dashboard with interactive charting libraries (such as TradingView Charts), stock symbol filtering, approval status, confidence scores, and historical analysis logs.
8.  **Implement CI/CD:** Establish a CI/CD pipeline using GitHub Actions or AWS CodePipeline to automate frontend and backend building, testing, and deployment.
9.  **Enhance Scalability:** Optimize batch processing logic, increase concurrent execution limits for Lambda, configure Dead-Letter Queue (DLQ) handling, and define clear Retry Policies.
10. **Recommendation Accuracy Evaluation:** Record the actual market performance of recommended stocks after set periods (e.g., 1 day, 1 week) to evaluate AI recommendation accuracy, using this feedback loop to refine prompt templates and confidence scoring.