-- =====================================================================
-- ATS mini — Dữ liệu mẫu cho buổi demo
-- Person D — System & UI Designer | Chương 5-6
-- Phiên bản: v1.0 (khớp sql/schema.sql v1.2 của C — 18 bảng, 9 ENUM)
--
-- MỤC ĐÍCH
--   Bộ dữ liệu này chứng minh rằng 11 màn hình SCR-01…SCR-11 trong
--   wireframes/D_wireframes_v1.md và prototype/index.html đọc được từ đúng
--   schema 18 bảng của C, không cần thêm bất kỳ cột nào. Mỗi nhánh nghiệp vụ
--   được minh hoạ trong buổi bảo vệ đều có hàng dữ liệu tương ứng:
--   BR-03 (trùng lịch), BR-05 (SLA xác nhận lịch), BR-06 (SLA feedback 48h),
--   BR-07 (quy tắc >=50% HIRE), BR-08 (số cấp duyệt offer), BR-13 (hold),
--   cơ chế attempt_no khi REQUEST_CHANGE, và dữ liệu funnel cho SCR-10.
--
-- CÁCH CHẠY
--   createdb ats_mini
--   psql -d ats_mini -f sql/schema.sql
--   psql -d ats_mini -f sql/seed_demo_D.sql
--   Yêu cầu: chạy trên một database TRỐNG vừa tạo bằng schema.sql. File này
--   dùng id tường minh nên sẽ báo lỗi khoá chính nếu bảng đã có dữ liệu.
--
-- CẢNH BÁO
--   CHỈ DÙNG CHO DEMO / MÔI TRƯỜNG HỌC TẬP. Không nạp vào môi trường thật.
--   Toàn bộ tên người, email, số liệu lương đều là dữ liệu hư cấu của công ty
--   giả định "Công ty CP Công nghệ Vạn Xuân (VXTech)", miền nội bộ @vxtech.vn.
--   Không có dữ liệu cá nhân thật nào được sử dụng.
--
-- QUY ƯỚC
--   - Mốc thời gian "hiện tại" của kịch bản demo: 2026-08-16 18:00.
--   - Ngày tháng được chuẩn hoá theo quan hệ nhân quả (nộp hồ sơ trước sàng
--     lọc, phỏng vấn trước feedback, feedback trước offer) nên một vài ngày
--     hiển thị trong prototype được dời lại cho hợp lý; tên người, email, tên
--     JD, mức lương và khung giờ phỏng vấn giữ nguyên đúng prototype.
--   - Không dùng cột nào ngoài sql/schema.sql. Những khái niệm giao diện cần
--     nhưng schema chưa có được ghi lại bằng comment "[D đề xuất C bổ sung: ...]"
--     và bỏ qua, đúng tinh thần "D không tự sửa schema của C".
-- =====================================================================

BEGIN;

-- ---------------------------------------------------------------------
-- 1. DEPARTMENTS — cây tổ chức 3 cấp (đệ quy qua parent_id)
-- ---------------------------------------------------------------------
-- Cấp 1: pháp nhân; cấp 2: các khối; cấp 3: Khối Dữ liệu trực thuộc Khối
-- Công nghệ. Cấu trúc này để màn SCR-11 vẽ được cây phòng ban và để RBAC
-- department scope (BR-20, NFR-04) có dữ liệu kiểm thử phân cấp.

INSERT INTO departments (id, name, parent_id, created_at, updated_at) VALUES
  (1, 'Công ty CP Công nghệ Vạn Xuân', NULL, '2026-01-05 08:00:00', '2026-01-05 08:00:00'),
  (2, 'Khối Công nghệ',                   1, '2026-01-05 08:05:00', '2026-01-05 08:05:00'),
  (3, 'Khối Nhân sự',                     1, '2026-01-05 08:05:00', '2026-01-05 08:05:00'),
  (4, 'Khối Tài chính',                   1, '2026-01-05 08:05:00', '2026-01-05 08:05:00'),
  (5, 'Khối Dữ liệu',                     2, '2026-02-10 09:00:00', '2026-02-10 09:00:00');

-- ---------------------------------------------------------------------
-- 2. USERS — 9 tài khoản nội bộ, phủ đủ 6 giá trị của ENUM user_role
-- ---------------------------------------------------------------------
-- user id 9 để is_active = FALSE nhằm minh hoạ trạng thái lỗi của SCR-01
-- (tài khoản bị vô hiệu hoá vẫn đăng nhập SSO thành công ở IdP nhưng bị
-- AuthService từ chối cấp phiên — xem NFR-04).

INSERT INTO users (id, email, name, role, department_id, is_active, created_at, updated_at) VALUES
  (1, 'minh.anh.nguyen@vxtech.vn', 'Nguyễn Minh Anh', 'RECRUITER',      3, TRUE,  '2026-01-06 08:00:00', '2026-01-06 08:00:00'),
  (2, 'quoc.bao.tran@vxtech.vn',   'Trần Quốc Bảo',   'HIRING_MANAGER', 2, TRUE,  '2026-01-06 08:00:00', '2026-01-06 08:00:00'),
  (3, 'ngoc.lan.vu@vxtech.vn',     'Vũ Ngọc Lan',     'INTERVIEWER',    2, TRUE,  '2026-01-06 08:00:00', '2026-01-06 08:00:00'),
  (4, 'hai.yen.do@vxtech.vn',      'Đỗ Hải Yến',      'HR_ADMIN',       3, TRUE,  '2026-01-06 08:00:00', '2026-01-06 08:00:00'),
  (5, 'thu.ha.le@vxtech.vn',       'Lê Thu Hà',       'HEAD_OF_HR',     3, TRUE,  '2026-01-06 08:00:00', '2026-01-06 08:00:00'),
  (6, 'duc.duy.pham@vxtech.vn',    'Phạm Đức Duy',    'FINANCE',        4, TRUE,  '2026-01-06 08:00:00', '2026-01-06 08:00:00'),
  (7, 'quang.huy.dinh@vxtech.vn',  'Đinh Quang Huy',  'INTERVIEWER',    2, TRUE,  '2026-02-01 08:00:00', '2026-02-01 08:00:00'),
  (8, 'kieu.trang.ha@vxtech.vn',   'Hà Kiều Trang',   'INTERVIEWER',    5, TRUE,  '2026-02-11 08:00:00', '2026-02-11 08:00:00'),
  (9, 'cuu.nhanvien@vxtech.vn',    'Nguyễn Cựu Nhân', 'INTERVIEWER',    2, FALSE, '2026-01-06 08:00:00', '2026-06-30 17:00:00');

-- ---------------------------------------------------------------------
-- 3. SCORECARD TEMPLATES — 2 mẫu, mỗi mẫu 5 tiêu chí, tổng trọng số = 1.00
-- ---------------------------------------------------------------------
-- Cấu trúc JSONB theo đúng ví dụ trong docs/data_dictionary_C.md mục 5:
--   [{"name":"technical","weight":0.30}, ...]
-- D bổ sung khoá "label" (nhãn tiếng Việt hiển thị trên SCR-06) và "scale".
-- [Ghi chú của D — KHÔNG nằm trong danh mục chín đề xuất gửi C (Bảng 5.52):
--  scorecard_templates chưa có cột version/is_active nên số hiệu phiên bản "v3"
--  đang phải nhét vào cột name. Đề xuất chính thức tương ứng là
--  `interview_processes.scorecard_template_version` (mức P2); ghi chú này chỉ
--  nêu hiện trạng dữ liệu mẫu, không phải một đề xuất sửa lược đồ mới.]

INSERT INTO scorecard_templates (id, name, criteria, created_at, updated_at) VALUES
  (1, 'Backend Senior v3',
   '[{"name":"technical",      "label":"Năng lực kỹ thuật",  "weight":0.30, "scale":5},
     {"name":"problemSolving", "label":"Giải quyết vấn đề",  "weight":0.25, "scale":5},
     {"name":"communication",  "label":"Giao tiếp",          "weight":0.20, "scale":5},
     {"name":"cultureFit",     "label":"Phù hợp văn hoá",    "weight":0.15, "scale":5},
     {"name":"growth",         "label":"Tinh thần cầu tiến", "weight":0.10, "scale":5}]'::jsonb,
   '2026-03-01 09:00:00', '2026-06-12 10:30:00'),
  (2, 'Data Engineer v1',
   '[{"name":"dataModeling",         "label":"Mô hình hoá dữ liệu", "weight":0.30, "scale":5},
     {"name":"pipelineEngineering",  "label":"Xây dựng pipeline",   "weight":0.25, "scale":5},
     {"name":"problemSolving",       "label":"Giải quyết vấn đề",   "weight":0.20, "scale":5},
     {"name":"communication",        "label":"Giao tiếp",           "weight":0.15, "scale":5},
     {"name":"cultureFit",           "label":"Phù hợp văn hoá",     "weight":0.10, "scale":5}]'::jsonb,
   '2026-03-01 09:00:00', '2026-03-01 09:00:00');

-- ---------------------------------------------------------------------
-- 4. JOB DESCRIPTIONS + INTERVIEW PROCESSES
-- ---------------------------------------------------------------------
-- JD-01 OPEN headcount 2  — JD chính của kịch bản demo, 3 vòng phỏng vấn.
-- JD-02 CLOSED headcount 1 — đã tuyển đủ nên tự đóng (BR-11); giữ lại để
--        SCR-10 có dữ liệu lịch sử và có ít nhất một ứng viên HIRED.
-- JD-03 DRAFT — chưa mở nên cố ý KHÔNG có application và không có vòng
--        phỏng vấn nào, dùng cho trạng thái "JD nháp" trên SCR-02.

