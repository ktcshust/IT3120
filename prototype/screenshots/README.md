# Bộ ảnh chụp prototype ATS mini — Person D

Thư mục này chứa toàn bộ ảnh chụp màn hình của prototype click-through
`prototype/index.html` (deliverable D8). Ảnh được sinh tự động bằng
`prototype/capture_screenshots.sh` nên có thể dựng lại bất cứ lúc nào và luôn
khớp với phiên bản prototype hiện tại. Bộ ảnh phục vụ hai mục đích: minh hoạ
cho phần trình diễn trong slide bảo vệ (`slides/defense_slides_v1.md`, khối
slide 25–27) và làm hình minh hoạ cho Chương 5 (`report/chapter_5_design.md`)
cùng phần đánh giá kết quả ở Chương 6 (`report/chapter_6_conclusion.md`).

Toàn bộ dữ liệu trên ảnh là dữ liệu giả của công ty hư cấu **VXTech** theo đúng
bộ dữ liệu mẫu đã chốt trong hợp đồng thiết kế của D; không có tên doanh nghiệp
hay thông tin cá nhân có thật.

## 1. Bảng danh mục ảnh

| Tên file | Màn hình | Trạng thái được chụp | UC / BR / NFR mà ảnh chứng minh | Dùng ở slide |
|---|---|---|---|---|
| `01-scr01-dang-nhap.png` | SCR-01 | Màn đăng nhập SSO, bộ chọn vai trò cho 6 role nội bộ | Tiền đề của mọi UC; NFR-04 (SSO OIDC, RBAC 6 role) | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `02-scr02-dashboard-day-du.png` | SCR-02 | Dashboard Recruiter đầy dữ liệu: JD phụ trách, việc cần xử lý, cảnh báo SLA | UC-01, UC-02; NFR-01 (danh sách ≤2s) | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `03-scr02-dashboard-trong.png` | SCR-02 | Trạng thái rỗng khi tài khoản chưa được giao JD nào | UC-02; yêu cầu "empty state" trong danh mục màn hình SCR-02 | Cụm slide 25–27 (ảnh phụ khi demo) |
| `04-scr03-kanban.png` | SCR-03 | Kanban pipeline đủ 7 cột `NEW` → `Kết thúc`, kéo-thả đổi trạng thái | UC-02 → UC-01; STATE-01; NFR-06 (mỗi transition sinh `application_status_history` + `audit_logs`) | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `05-scr04-ho-so-ung-vien.png` | SCR-04 | Hồ sơ ứng viên và timeline, nút tải CV bằng signed URL | UC-02, UC-03, UC-04; BR-20 (phạm vi xem hồ sơ); NFR-05, NFR-12 | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `06-scr05-xep-lich-khong-xung-dot.png` | SCR-05 | Chọn khung 09:00–10:00, không xung đột, nút xác nhận mở | UC-01; BR-03 (kiểm tra chồng lấn) | Slide 26 |
| `07-scr05-xep-lich-xung-dot.png` | SCR-05 | Chọn khung 14:00–15:00 trùng lịch của Vũ Ngọc Lan, hiện cảnh báo và 3 khung trống gợi ý, nút xác nhận bị khoá | UC-01; BR-03; NFR-02 (0 lịch trùng); quy tắc `newStart < existingEnd AND newEnd > existingStart` | Slide 26 |
| `08-scr05-xep-lich-override.png` | SCR-05 | Đã nhập lý do override đủ độ dài, nút xác nhận mở lại | BR-26 (override phải có lý do + audit); NFR-06 | Slide 26 |
| `09-scr06-scorecard-dang-nhap.png` | SCR-06 | Scorecard đang nhập dở: 4/5 tiêu chí có điểm, còn thiếu nhận xét nên nút submit bị khoá | UC-03; BR-15 (bắt buộc nhận xét bằng lời) | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `10-scr06-scorecard-da-khoa.png` | SCR-06 | Đã submit: điểm trung bình 4,20, bảng tiêu chí chuyển chỉ đọc, hiện mốc khoá sau 24h | UC-03 A5.1; BR-06 (SLA feedback); BR-07 (kết luận vòng) | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `11-scr07-offer-trong-band.png` | SCR-07 | Bước 2 wizard, lương 45.000.000 VND nằm trong band → chuỗi duyệt 1 cấp | UC-04; BR-08 | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `12-scr07-offer-vuot-band.png` | SCR-07 | Lương 51.840.000 VND vượt trần band 8,0% → chuỗi duyệt 2 cấp | UC-04; BR-08; cột `offers.band_snapshot_min/max` | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `13-scr07-offer-vuot-band-3-cap.png` | SCR-07 | Bước 4 wizard, lương 56.000.000 VND vượt band 16,7% → chuỗi duyệt 3 cấp có Người duyệt Tài chính | UC-04; BR-08; BR-16 | Cụm slide 25–27 (ảnh phụ khi demo) |
| `14-scr08-hop-thu-duyet.png` | SCR-08 | Hộp duyệt của Head of HR: offer OFF-318 đã qua cấp 1, đang chờ cấp 2, đủ 3 nút quyết định | UC-04; BR-08; ADR-10 (deny-by-default) | Slide 27 |
| `15-scr08-yeu-cau-chinh-sua.png` | SCR-08 | Sau khi bấm "Yêu cầu chỉnh sửa": `attempt_no` tăng lên 2, chuỗi duyệt quay lại cấp 1, nút quyết định bị khoá với vai trò không phải cấp đang chờ | UC-04 A4.1; BR-16; BR-21; NFR-06 | Slide 27 |
| `16-scr09-cong-ung-vien.png` | SCR-09 | Cổng ứng viên qua liên kết mời có hạn: timeline hồ sơ, lịch chờ xác nhận, thư mời làm việc | UC-01 (xác nhận lịch), UC-04/UC-06 (phản hồi offer); BR-05; ADR-09 (magic-link token) | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `17-scr09-cong-ung-vien-da-xac-nhan.png` | SCR-09 | Đã xác nhận tham dự và đang mở khung đề nghị mức lương khác | UC-01; UC-06 (counter-offer); BR-05 | Cụm slide 25–27 (ảnh phụ khi demo) |
| `18-scr10-bao-cao-day-du.png` | SCR-10 | Bốn biểu đồ báo cáo kèm dòng `dataFreshness` "độ trễ 12 phút" | UC-05; BR-24; NFR-10; ADR-07 (read model `rm_*` đọc trên replica) | Cụm slide 25–27 (ảnh minh hoạ khi demo) |
| `19-scr10-bao-cao-trong.png` | SCR-10 | Trạng thái chưa đủ dữ liệu để dựng biểu đồ | UC-05; yêu cầu "empty state" của SCR-10 | Cụm slide 25–27 (ảnh phụ khi demo) |
| `20-scr11-quan-tri.png` | SCR-11 | Quản trị người dùng, phòng ban và form phân quyền của HR Admin | F09 (ngoài 5 UC trọng tâm); BR-20, BR-21; NFR-04 | Cụm slide 25–27 (ảnh phụ khi demo) |

