---
title: "Cải tiến trong tương lai"
date: 2026-07-09
weight: 5
chapter: false
pre: " <b> 5.5. </b> "
---

### Cải tiến trong tương lai

Sau giai đoạn triển khai và kiểm thử ban đầu, **Stock Alerts System** đã thể hiện được luồng xử lý Serverless hoàn chỉnh từ bước thu thập dữ liệu thị trường đến bước kiểm duyệt khuyến nghị có hỗ trợ AI. Tuy nhiên, hệ thống vẫn có thể được cải tiến thêm để tăng độ tin cậy, bảo mật, khả năng mở rộng và tính ứng dụng trong quy trình làm việc thực tế của trader.

---

#### 1. Mở rộng và kiểm tra chất lượng nguồn dữ liệu
Phiên bản hiện tại chủ yếu sử dụng Yahoo Finance làm nguồn dữ liệu thị trường. Trong tương lai, hệ thống có thể tích hợp thêm các nhà cung cấp dữ liệu tài chính khác để đối chiếu giá, khối lượng giao dịch và dữ liệu lịch sử trước khi đưa vào pipeline phân tích.

Cải tiến này giúp giảm sự phụ thuộc vào một nguồn dữ liệu duy nhất và tăng độ tin cậy của kết quả đầu vào. Hệ thống cũng có thể bổ sung các rule kiểm tra dữ liệu như phát hiện nến bị thiếu, giá bất thường hoặc phiên giao dịch chưa đầy đủ trước khi lưu raw data vào Amazon S3.

#### 2. Cải thiện chỉ báo kỹ thuật và prompt AI
Ở giai đoạn hiện tại, backend đã tính toán các chỉ báo phổ biến như RSI, MACD, MA20, MA50 và Volume. Phiên bản tiếp theo có thể bổ sung thêm các chỉ báo như Bollinger Bands, Stochastic Oscillator, ADX, ATR và vùng hỗ trợ/kháng cự.

Prompt gửi đến Amazon Bedrock cũng nên được tinh chỉnh để mô hình trả về kết quả có cấu trúc ổn định hơn, bao gồm loại khuyến nghị, điểm tin cậy, lý do phân tích, mức độ rủi ro và ghi chú hành động ngắn cho trader. Điều này giúp kết quả AI dễ kiểm duyệt và dễ lưu trữ trong DynamoDB hơn.

#### 3. Bổ sung rule cảnh báo thời gian thực
Hệ thống có thể mở rộng thêm các rule cảnh báo theo thời gian thực hoặc theo lịch chạy định kỳ. Trader có thể thiết lập các điều kiện như giá vượt ngưỡng mục tiêu, RSI đi vào vùng quá mua/quá bán, MACD đảo chiều hoặc khối lượng giao dịch tăng bất thường.

Khi điều kiện được kích hoạt, hệ thống có thể đưa tác vụ vào Amazon SQS để xử lý bất đồng bộ, sau đó gửi thông báo cho trader hoặc khách hàng thông qua Amazon SES, email template hoặc các kênh khác sau khi trader phê duyệt.

#### 4. Tăng cường quy trình human-in-the-loop
Vì khuyến nghị cổ phiếu có thể ảnh hưởng đến quyết định đầu tư, hệ thống nên tiếp tục giữ bước kiểm duyệt của con người như một lớp an toàn chính. Các phiên bản sau có thể cải thiện workflow kiểm duyệt bằng cách bổ sung các trạng thái như `PENDING_REVIEW`, `APPROVED`, `REJECTED` và `SENT`.

Dashboard cũng có thể ghi nhận ai là người phê duyệt khuyến nghị, thời điểm phê duyệt và lý do từ chối báo cáo. Điều này tạo ra audit trail rõ ràng hơn cho bài toán tư vấn tài chính.

#### 5. Hoàn thiện phân quyền người dùng
Lớp xác thực hiện tại sử dụng Amazon Cognito. Trong tương lai, hệ thống nên định nghĩa rõ hơn cơ chế phân quyền theo vai trò:

