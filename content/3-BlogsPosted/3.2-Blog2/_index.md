---
title: "AWS Cost and AI: When Running Cloud Becomes a Cost Problem"
date: 2026-07-06
weight: 2
chapter: false
pre: " <b> 3.2. </b> "
---
# [EXPERIENCE SHARING] AWS Cost & AI: When Running Cloud Is No Longer Only a Technical Problem, but a Cost Problem

### 1. Introduction
While learning and practicing on AWS, my team initially focused only on:

* Deploying an application to EC2
* Configuring the backend runtime environment
* Understanding basic cloud operations

However, once the system started running more stably, a new issue appeared that we had not paid enough attention to before: AWS operating cost, or cloud cost.

At the same time, while expanding our learning, we also started exploring AWS AI-related services such as:

* Amazon Bedrock
* Amazon SageMaker at a basic level
* AWS AI Services such as Comprehend and Rekognition

That was when we realized something important:

> Cloud is not only about whether the application can be deployed, but also about how much it costs to run every day.

### 2. Practice System Context
Our team was deploying a simple backend system on AWS:

* EC2 Ubuntu running a Node.js backend
* Several APIs for application logic
* Continuous logging and test requests during the learning process

At the beginning, because we were using AWS Free Tier, we were quite subjective and assumed that:

* EC2 `t2.micro` is free
* We could run it freely without problems

However, when we expanded testing, the system started to generate cost-related factors:

* EC2 uptime ran continuously 24/7
* Logs increased gradually with requests
* Some supporting resources were turned on but not turned off
* Additional AI service experiments created unexpected costs

### 3. Misunderstanding: Free Tier Does Not Mean Free Forever
A common misunderstanding our team had was thinking that Free Tier means:

* No cost at all
* Unlimited usage

In reality, Free Tier is limited by both time and usage level. If usage exceeds the threshold, AWS charges immediately.

In our case:

* EC2 kept running continuously without shutdown
* Some experiments created extra resources that were not deleted
* EBS storage grew over time

This caused costs to appear even though we had not planned for them at first.

### 4. When AI Enters the System, the Cost Model Changes Completely
After learning more about AWS AI Services, our team experimented with several directions:

* Text processing with Amazon Comprehend
* Calling generative AI APIs at demo level
* Researching Amazon Bedrock for a chatbot use case

This was when the cost problem became much clearer.

Unlike EC2, which is billed mainly by runtime, AI services are usually billed by:

* Number of requests
* Number of processed tokens
* Amount of analyzed data

This creates a new issue: the cost is no longer as predictable as EC2.

For example, one small API call may not be significant, but when testing many times continuously, the cost can accumulate faster than expected.

### 5. Main Reasons Costs Increased Quickly
After reviewing the system, our team identified three main causes.

First, we did not control running resources well enough:

* EC2 was not stopped when unused
* Some EBS volumes were not cleaned up
* There was no auto-shutdown mechanism

Second, we lacked cost monitoring. At first, our team almost did not use:

* AWS Cost Explorer
* Billing Alert
* Budget tracking

This made it slow to detect unexpected costs.

Third, we tested AI without clear limits:

* No request limit
* No budget alert
* No controlled sandbox environment

As a result, resource consumption became difficult to control.

### 6. Cost Optimization Directions
After recognizing the problem, our team started adjusting how we used AWS in a more cost-aware way.

#### 6.1 Control EC2 Resources
We changed our EC2 usage habits:

* Start EC2 only when testing is needed
* Stop the instance after use
* Delete unnecessary resources

#### 6.2 Set Up AWS Cost Management
Our team started using:

* AWS Budgets to set cost limits
* Billing Alarm to alert when spending exceeds the threshold
* Cost Explorer to monitor daily cost

#### 6.3 Separate the AI Sandbox Environment
Instead of testing AI directly inside the main system, we moved toward:

* Creating a separate environment for experiments
* Limiting the number of requests
* Avoiding direct connection to the production flow

#### 6.4 Understand How AWS Pricing Works
The most important thing we learned is that each AWS service has a different cost logic:

* EC2 is billed by runtime
* Storage is billed by capacity
* AI services are billed by request, token, or analyzed data

This means we cannot apply the same cost assumptions to every service.

### 7. AWS AI from a Practical Perspective
After trying several AWS AI services, our team noticed that AWS AI is powerful in system integration and easy to connect with a backend through SDKs.

However, cost must be controlled carefully. For generative AI models especially, the key question is not only whether we can use them, but how to use them without exceeding the budget.

### 8. Lessons Learned
#### 8.1 Cloud Is Not Only Engineering, but Operations
Working with AWS is not only about deploying an app or running a server. It is also about:

* Managing resources
* Optimizing cost
* Monitoring the system continuously

#### 8.2 AI Does Not Feel Expensive at First, but It Is Not Free
The more we test, the more we spend. The longer the prompt, the higher the token cost. Cost logic needs to be designed from the beginning, not only after the system is already running.

#### 8.3 Monitoring Is Required, Not Optional
Without monitoring, we do not know how much we are spending, cannot control scale, and can easily break the budget without realizing it.

#### 8.4 Automation Upgrades the Way We Think
Moving from manually stopping EC2 to using schedulers, event-driven shutdown, and lifecycle automation is a shift from being an AWS user to being an AWS operator.

### 9. Conclusion
Through this practice and additional research on AWS Cost and AI services, our team understood more clearly that AWS is not only a place to deploy applications. It is also an ecosystem that must be managed like a real operating system.

From running a simple EC2 instance to experimenting with AI services, everything is connected to:

* Cost
* Performance
* Reasonable system design

I hope this sharing gives everyone a more practical view of using AWS, especially when starting to explore AI services.

If you have experience optimizing AWS cost or using AWS AI effectively, feel free to discuss and share more.

### Architecture Image

![AWS Cost and AI architecture with budget monitoring](../../images/3-BlogsPosted/3.2-Blog2/aws-cost-ai-architecture.png)

### Facebook Link
[View the Facebook post/profile](https://web.facebook.com/groups/660548818043427/user/100050719642663/)

#AWS #CloudComputing #AWSCost #AmazonBedrock #SageMaker #AI #AWSStudyGroupVN #DevOps
