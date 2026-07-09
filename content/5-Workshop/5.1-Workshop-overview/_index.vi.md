---
title: "Giới thiệu"
date: 2026-07-09
weight: 1
chapter: false
pre: " <b> 5.1. </b> "
---

#### Tổng quan về hệ thống
Hệ thống được xây dựng nhằm hỗ trợ quá trình phân tích cổ phiếu bằng kiến trúc AWS Serverless. Dữ liệu giá cổ phiếu được lấy từ Yahoo Finance, sau đó được xử lý qua các dịch vụ như Lambda, S3, SQS, Amazon Bedrock và DynamoDB.

Hệ thống sẽ tự động thu thập dữ liệu thị trường, tính toán các chỉ báo kỹ thuật như RSI, MACD, MA và Volume, sau đó gửi các chỉ số đã tính cho Amazon Bedrock để tạo ra phân tích và khuyến nghị đầu tư. Kết quả phân tích sẽ được hiển thị trên Dashboard để trader xem xét, phê duyệt hoặc từ chối trước khi gửi thông báo đến khách hàng qua email.

#### Khách hàng là ai?
Khách hàng của hệ thống là những người quan tâm đến việc theo dõi và đầu tư cổ phiếu, bao gồm:
*   Nhà đầu tư cá nhân muốn nhận gợi ý phân tích cổ phiếu.
*   Người mới tham gia thị trường cần công cụ hỗ trợ đọc hiểu tín hiệu kỹ thuật.
*   Trader hoặc nhân viên tư vấn tài chính cần dashboard để xem xét khuyến nghị trước khi gửi cho khách hàng.

Trong hệ thống này, khách hàng cuối không trực tiếp nhận khuyến nghị từ AI ngay lập tức. Thay vào đó, kết quả phân tích sẽ được trader kiểm tra trước nhằm đảm bảo tính an toàn và giảm rủi ro khi đưa ra thông tin đầu tư.

#### Hệ thống dùng để giải quyết vấn đề gì?
Hệ thống giải quyết vấn đề phân tích cổ phiếu thủ công tốn thời gian và dễ bỏ sót tín hiệu kỹ thuật. Khi số lượng mã cổ phiếu tăng lên, trader khó có thể theo dõi toàn bộ dữ liệu giá, khối lượng và các chỉ báo kỹ thuật một cách liên tục.

Hệ thống giúp tự động hóa các bước chính:
*   Thu thập dữ liệu cổ phiếu từ Yahoo Finance.
*   Lưu trữ dữ liệu thô để phục vụ kiểm tra và xử lý lại.
*   Tính toán các chỉ báo kỹ thuật ở backend.
*   Dùng AI để hỗ trợ phân tích các chỉ số đã tính.
*   Lưu kết quả phân tích vào DynamoDB.
*   Cho phép trader phê duyệt trước khi gửi email cho khách hàng.

Nhờ đó, hệ thống giúp rút ngắn thời gian phân tích, tăng khả năng theo dõi nhiều mã cổ phiếu cùng lúc và đảm bảo khuyến nghị cuối cùng vẫn có sự kiểm soát của con người.
