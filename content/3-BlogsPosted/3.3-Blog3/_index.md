---
title: "Deploying a Serverless Application with AWS Lambda and Amazon API Gateway"
date: 2026-07-06
weight: 3
chapter: false
pre: " <b> 3.3. </b> "
---
# [EXPERIENCE SHARING] Deploying a Serverless Application with AWS Lambda and Amazon API Gateway: When "No Server Management" Becomes an Advantage

### 1. Introduction
After completing backend deployment on Amazon EC2 and learning how to optimize operating costs on AWS, our team started asking a new question:

> Is there a way to deploy APIs without managing servers ourselves?

In practice, using Amazon EC2 gives us a lot of control:

* Configure the operating system
* Install the runtime manually
* Manage networking
* Manage storage
* Configure Security Groups

However, this also comes with many operational tasks:

* Monitor EC2 status
* Start or stop instances
* Patch the operating system
* Update software
* Manage scaling

While learning more about application deployment models on AWS, our team discovered a very different architecture: serverless computing.

The interesting point is that developers only need to focus on writing code, while AWS handles infrastructure management behind the scenes.

Through this post, our team wants to share what we learned about building a serverless API with AWS Lambda and Amazon API Gateway, while also comparing it with the traditional EC2 model to better understand the strengths and limitations of each deployment approach.

### 2. What Is Serverless?
When we first heard about serverless, our team thought it meant:

> There is no server.

In reality, that is not true.

Servers still exist, but users do not need to manage them directly. AWS handles the behind-the-scenes work, including:

* Provisioning resources
* Starting the runtime environment
* Auto scaling
* Updating the operating system
* Managing load handling

This allows developers to focus on business logic instead of infrastructure administration.

This is also why serverless is widely used in:

* REST APIs
* Mobile app backends
* Chatbots
* IoT
* Event processing
* AI pipelines

### 3. Deployment Architecture
In a basic serverless model, our team studied the following architecture.

The developer builds the source code and deploys a function to AWS Lambda. Users send HTTP requests to Amazon API Gateway. API Gateway acts as the entry point and forwards requests to the Lambda function.

Lambda handles the business logic, can access a database or other AWS services if needed, and returns the result back through API Gateway.

Unlike EC2, this entire process happens without the user managing any server.

### 4. What Makes Serverless Attractive?
After studying documentation and practicing basic examples, our team noticed several strong advantages.

#### No Server Management
This is the biggest difference.

In the EC2 model, we need to:

* Create instances
* Monitor CPU
* Manage RAM
* Update the operating system
* Configure scaling

With Lambda, AWS is responsible for all of these tasks.

#### Automatic Scaling Based on Traffic
If an application suddenly receives thousands of requests at the same time, Lambda automatically creates more execution environments to respond.

When traffic decreases, resources are automatically released. This avoids the need to predict the number of servers in advance like in traditional models.

#### Pay per Use
One of the most impressive points for our team was AWS Lambda pricing.

With Lambda:

* There is no charge when the function is not running
* Cost is based on invocation count and execution time

This is very different from EC2, where an instance can still generate cost even when no request is being processed.

That is also why serverless is often suitable for systems with unstable or variable traffic.

### 5. Limitations to Consider
Although serverless provides many benefits, our team also realized that it is not the right solution for every case.

#### Cold Start
When a Lambda function has not been used for a period of time, its execution environment may be released. The next first request needs extra time to initialize the function.

This behavior is called cold start. For APIs that require extremely fast responses, this is an important factor to consider.

#### Execution Time Limit
AWS Lambda is designed for short-running tasks.

If an application needs continuous long-running processing or complex background processes, EC2 or ECS may be more suitable.

#### Higher Dependency on Cloud Services
When using Lambda, the system architecture becomes closely connected to AWS services such as:

* API Gateway
* IAM
* CloudWatch
* Lambda

This makes integration convenient, but also increases dependency on the cloud platform being used.

### 6. Cost Perspective
After the previous post about AWS Cost Management, our team found that serverless also gives an interesting perspective on cost optimization.

In the EC2 model:

* The server runs continuously
* Cost is calculated by runtime

With Lambda:

* If there is no request, there is almost no compute cost
* The system automatically scales when needed
* There is no need to keep a server running all the time

This is especially suitable for:

* Websites with low traffic
* Internal APIs
* Experimental applications
* MVPs, or Minimum Viable Products
* Learning and research exercises

However, if a system has very high traffic or continuous processing, total Lambda cost can sometimes be higher than running EC2 or ECS. Therefore, choosing the right model should depend on the actual characteristics of the application.

### 7. Lessons Learned
Through learning about serverless architecture on AWS, our team realized that serverless is not a complete replacement for EC2.

Instead, it is another option for a different group of problems.

If we need full operating system control, long-running applications, or special configuration, EC2 is still a reasonable choice.

On the other hand, if the goal is fast deployment, less infrastructure administration, automatic scaling, and cost optimization for APIs with variable traffic, AWS Lambda combined with Amazon API Gateway is a model worth considering.

The most important lesson we learned is not that EC2 is better than Lambda, or Lambda is better than EC2. The real lesson is:

> Every AWS service is designed to solve a specific group of problems. Understanding each service clearly helps us choose the right architecture from the beginning.

### 8. Conclusion
Through learning about the serverless model, our team had the opportunity to explore a more modern way to build applications on AWS.

Combining Amazon API Gateway with AWS Lambda significantly reduces infrastructure management work while taking advantage of automatic scaling and pay-per-use pricing.

For learning projects, APIs with unstable traffic, or applications that need quick deployment, this is an architecture worth experiencing and researching.

In the future, our team also wants to learn more about combining Lambda with services such as Amazon DynamoDB, Amazon S3, and Amazon EventBridge to build more complete serverless systems.

I hope this sharing gives everyone another perspective on the serverless model on AWS. If you have deployed Lambda in real projects or have experience optimizing performance and cost for serverless architecture, we would love to learn from your comments and discussion.

### Architecture Image

![Serverless API architecture with API Gateway, Lambda, DynamoDB, CloudWatch and IAM Role](../../images/3-BlogsPosted/3.3-Blog3/serverless-api-gateway-lambda-architecture.png)

### Facebook Link
[View the Facebook post/profile](https://web.facebook.com/groups/660548818043427/user/100050719642663/)

#AWS #Lambda #APIGateway #Serverless #CloudComputing #AWSStudyGroupVN #Backend #CloudArchitecture
