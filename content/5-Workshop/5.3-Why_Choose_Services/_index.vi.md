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

---

### Các bước cải tiến trong tương lai

1.  **Mở rộng nguồn dữ liệu:** Hiện tại hệ thống chỉ sử dụng Yahoo Finance. Trong tương lai có thể bổ sung thêm các nguồn dữ liệu tài chính khác để đối chiếu giá, tăng độ tin cậy và hỗ trợ dữ liệu gần với thời gian thực hơn.
2.  **Cải thiện mô hình phân tích AI:** Amazon Bedrock hiện chỉ phân tích dựa trên chỉ báo kỹ thuật cơ bản. Sau này có thể mở rộng thêm nhiều chỉ báo khác như Bollinger Bands, Stochastic, ADX hoặc ATR để AI có thêm dữ liệu đầu vào và đưa ra khuyến nghị chính xác hơn.
3.  **Bổ sung cảnh báo thời gian thực:** Hệ thống có thể thêm chức năng tự động gửi cảnh báo tức thì khi giá cổ phiếu vượt ngưỡng thiết lập, chỉ số RSI rơi vào vùng quá mua/quá bán hoặc chỉ báo MACD đảo chiều.
4.  **Hoàn thiện quy trình quản trị người dùng:** Phân quyền rõ ràng hơn giữa các vai trò: **Admin** (quản lý hệ thống/người dùng), **Trader** (kiểm duyệt và phê duyệt khuyến nghị), và **Customer** (chỉ nhận báo cáo hoặc xem lịch sử khuyến nghị).
5.  **Tăng cường bảo mật:** Bổ sung thêm các lớp bảo mật nâng cao như cấu hình CloudWatch Alarms, thêm các AWS WAF Rules nâng cao, giới hạn tần suất request theo IP, kích hoạt audit log bằng CloudTrail.
6.  **Tối ưu chi phí và hiệu năng:** Theo dõi chi phí qua AWS Cost Explorer, tối ưu hóa kích thước prompt để giảm số lượng token gửi đến Bedrock, cache dữ liệu cổ phiếu phổ biến và tinh chỉnh cấu hình RAM/Timeout của Lambda.
7.  **Cải thiện giao diện Dashboard:** Nâng cấp thêm các biểu đồ trực quan (như TradingView Charts), bộ lọc theo mã cổ phiếu, trạng thái phê duyệt, độ tin cậy, khung thời gian và lịch sử các lần phân tích trước đó.
8.  **Bổ sung quy trình CI/CD:** Thiết lập CI/CD bằng GitHub Actions hoặc AWS CodePipeline để tự động hóa quá trình build, test và deploy frontend/backend.
9.  **Mở rộng khả năng scale:** Tối ưu hóa việc xử lý dữ liệu theo lô (batch processing), tăng concurrency giới hạn cho Lambda, cấu hình Dead-Letter Queue (DLQ) nâng cao và thiết lập Retry Policy rõ ràng.
10. **Thêm cơ chế đánh giá độ chính xác:** Lưu lại kết quả biến động thực tế của cổ phiếu sau một khoảng thời gian (ví dụ 1 ngày, 1 tuần) để đối chiếu với khuyến nghị của AI, từ đó tinh chỉnh prompt và logic tính điểm tin cậy.