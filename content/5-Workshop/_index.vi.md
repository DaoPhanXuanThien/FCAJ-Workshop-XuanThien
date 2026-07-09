---
title: "Báo cáo Dự án"
date: 2026-07-09
weight: 5
chapter: false
pre: " <b> 5. </b> "
---

# Báo cáo Dự án: Hệ thống Phân tích và Cảnh báo Giá Cổ phiếu

Phần này tóm tắt quá trình nghiên cứu, xây dựng và triển khai dự án tốt nghiệp **Stock Alerts System** sử dụng kiến trúc AWS Serverless và Trí tuệ nhân tạo (Amazon Bedrock). Nội dung được chia thành các phần chính dưới đây:

### 1. [Tổng quan về dự án](5.1-Workshop-overview/)
Giới thiệu mục tiêu dự án, đối tượng khách hàng hướng tới và bài toán kinh doanh mà hệ thống giải quyết nhằm hỗ trợ các Trader tự động hóa quy trình phân tích thị trường.

### 2. [Các bước chuẩn bị & Triển khai](5.2-Prerequiste/)
Hướng dẫn chi tiết quy trình thiết lập tài khoản và triển khai thực tế các dịch vụ AWS trong hệ thống (S3, SQS, Lambda, KMS, DynamoDB, CloudFront, WAF, Cognito, API Gateway, Bedrock).

### 3. [Lý do lựa chọn kiến trúc](5.3-Why_Choose_Services/)
Phân tích các tiêu chí lựa chọn giải pháp (tối ưu chi phí, Serverless, Managed Service, khả năng mở rộng) và đề xuất các định hướng cải tiến hệ thống trong tương lai.

### 4. [Kiểm thử & Xác minh kết quả](5.4-Test/)
Ghi nhận quá trình chạy thử nghiệm hệ thống thực tế từ giao diện người dùng, theo dõi luồng xử lý bất đồng bộ qua các dịch vụ, kiểm tra log CloudWatch và cách xử lý lỗi hạn mức quota của Amazon Bedrock.