INSERT INTO job_descriptions
  (id, title, department_id, level, salary_band_min, salary_band_max,
   hiring_manager_id, recruiter_id, status, headcount, opened_at, closed_at, created_at, updated_at) VALUES
  (1, 'Senior Backend Engineer (Java)', 2, 'Senior', 35000000.00, 48000000.00, 2, 1, 'OPEN',   2, '2026-07-20 09:00:00', NULL,                  '2026-07-18 14:20:00', '2026-08-15 14:05:00'),
  (2, 'Data Engineer',                  5, 'Middle', 28000000.00, 40000000.00, 2, 1, 'CLOSED', 1, '2026-06-15 09:00:00', '2026-08-12 08:00:00', '2026-06-12 10:00:00', '2026-08-12 08:00:00'),
  (3, 'AI Engineer',                    2, 'Senior', 40000000.00, 60000000.00, 2, 1, 'DRAFT',  1, NULL,                  NULL,                  '2026-08-14 16:40:00', '2026-08-14 16:40:00');

INSERT INTO interview_processes
  (id, jd_id, round_order, round_name, required_interviewers, scorecard_template_id, created_at, updated_at) VALUES
  (1, 1, 1, 'Technical Round 1',        2, 1, '2026-07-18 14:30:00', '2026-07-18 14:30:00'),
  (2, 1, 2, 'System Design',            1, 1, '2026-07-18 14:30:00', '2026-07-18 14:30:00'),
  (3, 1, 3, 'Culture Fit',              1, 1, '2026-07-18 14:30:00', '2026-07-18 14:30:00'),
  (4, 2, 1, 'Data Engineering Round 1', 1, 2, '2026-06-12 10:10:00', '2026-06-12 10:10:00'),
  (5, 2, 2, 'Case Study',               1, 2, '2026-06-12 10:10:00', '2026-06-12 10:10:00');

-- ---------------------------------------------------------------------
-- 5. CANDIDATES + ATTACHMENTS
-- ---------------------------------------------------------------------
-- 8 ứng viên phủ 5 nguồn tuyển: LINKEDIN, WEBSITE, REFERRAL, HEADHUNTER,
-- EMAIL. Giá trị OTHER của ENUM candidate_source cố ý không dùng vì SCR-10
-- (source effectiveness) cần các nguồn có ý nghĩa so sánh.
-- Chỉ email của Hoàng Thị Mai Chi được ấn định trong hợp đồng thiết kế của D;
-- các email còn lại đặt theo cùng quy tắc <ten>.<ho>@gmail.com cho nhất quán.

INSERT INTO candidates
  (id, full_name, email, phone, current_company, years_of_experience, experience_summary, source, parsed_profile, created_at, updated_at) VALUES
  (1, 'Hoàng Thị Mai Chi', 'mai.chi.hoang@gmail.com',    '0912345671', 'FPT Software',   6, 'Senior Backend Engineer, 6 năm Java/Spring Boot, PostgreSQL, Kafka.',            'LINKEDIN',   '{"skills":["Java 17","Spring Boot","PostgreSQL","Kafka"],"expectedSalary":52000000,"availableFrom":"2026-09-01"}'::jsonb, '2026-08-10 08:47:00', '2026-08-10 08:47:00'),
  (2, 'Ngô Phương Thảo',   'phuong.thao.ngo@gmail.com',  '0912345672', 'VNG',            5, 'Backend Engineer, 5 năm Kotlin/Java, có kinh nghiệm hệ thống thanh toán.',      'WEBSITE',    '{"skills":["Kotlin","Java","MySQL"],"expectedSalary":45000000}'::jsonb, '2026-07-05 14:00:00', '2026-08-05 09:30:00'),
  (3, 'Trịnh Bá Long',     'ba.long.trinh@gmail.com',    '0912345673', 'Viettel Digital', 5, 'Backend Engineer, 5 năm Golang, đang chuyển hướng sang hệ sinh thái Java.',    'EMAIL',      '{"skills":["Golang","Java","Docker"]}'::jsonb, '2026-06-25 10:20:00', '2026-08-07 11:00:00'),
  (4, 'Đặng Khánh Linh',   'khanh.linh.dang@gmail.com',  '0912345674', 'MISA',           4, 'Backend Engineer, 4 năm Java, kinh nghiệm hệ thống kế toán doanh nghiệp.',      'WEBSITE',    '{"skills":["Java","Spring","Oracle"]}'::jsonb, '2026-08-09 08:00:00', '2026-08-09 08:00:00'),
  (5, 'Lý Gia Hân',        'gia.han.ly@gmail.com',       '0912345675', 'Base.vn',        3, 'Backend Engineer, 3 năm Java, mạnh về tích hợp API nội bộ.',                    'LINKEDIN',   '{"skills":["Java","REST","Redis"]}'::jsonb, '2026-07-02 09:10:00', '2026-08-13 20:10:00'),
  (6, 'Phan Anh Tuấn',     'anh.tuan.phan@gmail.com',    '0912345676', 'Grab Việt Nam',  8, 'Staff Engineer, 8 năm, kiến trúc microservices và hệ thống dữ liệu lớn.',       'HEADHUNTER', '{"skills":["Java","Kafka","Kubernetes"],"expectedSalary":50000000}'::jsonb, '2026-07-28 10:00:00', '2026-08-11 09:15:00'),
  (7, 'Vương Hải Đăng',    'hai.dang.vuong@gmail.com',   '0912345677', 'Momo',           7, 'Senior Backend Engineer, 7 năm, chuyên hệ thống giao dịch thời gian thực.',     'LINKEDIN',   '{"skills":["Java","Spring","Kafka"],"expectedSalary":54000000}'::jsonb, '2026-07-25 08:40:00', '2026-08-11 10:00:00'),
  (8, 'Bùi Tuấn Kiệt',     'tuan.kiet.bui@gmail.com',    '0912345678', 'Zalo',           5, 'Data Engineer, 5 năm Spark/Airflow, được nhân viên nội bộ giới thiệu.',         'REFERRAL',   '{"skills":["Spark","Airflow","Python","SQL"],"expectedSalary":39000000}'::jsonb, '2026-06-20 08:15:00', '2026-08-01 09:00:00');

-- Mỗi ứng viên có 1 CV; riêng ứng viên 1 có 2 phiên bản để minh hoạ nhãn
-- "attachments · v2" trên SCR-04 và cơ chế versioning của ADR-04 / NFR-12.
-- [Ghi chú của D — KHÔNG phải đề xuất sửa lược đồ: theo ADR-04, checksum SHA-256
--  của CV được đọc thẳng từ metadata của object trên MinIO qua
--  StoragePort.checksum(ObjectKey) chứ không nhân bản thành cột trong DB, nên
--  `attachments` giữ nguyên 8 cột và NFR-12 vẫn kiểm được. Xem
--  report/chapter_5_design.md mục 5.4.4 và docs/nfr_detail_D.md NFR-12.]

INSERT INTO attachments (id, candidate_id, file_url, file_name, version, uploaded_at, created_at, updated_at) VALUES
  (1, 1, 's3://ats-cv/2026/08/cand-1/mai-chi-hoang-cv-v1.pdf',    'HoangThiMaiChi_CV.pdf',    1, '2026-08-10 08:47:00', '2026-08-10 08:47:00', '2026-08-10 08:47:00'),
  (2, 1, 's3://ats-cv/2026/08/cand-1/mai-chi-hoang-cv-v2.pdf',    'HoangThiMaiChi_CV_v2.pdf', 2, '2026-08-13 21:05:00', '2026-08-13 21:05:00', '2026-08-13 21:05:00'),
  (3, 2, 's3://ats-cv/2026/07/cand-2/phuong-thao-ngo-cv-v1.pdf',  'NgoPhuongThao_CV.pdf',     1, '2026-07-05 14:00:00', '2026-07-05 14:00:00', '2026-08-05 09:30:00'),
  (4, 3, 's3://ats-cv/2026/06/cand-3/ba-long-trinh-cv-v1.pdf',    'TrinhBaLong_CV.pdf',       1, '2026-06-25 10:20:00', '2026-06-25 10:20:00', '2026-06-25 10:20:00'),
  (5, 4, 's3://ats-cv/2026/08/cand-4/khanh-linh-dang-cv-v1.pdf',  'DangKhanhLinh_CV.pdf',     1, '2026-08-09 08:00:00', '2026-08-09 08:00:00', '2026-08-09 08:00:00'),
  (6, 5, 's3://ats-cv/2026/07/cand-5/gia-han-ly-cv-v1.pdf',       'LyGiaHan_CV.pdf',          1, '2026-07-02 09:10:00', '2026-07-02 09:10:00', '2026-07-02 09:10:00'),
  (7, 6, 's3://ats-cv/2026/07/cand-6/anh-tuan-phan-cv-v1.pdf',    'PhanAnhTuan_CV.pdf',       1, '2026-07-28 10:00:00', '2026-07-28 10:00:00', '2026-07-28 10:00:00'),
  (8, 7, 's3://ats-cv/2026/07/cand-7/hai-dang-vuong-cv-v1.pdf',   'VuongHaiDang_CV.pdf',      1, '2026-07-25 08:40:00', '2026-07-25 08:40:00', '2026-07-25 08:40:00'),
  (9, 8, 's3://ats-cv/2026/06/cand-8/tuan-kiet-bui-cv-v1.pdf',    'BuiTuanKiet_CV.pdf',       1, '2026-06-20 08:15:00', '2026-06-20 08:15:00', '2026-06-20 08:15:00');

