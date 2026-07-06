---
title: "Deploy Backend on AWS EC2 and a Bug Caused by Capital Letters"
date: 2026-07-06
weight: 1
chapter: false
pre: " <b> 3.1. </b> "
---
# [EXPERIENCE SHARING] Deploy Backend on AWS EC2 and a Bug Caused by Capital Letters

### 1. Introduction
During my learning and hands-on practice deploying applications on AWS EC2, I ran into a small but surprisingly time-consuming bug.

At first, our team thought the process would be simple:

* Make sure the code runs well locally
* Copy the source code to EC2
* Configure the `.env` file
* Start the server

Then the application should work normally. However, reality was not that simple. When deploying the backend from a Windows local environment to EC2 Ubuntu/Linux, the system started showing a series of logic issues:

* The application did not detect the environment state correctly
* Some automatic features did not work
* Boolean configuration always returned the wrong value
* The app did not show a clear error, but the logic behaved abnormally

After many hours of checking, I found that the root cause came from a tiny detail: uppercase and lowercase letters in environment variables.

Through this post, I want to share my real experience managing `.env` files on AWS EC2, and also introduce some security optimization directions based on AWS best practices.

### 2. What Are Environment Variables?
In modern backend projects, using environment variables is almost a required standard.

Instead of hard-coding configuration values directly into the source code, developers usually store them in a `.env` file.

For example:

```env
ENV=development
REGION=ap-southeast-1
ENVIRONMENT_AUTO=True
```

This approach helps:

* Improve security
* Switch more easily between Development and Production environments
* Manage configuration more easily
* Reduce source-code changes during deployment

When deploying an application to AWS EC2, the `.env` file is usually copied or created directly on the server so the application can read it at runtime.

### 3. Deployment Model on AWS EC2
I used a basic deployment model:

```text
Developer (Local) -> Source Code + .env -> SSH Deploy to EC2 -> Amazon EC2 (Ubuntu/Linux) -> Backend Application
```

During deployment:

* Source code was uploaded to EC2
* The `.env` file was configured manually
* The backend server was started with Node.js

Everything seemed stable until the application started processing Boolean variables.

### 4. The Problem on AWS EC2
In the Windows local environment:

* The application worked normally
* Boolean flags were processed with the correct logic

For example:

```env
ENVIRONMENT_AUTO=True
```

When running locally, the system understood this as an enabled value (`true`), so the auto-configuration feature worked correctly.

However, after deploying to EC2 Ubuntu/Linux:

* The system did not read the value correctly
* Some `if` conditions always returned `false`
* Processing logic became incorrect even though no clear error appeared

After debugging, I found two main causes.

### 5. Root Causes
#### 5.1 Linux Treats Uppercase and Lowercase More Strictly
Unlike Windows, Linux on AWS EC2 is highly case-sensitive.

For example, `True` and `true` can be parsed differently depending on the framework or `.env` processing library.

In some cases:

* `"True"` is only a string
* It is not converted to a Boolean
* Conditional checks return the wrong result

Example:

```js
if (process.env.ENVIRONMENT_AUTO === "true")
```

If the `.env` file contains:

```env
ENVIRONMENT_AUTO=True
```

The condition above will always fail. This is a very common issue when deploying from Windows to Linux.

#### 5.2 Manual `.env` Management on EC2
At first, I created the `.env` file directly on the server using:

```bash
nano .env
```

This is quick, but it has many problems:

* Easy to typo
* Easy to miss variables
* Hard to synchronize between environments
* Hard to manage when the system scales
* Risky if sensitive information is exposed through unauthorized EC2 access

In addition, storing values such as secret keys, database passwords, and API tokens directly on the server is not aligned with AWS security best practices.

### 6. The Solution I Applied
#### 6.1 Quick Fix: Normalize Boolean Values
I changed all Boolean values in `.env` to lowercase:

```env
ENVIRONMENT_AUTO=true
```

At the same time, I normalized data before processing it:

* Use `.toLowerCase()`
* Explicitly convert to Boolean

Example:

```js
const autoEnv = process.env.ENVIRONMENT_AUTO?.toLowerCase() === "true";
```

After the change:

* The logic worked stably
* The app detected the environment state correctly
* The wrong condition issue disappeared

#### 6.2 AWS Best Practice Direction
After learning more about AWS best practices, I realized that storing `.env` files directly on EC2 is not the best security approach.

So our team is researching a migration to:

* AWS Systems Manager Parameter Store
* AWS Secrets Manager

Benefits:

* Centralized environment variable management
* Better security
* No need to hard-code secrets
* Access control through IAM Role
* Easier system scaling

Instead of letting EC2 read the `.env` file directly, the system can move toward:

```text
EC2 -> IAM Role -> AWS Parameter Store
```

This is a safer and more common deployment pattern for production systems on AWS.

### 7. Lessons Learned
From this experience, I learned several important lessons.

Cloud Linux is more different from local Windows than I expected. Some small issues in local development can become major problems after deployment to Linux.

Small bugs often take the most time to debug. The issue is not always caused by complex code. Sometimes, just incorrect capitalization, wrong data type, or invalid `.env` format can make the application behave incorrectly.

Environment variable management is very important. Environment variables are not only configuration. They are also related to security, system management, scalability, and production stability.

### 8. Conclusion
Through this practice, I understood more clearly:

* How AWS EC2 works on Linux
* The importance of environment variables
* The differences between local and cloud environments
* Secret management directions based on AWS best practices

This is a practical sharing post from my own deployment experience, and I hope it helps others avoid similar issues when deploying applications to AWS EC2.

If you have more experience with AWS Secrets Manager, Parameter Store, `.env` management, or backend deployment best practices, feel free to discuss and share more.

### Architecture Images

![EC2 backend deployment with local .env file](../../images/3-BlogsPosted/3.1-Blog1/ec2-env-current-architecture.png)

![EC2 backend deployment using AWS Systems Manager Parameter Store](../../images/3-BlogsPosted/3.1-Blog1/ec2-ssm-parameter-store-architecture.png)

### Facebook Link
[View the Facebook post/profile](https://web.facebook.com/groups/660548818043427/user/100050719642663/)

#AWS #EC2 #AWSCloud #EnvironmentVariables #CloudComputing #AWSStudyGroupVN #Backend #DevOps
