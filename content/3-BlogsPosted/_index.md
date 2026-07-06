---
title: "Blogs Posted"
date: 2026-07-06
weight: 3
chapter: false
pre: " <b> 3. </b> "
---

This section summarizes the three AWS Study Group blog posts completed during the internship. The posts focus on practical lessons from deploying backend applications on AWS, controlling cloud costs, exploring AWS AI services, and comparing traditional EC2 deployment with serverless architecture.

### [Blog 1 - Deploy Backend on AWS EC2 and a Bug Caused by Capital Letters](3.1-Blog1/)
This blog shares a real deployment issue when moving a backend application from a Windows local environment to Amazon EC2 running Ubuntu/Linux. The main lesson is that environment variables, especially Boolean values such as `True` and `true`, can behave differently because Linux is case-sensitive. The post also explains why manually managing `.env` files on EC2 can create security and maintenance risks, and introduces better directions such as AWS Systems Manager Parameter Store and AWS Secrets Manager.

### [Blog 2 - AWS Cost and AI: When Running Cloud Becomes a Cost Problem](3.2-Blog2/)
This blog discusses how AWS cost management becomes important once an application starts running beyond basic deployment. It explains common misunderstandings about AWS Free Tier, the cost impact of continuously running EC2 instances, unused resources, logs, storage, and AI service experiments. The post also highlights how AWS AI services such as Amazon Bedrock, SageMaker, Comprehend, and Rekognition require careful monitoring because they may be billed by requests, tokens, or analyzed data. Key solutions include AWS Budgets, Billing Alarms, Cost Explorer, sandbox environments, and cost-aware design.

### [Blog 3 - Deploying a Serverless Application with AWS Lambda and Amazon API Gateway](3.3-Blog3/)
This blog introduces serverless application deployment using AWS Lambda and Amazon API Gateway. It compares the traditional EC2 model, where developers manage operating systems, runtime, scaling, and server operations, with serverless architecture, where AWS handles infrastructure management. The post summarizes the benefits of serverless, including no server management, automatic scaling, and pay-per-use pricing, while also noting limitations such as cold starts, execution time limits, and stronger dependency on cloud services.
