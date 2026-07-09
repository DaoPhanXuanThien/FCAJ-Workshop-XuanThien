---
title: "Kiểm thử và xác minh"
date: 2026-07-09
weight: 4
chapter: false
pre: " <b> 5.4. </b> "
---

### Kiểm thử hệ thống và xác minh kết quả

Sau khi triển khai toàn bộ hạ tầng Serverless và Database, chúng ta thực hiện các bước kiểm thử chức năng để xác minh luồng chạy của hệ thống từ giao diện người dùng đến các dịch vụ xử lý ở backend.

---

#### 1. Đăng nhập hệ thống qua Amazon Cognito
Truy cập vào trang Dashboard của hệ thống. Giao diện đăng nhập được tích hợp với Amazon Cognito User Pool để xác thực người dùng.

![Giao diện đăng nhập Cognito](/images/5-Workshop/5.4-Test/image1.png)

*Nhận xét:* Do tài khoản của trader đã được khởi tạo trước đó trong User Pool nên quá trình đăng nhập diễn ra trực tiếp và an toàn.

---

#### 2. Giao diện Dashboard quản trị tài chính
Sau khi đăng nhập thành công, giao diện Dashboard hiển thị danh sách các mã cổ phiếu đang theo dõi. Ban đầu, Dashboard chỉ hiển thị dữ liệu mẫu (ví dụ: mã `FPT`).

![Giao diện Dashboard ban đầu](/images/5-Workshop/5.4-Test/image2.png)

---

#### 3. Thực hiện phân tích mã cổ phiếu mới
Để chạy phân tích, trader chọn mã cổ phiếu mong muốn (ví dụ: mã `VNM` - Vinamilk) từ thanh công cụ và nhấn nút **Phân tích (Analyze)**.

![Thao tác chọn mã VNM để phân tích](/images/5-Workshop/5.4-Test/image3.png)

---

#### 4. Quy trình xử lý bất đồng bộ ở Backend
Khi nhấn nút **Phân tích**, hệ thống kích hoạt luồng xử lý bất đồng bộ sau:
1.  **API Gateway** tiếp nhận request từ Client và kích hoạt **Ingestion Lambda**.
2.  **Ingestion Lambda** thực hiện gọi Yahoo Finance API để cào dữ liệu lịch sử và giá hiện tại của mã `VNM`.
3.  Dữ liệu thô (raw data) được ghi nhận và lưu trữ dưới dạng file JSON trong **Amazon S3**.
4.  S3 gửi thông báo sự kiện (Event Notification) để đẩy một message vào **Amazon SQS Queue**.
5.  **Processing Lambda** được trigger bởi hàng đợi SQS, tiến hành lấy message, đọc dữ liệu thô từ S3 và thực hiện tính toán các chỉ số kỹ thuật nâng cao (như RSI, MACD, MA20, MA50, Volume).

*   **Trạng thái hàng đợi SQS trong quá trình xử lý:**
    
    ![Trạng thái SQS Queue](/images/5-Workshop/5.4-Test/image4.png)
    
    ![Chi tiết hàng đợi SQS](/images/5-Workshop/5.4-Test/image5.png)

*Sau khi Processing Lambda xử lý xong tin nhắn:* Số lượng tin nhắn trong hàng đợi SQS giảm về 0 (như hình dưới), xác nhận tin nhắn đã được tiêu thụ thành công.

![Hàng đợi SQS trống sau khi xử lý](/images/5-Workshop/5.4-Test/image6.png)

---

#### 5. Lưu trữ kết quả phân tích trong Amazon DynamoDB
Sau khi tính toán các chỉ số kỹ thuật và gọi mô hình AI để nhận khuyến nghị, kết quả cuối cùng được ghi nhận vào bảng DynamoDB `Stock_reports_1`.

![Kết quả lưu trữ trong DynamoDB](/images/5-Workshop/5.4-Test/image7.png)

---

#### 6. Hiển thị báo cáo phân tích trên Dashboard
Quay lại trang Dashboard, thông tin mã cổ phiếu `VNM` đã xuất hiện cùng với các thông số chỉ báo kỹ thuật chi tiết. 

![Dashboard hiển thị mã VNM](/images/5-Workshop/5.4-Test/image8.png)
*(Hình ảnh thể hiện danh sách 3 mã cổ phiếu đã được phân tích thành công trên Dashboard)*

![Chi tiết thông số chỉ báo trên Dashboard](/images/5-Workshop/5.4-Test/image9.png)

---

#### 7. Kiểm tra logs hệ thống trên Amazon CloudWatch
Truy cập vào Amazon CloudWatch Logs để giám sát hoạt động chi tiết của Processing Lambda và kiểm tra xem có lỗi phát sinh hay không.

![Xem logs trên CloudWatch](/images/5-Workshop/5.4-Test/image10.png)

Logs ghi nhận luồng xử lý đã diễn ra thành công theo đúng logic nghiệp vụ được thiết kế.

![Logs chi tiết xử lý thành công](/images/5-Workshop/5.4-Test/image11.png)

---

#### 8. Sự cố giới hạn token (Token Quota Limit Exceeded) tại Amazon Bedrock
Trong quá trình kiểm thử, hệ thống ghi nhận lỗi từ Amazon Bedrock: **"Too many tokens per day, please try again."** (Vượt quá hạn mức số lượng token được gọi trong ngày).

![Lỗi vượt hạn mức Bedrock](/images/5-Workshop/5.4-Test/image12.png)

*   **Nguyên nhân:** Do giới hạn mặc định của tài khoản AWS đối với mô hình Claude.
*   **Hậu quả:** Khi gặp lỗi này, hệ thống sẽ tự động kích hoạt cơ chế fallback dữ liệu, gán điểm tin cậy mặc định là `68` (nhỏ hơn ngưỡng an toàn `75` để gửi đi) nhằm đảm bảo hệ thống không bị sập.
    
    ![Dữ liệu fallback trên DynamoDB](/images/5-Workshop/5.4-Test/image13.png)

*   **Cách khắc phục:** Thực hiện gửi yêu cầu nâng hạn mức (Request Quota) đối với mô hình Claude 3.5 Sonnet v2 trên giao diện quản trị Amazon Bedrock.
    
    ![Giao diện yêu cầu nâng hạn mức Bedrock](/images/5-Workshop/5.4-Test/image14.png)

---

#### 9. Kiểm duyệt cuối cùng (Human-in-the-loop)
Sau khi khắc phục vấn đề về quota, Bedrock có thể phân tích thành công và trả về điểm tự tin cao. Các báo cáo có tín hiệu rõ ràng như **MUA MẠNH** hoặc **BÁN MẠNH** sẽ được trader kiểm duyệt lại trên Dashboard một lần nữa trước khi bấm nút gửi thông báo chính thức đến Email của khách hàng.

![Giao diện Dashboard sau khi nâng hạn mức](/images/5-Workshop/5.4-Test/image15.png)

![Màn hình duyệt báo cáo của Trader](/images/5-Workshop/5.4-Test/image16.png)
