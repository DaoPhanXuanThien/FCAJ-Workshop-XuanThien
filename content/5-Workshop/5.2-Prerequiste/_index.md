---
title: "Prerequisites"
date: 2026-07-09
weight: 2
chapter: false
pre: " <b> 5.2. </b> "
---

### Prerequisites and Infrastructure Deployment

To deploy the **Stock Alerts System** project, we need to prepare and configure the AWS services according to the steps below.

---

#### 1. AWS Account & Architecture Diagram

*   **AWS Account:** Use an AWS account (e.g. AWS Free Tier) to manage and provision resources.
    
    ![AWS Account](/images/5-Workshop/5.2-Prerequiste/image1.png)

*   **Architecture Diagram:** System component connections.
    
    ![Architecture Diagram](/images/5-Workshop/5.2-Prerequiste/image2.png)

---

#### 2. Service Deployment Process

##### A. Yahoo Finance API Integration
Yahoo Finance is the primary market data source for the system. The system uses Yahoo Finance to fetch stock price data such as open, high, low, close, trading volume, and historical prices across different time frames.

##### B. Backend Deployment (Compute & Storage)

*   **Amazon S3 (Raw Data Storage):** Create an S3 Bucket named `production-stock-raw-data-finance`.
    
    Amazon S3 is used to store raw data fetched from Yahoo Finance. Storing raw data allows the system to audit input data, reprocess it if necessary, and separate the data ingestion step from the analysis step.
    
    ![Create S3 Bucket](/images/5-Workshop/5.2-Prerequiste/image3.png)

*   **Amazon SQS (Message Queues):** Create two queues: `stock-processing-dlq` (Dead-Letter Queue) and `stock-processing-queue`.
    
    Amazon SQS acts as a message queue buffer between the Ingestion Lambda and the Processing Lambda. SQS enables asynchronous processing, preventing the ingestion Lambda from having to wait for the analysis to complete. When new data is available, a message is sent to SQS for the Processing Lambda to consume.
    
    ![Create SQS Queue](/images/5-Workshop/5.2-Prerequiste/image4.png)
    
    ![SQS Queue List](/images/5-Workshop/5.2-Prerequiste/image5.png)

*   **AWS Lambda (Serverless Compute):** Create 2 Lambda functions with the `Node.js 22.x` runtime:
    *   `Ingestion-Lambda`: Responsible for receiving stock analysis requests from the API Gateway, calling Yahoo Finance to fetch market data, normalizing it, and storing raw data in S3. It then sends a message to SQS to trigger the next step.
    *   `Processing-Lambda`: The core processing component. It reads data from S3 via the SQS message, calculates technical indicators like RSI, MACD, MA20, MA50, and Volume. It then sends the calculated metrics to Amazon Bedrock for AI analysis and recommendations.
    
    ![Configure Lambda Functions](/images/5-Workshop/5.2-Prerequiste/image6.png)

*   **AWS IAM Role (Access Management):** Configure appropriate IAM Roles to grant Lambda functions permission to access S3, SQS, Bedrock, DynamoDB, and KMS.
    
    ![IAM Role](/images/5-Workshop/5.2-Prerequiste/image7.png)
    
    ![IAM Policy Document](/images/5-Workshop/5.2-Prerequiste/image8.png)
    
    ![IAM Role List](/images/5-Workshop/5.2-Prerequiste/image9.png)

---

##### C. Database Deployment

*   **AWS KMS (Key Management Service):** Create a KMS key to encrypt sensitive data.
    
    AWS KMS is used to encrypt data stored in DynamoDB. Analysis data and related information are protected at rest, enhancing system security.
    
    ![Create KMS Key](/images/5-Workshop/5.2-Prerequiste/image10.png)

*   **Amazon DynamoDB:** Create a table named `Stock_reports_1` using Partition Key (PK) and Sort Key (SK).
    
    DynamoDB stores the final analysis results, including stock ticker, timeframe, technical indicators, AI recommendations, confidence score, analysis rationale, and trader approval status. The Dashboard queries this table to display reports to users.
    
    ![Configure DynamoDB Table](/images/5-Workshop/5.2-Prerequiste/image11.png)
    
    *   **Secure DynamoDB Table with AWS KMS:**
        
        ![DynamoDB Encryption with KMS](/images/5-Workshop/5.2-Prerequiste/image12.png)

---

##### D. Frontend & Security Deployment

*   **Amazon S3 (Frontend Hosting):** Create an S3 Bucket named `stock-frontend-finance` and configure Static Website Hosting.
    
    In addition to storing raw backend data, Amazon S3 hosts the Web interface assets. HTML, CSS, JavaScript, and other static resources are stored in S3 and distributed via CloudFront. This approach reduces operating costs, eliminates web server management, and simplifies UI updates.
    
    ![Create S3 Frontend Bucket](/images/5-Workshop/5.2-Prerequiste/image13.png)

*   **Amazon CloudFront & AWS WAF (Distribution & Firewall):**
    *   **Amazon CloudFront:** A CDN (Content Delivery Network) service used to distribute the system's Web interface to users. CloudFront caches static content at Edge Locations near users, reducing latency and S3 load. It also supports HTTPS and integrates with AWS WAF.
    *   **AWS WAF:** Deployed in front of CloudFront to protect the Web application from common Internet attacks. WAF allows creating rules to filter and block malicious requests like SQL Injection, Cross-Site Scripting (XSS), bots, or anomalous request rates.
    
    ![Configure CloudFront Distribution](/images/5-Workshop/5.2-Prerequiste/image14.png)
    
    ![AWS WAF Integration Web ACL](/images/5-Workshop/5.2-Prerequiste/image15.png)
    
    ![Configure CloudFront Origins](/images/5-Workshop/5.2-Prerequiste/image16.png)

*   **Amazon Cognito (User Authentication):** Create a User Pool for account management.
    
    Amazon Cognito authenticates users logging into the system. Only authorized users like traders or admins can access the Dashboard, view analysis reports, and approve or reject recommendations.
    
    ![Create Cognito User Pool](/images/5-Workshop/5.2-Prerequiste/image17.png)
    
    *   **Cognito Login UI:**
        
        ![Cognito Login UI](/images/5-Workshop/5.2-Prerequiste/image18.png)

---

##### E. API Gateway & AI Services

*   **Amazon API Gateway:** Create a REST API named `Ingestion-lambda_API`.
    
    API Gateway acts as the entry point between the Frontend and Backend. When users interact with the Dashboard, requests are sent to API Gateway, which routes them to the corresponding Lambda functions.
    
    ![Create API Gateway](/images/5-Workshop/5.2-Prerequiste/image19.png)
    
    *   **Configure Resources & Methods:**
        
        ![Configure API Gateway Resources](/images/5-Workshop/5.2-Prerequiste/image20.png)

*   **Amazon Bedrock (AI Reasoning Engine):** Request model access and request quota.
    
    Amazon Bedrock is used to analyze the technical data computed by the backend. Bedrock does not fetch market data directly. It receives indicators like RSI, MACD, MA, and stock price to generate recommendations such as "STRONG BUY", "STRONG SELL", or "HOLD", along with confidence scores and reasoning.
    
    ![Request Amazon Bedrock Model Access](/images/5-Workshop/5.2-Prerequiste/image21.png)
    
    ![Approved Model List](/images/5-Workshop/5.2-Prerequiste/image22.png)