Ảnh được đánh số theo đúng thứ tự trình diễn của kịch bản demo sáu bước
(đăng nhập và đổi vai trò → sàng lọc CV → xếp lịch → ghi feedback → duyệt offer
vượt band → xem báo cáo), nên khi chèn vào slide chỉ cần lấy lần lượt từ trên xuống.

## 2. Thông số kỹ thuật của bộ ảnh

- Định dạng PNG, mật độ điểm ảnh 2x (`--force-device-scale-factor=2`) để chữ
  không bị vỡ khi phóng lên máy chiếu.
- Bề rộng viewport mặc định 1440 px CSS (ảnh rộng 2880 px). Riêng
  `04-scr03-kanban.png` dùng viewport 2040 px và nới `max-width` của vùng nội
  dung lên 1800 px để cả 7 cột pipeline (`NEW` → `Kết thúc`) nằm gọn trong một
  ảnh; trên màn hình thường, dải kanban cuộn ngang đúng như thiết kế.
- Chiều cao mỗi ảnh được đo theo chiều cao thực của màn hình đang hiển thị nên
  nội dung không bị cắt. Khung nội dung có chiều cao tối thiểu 900 px CSS, vì
  vậy những cảnh ngắn hơn sàn này còn một khoảng trắng đáng kể ở đáy ảnh. Hiện
  có 12/20 ảnh cao đúng 900 px CSS (1800 px thật) vì chạm sàn; rõ nhất là hai
  ảnh trạng thái rỗng `03-scr02-dashboard-trong.png` và
  `19-scr10-bao-cao-trong.png`. Khi đưa lên slide nên cắt bớt phần trắng ở đáy
  cho cân bố cục.
- Thanh công cụ demo ở góc dưới bên phải và lớp chú thích của prototype được ẩn
  khi chụp để không che nội dung giao diện.

## 3. Cách chụp lại khi prototype thay đổi

Chạy từ thư mục gốc của repo:

