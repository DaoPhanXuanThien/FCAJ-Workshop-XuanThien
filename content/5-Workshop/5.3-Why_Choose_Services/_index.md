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