-- ---------------------------------------------------------------------
-- 6. APPLICATIONS — 11 hồ sơ, phủ đủ 10 nhánh trạng thái đáng chú ý
-- ---------------------------------------------------------------------
-- Ánh xạ trạng thái -> mục đích demo:
--   101 OFFER_PENDING   chờ duyệt offer (offer vượt band 8%, 2 cấp) — SCR-07/08
--   102 INTERVIEWING    đang phỏng vấn, vế thứ nhất của cặp trùng lịch BR-03
--   103 INTERVIEWING    đang phỏng vấn, vế thứ hai của cặp trùng lịch BR-03
--   104 NEED_RESCHEDULE quá hạn xác nhận lịch (BR-05 / X-01) — SCR-05, SCR-09
--   105 SCREENING       đang sàng lọc — cột kanban SCR-03
--   106 ACCEPTED        đã nhận offer, chưa tới ngày onboard
--   107 OFFER_SENT      đã gửi offer (offer từng bị REQUEST_CHANGE, attempt_no = 2)
--   108 HIRED           đã tuyển, lấp đủ headcount JD-02 nên JD-02 CLOSED
--   109 ON_HOLD         đang giữ chỗ (BR-13, tối đa 14 ngày làm việc); hồ sơ này
--                       thuộc JD-02 vốn đã CLOSED ngày 12/08 nên theo vế thứ hai
--                       của BR-13, SchedulerWorker sẽ chuyển sang REJECTED ở lần
--                       quét kế tiếp. Dòng được cố ý giữ nguyên ở ON_HOLD để buổi
--                       demo có sẵn cả trạng thái giữ chỗ lẫn đầu vào của job BR-13.
--   110 TALENT_POOL     lưu vào talent pool (UC-02 A4.1)
--   111 REJECTED        bị từ chối, có rejection_reason
-- (Hợp đồng yêu cầu 8-10 hồ sơ; ở đây dùng 11 để phủ trọn 10 nhánh trạng thái
--  mà vẫn giữ được cặp INTERVIEWING cần thiết cho tình huống trùng lịch.)
--
-- [X-02] Enum application_status hiện chưa có giá trị 'SHORTLISTED'. Hồ sơ 105
-- (Lý Gia Hân) thực chất đã qua sàng lọc và đang chờ xếp lịch, tức là thuộc cột
-- "Đã shortlist" trên kanban SCR-03. Khi mâu thuẫn X-02 được duyệt và C thêm giá
-- trị 'SHORTLISTED' vào ENUM, cần đổi status của application id = 105 và dòng
-- application_status_history tương ứng (id = 16) từ 'SCREENING' sang 'SHORTLISTED'.
-- Trước khi X-02 được duyệt, KHÔNG dùng 'SHORTLISTED' ở bất kỳ đâu trong file này.
--
-- [D đề xuất C bổ sung: applications chưa có cột version cho optimistic locking
--  (ADR-08); dữ liệu demo vì vậy không mô phỏng được xung đột ghi đồng thời.]

INSERT INTO applications
  (id, candidate_id, jd_id, status, applied_at, current_round, rejection_reason, created_at, updated_at) VALUES
  (101, 1, 1, 'OFFER_PENDING',   '2026-08-10 08:47:00', 2,    NULL, '2026-08-10 08:47:00', '2026-08-15 14:05:00'),
  (102, 2, 1, 'INTERVIEWING',    '2026-08-05 09:30:00', 2,    NULL, '2026-08-05 09:30:00', '2026-08-15 09:10:00'),
  (103, 3, 1, 'INTERVIEWING',    '2026-08-07 11:00:00', 1,    NULL, '2026-08-07 11:00:00', '2026-08-15 16:40:00'),
  (104, 4, 1, 'NEED_RESCHEDULE', '2026-08-09 08:00:00', 1,    NULL, '2026-08-09 08:00:00', '2026-08-15 10:05:00'),
  (105, 5, 1, 'SCREENING',       '2026-08-13 20:10:00', NULL, NULL, '2026-08-13 20:10:00', '2026-08-14 09:20:00'),
  (106, 6, 1, 'ACCEPTED',        '2026-07-28 10:00:00', 2,    NULL, '2026-07-28 10:00:00', '2026-08-11 09:15:00'),
  (107, 7, 1, 'OFFER_SENT',      '2026-07-25 08:40:00', 2,    NULL, '2026-07-25 08:40:00', '2026-08-11 10:00:00'),
  (108, 8, 2, 'HIRED',           '2026-06-20 08:15:00', 1,    NULL, '2026-06-20 08:15:00', '2026-08-01 09:00:00'),
  (109, 2, 2, 'ON_HOLD',         '2026-07-05 14:00:00', 1,    NULL, '2026-07-05 14:00:00', '2026-08-10 09:00:00'),
  (110, 5, 2, 'TALENT_POOL',     '2026-07-02 09:10:00', NULL, NULL, '2026-07-02 09:10:00', '2026-07-20 15:30:00'),
  (111, 3, 2, 'REJECTED',        '2026-06-25 10:20:00', NULL,
       'Thiếu kinh nghiệm ETL quy mô lớn theo yêu cầu vòng sàng lọc', '2026-06-25 10:20:00', '2026-07-01 11:00:00');

-- Ghi chú BR-04: ứng viên 3 (Trịnh Bá Long) bị từ chối ở JD-02 ngày 01/07/2026
-- nhưng vẫn ứng tuyển JD-01 ngày 07/08/2026 — hợp lệ vì BR-04 chỉ chặn nộp lại
-- CÙNG một JD trong 6 tháng. Cặp dòng 111/103 là dữ liệu để kiểm thử rule này.

-- ---------------------------------------------------------------------
-- 7. APPLICATION STATUS HISTORY — bảng append-only, mỗi lần chuyển 1 dòng
-- ---------------------------------------------------------------------
-- Đây là nguồn dữ liệu chính của read model báo cáo (ADR-07): funnel theo
-- to_status và time-in-stage tính bằng hiệu changed_at giữa hai dòng liên
-- tiếp của cùng application_id. actor_id = NULL nghĩa là do SchedulerWorker
-- (C17) thực hiện, không phải người dùng.