*   **Admin:** Quản lý người dùng, cấu hình hệ thống và thiết lập giám sát.
*   **Trader:** Kiểm duyệt khuyến nghị AI và phê duyệt hoặc từ chối báo cáo.
*   **Customer:** Nhận báo cáo đã được phê duyệt hoặc xem lịch sử khuyến nghị.

Cách tách vai trò này giúp bảo vệ các thao tác nhạy cảm và ngăn người dùng cuối truy cập vào những chức năng nội bộ của hệ thống.

#### 6. Tăng cường bảo mật và khả năng audit
Project hiện đã sử dụng các dịch vụ như AWS WAF, KMS, Cognito và IAM. Bước tiếp theo là bổ sung các lớp giám sát và audit mạnh hơn, bao gồm CloudWatch Alarms, CloudTrail logs, chính sách IAM theo nguyên tắc least privilege, giới hạn tần suất gọi API và WAF rules cho các kiểu tấn công phổ biến.

Dữ liệu nhạy cảm trong DynamoDB và S3 vẫn cần được mã hóa bằng KMS. Access logs cũng nên được kiểm tra định kỳ để phát hiện các hành vi gọi API bất thường hoặc truy cập không hợp lệ.

#### 7. Tối ưu chi phí và hiệu năng
Vì chi phí Amazon Bedrock phụ thuộc nhiều vào lượng token sử dụng, prompt cần được tối ưu trước khi gửi đến mô hình. Backend nên tránh gửi toàn bộ dữ liệu lịch sử thô, thay vào đó chỉ gửi các chỉ báo đã tính toán và những phần tóm tắt quan trọng.

Các hướng tối ưu khác gồm cache dữ liệu cổ phiếu được yêu cầu thường xuyên, tinh chỉnh bộ nhớ và timeout của Lambda, theo dõi AWS Cost Explorer và thiết lập billing alerts. Những cải tiến này giúp hệ thống phù hợp hơn với môi trường đồ án hoặc nhóm nhỏ.

#### 8. Nâng cấp trải nghiệm Dashboard
Dashboard có thể được cải thiện bằng các biểu đồ tương tác, bộ lọc theo mã cổ phiếu, khung thời gian, trạng thái khuyến nghị, điểm tin cậy và trạng thái phê duyệt. Việc bổ sung màn hình lịch sử phân tích cũng giúp trader so sánh khuyến nghị trước đó với biến động thị trường hiện tại.

Để trải nghiệm thực tế hơn, Dashboard nên hiển thị rõ các trạng thái như đang xử lý, phân tích thất bại, fallback mode, lỗi quota và tạo báo cáo thành công.

#### 9. Bổ sung CI/CD cho Frontend và Backend
Quy trình triển khai có thể được tự động hóa bằng GitHub Actions hoặc AWS CodePipeline. CI/CD workflow nên thực hiện build và test Lambda code, kiểm tra cấu hình hạ tầng, deploy frontend lên S3 và invalidate cache CloudFront khi có phiên bản mới.

Điều này giúp project dễ bảo trì hơn và giảm lỗi thao tác thủ công khi hệ thống phát triển lớn hơn.

#### 10. Đo lường độ chính xác của khuyến nghị
Để đánh giá mức độ hữu ích của khuyến nghị có hỗ trợ AI, hệ thống nên lưu lại biến động thực tế của cổ phiếu sau khi khuyến nghị được tạo, ví dụ sau 1 ngày, 3 ngày và 1 tuần.

Bằng cách so sánh biến động thực tế với khuyến nghị trước đó của AI, nhóm có thể đo lường độ chính xác, phát hiện các tín hiệu yếu, cải thiện cách tính điểm tin cậy và tinh chỉnh prompt theo thời gian.

---

### Tổng kết

Định hướng phát triển tiếp theo của project là chuyển từ một prototype đã chạy được sang một nền tảng phân tích tài chính hoàn thiện hơn. Các ưu tiên quan trọng nhất là tăng độ tin cậy của dữ liệu, làm cho khuyến nghị AI nhất quán hơn, giữ quy trình kiểm duyệt của con người, tăng cường bảo mật và xây dựng vòng phản hồi để đo lường độ chính xác của khuyến nghị.
