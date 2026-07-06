---
title: "Các bài blogs đã đăng"
date: 2026-07-06
weight: 3
chapter: false
pre: " <b> 3. </b> "
---

Phần này tóm tắt ba bài blog đã hoàn thành trong quá trình thực tập và đăng/chia sẻ theo chủ đề AWS Study Group. Nội dung tập trung vào các kinh nghiệm thực tế khi triển khai backend trên AWS, kiểm soát chi phí cloud, tìm hiểu AWS AI Services và so sánh mô hình triển khai EC2 truyền thống với kiến trúc Serverless.

### [Blog 1 - Deploy Backend lên AWS EC2 và lỗi chỉ vì chữ hoa](3.1-Blog1/)
Bài viết chia sẻ một lỗi thực tế khi triển khai backend từ môi trường Windows Local lên Amazon EC2 chạy Ubuntu/Linux. Bài học chính là Environment Variables, đặc biệt là các giá trị Boolean như `True` và `true`, có thể được xử lý khác nhau do Linux phân biệt chữ hoa và chữ thường. Bài viết cũng giải thích rủi ro khi quản lý file `.env` thủ công trên EC2 và gợi ý các hướng tối ưu bảo mật hơn như AWS Systems Manager Parameter Store và AWS Secrets Manager.

### [Blog 2 - AWS Cost & AI: Khi chạy cloud trở thành vấn đề chi phí](3.2-Blog2/)
Bài viết phân tích việc quản lý chi phí AWS trở nên quan trọng như thế nào sau khi ứng dụng bắt đầu vận hành ổn định. Nội dung đề cập đến các hiểu lầm phổ biến về AWS Free Tier, chi phí phát sinh từ EC2 chạy liên tục, tài nguyên chưa dọn dẹp, log, storage và các thử nghiệm với dịch vụ AI. Bài viết cũng nhấn mạnh rằng các dịch vụ AWS AI như Amazon Bedrock, SageMaker, Comprehend và Rekognition cần được theo dõi kỹ vì có thể tính phí theo request, token hoặc dữ liệu xử lý. Các hướng giải quyết gồm AWS Budgets, Billing Alarms, Cost Explorer, môi trường sandbox và thiết kế hệ thống theo hướng cost-aware.

### [Blog 3 - Triển khai ứng dụng Serverless với AWS Lambda và Amazon API Gateway](3.3-Blog3/)
Bài viết giới thiệu mô hình triển khai ứng dụng Serverless bằng AWS Lambda kết hợp với Amazon API Gateway. Nội dung so sánh mô hình EC2 truyền thống, nơi developer phải quản lý hệ điều hành, runtime, scaling và vận hành server, với kiến trúc Serverless, nơi AWS đảm nhiệm phần hạ tầng. Bài viết tóm tắt các lợi ích như không cần quản lý server, tự động mở rộng và thanh toán theo mức sử dụng, đồng thời nêu các hạn chế cần lưu ý như cold start, giới hạn thời gian thực thi và mức độ phụ thuộc cao hơn vào dịch vụ cloud.