INSERT INTO application_status_history
  (id, application_id, from_status, to_status, actor_id, changed_at, note) VALUES
  -- 101 Hoàng Thị Mai Chi — luồng chính của demo
  ( 1, 101, NULL,            'NEW',             NULL, '2026-08-10 08:47:00', 'Hồ sơ vào từ nguồn LINKEDIN'),
  ( 2, 101, 'NEW',           'SCREENING',          1, '2026-08-11 16:20:00', 'Recruiter nhận sàng lọc'),
  ( 3, 101, 'SCREENING',     'INTERVIEWING',       1, '2026-08-12 05:32:00', 'Đã gửi thư mời phỏng vấn vòng 1'),
  ( 4, 101, 'INTERVIEWING',  'OFFER_PENDING',      1, '2026-08-15 14:05:00', 'Tạo offer 51.840.000 VND, vượt trần band 8% nên cần 2 cấp duyệt'),
  -- 102 Ngô Phương Thảo
  ( 5, 102, NULL,            'NEW',             NULL, '2026-08-05 09:30:00', 'Hồ sơ nộp qua website tuyển dụng'),
  ( 6, 102, 'NEW',           'SCREENING',          1, '2026-08-06 10:10:00', NULL),
  ( 7, 102, 'SCREENING',     'INTERVIEWING',       1, '2026-08-08 15:00:00', 'Xếp lịch vòng 1 ngày 12/08'),
  -- 103 Trịnh Bá Long
  ( 8, 103, NULL,            'NEW',             NULL, '2026-08-07 11:00:00', NULL),
  ( 9, 103, 'NEW',           'SCREENING',          1, '2026-08-08 09:30:00', NULL),
  (10, 103, 'SCREENING',     'INTERVIEWING',       1, '2026-08-15 16:40:00', 'Ép xếp lịch vòng 1 vào khung đã trùng, có lý do và audit log'),
  -- 104 Đặng Khánh Linh — minh hoạ BR-05 / X-01
  (11, 104, NULL,            'NEW',             NULL, '2026-08-09 08:00:00', NULL),
  (12, 104, 'NEW',           'SCREENING',          1, '2026-08-10 09:00:00', NULL),
  (13, 104, 'SCREENING',     'INTERVIEWING',       1, '2026-08-14 10:00:00', 'Gửi thư mời vòng 1 lúc 17/08 10:00, hạn xác nhận 24h'),
  (14, 104, 'INTERVIEWING',  'NEED_RESCHEDULE', NULL, '2026-08-15 10:05:00', 'Quá hạn xác nhận lịch, SchedulerWorker chuyển trạng thái'),
  -- 105 Lý Gia Hân — xem ghi chú X-02 ở mục 6
  (15, 105, NULL,            'NEW',             NULL, '2026-08-13 20:10:00', NULL),
  (16, 105, 'NEW',           'SCREENING',          1, '2026-08-14 09:20:00', 'Đạt vòng sàng lọc hồ sơ, chờ xếp lịch vòng 1'),
  -- 106 Phan Anh Tuấn — đã nhận offer
  (17, 106, NULL,            'NEW',             NULL, '2026-07-28 10:00:00', 'Nguồn HEADHUNTER'),
  (18, 106, 'NEW',           'SCREENING',          1, '2026-07-29 09:00:00', NULL),
  (19, 106, 'SCREENING',     'INTERVIEWING',       1, '2026-08-01 10:30:00', NULL),
  (20, 106, 'INTERVIEWING',  'OFFER_PENDING',      1, '2026-08-08 09:00:00', 'Offer 47.000.000 VND nằm trong band nên chỉ cần 1 cấp duyệt'),
  (21, 106, 'OFFER_PENDING', 'OFFER_APPROVED',     2, '2026-08-08 11:30:00', 'Hiring Manager duyệt cấp 1'),
  (22, 106, 'OFFER_APPROVED','OFFER_SENT',         1, '2026-08-08 14:00:00', 'Gửi offer cho ứng viên qua Candidate Portal'),
  (23, 106, 'OFFER_SENT',    'ACCEPTED',        NULL, '2026-08-11 09:15:00', 'Ứng viên bấm nhận offer trên SCR-09'),
  -- 107 Vương Hải Đăng — offer từng bị REQUEST_CHANGE
  (24, 107, NULL,            'NEW',             NULL, '2026-07-25 08:40:00', NULL),
  (25, 107, 'NEW',           'SCREENING',          1, '2026-07-26 09:40:00', NULL),
  (26, 107, 'SCREENING',     'INTERVIEWING',       1, '2026-08-01 09:00:00', NULL),
  (27, 107, 'INTERVIEWING',  'OFFER_PENDING',      1, '2026-08-07 16:00:00', 'Offer 54.000.000 VND vượt trần band 12,5% nên cần 3 cấp duyệt'),
  (28, 107, 'OFFER_PENDING', 'OFFER_APPROVED',     6, '2026-08-11 09:05:00', 'Hoàn tất 3 cấp duyệt ở lần duyệt thứ hai'),
  (29, 107, 'OFFER_APPROVED','OFFER_SENT',         1, '2026-08-11 10:00:00', NULL),
  -- 108 Bùi Tuấn Kiệt — đã tuyển, lấp đủ headcount JD-02
  (30, 108, NULL,            'NEW',             NULL, '2026-06-20 08:15:00', 'Nguồn REFERRAL'),
  (31, 108, 'NEW',           'SCREENING',          1, '2026-06-22 09:00:00', NULL),
  (32, 108, 'SCREENING',     'INTERVIEWING',       1, '2026-07-10 14:00:00', NULL),
  (33, 108, 'INTERVIEWING',  'OFFER_PENDING',      1, '2026-07-18 09:00:00', 'Offer 39.000.000 VND nằm trong band'),
  (34, 108, 'OFFER_PENDING', 'OFFER_APPROVED',     2, '2026-07-18 15:00:00', NULL),
  (35, 108, 'OFFER_APPROVED','OFFER_SENT',         1, '2026-07-19 09:00:00', NULL),
  (36, 108, 'OFFER_SENT',    'ACCEPTED',        NULL, '2026-07-22 14:20:00', NULL),
  (37, 108, 'ACCEPTED',      'HIRED',              4, '2026-08-01 09:00:00', 'Onboard đúng hạn, JD-02 đủ headcount và tự đóng theo BR-11'),
  -- 109 Ngô Phương Thảo tại JD-02 — đang giữ chỗ
  (38, 109, NULL,            'NEW',             NULL, '2026-07-05 14:00:00', NULL),
  (39, 109, 'NEW',           'SCREENING',          1, '2026-07-08 10:00:00', NULL),
  (40, 109, 'SCREENING',     'ON_HOLD',            1, '2026-08-10 09:00:00', 'JD-02 sắp đủ headcount, giữ chỗ tối đa 14 ngày làm việc theo BR-13'),
  -- Xem ghi chú BR-13 ở mục 6: JD-02 đóng ngày 12/08 nên hồ sơ 109 là đầu vào
  -- đang chờ của job BR-13, cố ý chưa chuyển sang REJECTED trong bộ dữ liệu demo.
  -- 110 Lý Gia Hân tại JD-02 — talent pool
  (41, 110, NULL,            'NEW',             NULL, '2026-07-02 09:10:00', NULL),
  (42, 110, 'NEW',           'SCREENING',          1, '2026-07-04 09:30:00', NULL),
  (43, 110, 'SCREENING',     'TALENT_POOL',        1, '2026-07-20 15:30:00', 'Hồ sơ tốt nhưng chưa khớp yêu cầu vị trí, lưu talent pool'),
  -- 111 Trịnh Bá Long tại JD-02 — bị từ chối
  (44, 111, NULL,            'NEW',             NULL, '2026-06-25 10:20:00', NULL),
  (45, 111, 'NEW',           'SCREENING',          1, '2026-06-27 09:15:00', NULL),
  (46, 111, 'SCREENING',     'REJECTED',           1, '2026-07-01 11:00:00', 'Thiếu kinh nghiệm ETL quy mô lớn');

-- ---------------------------------------------------------------------
-- 8. INTERVIEWS + INTERVIEW PARTICIPANTS
-- ---------------------------------------------------------------------
-- ***** DỮ LIỆU CỐ Ý TRÙNG LỊCH — dùng để minh hoạ BR-03 khi demo *****
-- Hai buổi phỏng vấn id 204 và 205 cùng diễn ra 2026-08-19 14:00-15:00 và cùng
-- có interviewer Vũ Ngọc Lan (users.id = 3), nhưng thuộc hai application khác
-- nhau (102 và 103). Đây KHÔNG phải lỗi dữ liệu: cặp dòng này được đưa vào có
-- chủ ý để câu truy vấn phát hiện xung đột ở mục "Kiểm chứng nhanh" trả về đúng
-- một cặp, cho thấy vì sao BR-03 phải được kiểm tra ở tầng service trong cùng
-- vùng khoá phân tán (Redis lock của LockManager - C24) chứ không thể biểu diễn
-- bằng CHECK constraint của PostgreSQL (xem ghi chú 1 cuối sql/schema.sql).
-- Trên kịch bản nghiệp vụ, buổi 205 là kết quả của thao tác "ép xếp lịch" có
-- nhập lý do và ghi audit log (audit_logs id = 2).
--
-- Buổi 203 (đã COMPLETED, có 2 người phỏng vấn) cố ý THIẾU feedback của
-- Vũ Ngọc Lan để minh hoạ BR-06 / SEQ-03: buổi kết thúc 2026-08-12 10:00,
-- hạn nộp là 2026-08-14 10:00, tới mốc demo 2026-08-16 18:00 đã quá hạn 48h.

INSERT INTO interviews
  (id, application_id, round_order, scheduled_at, duration_min, meeting_link, status, created_at, updated_at) VALUES
  (201, 101, 1, '2026-08-14 14:00:00', 60, 'https://meet.vxtech.vn/ats/iv-201', 'COMPLETED',       '2026-08-12 05:32:00', '2026-08-14 15:00:00'),
  (202, 101, 2, '2026-08-15 10:30:00', 90, 'https://meet.vxtech.vn/ats/iv-202', 'COMPLETED',       '2026-08-14 16:10:00', '2026-08-15 12:00:00'),
  (203, 102, 1, '2026-08-12 09:00:00', 60, 'https://meet.vxtech.vn/ats/iv-203', 'COMPLETED',       '2026-08-08 15:00:00', '2026-08-12 10:00:00'),
  (204, 102, 2, '2026-08-19 14:00:00', 60, 'https://meet.vxtech.vn/ats/iv-204', 'SCHEDULED',       '2026-08-15 09:10:00', '2026-08-15 09:10:00'),
  (205, 103, 1, '2026-08-19 14:00:00', 60, 'https://meet.vxtech.vn/ats/iv-205', 'SCHEDULED',       '2026-08-15 16:40:00', '2026-08-15 16:40:00'),
  (206, 104, 1, '2026-08-17 10:00:00', 60, 'https://meet.vxtech.vn/ats/iv-206', 'NEED_RESCHEDULE', '2026-08-14 10:00:00', '2026-08-15 10:05:00'),
  (207, 106, 1, '2026-08-05 09:00:00', 60, 'https://meet.vxtech.vn/ats/iv-207', 'COMPLETED',       '2026-08-01 10:30:00', '2026-08-05 10:00:00'),
  (208, 106, 2, '2026-08-07 14:00:00', 90, 'https://meet.vxtech.vn/ats/iv-208', 'COMPLETED',       '2026-08-05 11:00:00', '2026-08-07 15:30:00'),
  (209, 107, 1, '2026-08-03 15:00:00', 60, 'https://meet.vxtech.vn/ats/iv-209', 'COMPLETED',       '2026-08-01 09:00:00', '2026-08-03 16:00:00'),
  (210, 107, 2, '2026-08-06 09:00:00', 90, 'https://meet.vxtech.vn/ats/iv-210', 'COMPLETED',       '2026-08-03 16:30:00', '2026-08-06 10:30:00'),
  (211, 108, 1, '2026-07-15 09:00:00', 60, 'https://meet.vxtech.vn/ats/iv-211', 'COMPLETED',       '2026-07-10 14:00:00', '2026-07-15 10:00:00'),
  (212, 109, 1, '2026-08-12 09:00:00', 60, 'https://meet.vxtech.vn/ats/iv-212', 'CANCELLED',       '2026-08-05 10:00:00', '2026-08-10 09:00:00');

