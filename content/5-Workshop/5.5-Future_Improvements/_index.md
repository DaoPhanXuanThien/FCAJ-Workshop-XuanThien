---
title: "Future Improvements"
date: 2026-07-09
weight: 5
chapter: false
pre: " <b> 5.5. </b> "
---

### Future Improvements

After the first implementation and testing phase, the **Stock Alerts System** already demonstrates a complete serverless workflow from market data ingestion to AI-assisted recommendation review. However, several improvements can make the system more reliable, secure, scalable, and useful for real trading workflows.

---

#### 1. Expand and Validate Market Data Sources
The current version mainly uses Yahoo Finance as the market data source. In the future, the system can integrate additional financial data providers to cross-check price, volume, and historical data before sending them to the analysis pipeline.

This improvement helps reduce dependency on a single source and increases data reliability. The system can also add validation rules to detect missing candles, abnormal price values, or incomplete trading sessions before saving raw data into Amazon S3.

#### 2. Improve Technical Indicators and AI Prompt Design
At this stage, the backend calculates common indicators such as RSI, MACD, MA20, MA50, and Volume. The next version can add more indicators such as Bollinger Bands, Stochastic Oscillator, ADX, ATR, and support/resistance levels.

The prompt sent to Amazon Bedrock should also be refined so the model returns a consistent structure, including recommendation type, confidence score, reasoning, risk level, and short action notes for traders. This makes the AI output easier to review and store in DynamoDB.

#### 3. Add Real-Time Alert Rules
The system can be extended with real-time or scheduled alert rules. Traders can define conditions such as price crossing a target level, RSI entering overbought or oversold zones, MACD crossover signals, or abnormal volume spikes.

When a condition is met, the system can send the result to Amazon SQS for asynchronous processing, then notify traders or customers through Amazon SES, email templates, or other channels after trader approval.

#### 4. Strengthen Human-in-the-Loop Workflow
Because stock recommendations can affect investment decisions, the system should keep human approval as a core safety layer. Future versions can improve the review workflow by adding status values such as `PENDING_REVIEW`, `APPROVED`, `REJECTED`, and `SENT`.

The Dashboard can also record who approved a recommendation, when it was approved, and why a report was rejected. This creates a clearer audit trail for financial advisory use cases.

#### 5. Improve User Roles and Access Control
The current authentication layer uses Amazon Cognito. A future version should define clearer role-based access control for different user groups:

*   **Admin:** Manages users, system settings, and monitoring configuration.
*   **Trader:** Reviews AI recommendations and approves or rejects reports.
*   **Customer:** Receives approved reports or views recommendation history.

This separation helps protect sensitive operations and prevents end users from accessing internal review or infrastructure-related functions.

#### 6. Enhance Security and Auditability
The project already uses services such as AWS WAF, KMS, Cognito, and IAM. The next step is to add stronger monitoring and audit controls, including CloudWatch Alarms, CloudTrail logs, stricter IAM least-privilege policies, API rate limiting, and WAF rules for common attack patterns.

Sensitive data stored in DynamoDB and S3 should continue to be encrypted with KMS. Access logs should be reviewed periodically to detect abnormal API usage or unauthorized access attempts.

#### 7. Optimize Cost and Performance
Since Amazon Bedrock usage depends on token consumption, prompt size should be optimized before sending data to the model. The backend should avoid sending raw historical data directly and instead send only calculated indicators and important summaries.

Other cost optimizations include caching frequently requested stock data, tuning Lambda memory and timeout settings, monitoring AWS Cost Explorer, and setting billing alerts. These improvements help keep the project suitable for a student or small-team environment.

#### 8. Upgrade Dashboard Experience
The Dashboard can be improved with interactive charts, filters by stock symbol, timeframe, recommendation status, confidence score, and approval state. Adding historical analysis views also helps traders compare previous recommendations with current market movements.

For a more practical user experience, the Dashboard should show clear states for processing, failed analysis, fallback mode, quota issues, and successful report generation.

#### 9. Add CI/CD for Frontend and Backend
The deployment process can be automated with GitHub Actions or AWS CodePipeline. A CI/CD workflow should build and test Lambda code, validate infrastructure configuration, deploy frontend files to S3, and invalidate CloudFront cache when a new version is released.

This makes the project easier to maintain and reduces manual deployment mistakes when the system grows.

#### 10. Measure Recommendation Accuracy
To evaluate the usefulness of AI-assisted recommendations, the system should store the actual stock movement after a recommendation is made, for example after 1 day, 3 days, and 1 week.

By comparing actual market movement with previous AI recommendations, the team can measure accuracy, identify weak signals, improve confidence scoring, and refine prompt templates over time.

---

### Summary

The future direction of the project is to move from a working prototype toward a more production-ready financial analysis platform. The most important priorities are improving data reliability, making AI recommendations more consistent, keeping human approval in the workflow, strengthening security, and building measurable feedback loops for recommendation accuracy.
