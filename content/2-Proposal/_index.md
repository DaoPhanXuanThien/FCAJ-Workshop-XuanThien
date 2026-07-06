---
title: "Proposal"
date: 2026-07-06
weight: 2
chapter: false
pre: " <b> 2. </b> "
---
# PROJECT PROPOSAL: STOCK PRICE ANALYSIS AND ALERT SYSTEM (STOCK ALERTS SYSTEM)
## A Comprehensive AWS Serverless & AI Agent Solution for Professional Traders

### 1. Executive Summary
The project aims to build an automated real-time stock price analysis, reasoning, and alert system based on AWS Serverless Architecture combined with Claude artificial intelligence through Amazon Bedrock. The system supports traders in monitoring the market, automatically calculating technical indicators, and generating in-depth analytical reports to send to end customers. By separating deterministic quantitative data processing from AI language reasoning, the system maintains high calculation accuracy, minimizes AI hallucination, and operates with a human-in-the-loop review mechanism before any strategy is published.

### 2. Problem Statement
Current problem: Traders often face a massive volume of market information, including technical charts and macroeconomic news that changes minute by minute. Manual analysis takes significant time, can cause missed opportunities, and may lead to emotion-driven decisions. In addition, using general AI models for financial analysis can be risky because they may calculate indicators such as RSI or MACD incorrectly, or generate unsupported news and assumptions.

Solution: The system solves this by separating responsibilities. Python code running on AWS Lambda performs accurate technical indicator calculations, then prepares trusted context through a RAG-style flow so the AI Agent, Claude Opus or Sonnet, can reason and produce higher-quality recommendations. A secured dashboard enables traders to quickly edit, review, approve, and send strategies to customers through email or SNS.

Benefits and return on investment (ROI): The solution can optimize up to 90% of the trader's data aggregation time. AWS infrastructure operating cost is designed to approach zero for the student project by maximizing AWS Free Tier usage.

### 3. Solution Architecture
The system is designed as a fully serverless, pay-as-you-go architecture and is divided into four independent DevOps-friendly layers.

Frontend and Dashboard Layer: Built with JavaScript and deployed to Amazon S3 Static Hosting with Amazon CloudFront CDN for high-speed content delivery without maintaining a web server.

Ingestion and Math Engine Layer: Uses separate AWS Lambda functions for raw data ingestion and numerical data processing. Historical data is retrieved from yfinance, while real-time data comes from the Yahoo Finance API.

AI Analytics Engine Layer: Claude on Amazon Bedrock acts as the reasoning brain that explains the model and provides explainable AI analysis.

Database and Storage Layer: Amazon S3 stores raw JSON files, while Amazon DynamoDB stores structured time-series analysis data.

### 4. Technical Implementation
Closed-loop end-to-end workflow:

1. Trigger and ingest data: Amazon EventBridge triggers the Ingestion Lambda according to stock market hours to fetch data from Yahoo Finance and push it to Amazon S3.

2. Quantitative calculation: S3 Event Notification sends messages to the SQS Main Queue to throttle concurrency and prevent Lambda overload. Processing Lambda reads the messages and uses the pandas-ta library to calculate RSI, MACD, and other technical indicators accurately.

3. AI analysis and GenAI reasoning: The system calls Claude through Amazon Bedrock with a dynamic prompt. Claude is constrained to return strict JSON containing recommendations, confidence score, and logical reasoning trace. Signals with confidence scores below 75 are automatically filtered out.

4. Time-series storage: Results are written to DynamoDB and encrypted with AWS KMS. The table uses a composite primary key design, with PK as TICKER#<Stock_Code> and SK as TIMESTAMP#<YYYYMMDD-HHMMSS>, allowing recent 30-day data queries in under 10 ms.

5. Alerts and dashboard delivery: Lambda calls the Telegram Bot API directly through sendMessage to alert traders. Traders sign in to the dashboard through Amazon Cognito, receive a JWT token, and access services through Amazon API Gateway with built-in rate limiting to reduce DDoS risk.

6. Final human review: Traders compare candlestick charts from TradingView Lightweight Charts with AI reasoning, then approve the strategy before sending it to customers.

### 5. Timeline & Milestones
- May: Study AWS and learn about the services that will be used in the project.
- June: Design and adjust the architecture, then divide responsibilities among team members.
- July: Implement the project, test the system, and fix issues.

### 6. Budget Estimation
- Amazon EventBridge: approximately 8,800 trigger events, free, 0.00 USD.
- AWS Lambda: approximately 17,600 executions for ingestion and processing, 0.00 USD per 1 million requests under Free Tier.
- Amazon SQS: approximately 17,600 messages for Main Queue and DLQ, 0.00 USD per 1 million requests under Free Tier.
- Amazon S3: raw JSON storage of approximately 200 MB per month, 0.00 USD under 5 GB.
- Amazon DynamoDB: approximately 2,200 analysis data records, 0.00 USD under 25 GB.
- Amazon API Gateway: approximately 5,000 dashboard calls, 0.00 USD per 1 million requests under Free Tier.
- Amazon Cognito: administrator or trader accounts, 0.00 USD under 50,000 monthly active users.
- AWS SSM Parameter Store: secure API key storage, 0.00 USD for Standard parameters.
- Amazon CloudWatch: metrics and logs, 0.00 USD under 5 GB.
- Amazon Bedrock with Claude 3.5 Sonnet: approximately 9.90 USD for 2,200 analysis requests.

Fixed AWS infrastructure budget: 0 VND.

Development and test phase using Claude 3.5 Sonnet: input is approximately 1,500 tokens per request for technical analysis data and macro news text. With 2,200 requests, the total input volume is about 3.3 million tokens. At 3.00 USD per 1 million tokens, the estimated input cost is 9.90 USD, and the total development cost with Sonnet is approximately 19.80 USD per month.

Variable AI Agent budget: approximately 19.80 USD per month, generated only when development or real testing runs are executed.

### 7. Risk Assessment
Risk 1: AI cost threshold overrun due to Bedrock token bursts. If the market is highly volatile, the number of symbols reaching a confidence score of 75 or higher may increase sharply, causing frequent Claude calls and higher token cost.

Mitigation strategy: Add a hard quota and rate limit for the maximum number of Bedrock calls per day directly in the Lambda code. Use Claude 3.5 Sonnet as the main model to control cost.

Risk 2: System congestion when many files arrive in S3 at the same time.

Mitigation strategy: The V3.1 architecture resolves this by inserting SQS Main Queue as an intermediate buffer to throttle concurrency and force Lambda to process messages sequentially in a controlled way.

Risk 3: yfinance API connection failure or request blocking.

Mitigation strategy: Configure Lambda to retry automatically twice. If the job still fails, send the failed message to the Dead-Letter Queue and trigger a CloudWatch Alarm to notify the trader through Telegram for manual handling.

### 8. Expected Outcomes
Technical improvements: Successfully build a fault-tolerant asynchronous workflow. Apply Zero Trust security architecture practices through Cognito, HTTPS encryption with ACM, and secret management through SSM Parameter Store.

Practical value: Deliver an AI assistant tool that explains the reason behind each action through an explainable reasoning trace. This helps traders improve investment productivity while maintaining strict information safety before sending strategies to customers.

### 9. System Architecture Model

![Stock Alerts System Architecture](../images/2-Proposal/stock_alerts_architecture.png)