INSERT INTO interview_participants (id, interview_id, interviewer_id, role, created_at) VALUES
  (301, 201, 3, 'PRIMARY',   '2026-08-12 05:32:00'),  -- Vũ Ngọc Lan
  (302, 201, 7, 'SECONDARY', '2026-08-12 05:32:00'),  -- Đinh Quang Huy: vòng 2 người, phục vụ BR-07
  (303, 202, 2, 'PRIMARY',   '2026-08-14 16:10:00'),  -- Trần Quốc Bảo
  (304, 203, 7, 'PRIMARY',   '2026-08-08 15:00:00'),  -- Đinh Quang Huy đã nộp feedback
  (305, 203, 3, 'SECONDARY', '2026-08-08 15:00:00'),  -- Vũ Ngọc Lan CỐ Ý chưa nộp feedback (BR-06)
  (306, 204, 3, 'PRIMARY',   '2026-08-15 09:10:00'),  -- vế 1 của cặp trùng lịch
  (307, 205, 3, 'PRIMARY',   '2026-08-15 16:40:00'),  -- vế 2 của cặp trùng lịch
  (308, 206, 3, 'PRIMARY',   '2026-08-14 10:00:00'),
  (309, 207, 3, 'PRIMARY',   '2026-08-01 10:30:00'),
  (310, 208, 2, 'PRIMARY',   '2026-08-05 11:00:00'),
  (311, 209, 3, 'PRIMARY',   '2026-08-01 09:00:00'),
  (312, 210, 2, 'PRIMARY',   '2026-08-03 16:30:00'),
  (313, 211, 8, 'PRIMARY',   '2026-07-10 14:00:00'),  -- Hà Kiều Trang, JD-02
  (314, 212, 8, 'PRIMARY',   '2026-08-05 10:00:00');

-- ---------------------------------------------------------------------
-- 9. FEEDBACKS + FEEDBACK CRITERIA
-- ---------------------------------------------------------------------
-- Quy ước: feedbacks.total_score là cột cache của AVG(feedback_criteria.score)
-- đúng theo docs/data_dictionary_C.md mục 11. Điểm có trọng số hiển thị trên
-- SCR-06 được tính ở tầng ứng dụng từ scorecard_templates.criteria, không lưu
-- vào DB. Với feedback id 401, hai cách tính cho cùng kết quả 4,20.
--
-- ***** BR-07 — hai kết luận trái chiều trong CÙNG một vòng *****
-- Buổi 201 có 2 người phỏng vấn: Vũ Ngọc Lan kết luận HIRE, Đinh Quang Huy kết
-- luận NO_HIRE. Tỷ lệ HIRE trở lên = 1/2 = 50%, đúng ngưỡng ">=50%" của BR-07
-- nên vòng vẫn PASS. Đây là ca biên được chọn có chủ ý để chất vấn cách cài đặt
-- rule (dùng >= hay >), xem câu truy vấn kiểm chứng ở cuối file.

INSERT INTO feedbacks
  (id, interview_id, interviewer_id, verdict, total_score, submitted_at, is_locked, created_at, updated_at) VALUES
  (401, 201, 3, 'HIRE',        4.20, '2026-08-14 15:05:00', TRUE,  '2026-08-14 15:05:00', '2026-08-15 15:05:00'),
  (402, 201, 7, 'NO_HIRE',     3.00, '2026-08-14 17:40:00', TRUE,  '2026-08-14 17:40:00', '2026-08-15 17:40:00'),
  -- Phiếu 403 CỐ Ý để is_locked = FALSE: nộp lúc 2026-08-16 09:00, tại mốc "hiện tại"
  -- của kịch bản demo (2026-08-16 18:00) mới trôi qua 9 giờ nên vẫn nằm trong cửa sổ
  -- 24h được phép sửa. Đây là dòng dữ liệu để minh hoạ trạng thái scorecard CHƯA khoá
  -- trên SCR-06 (nút "Lưu nháp"/"Sửa" còn bật); tám phiếu còn lại đã quá 24h nên
  -- is_locked = TRUE và updated_at = submitted_at + 24h.
  (403, 202, 2, 'HIRE',        4.40, '2026-08-16 09:00:00', FALSE, '2026-08-16 09:00:00', '2026-08-16 09:00:00'),
  (404, 203, 7, 'HIRE',        4.00, '2026-08-12 11:30:00', TRUE,  '2026-08-12 11:30:00', '2026-08-13 11:30:00'),
  (405, 207, 3, 'STRONG_HIRE', 4.60, '2026-08-05 10:20:00', TRUE,  '2026-08-05 10:20:00', '2026-08-06 10:20:00'),
  (406, 208, 2, 'HIRE',        4.20, '2026-08-07 16:10:00', TRUE,  '2026-08-07 16:10:00', '2026-08-08 16:10:00'),
  (407, 209, 3, 'HIRE',        4.00, '2026-08-03 17:00:00', TRUE,  '2026-08-03 17:00:00', '2026-08-04 17:00:00'),
  (408, 210, 2, 'HIRE',        4.20, '2026-08-06 11:00:00', TRUE,  '2026-08-06 11:00:00', '2026-08-07 11:00:00'),
  (409, 211, 8, 'HIRE',        4.00, '2026-07-15 10:40:00', TRUE,  '2026-07-15 10:40:00', '2026-07-16 10:40:00');
-- Không có dòng feedback nào cho cặp (interview 203, interviewer 3): đây là dữ
-- liệu cố ý thiếu để minh hoạ BR-06 và luồng nhắc/escalate của SEQ-03.
-- [Cột `version` cho feedbacks nằm trong đề xuất P0 của Bảng 5.52 (cùng với
--  applications và offers). Riêng cột `general_comment` KHÔNG nằm trong danh
--  mục chín đề xuất: ghi chú chung của người phỏng vấn trên SCR-06 hiện được
--  gộp vào comment của từng tiêu chí, đây là hiện trạng chấp nhận được chứ
--  không phải một đề xuất sửa lược đồ mới.]