```bash
bash prototype/capture_screenshots.sh
```

Script chụp toàn bộ ảnh vào một thư mục tạm trước, tự kiểm tra ba điều kiện —
chụp đủ 20 cảnh, mọi ảnh lớn hơn 20 KB và không có hai ảnh nào trùng mã băm
(trùng mã băm nghĩa là kịch bản cảnh không đổi được màn hình) — rồi mới thay
thế bộ ảnh trong thư mục này. Nếu một cảnh lỗi giữa chừng thì bộ ảnh cũ được
giữ nguyên và script báo lỗi. Kết quả kiểm tra được in ra cuối phiên chạy.

Yêu cầu môi trường: Google Chrome (hoặc Chromium) và `python3`. Mặc định script
tìm Chrome tại `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`;
nếu không có, script dò thêm vài vị trí phổ biến khác và có thể chỉ định thẳng
qua biến môi trường `CHROME_BIN`:

```bash
CHROME_BIN=/usr/bin/google-chrome bash prototype/capture_screenshots.sh
```

Script chạy hoàn toàn ngoại tuyến, không cài thêm thư viện nào.

Cách hoạt động: với mỗi cảnh, script tạo một bản sao tạm của `index.html`, chèn
một khối `<script>` trước thẻ `</body>` để tự động đặt vai trò, chuyển màn hình
và bật đúng trạng thái cần chụp, gọi Chrome ở chế độ headless hai lượt (lượt
một đo chiều cao nội dung, lượt hai chụp ảnh), rồi xoá file tạm. Muốn thêm một
cảnh mới, chỉ cần thêm một khối `scene <tên-file> <<'JS' … JS` trong script;
mọi hàm công khai của prototype (`showScreen`, `setRole`, `openSchedule`,
`evaluateSchedule`, `renderChain`, `setWizardStep`, `selectOffer`, `decide`,
`submitScorecard`, `resetScorecard`) đều gọi được từ kịch bản cảnh.

## 4. Ghi chú kiểm chứng

Bộ ảnh hiện tại gồm 20 tấm, đã được kiểm tra: mọi tệp đều lớn hơn 20 KB, không
có tệp nào trùng mã băm, và mười tấm đại diện (gồm kanban, xung đột lịch,
override lịch, scorecard đã khoá, offer vượt band, chuỗi duyệt 3 cấp, hộp duyệt
offer, yêu cầu chỉnh sửa, báo cáo đầy đủ, cổng ứng viên) đã được xem lại bằng
mắt để xác nhận đúng cảnh, tiếng Việt hiển thị đủ dấu và nội dung không bị cắt.
Khoảng trắng ở đáy của các ảnh chạm sàn 900 px CSS (xem mục 2) là hệ quả của
chiều cao tối thiểu chứ không phải lỗi dựng ảnh.

Trong lúc dựng bộ ảnh, chúng em có sửa một điểm nhỏ của `prototype/index.html`:
sau khi submit scorecard, bảng 5 tiêu chí không còn bị ẩn đi mà chuyển sang chế
độ chỉ đọc, để người xem đối chiếu được điểm và nhận xét đã ghi (đúng tinh thần
UC-03 A5.1 "còn sửa được trong 24h rồi khoá vĩnh viễn").

Đợt rà soát cuối còn sửa thêm sáu điểm dữ liệu trong `prototype/index.html` để
các con số trên ảnh không tự mâu thuẫn: tổng hire theo nguồn tuyển hạ về đúng 7
cho khớp phễu tuyển dụng; mốc khoá feedback 24 giờ đổi thành 15/08/2026 15:05
cho khớp mốc submit 14/08/2026 15:05 (ở cả `SCR-04` và `SCR-06`); vòng cần đặt
trên `SCR-05` đổi từ `R1 — Technical Round 1` sang `R2 — System Design`; thẻ KPI
"JD đang mở" đổi từ 3 xuống 2 vì `JD-03` đang ở `DRAFT`; việc cần xử lý về
feedback quá hạn đổi sang hồ sơ Ngô Phương Thảo (JD-02) đúng như Hình 5.64;
và hành động audit đổi từ `OVERRIDE_SCHEDULE_CONFLICT` sang mã chuẩn
`INTERVIEW_CONFLICT_OVERRIDE` trên buổi `INT-2088` mới tạo. Chip "Đã xác nhận
15/08/2026 20:12" ở `SCR-09` nay do chính handler của prototype đặt, nên cảnh 17
gọi đúng luồng thật thay vì chèn chuỗi vào DOM.
