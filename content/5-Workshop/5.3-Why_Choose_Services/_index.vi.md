---
title: "Vì sao chọn dịch vụ?"
date: 2026-07-09
weight: 3
chapter: false
pre: " <b> 5.3. </b> "
---

### Vì sao chọn các dịch vụ trên để làm project?

Mô hình được lựa chọn dựa trên 4 tiêu chí chính: **chi phí thấp**, **đơn giản khi triển khai**, **sử dụng Managed Service/Serverless** và **có khả năng mở rộng tốt**.

---

#### 1. Chi phí
Các dịch vụ như Lambda, S3, SQS, DynamoDB, API Gateway, CloudFront và SES đều phù hợp với mô hình trả tiền theo mức sử dụng (Pay-as-you-go). Hệ thống không cần thuê máy chủ chạy liên tục, nên chi phí ban đầu thấp và phù hợp với đồ án sinh viên.

*Ví dụ:* Khi chưa có nhiều người dùng, Lambda chỉ phát sinh chi phí khi có request, SQS chỉ tính theo số lượng message, DynamoDB tính theo dung lượng và lượt đọc/ghi, còn S3 tính theo dung lượng lưu trữ. Điều này giúp hệ thống tiết kiệm hơn nhiều so với việc triển khai một server EC2 chạy 24/7.

---

#### 2. Độ đơn giản và Serverless
Project sử dụng kiến trúc Serverless để giảm khối lượng vận hành hệ thống. Thay vì phải tự cấu hình server, cài đặt runtime, quản lý scaling, cập nhật hệ điều hành và giám sát tài nguyên, các thành phần chính được triển khai bằng dịch vụ serverless như:
*   **AWS Lambda:** Chạy backend logic.
*   **Amazon API Gateway:** Cung cấp API endpoints.
*   **Amazon S3:** Lưu trữ dữ liệu thô và hosting frontend tĩnh.
*   **Amazon SQS:** Xử lý hàng đợi bất đồng bộ.
*   **Amazon DynamoDB:** Lưu báo cáo phân tích và kết quả.

Nhờ đó, nhóm có thể tập trung hoàn toàn vào nghiệp vụ chính của project: lấy dữ liệu cổ phiếu, tính toán chỉ báo kỹ thuật, gọi Amazon Bedrock và xây dựng luồng phê duyệt của trader.

---

#### 3. Managed Service
Các dịch vụ trong mô hình phần lớn là Managed Service, nghĩa là AWS chịu trách nhiệm vận hành hạ tầng nền bên dưới. Điều này giúp hệ thống ổn định hơn và giảm rủi ro lỗi vận hành.

Cụ thể:
*   **Amazon Bedrock:** Giúp tích hợp AI mà không cần tự triển khai và tối ưu mô hình machine learning.
*   **Amazon DynamoDB:** Lưu trữ dữ liệu NoSQL với hiệu năng cao mà không cần tự quản trị database server.
*   **Amazon SQS:** Tách rời các bước xử lý mà không cần tự xây dựng và bảo trì message queue.
*   **Amazon SES:** Hỗ trợ gửi email thông báo đáng tin cậy mà không cần tự cấu hình mail server.
*   **AWS KMS:** Quản lý khóa mã hóa dữ liệu mà không cần tự xây dựng cơ chế mã hóa riêng.

---

#### 4. Khả năng mở rộng
Mô hình có khả năng mở rộng tốt vì các thành phần được tách rời theo từng nhiệm vụ. Khi số lượng mã cổ phiếu hoặc số lượng người dùng tăng lên, hệ thống có thể mở rộng từng phần mà không ảnh hưởng toàn bộ kiến trúc.

*Ví dụ:*
*   Nếu nhiều người gửi yêu cầu phân tích cùng lúc, API Gateway và Lambda có thể xử lý nhiều request song song (auto-scaling).
*   Nếu lượng dữ liệu tăng nhanh đột biến, SQS giúp xếp hàng message để Processing Lambda xử lý dần, tránh tình trạng quá tải hệ thống.
*   Nếu cần lưu nhiều báo cáo hơn, DynamoDB và S3 có thể tự động mở rộng theo dung lượng và lưu lượng truy cập.
*   Nếu nhiều người truy cập Dashboard, CloudFront giúp phân phối frontend nhanh hơn và giảm tải cho S3.
*   Nếu cần tăng khả năng bảo vệ ứng dụng, AWS WAF có thể bổ sung rule để chặn request độc hại theo thời gian thực.