-- Tên tiêu chí lấy đúng khoá "name" trong scorecard_templates.criteria:
--   template 1: technical, problemSolving, communication, cultureFit, growth
--   template 2: dataModeling, pipelineEngineering, problemSolving, communication, cultureFit
INSERT INTO feedback_criteria (id, feedback_id, criterion_name, score, comment, created_at) VALUES
  ( 1, 401, 'technical',      4, 'Nắm chắc JVM và tuning GC, giải thích được đánh đổi khi chọn index.', '2026-08-14 15:05:00'),
  ( 2, 401, 'problemSolving', 4, 'Chia bài toán tốt, đưa ra được phương án dự phòng.',                  '2026-08-14 15:05:00'),
  ( 3, 401, 'communication',  5, 'Trình bày mạch lạc, chủ động làm rõ yêu cầu trước khi code.',         '2026-08-14 15:05:00'),
  ( 4, 401, 'cultureFit',     4, 'Hợp với lối làm việc có review chéo của nhóm.',                       '2026-08-14 15:05:00'),
  ( 5, 401, 'growth',         4, 'Có thói quen viết lại sự cố thành tài liệu nội bộ.',                  '2026-08-14 15:05:00'),
  ( 6, 402, 'technical',      3, 'Trả lời đúng nhưng chưa đạt độ sâu kỳ vọng ở mức Senior.',            '2026-08-14 17:40:00'),
  ( 7, 402, 'problemSolving', 3, 'Cần gợi ý mới đi tới phương án tối ưu.',                              '2026-08-14 17:40:00'),
  ( 8, 402, 'communication',  3, 'Diễn đạt được nhưng dài dòng ở phần thiết kế.',                       '2026-08-14 17:40:00'),
  ( 9, 402, 'cultureFit',     3, 'Chưa thể hiện rõ kinh nghiệm làm việc nhóm nhiều bên.',               '2026-08-14 17:40:00'),
  (10, 402, 'growth',         3, 'Không nêu được ví dụ tự học gần đây.',                                '2026-08-14 17:40:00'),
  (11, 403, 'technical',      4, 'Thiết kế phân mảnh dữ liệu hợp lý.',                                  '2026-08-16 09:00:00'),
  (12, 403, 'problemSolving', 4, 'Ước lượng tải và chọn ngưỡng cache thuyết phục.',                     '2026-08-16 09:00:00'),
  (13, 403, 'communication',  5, 'Vẽ và giải thích kiến trúc rõ ràng.',                                 '2026-08-16 09:00:00'),
  (14, 403, 'cultureFit',     5, 'Chủ động hỏi về quy trình vận hành của nhóm.',                        '2026-08-16 09:00:00'),
  (15, 403, 'growth',         4, 'Sẵn sàng nhận phần việc ngoài chuyên môn hẹp.',                       '2026-08-16 09:00:00'),
  (16, 404, 'technical',      4, 'Vững Kotlin, chuyển đổi sang Java không có rào cản lớn.',             '2026-08-12 11:30:00'),
  (17, 404, 'problemSolving', 4, 'Tiếp cận bài toán theo hướng thu hẹp dần.',                           '2026-08-12 11:30:00'),
  (18, 404, 'communication',  4, 'Trao đổi tự nhiên, hỏi lại khi đề bài thiếu dữ kiện.',                '2026-08-12 11:30:00'),
  (19, 404, 'cultureFit',     4, 'Kinh nghiệm làm việc với nhóm phân tán.',                             '2026-08-12 11:30:00'),
  (20, 404, 'growth',         4, 'Đang tự học mảng quan sát hệ thống.',                                 '2026-08-12 11:30:00'),
  (21, 405, 'technical',      5, 'Kiến thức microservices và Kafka rất chắc.',                          '2026-08-05 10:20:00'),
  (22, 405, 'problemSolving', 5, 'Đưa ra hai phương án kèm chi phí vận hành.',                          '2026-08-05 10:20:00'),
  (23, 405, 'communication',  4, 'Trình bày tốt, đôi chỗ đi quá nhanh.',                                '2026-08-05 10:20:00'),
  (24, 405, 'cultureFit',     4, 'Quen với môi trường nhiều bên liên quan.',                            '2026-08-05 10:20:00'),
  (25, 405, 'growth',         5, 'Chủ động dẫn dắt buổi chia sẻ kỹ thuật nội bộ.',                      '2026-08-05 10:20:00'),
  (26, 406, 'technical',      4, 'Thiết kế chịu tải tốt, có tính tới hàng đợi chết.',                   '2026-08-07 16:10:00'),
  (27, 406, 'problemSolving', 4, 'Phân tích điểm nghẽn hợp lý.',                                        '2026-08-07 16:10:00'),
  (28, 406, 'communication',  5, 'Giải thích quyết định kiến trúc rất rõ.',                             '2026-08-07 16:10:00'),
  (29, 406, 'cultureFit',     4, 'Phù hợp vai trò dẫn dắt kỹ thuật.',                                   '2026-08-07 16:10:00'),
  (30, 406, 'growth',         4, 'Quan tâm tới đào tạo thành viên mới.',                                '2026-08-07 16:10:00'),
  (31, 407, 'technical',      4, 'Kinh nghiệm hệ thống giao dịch thời gian thực rõ nét.',               '2026-08-03 17:00:00'),
  (32, 407, 'problemSolving', 4, 'Xử lý tình huống mất dữ liệu tốt.',                                   '2026-08-03 17:00:00'),
  (33, 407, 'communication',  4, 'Trình bày ngắn gọn, đúng trọng tâm.',                                 '2026-08-03 17:00:00'),
  (34, 407, 'cultureFit',     4, 'Quen quy trình review chặt.',                                         '2026-08-03 17:00:00'),
  (35, 407, 'growth',         4, 'Có kế hoạch học thêm mảng dữ liệu.',                                  '2026-08-03 17:00:00'),
  (36, 408, 'technical',      4, 'Thiết kế idempotent cho luồng thanh toán.',                           '2026-08-06 11:00:00'),
  (37, 408, 'problemSolving', 5, 'Chủ động nêu rủi ro và cách chặn.',                                   '2026-08-06 11:00:00'),
  (38, 408, 'communication',  4, 'Diễn đạt rõ, có ví dụ thực tế.',                                      '2026-08-06 11:00:00'),
  (39, 408, 'cultureFit',     4, 'Hợp tác tốt với nhóm vận hành.',                                      '2026-08-06 11:00:00'),
  (40, 408, 'growth',         4, 'Đang theo mảng độ tin cậy hệ thống.',                                 '2026-08-06 11:00:00'),
  -- feedback 409 dùng mẫu chấm của JD-02 nên tên tiêu chí khác
  (41, 409, 'dataModeling',        4, 'Chuẩn hoá mô hình kho dữ liệu hợp lý.',                          '2026-07-15 10:40:00'),
  (42, 409, 'pipelineEngineering', 4, 'Kinh nghiệm Airflow và xử lý chạy lại tác vụ lỗi.',              '2026-07-15 10:40:00'),
  (43, 409, 'problemSolving',      4, 'Ước lượng chi phí lưu trữ khá sát.',                             '2026-07-15 10:40:00'),
  (44, 409, 'communication',       4, 'Giải thích luồng dữ liệu dễ hiểu.',                              '2026-07-15 10:40:00'),
  (45, 409, 'cultureFit',          4, 'Được người giới thiệu nội bộ đánh giá tốt.',                     '2026-07-15 10:40:00');

-- ---------------------------------------------------------------------
-- 10. OFFERS + OFFER APPROVALS
-- ---------------------------------------------------------------------
-- Số cấp duyệt xác định theo BR-08 (spec_ats mục UC-04):
--   trong band -> 1 cấp (Hiring Manager)
--   vượt band <=10% -> 2 cấp (thêm Head of HR)
--   vượt band >10%  -> 3 cấp (thêm Finance)
-- Ba tình huống bắt buộc phải có mặt trong bộ dữ liệu demo:
--   offer 503 và 504: trong band, 1 cấp.
--   offer 501: 51.840.000 so với trần band 48.000.000 = vượt 8%, 2 cấp, đang
--              chờ cấp 2 quyết định - đây chính là dòng hiển thị trên SCR-08.
--   offer 502: 54.000.000 so với trần band 48.000.000 = vượt 12,5%, 3 cấp;
--              lần duyệt thứ nhất bị REQUEST_CHANGE ở cấp 2 nên toàn bộ chuỗi
--              chạy lại từ cấp 1 với attempt_no = 2, đúng cơ chế attempt_no của C.
--
-- [D đề xuất C bổ sung: offers chưa có band_snapshot_min/max nên phần trăm vượt
--  band phải tính lại từ job_descriptions tại thời điểm xem; nếu band của JD bị
--  sửa sau khi tạo offer thì con số hiển thị trên SCR-07/SCR-08 sẽ lệch.]

INSERT INTO offers
  (id, application_id, salary, start_date, benefits, deadline, status,
   current_approval_level, current_approval_attempt, created_at, updated_at) VALUES
  (501, 101, 51840000.00, '2026-09-01',
       '{"thang13": true, "bonus": "10% KPI năm", "baoHiem": "PVI Care hạng A", "phepNam": 15, "laptop": "MacBook Pro 14"}'::jsonb,
       '2026-08-22', 'PENDING_APPROVAL',   2, 1, '2026-08-15 14:05:00', '2026-08-15 16:12:00'),
  (502, 107, 54000000.00, '2026-09-15',
       '{"thang13": true, "bonus": "10% KPI năm", "baoHiem": "PVI Care hạng A", "phepNam": 15, "hoTroDiLai": 2000000}'::jsonb,
       '2026-08-20', 'SIGNED_BY_COMPANY',  3, 2, '2026-08-07 16:00:00', '2026-08-11 10:00:00'),
  (503, 106, 47000000.00, '2026-10-01',
       '{"thang13": true, "bonus": "10% KPI năm", "baoHiem": "PVI Care hạng A", "phepNam": 15}'::jsonb,
       '2026-08-14', 'ACCEPTED',           1, 1, '2026-08-08 09:00:00', '2026-08-11 09:15:00'),
  (504, 108, 39000000.00, '2026-08-01',
       '{"thang13": true, "bonus": "8% KPI năm", "baoHiem": "PVI Care hạng B", "phepNam": 12}'::jsonb,
       '2026-07-25', 'ACCEPTED',           1, 1, '2026-07-18 09:00:00', '2026-07-22 14:20:00');

-- Người duyệt theo ma trận RBAC mục 9 hợp đồng thiết kế:
--   cấp 1 = Hiring Manager (user 2), cấp 2 = Head of HR (user 5), cấp 3 = Finance (user 6).
INSERT INTO offer_approvals
  (id, offer_id, approver_id, level, attempt_no, decision, comment, decided_at, created_at) VALUES
  (601, 501, 2, 1, 1, 'APPROVED',       'Đồng ý mức đề xuất, ứng viên đang giữ 2 offer khác cùng phân khúc.', '2026-08-15 16:12:00', '2026-08-15 14:05:00'),
  (602, 501, 5, 2, 1, 'PENDING',        NULL,                                                                 NULL,                  '2026-08-15 16:12:00'),
  -- Lần duyệt thứ nhất của offer 502 bị trả về ở cấp 2
  (603, 502, 2, 1, 1, 'APPROVED',       'Ứng viên đạt cả 2 vòng, đề nghị giữ mức đàm phán.',                  '2026-08-08 09:20:00', '2026-08-07 16:00:00'),
  (604, 502, 5, 2, 1, 'REQUEST_CHANGE', 'Đề nghị bổ sung so sánh thị trường trước khi duyệt mức vượt band.',  '2026-08-08 15:40:00', '2026-08-08 09:20:00'),
  -- Lần duyệt thứ hai chạy lại từ cấp 1, attempt_no = 2
  (605, 502, 2, 1, 2, 'APPROVED',       'Đã bổ sung dữ liệu thị trường theo yêu cầu cấp 2.',                  '2026-08-10 08:30:00', '2026-08-09 09:00:00'),
  (606, 502, 5, 2, 2, 'APPROVED',       'Chấp thuận mức vượt band 12,5% cho vị trí khó tuyển.',               '2026-08-10 14:15:00', '2026-08-10 08:30:00'),
  (607, 502, 6, 3, 2, 'APPROVED',       'Ngân sách quý 3 còn dư cho 1 vị trí Senior.',                        '2026-08-11 09:05:00', '2026-08-10 14:15:00'),
  (608, 503, 2, 1, 1, 'APPROVED',       'Mức nằm trong band, duyệt 1 cấp.',                                   '2026-08-08 11:30:00', '2026-08-08 09:00:00'),
  (609, 504, 2, 1, 1, 'APPROVED',       'Mức nằm trong band, duyệt 1 cấp.',                                   '2026-07-18 15:00:00', '2026-07-18 09:00:00');

