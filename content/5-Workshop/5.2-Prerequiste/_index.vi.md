---
title: "Các bước chuẩn bị"
date: 2026-07-09
weight: 2
chapter: false
pre: " <b> 5.2. </b> "
---

### Các bước chuẩn bị và triển khai hạ tầng

Để triển khai dự án **Hệ thống Phân tích và Cảnh báo Giá Cổ phiếu (Stock Alerts System)**, chúng ta cần chuẩn bị và thiết lập các dịch vụ trên AWS theo các bước dưới đây.

---

#### 1. Tài khoản AWS & Sơ đồ kiến trúc

*   **Tài khoản AWS:** Sử dụng tài khoản AWS (ví dụ AWS Free Tier) để quản trị và thiết lập tài nguyên.
    
    ![Tài khoản AWS](/images/5-Workshop/5.2-Prerequiste/image1.png)

*   **Sơ đồ kiến trúc:** Sơ đồ kết nối giữa các dịch vụ trong hệ thống.
    
    ![Sơ đồ kiến trúc](/images/5-Workshop/5.2-Prerequiste/image2.png)

---

#### 2. Quá trình triển khai dịch vụ

##### A. Tích hợp Yahoo Finance API
Yahoo Finance là nguồn dữ liệu thị trường chính của hệ thống. Dịch vụ sử dụng Yahoo Finance để lấy dữ liệu giá cổ phiếu như giá mở cửa, giá cao nhất, giá thấp nhất, giá đóng cửa, khối lượng giao dịch và lịch sử giá theo từng khung thời gian.

##### B. Triển khai Backend (Compute & Storage)

*   **Amazon S3 (Raw Data Storage):** Khởi tạo S3 Bucket với tên `production-stock-raw-data-finance`.
    
    Amazon S3 dùng để lưu trữ dữ liệu thô lấy từ Yahoo Finance. Việc lưu raw data giúp hệ thống có thể kiểm tra lại dữ liệu đầu vào, tái xử lý khi cần và tách biệt bước thu thập dữ liệu với bước phân tích.
    
    ![Khởi tạo S3](/images/5-Workshop/5.2-Prerequiste/image3.png)

*   **Amazon SQS (Hàng đợi thông điệp):** Tạo hai queue `stock-processing-dlq` (Dead-Letter Queue) và `stock-processing-queue`.
    
    Amazon SQS đóng vai trò hàng đợi trung gian giữa Ingestion Lambda và Processing Lambda. SQS giúp hệ thống xử lý bất đồng bộ, tránh việc Lambda thu thập dữ liệu phải chờ quá trình phân tích hoàn tất. Khi có dữ liệu mới, message sẽ được đưa vào SQS để Processing Lambda xử lý sau.
    
    ![Khởi tạo SQS Queue](/images/5-Workshop/5.2-Prerequiste/image4.png)
    
    ![Danh sách SQS Queue](/images/5-Workshop/5.2-Prerequiste/image5.png)

*   **AWS Lambda (Xử lý logic serverless):** Tạo 2 hàm Lambda với môi trường chạy `Node.js 22.x` hoặc Python tương ứng:
    *   `Ingestion-Lambda`: Có nhiệm vụ nhận yêu cầu phân tích cổ phiếu từ API Gateway, gọi Yahoo Finance để lấy dữ liệu thị trường, chuẩn hóa dữ liệu và lưu dữ liệu thô vào S3. Sau đó Lambda gửi message vào SQS để kích hoạt bước xử lý tiếp theo.
    *   `Processing-Lambda`: Là thành phần xử lý chính của hệ thống. Lambda này đọc dữ liệu từ S3 thông qua message trong SQS, tính toán các chỉ báo kỹ thuật như RSI, MACD, MA20, MA50 và Volume. Sau đó, gửi dữ liệu đã tính sang Amazon Bedrock để AI tạo phân tích và khuyến nghị.
    
    ![Cấu hình Lambda Functions](/images/5-Workshop/5.2-Prerequiste/image6.png)

*   **AWS IAM Role (Quản lý quyền truy cập):** Thiết lập các IAM Role phù hợp cấp quyền cho các hàm Lambda truy cập S3, SQS, Bedrock, DynamoDB và KMS.
    
    ![IAM Role](/images/5-Workshop/5.2-Prerequiste/image7.png)
    
    ![IAM Policy Document](/images/5-Workshop/5.2-Prerequiste/image8.png)
    
    ![IAM Role list](/images/5-Workshop/5.2-Prerequiste/image9.png)

---

##### C. Triển khai Cơ sở dữ liệu (Database)

*   **AWS KMS (Quản lý khóa mã hóa):** Tạo mã khóa KMS để mã hóa dữ liệu nhạy cảm.
    
    AWS KMS được sử dụng để mã hóa dữ liệu lưu trữ trong DynamoDB. Dữ liệu phân tích và thông tin liên quan được bảo vệ ở trạng thái lưu trữ bằng cơ chế mã hóa at-rest, giúp tăng tính bảo mật cho hệ thống.
    
    ![Khởi tạo KMS Key](/images/5-Workshop/5.2-Prerequiste/image10.png)