-- ---------------------------------------------------------------------
-- 11. EMAIL TEMPLATES
-- ---------------------------------------------------------------------
-- [D đề xuất C bổ sung: email_templates chưa có locale, version, is_active và
--  UNIQUE hiện là (template_key). NFR-09 yêu cầu mọi template có bản VI và EN,
--  BR-12 yêu cầu chỉ dùng template đang active đã duyệt. Trong khi chờ, bộ dữ
--  liệu demo mã hoá ngôn ngữ vào phần đuôi của template_key (_VI / _EN) — đây
--  là giải pháp tạm, không phải thiết kế đề xuất.]

INSERT INTO email_templates (id, template_key, subject, body, variables, created_at, updated_at) VALUES
  (1, 'INTERVIEW_INVITE_VI',
      'Thư mời phỏng vấn vị trí {{jdTitle}} tại VXTech',
      'Kính gửi {{candidateName}}, VXTech trân trọng mời anh/chị tham dự vòng {{roundName}} vào {{scheduledAt}}. Vui lòng xác nhận trong 24 giờ qua liên kết {{confirmUrl}}.',
      '["candidateName","jdTitle","roundName","scheduledAt","confirmUrl"]'::jsonb,
      '2026-03-05 09:00:00', '2026-07-01 10:00:00'),
  (2, 'INTERVIEW_INVITE_EN',
      'Interview invitation for {{jdTitle}} at VXTech',
      'Dear {{candidateName}}, VXTech would like to invite you to the {{roundName}} round on {{scheduledAt}}. Please confirm within 24 hours via {{confirmUrl}}.',
      '["candidateName","jdTitle","roundName","scheduledAt","confirmUrl"]'::jsonb,
      '2026-03-05 09:00:00', '2026-07-01 10:00:00'),
  (3, 'FEEDBACK_REMINDER_VI',
      'Nhắc nộp phiếu đánh giá buổi phỏng vấn {{roundName}}',
      'Kính gửi {{interviewerName}}, phiếu đánh giá cho buổi phỏng vấn {{roundName}} của ứng viên {{candidateName}} sẽ quá hạn lúc {{deadline}}. Vui lòng hoàn tất tại {{scorecardUrl}}.',
      '["interviewerName","roundName","candidateName","deadline","scorecardUrl"]'::jsonb,
      '2026-03-05 09:00:00', '2026-03-05 09:00:00'),
  (4, 'OFFER_SENT_VI',
      'Thư mời nhận việc vị trí {{jdTitle}} tại VXTech',
      'Kính gửi {{candidateName}}, VXTech trân trọng gửi thư mời nhận việc với mức lương {{salary}} VND, ngày bắt đầu dự kiến {{startDate}}. Vui lòng phản hồi trước {{deadline}} tại {{portalUrl}}.',
      '["candidateName","jdTitle","salary","startDate","deadline","portalUrl"]'::jsonb,
      '2026-03-05 09:00:00', '2026-06-20 14:00:00'),
  (5, 'REJECTION_VI',
      'Kết quả ứng tuyển vị trí {{jdTitle}} tại VXTech',
      'Kính gửi {{candidateName}}, cảm ơn anh/chị đã dành thời gian cho VXTech. Rất tiếc hồ sơ chưa phù hợp với vị trí {{jdTitle}} ở thời điểm này. Chúng tôi xin phép lưu hồ sơ để liên hệ khi có vị trí phù hợp hơn.',
      '["candidateName","jdTitle"]'::jsonb,
      '2026-03-05 09:00:00', '2026-03-05 09:00:00');

-- ---------------------------------------------------------------------
-- 12. AUDIT LOGS
-- ---------------------------------------------------------------------
-- Vài dòng tiêu biểu cho NFR-06 và NFR-12. actor_id = NULL nghĩa là hành động
-- do SchedulerWorker (C17) thực hiện.

INSERT INTO audit_logs (id, actor_id, action, entity_type, entity_id, payload, created_at) VALUES
  (1, NULL, 'LOGIN_DENIED_INACTIVE_ACCOUNT', 'User',        9,
      '{"email":"cuu.nhanvien@vxtech.vn","reason":"is_active = false","ip":"10.20.3.44"}'::jsonb, '2026-08-16 08:12:00'),
  (2, 1,    'SCHEDULE_CONFLICT_OVERRIDE',    'Interview',   205,
      '{"interviewerId":3,"slot":"2026-08-19T14:00:00","conflictWithInterviewId":204,"reason":"Ứng viên chỉ trống khung này trước khi đi công tác"}'::jsonb, '2026-08-15 16:40:00'),
  (3, 3,    'CV_DOWNLOAD',                   'Attachment',  2,
      '{"candidateId":1,"presignedUrlTtlSeconds":600,"purpose":"Chuẩn bị vòng Technical Round 1"}'::jsonb, '2026-08-13 22:10:00'),
  (4, 1,    'APPLICATION_STATUS_CHANGED',    'Application', 101,
      '{"from":"INTERVIEWING","to":"OFFER_PENDING","offerId":501}'::jsonb, '2026-08-15 14:05:00'),
  (5, 2,    'OFFER_APPROVED',                'Offer',       501,
      '{"level":1,"attemptNo":1,"salary":51840000,"pctOverBand":8.0}'::jsonb, '2026-08-15 16:12:00'),
  (6, 5,    'OFFER_REQUEST_CHANGE',          'Offer',       502,
      '{"level":2,"attemptNo":1,"comment":"Bổ sung so sánh thị trường"}'::jsonb, '2026-08-08 15:40:00'),
  (7, NULL, 'FEEDBACK_LOCKED',               'Feedback',    401,
      '{"lockedAfterHours":24,"interviewId":201}'::jsonb, '2026-08-15 15:05:00'),
  (8, NULL, 'APPLICATION_STATUS_CHANGED',    'Application', 104,
      '{"from":"INTERVIEWING","to":"NEED_RESCHEDULE","rule":"BR-05","slaHours":24}'::jsonb, '2026-08-15 10:05:00');

-- ---------------------------------------------------------------------
-- 13. NOTIFICATIONS
-- ---------------------------------------------------------------------
-- Thông báo in-app cho người dùng nội bộ. Theo ADR-09, ứng viên KHÔNG phải
-- User nên không có dòng notifications nào trỏ tới ứng viên; thông báo cho
-- ứng viên đi bằng email qua Candidate Portal.
-- [D đề xuất C bổ sung: notifications chưa có delivery_status nên chưa đo được
--  tỷ lệ gửi thành công đúng hạn phục vụ BR-25 / NFR-10.]

INSERT INTO notifications (id, user_id, type, payload, is_read, created_at) VALUES
  (1, 3, 'FEEDBACK_OVERDUE',        '{"interviewId":203,"candidateName":"Ngô Phương Thảo","roundName":"Technical Round 1","deadline":"2026-08-14T10:00:00","rule":"BR-06"}'::jsonb, FALSE, '2026-08-14 10:05:00'),
  (2, 2, 'FEEDBACK_ESCALATION',     '{"interviewId":203,"interviewerName":"Vũ Ngọc Lan","overdueHours":48,"rule":"BR-06"}'::jsonb,                                              FALSE, '2026-08-16 10:05:00'),
  (3, 5, 'OFFER_APPROVAL_PENDING',  '{"offerId":501,"candidateName":"Hoàng Thị Mai Chi","salary":51840000,"level":2,"pctOverBand":8.0}'::jsonb,                                 FALSE, '2026-08-15 16:12:00'),
  (4, 1, 'SCHEDULE_CONFLICT',       '{"interviewId":205,"interviewerName":"Vũ Ngọc Lan","slot":"2026-08-19T14:00:00","conflictWithInterviewId":204,"rule":"BR-03"}'::jsonb,     TRUE,  '2026-08-15 16:40:00'),
  (5, 1, 'CANDIDATE_NOT_CONFIRMED', '{"applicationId":104,"candidateName":"Đặng Khánh Linh","interviewId":206,"rule":"BR-05"}'::jsonb,                                          FALSE, '2026-08-15 10:05:00'),
  (6, 1, 'OFFER_ACCEPTED',          '{"offerId":503,"candidateName":"Phan Anh Tuấn","startDate":"2026-10-01"}'::jsonb,                                                          TRUE,  '2026-08-11 09:15:00');

-- ---------------------------------------------------------------------
-- 14. ĐỒNG BỘ SEQUENCE
-- ---------------------------------------------------------------------
-- Toàn bộ id ở trên được chỉ định tường minh nên các sequence của BIGSERIAL
-- vẫn đang đứng ở giá trị 1. Nếu bỏ qua bước này, bản ghi đầu tiên do ứng dụng
-- tạo ra sau khi nạp seed sẽ nhận id = 1 và va chạm khoá chính. Dùng
-- pg_get_serial_sequence để không phải viết cứng tên sequence.

SELECT setval(pg_get_serial_sequence('departments',               'id'), (SELECT MAX(id) FROM departments));
SELECT setval(pg_get_serial_sequence('users',                     'id'), (SELECT MAX(id) FROM users));
SELECT setval(pg_get_serial_sequence('job_descriptions',          'id'), (SELECT MAX(id) FROM job_descriptions));
SELECT setval(pg_get_serial_sequence('scorecard_templates',       'id'), (SELECT MAX(id) FROM scorecard_templates));
SELECT setval(pg_get_serial_sequence('interview_processes',       'id'), (SELECT MAX(id) FROM interview_processes));
SELECT setval(pg_get_serial_sequence('candidates',                'id'), (SELECT MAX(id) FROM candidates));
SELECT setval(pg_get_serial_sequence('attachments',               'id'), (SELECT MAX(id) FROM attachments));
SELECT setval(pg_get_serial_sequence('applications',              'id'), (SELECT MAX(id) FROM applications));
SELECT setval(pg_get_serial_sequence('application_status_history','id'), (SELECT MAX(id) FROM application_status_history));
SELECT setval(pg_get_serial_sequence('interviews',                'id'), (SELECT MAX(id) FROM interviews));
SELECT setval(pg_get_serial_sequence('interview_participants',    'id'), (SELECT MAX(id) FROM interview_participants));
SELECT setval(pg_get_serial_sequence('feedbacks',                 'id'), (SELECT MAX(id) FROM feedbacks));
SELECT setval(pg_get_serial_sequence('feedback_criteria',         'id'), (SELECT MAX(id) FROM feedback_criteria));
SELECT setval(pg_get_serial_sequence('offers',                    'id'), (SELECT MAX(id) FROM offers));
SELECT setval(pg_get_serial_sequence('offer_approvals',           'id'), (SELECT MAX(id) FROM offer_approvals));
SELECT setval(pg_get_serial_sequence('email_templates',           'id'), (SELECT MAX(id) FROM email_templates));
SELECT setval(pg_get_serial_sequence('audit_logs',                'id'), (SELECT MAX(id) FROM audit_logs));
SELECT setval(pg_get_serial_sequence('notifications',             'id'), (SELECT MAX(id) FROM notifications));

COMMIT;

-- =====================================================================
-- KIỂM CHỨNG NHANH
-- =====================================================================
-- Sáu câu truy vấn dưới đây chạy trực tiếp trên sql/schema.sql v1.2, mỗi câu
-- tương ứng một màn hình chính của D. Khi bảo vệ, dán từng câu vào psql để
-- chứng minh dữ liệu hiển thị trên prototype được tính ra từ schema thật chứ
-- không phải số cứng trong mã giao diện.
--
-- ---------------------------------------------------------------------
-- (1) SCR-03 — Kanban pipeline: đếm hồ sơ theo trạng thái của JD-01.
--     Kết quả mong đợi: INTERVIEWING 2, NEED_RESCHEDULE 1, OFFER_PENDING 1,
--     SCREENING 1, ACCEPTED 1, OFFER_SENT 1 (tổng 7 hồ sơ của JD-01).
-- ---------------------------------------------------------------------
-- SELECT a.status, COUNT(*) AS so_ho_so
-- FROM applications a
-- WHERE a.jd_id = 1
-- GROUP BY a.status
-- ORDER BY a.status;
--
-- ---------------------------------------------------------------------
-- (2) SCR-05 — Phát hiện xung đột lịch của cùng một interviewer (BR-03).
--     Quy tắc overlap: newStart < existingEnd AND newEnd > existingStart.
--     Kết quả mong đợi: đúng 1 cặp (interview 204 và 205, interviewer 3).
-- ---------------------------------------------------------------------
-- SELECT p1.interviewer_id, u.name AS interviewer,
--        i1.id AS interview_a, i1.scheduled_at AS bat_dau_a,
--        i2.id AS interview_b, i2.scheduled_at AS bat_dau_b,
--        i1.application_id AS ho_so_a, i2.application_id AS ho_so_b
-- FROM interviews i1
-- JOIN interview_participants p1 ON p1.interview_id = i1.id
-- JOIN interview_participants p2 ON p2.interviewer_id = p1.interviewer_id
-- JOIN interviews i2 ON i2.id = p2.interview_id
-- JOIN users u ON u.id = p1.interviewer_id
-- WHERE i1.id < i2.id
--   AND i1.status = 'SCHEDULED' AND i2.status = 'SCHEDULED'
--   AND i1.scheduled_at < i2.scheduled_at + make_interval(mins => i2.duration_min)
--   AND i1.scheduled_at + make_interval(mins => i1.duration_min) > i2.scheduled_at
-- ORDER BY i1.scheduled_at;
--
-- ---------------------------------------------------------------------
-- (3) SCR-06 — Điểm trung bình scorecard và kiểm tra quy tắc >=50% HIRE (BR-07)
--     cho buổi phỏng vấn 201. Kết quả mong đợi: 2 phiếu, điểm trung bình 4,20
--     và 3,00; tỷ lệ HIRE trở lên = 50,00% nên vòng PASS đúng ngưỡng biên.
-- ---------------------------------------------------------------------
-- SELECT f.interview_id,
--        u.name AS nguoi_pv, f.verdict, f.total_score,
--        ROUND(AVG(fc.score)::numeric, 2) AS diem_tinh_lai,
--        ROUND(100.0 * SUM(CASE WHEN f.verdict IN ('HIRE','STRONG_HIRE') THEN 1 ELSE 0 END)
--                    OVER (PARTITION BY f.interview_id)
--              / COUNT(*) OVER (PARTITION BY f.interview_id), 2) AS pct_hire_cua_vong
-- FROM feedbacks f
-- JOIN users u ON u.id = f.interviewer_id
-- JOIN feedback_criteria fc ON fc.feedback_id = f.id
-- WHERE f.interview_id = 201
-- GROUP BY f.id, f.interview_id, u.name, f.verdict, f.total_score
-- ORDER BY u.name;
--
-- ---------------------------------------------------------------------
-- (4) SCR-07 / SCR-08 — Phần trăm lệch so với trần band và số cấp duyệt theo
--     BR-08. Kết quả mong đợi: offer 501 vượt 8,00% (2 cấp), offer 502 vượt
--     12,50% (3 cấp), offer 503 và 504 trong band (1 cấp).
-- ---------------------------------------------------------------------
-- SELECT o.id AS offer_id, c.full_name, jd.title,
--        o.salary, jd.salary_band_min, jd.salary_band_max,
--        ROUND((o.salary - jd.salary_band_max) / jd.salary_band_max * 100, 2) AS pct_lech_tran_band,
--        CASE
--          WHEN o.salary <= jd.salary_band_max THEN 1
--          WHEN (o.salary - jd.salary_band_max) / jd.salary_band_max <= 0.10 THEN 2
--          ELSE 3
--        END AS so_cap_duyet_theo_br08,
--        o.status, o.current_approval_level, o.current_approval_attempt
-- FROM offers o
-- JOIN applications a ON a.id = o.application_id
-- JOIN candidates c ON c.id = a.candidate_id
-- JOIN job_descriptions jd ON jd.id = a.jd_id
-- ORDER BY pct_lech_tran_band DESC;
--
-- ---------------------------------------------------------------------
-- (5) SCR-10 — Funnel tuyển dụng và time-in-stage, đọc từ bảng append-only
--     application_status_history đúng như thiết kế read model của ADR-07.
--     Bộ lọc WHERE giới hạn kết quả đúng 6 trạng thái của phễu chính; các
--     trạng thái nhánh (NEED_RESCHEDULE, OFFER_APPROVED, OFFER_SENT, ON_HOLD,
--     TALENT_POOL, REJECTED) được xem ở câu (1) nên không đưa vào đây.
--     Kết quả mong đợi: 11 hồ sơ vào NEW, 11 qua SCREENING, 7 INTERVIEWING,
--     4 OFFER_PENDING, 2 ACCEPTED, 1 HIRED.
-- ---------------------------------------------------------------------
-- SELECT h.to_status,
--        COUNT(DISTINCT h.application_id) AS so_ho_so_da_di_qua,
--        ROUND(AVG(EXTRACT(EPOCH FROM (h.next_at - h.changed_at)) / 3600)::numeric, 1) AS gio_trung_binh_o_trang_thai
-- FROM (
--   SELECT application_id, to_status, changed_at,
--          LEAD(changed_at) OVER (PARTITION BY application_id ORDER BY changed_at) AS next_at
--   FROM application_status_history
-- ) h
-- WHERE h.to_status IN ('NEW','SCREENING','INTERVIEWING','OFFER_PENDING','ACCEPTED','HIRED')
-- GROUP BY h.to_status
-- ORDER BY so_ho_so_da_di_qua DESC, h.to_status;
--
-- ---------------------------------------------------------------------
-- (6) SCR-02 / SEQ-03 — Danh sách feedback quá hạn 48 giờ chưa nộp (BR-06),
--     nguồn dữ liệu cho ô cảnh báo trên dashboard và cho job escalate.
--     Kết quả mong đợi: đúng 1 dòng — Vũ Ngọc Lan, buổi phỏng vấn 203.
-- ---------------------------------------------------------------------
-- SELECT i.id AS interview_id, u.name AS nguoi_chua_nop, c.full_name AS ung_vien,
--        i.scheduled_at + make_interval(mins => i.duration_min) AS ket_thuc_luc,
--        i.scheduled_at + make_interval(mins => i.duration_min) + INTERVAL '48 hours' AS han_nop
-- FROM interviews i
-- JOIN interview_participants p ON p.interview_id = i.id
-- JOIN users u ON u.id = p.interviewer_id
-- JOIN applications a ON a.id = i.application_id
-- JOIN candidates c ON c.id = a.candidate_id
-- LEFT JOIN feedbacks f ON f.interview_id = i.id AND f.interviewer_id = p.interviewer_id
-- WHERE i.status = 'COMPLETED'
--   AND f.id IS NULL
--   AND i.scheduled_at + make_interval(mins => i.duration_min) + INTERVAL '48 hours'
--       < TIMESTAMP '2026-08-16 18:00:00'
-- ORDER BY han_nop;
-- =====================================================================