*   **Amazon DynamoDB:** Tạo bảng với tên `Stock_reports_1` sử dụng Partition Key (PK) và Sort Key (SK).
    
    DynamoDB dùng để lưu kết quả phân tích cuối cùng, bao gồm mã cổ phiếu, khung thời gian, chỉ báo kỹ thuật, khuyến nghị AI, điểm tin cậy, lý do phân tích và trạng thái phê duyệt của trader. Đây là nơi Dashboard truy vấn dữ liệu để hiển thị báo cáo cho người dùng.
    
    ![Cấu hình DynamoDB Table](/images/5-Workshop/5.2-Prerequiste/image11.png)
    
    *   **Bảo mật bảng DynamoDB bằng AWS KMS:**
        
        ![DynamoDB Encryption with KMS](/images/5-Workshop/5.2-Prerequiste/image12.png)

---

##### D. Triển khai Frontend & Bảo mật (Frontend Deployment)

*   **Amazon S3 (Frontend Hosting):** Tạo S3 Bucket với tên `stock-frontend-finance` và cấu hình tính năng Static Website Hosting.
    
    Ngoài chức năng lưu trữ dữ liệu thô ở Backend, Amazon S3 còn được sử dụng để lưu trữ mã nguồn giao diện Web dưới dạng Static Website Hosting. Các tệp HTML, CSS, JavaScript và các tài nguyên tĩnh khác được lưu trong S3 và được CloudFront phân phối đến người dùng. Cách triển khai này giúp giảm chi phí vận hành, không cần quản lý máy chủ Web và dễ dàng cập nhật phiên bản giao diện mới.
    
    ![Khởi tạo S3 Frontend Bucket](/images/5-Workshop/5.2-Prerequiste/image13.png)

*   **Amazon CloudFront & AWS WAF (Phân phối & Tường lửa):**
    *   **Amazon CloudFront:** Là dịch vụ CDN (Content Delivery Network) được sử dụng để phân phối giao diện Web của hệ thống đến người dùng với tốc độ nhanh hơn. CloudFront lưu các nội dung tĩnh tại các Edge Location gần người dùng, từ đó giảm độ trễ khi truy cập và giảm tải cho S3. Ngoài ra, CloudFront còn hỗ trợ HTTPS và tích hợp với AWS WAF.
    *   **AWS WAF:** Được triển khai trước CloudFront nhằm bảo vệ ứng dụng Web khỏi các cuộc tấn công phổ biến trên Internet. WAF cho phép xây dựng các luật (Rules) để lọc và chặn các request độc hại như SQL Injection, Cross-Site Scripting (XSS), bot hoặc các request có tần suất bất thường.
    
    ![Cấu hình CloudFront Distribution](/images/5-Workshop/5.2-Prerequiste/image14.png)
    
    ![Tích hợp AWS WAF Web ACL](/images/5-Workshop/5.2-Prerequiste/image15.png)
    
    ![Cấu hình CloudFront Origins](/images/5-Workshop/5.2-Prerequiste/image16.png)

*   **Amazon Cognito (Xác thực người dùng):** Tạo User Pool phục vụ quản lý tài khoản.
    
    Amazon Cognito dùng để xác thực người dùng đăng nhập vào hệ thống. Chỉ những người dùng hợp lệ như trader hoặc admin mới có thể truy cập Dashboard, xem báo cáo phân tích và thực hiện thao tác phê duyệt hoặc từ chối khuyến nghị.
    
    ![Khởi tạo Cognito User Pool](/images/5-Workshop/5.2-Prerequiste/image17.png)
    
    *   **Giao diện đăng nhập quản trị qua Cognito:**
        
        ![Cognito Login UI](/images/5-Workshop/5.2-Prerequiste/image18.png)

---

##### E. Triển khai Cổng API & Kết nối AI (API & AI Services)

*   **Amazon API Gateway:** Tạo REST API với tên `Ingestion-lambda-API`.
    
    API Gateway đóng vai trò là cổng giao tiếp giữa Frontend và Backend. Khi người dùng thao tác trên Dashboard, request sẽ được gửi đến API Gateway, sau đó API Gateway chuyển tiếp request đến các Lambda tương ứng.
    
    ![Khởi tạo API Gateway](/images/5-Workshop/5.2-Prerequiste/image19.png)
    
    *   **Cấu hình tài nguyên và phương thức (Resources & Methods):**
        
        ![Cấu hình API Gateway Resources](/images/5-Workshop/5.2-Prerequiste/image20.png)

*   **Amazon Bedrock (AI Reasoning Engine):** Yêu cầu hạn mức truy cập mô hình (Model access / Request quota).
    
    Amazon Bedrock được sử dụng để phân tích dữ liệu kỹ thuật đã được backend tính toán. Bedrock không trực tiếp lấy dữ liệu thị trường và không dùng tin tức. Nó chỉ nhận các chỉ số như RSI, MACD, MA và giá cổ phiếu để tạo ra khuyến nghị như “MUA MẠNH”, “BÁN MẠNH” hoặc “THEO DÕI”, kèm theo điểm tin cậy và lý do phân tích.
    
    ![Yêu cầu quyền truy cập Amazon Bedrock Model](/images/5-Workshop/5.2-Prerequiste/image21.png)
    
    ![Danh sách Models được cấp quyền sử dụng](/images/5-Workshop/5.2-Prerequiste/image22.png)