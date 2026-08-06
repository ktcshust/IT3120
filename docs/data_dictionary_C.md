# Data Dictionary — Chương 4 (Person C)

**Phiên bản:** v1.2 (audit Chương 4 — role BR-08 + status history; xem `docs/change_log.md`)
**Phạm vi:** Toàn bộ 18 bảng trong `diagrams/C_erd_v1.md` / `sql/schema.sql`.
**Quy ước:** `NN` = NOT NULL, mặc định thời gian dùng `now()` (UTC), mọi khoá ngoại (FK) đều có index đi kèm (không lặp lại ghi chú "có index" ở từng dòng để bảng gọn — xem tổng hợp index ở cuối file).

Ghi chú thiết kế đặc biệt (denormalize / cache) được đánh dấu **[DENORM]**.

---

## 1. departments

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| name | VARCHAR(150) | NN | — | Tên phòng ban | UNIQUE |
| parent_id | BIGINT | NULL | NULL | Phòng ban cha (cây tổ chức) | FK → departments.id, ON DELETE SET NULL |
| created_at | TIMESTAMP | NN | now() | Thời điểm tạo | — |
| updated_at | TIMESTAMP | NN | now() | Thời điểm sửa gần nhất | — |

---

## 2. users

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| email | VARCHAR(255) | NN | — | Email đăng nhập (SSO) | UNIQUE |
| name | VARCHAR(150) | NN | — | Họ tên | — |
| role | ENUM `user_role` | NN | — | Vai trò: RECRUITER, HIRING_MANAGER, INTERVIEWER, HR_ADMIN, **HEAD_OF_HR**, **FINANCE** (v1.2) | — |
| department_id | BIGINT | NN | — | Phòng ban trực thuộc | FK → departments.id, ON DELETE RESTRICT |
| is_active | BOOLEAN | NN | TRUE | Còn làm việc hay đã rời công ty | — |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

**Ghi chú:** `role` dùng single-table inheritance thay cho 6 bảng con. **[v1.2]** Thêm `HEAD_OF_HR` / `FINANCE` để khớp BR-08 (cấp duyệt 2 và 3). `HR_ADMIN` giữ vai trò cấu hình hệ thống (user, template), không gộp với Head of HR.

---

## 3. job_descriptions

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| title | VARCHAR(200) | NN | — | Tên vị trí tuyển | — |
| department_id | BIGINT | NN | — | Phòng ban cần tuyển | FK → departments.id, ON DELETE RESTRICT |
| level | VARCHAR(50) | NULL | NULL | Cấp bậc (Junior/Senior...) | — |
| salary_band_min | DECIMAL(12,2) | NN | — | Mức lương sàn | CHECK salary_band_min >= 0 |
| salary_band_max | DECIMAL(12,2) | NN | — | Mức lương trần | CHECK salary_band_max >= salary_band_min (BR liên quan đến BR-08) |
| hiring_manager_id | BIGINT | NN | — | Người duyệt JD & offer | FK → users.id, ON DELETE RESTRICT |
| recruiter_id | BIGINT | NN | — | Người phụ trách vận hành (BR-01: đúng 1 recruiter) | FK → users.id, ON DELETE RESTRICT |
| status | ENUM `jd_status` | NN | 'DRAFT' | DRAFT / OPEN / CLOSED (BR-02: chỉ nhận CV khi OPEN) | — |
| headcount | INT | NN | 1 | Số lượng cần tuyển | CHECK headcount > 0 |
| opened_at | TIMESTAMP | NULL | NULL | Thời điểm mở | — |
| closed_at | TIMESTAMP | NULL | NULL | Thời điểm đóng (thủ công hoặc tự động khi đủ hire) | — |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

---

## 4. interview_processes

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| jd_id | BIGINT | NN | — | JD áp dụng quy trình này | FK → job_descriptions.id, ON DELETE CASCADE |
| round_order | INT | NN | — | Thứ tự vòng (1, 2, 3...) | CHECK round_order > 0 |
| round_name | VARCHAR(100) | NN | — | VD: "Technical R1" | — |
| required_interviewers | INT | NN | 1 | Số interviewer tối thiểu cần có (liên quan BR-07) | CHECK required_interviewers > 0 |
| scorecard_template_id | BIGINT | NN | — | Mẫu chấm điểm dùng cho vòng này | FK → scorecard_templates.id, ON DELETE RESTRICT |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

**Ràng buộc bổ sung:** `UNIQUE(jd_id, round_order)` — một JD không thể có 2 vòng cùng thứ tự.

---

## 5. scorecard_templates

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| name | VARCHAR(150) | NN | — | Tên mẫu scorecard | — |
| criteria | JSONB | NN | — | Danh sách tiêu chí + trọng số, VD `[{"name":"technical","weight":0.3}, ...]` | — |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

**Ghi chú:** dùng JSONB (không phải bảng con) vì cấu trúc tiêu chí có thể thay đổi theo từng công ty/JD mà không muốn migrate schema liên tục — đây là 1 điểm cố ý "vi phạm 1NF có kiểm soát", chấp nhận được vì `criteria` chỉ đọc/ghi nguyên khối, không cần query theo từng tiêu chí con ở tầng SQL.

---

## 6. candidates

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính, định danh nội bộ (không đổi dù candidate đổi email) | PK |
| full_name | VARCHAR(150) | NN | — | Họ tên ứng viên | — |
| email | VARCHAR(255) | NN | — | Email liên hệ hiện tại | UNIQUE |
| phone | VARCHAR(30) | NULL | NULL | Số điện thoại | — |
| current_company | VARCHAR(150) | NULL | NULL | Công ty hiện tại | — |
| years_of_experience | INT | NULL | NULL | Số năm kinh nghiệm (dạng số, để lọc/sort được) | CHECK years_of_experience >= 0 |
| experience_summary | TEXT | NULL | NULL | Tóm tắt kinh nghiệm dạng text tự do | — |
| source | ENUM `candidate_source` | NN | 'OTHER' | Nguồn tuyển: EMAIL, LINKEDIN, WEBSITE, REFERRAL, HEADHUNTER, OTHER | — |
| parsed_profile | JSONB | NULL | NULL | Profile được parse tự động từ CV (module F12, optional) | — |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

**Ghi chú:** tách `years_of_experience INT` (chuẩn hoá, lọc được) khỏi `experience_summary TEXT` (tự do) — quyết định thống nhất với A khi review Chương 2 (xem xung đột thường gặp ở `03_person_C_data.md` mục 8).

---

## 7. attachments

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| candidate_id | BIGINT | NN | — | Ứng viên sở hữu file | FK → candidates.id, ON DELETE CASCADE |
| file_url | VARCHAR(500) | NN | — | Đường dẫn object storage (S3/MinIO) | — |
| file_name | VARCHAR(255) | NN | — | Tên file gốc | — |
| version | INT | NN | 1 | Số phiên bản (mỗi lần upload lại CV mới) | CHECK version > 0 |
| uploaded_at | TIMESTAMP | NN | now() | Thời điểm upload | — |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

---

## 8. applications

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| candidate_id | BIGINT | NN | — | Ứng viên apply | FK → candidates.id, ON DELETE RESTRICT |
| jd_id | BIGINT | NN | — | JD được apply | FK → job_descriptions.id, ON DELETE RESTRICT |
| status | ENUM `application_status` | NN | 'NEW' | Trạng thái theo state machine mục 7 spec (17 giá trị) | — |
| applied_at | TIMESTAMP | NN | now() | Thời điểm nộp | — |
| current_round | INT | NULL | NULL | **[DENORM]** Vòng phỏng vấn hiện tại — cache từ `MAX(interviews.round_order)` | — |
| rejection_reason | VARCHAR(255) | NULL | NULL | Lý do reject (bắt buộc nếu status = REJECTED, enforce ở application layer) | — |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

**Ràng buộc bổ sung:** `UNIQUE(candidate_id, jd_id, applied_at)` không đủ để chặn BR-04 (apply lại sau 6 tháng) — rule này có tính thời gian động nên enforce ở service layer, DB chỉ hỗ trợ bằng index `(candidate_id, jd_id, applied_at)`.

---

## 8b. application_status_history **[v1.2]**

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| application_id | BIGINT | NN | — | Application bị đổi trạng thái | FK → applications.id, ON DELETE CASCADE |
| from_status | ENUM `application_status` | NULL | NULL | Trạng thái trước (NULL khi tạo Application = NEW) | — |
| to_status | ENUM `application_status` | NN | — | Trạng thái sau | — |
| actor_id | BIGINT | NULL | NULL | Người thực hiện (NULL = System/cron, VD BR-05/BR-13) | FK → users.id, ON DELETE SET NULL |
| changed_at | TIMESTAMP | NN | now() | Thời điểm chuyển | — |
| note | VARCHAR(255) | NULL | NULL | Ghi chú ngắn (VD: lý do hold hết hạn) | — |

**Ghi chú thiết kế:** Bảng **append-only** (không `updated_at`) — mỗi transition của STATE-01 ghi 1 dòng. Phục vụ time-in-stage / funnel chi tiết tốt hơn `audit_logs` polymorphic. Service gọi `Application.recordStatusChange()` mỗi khi `transitionTo()`.

---

## 9. interviews

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| application_id | BIGINT | NN | — | Application được phỏng vấn | FK → applications.id, ON DELETE CASCADE |
| round_order | INT | NN | — | Thứ tự vòng, khớp `interview_processes.round_order` | — |
| scheduled_at | TIMESTAMP | NN | — | Thời gian bắt đầu | — |
| duration_min | INT | NN | 60 | Thời lượng (phút) | CHECK duration_min > 0 |
| meeting_link | VARCHAR(500) | NULL | NULL | Link Google Meet/Zoom | — |
| status | ENUM `interview_status` | NN | 'SCHEDULED' | SCHEDULED / COMPLETED / CANCELLED / NEED_RESCHEDULE | — |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

**Ghi chú BR-03:** "không xếp 2 phỏng vấn trùng giờ cho 1 interviewer" **không** thể biểu diễn bằng CHECK constraint đơn giản (phải so sánh khoảng thời gian giữa nhiều dòng của bảng `interview_participants`/`interviews`). Enforce bằng: (1) lock Redis `(interviewer_id, time_slot)` ở tầng service trước khi insert (xem SEQ-01 của B), (2) index `(scheduled_at)` trên `interviews` + `(interviewer_id)` trên `interview_participants` để query kiểm tra xung đột nhanh trước khi insert.

**Ràng buộc bổ sung [v1.1]:** `UNIQUE(application_id, round_order)` — thêm qua audit Chương 3 của B, đảm bảo "reschedule" (STATE-02, `diagrams/B_state_interview_v1.md`) luôn là **UPDATE** lại dòng `interviews` hiện có (đổi `scheduled_at` + `status`), không tạo dòng mới cho cùng vòng phỏng vấn của cùng application. Cần xác nhận với B/D tại Sync S4.

---

## 10. interview_participants

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính (surrogate key) | PK |
| interview_id | BIGINT | NN | — | Buổi phỏng vấn | FK → interviews.id, ON DELETE CASCADE |
| interviewer_id | BIGINT | NN | — | Người phỏng vấn | FK → users.id, ON DELETE RESTRICT |
| role | ENUM `participant_role` | NN | 'SECONDARY' | PRIMARY / SECONDARY | — |
| created_at | TIMESTAMP | NN | now() | — | — |

**Ràng buộc bổ sung:** `UNIQUE(interview_id, interviewer_id)` — 1 interviewer không thể được thêm 2 lần vào cùng 1 buổi phỏng vấn. Đây là bảng trung gian giải quyết N–N `interviews` ↔ `users`.

---

## 11. feedbacks

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| interview_id | BIGINT | NN | — | Buổi phỏng vấn được chấm | FK → interviews.id, ON DELETE CASCADE |
| interviewer_id | BIGINT | NN | — | Người chấm | FK → users.id, ON DELETE RESTRICT |
| verdict | ENUM `verdict` | NN | — | STRONG_HIRE / HIRE / NO_HIRE / STRONG_NO_HIRE | — |
| total_score | DECIMAL(4,2) | NULL | NULL | **[DENORM]** Tổng điểm — cache từ `AVG(feedback_criteria.score)`, tính lại mỗi khi criterion thay đổi trong 24h chưa lock | — |
| submitted_at | TIMESTAMP | NN | now() | — | — |
| is_locked | BOOLEAN | NN | FALSE | Khoá sau 24h theo BR-06/spec UC-03 bước 5 | — |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

**Ràng buộc bổ sung:** `UNIQUE(interview_id, interviewer_id)` — mỗi interviewer chỉ nộp 1 feedback cho 1 buổi phỏng vấn.

---

## 12. feedback_criteria

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| feedback_id | BIGINT | NN | — | Feedback cha | FK → feedbacks.id, ON DELETE CASCADE |
| criterion_name | VARCHAR(50) | NN | — | technical / problem_solving / communication / culture_fit / growth_mindset | — |
| score | INT | NN | — | Thang 1–5 | CHECK score BETWEEN 1 AND 5 |
| comment | TEXT | NULL | NULL | Nhận xét cho tiêu chí | — |
| created_at | TIMESTAMP | NN | now() | — | — |

**Ràng buộc bổ sung:** `UNIQUE(feedback_id, criterion_name)` — không trùng tiêu chí trong cùng 1 feedback.

---

## 13. offers

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| application_id | BIGINT | NN | — | Application được offer (1–1) | FK → applications.id, ON DELETE RESTRICT, UNIQUE |
| salary | DECIMAL(12,2) | NN | — | Mức lương đề xuất | CHECK salary > 0 |
| start_date | DATE | NN | — | Ngày bắt đầu dự kiến | — |
| benefits | JSONB | NULL | NULL | Danh sách phúc lợi | — |
| deadline | DATE | NN | — | Hạn phản hồi (BR-09: tối đa 7 ngày làm việc) | — |
| status | ENUM `offer_status` | NN | 'DRAFT' | DRAFT / PENDING_APPROVAL / APPROVED / SIGNED_BY_COMPANY / ACCEPTED / DECLINED / NEGOTIATING / EXPIRED / REJECTED_INTERNALLY | — |
| current_approval_level | INT | NN | 0 | Cấp duyệt hiện tại (0 = chưa gửi duyệt) theo BR-08 | CHECK current_approval_level >= 0 |
| current_approval_attempt **[v1.1]** | INT | NN | 1 | Lần duyệt hiện tại — tăng lên khi quy trình bị Request Change và chạy lại từ cấp 1 (UC-04 A4.1) | CHECK current_approval_attempt > 0 |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

**Ràng buộc bổ sung:** `UNIQUE(application_id)` biểu diễn quan hệ 1–1 (mỗi application tối đa 1 offer đang hoạt động — offer cũ bị expired/declined thì có thể tạo offer mới, nên thực tế cho phép nhiều dòng lịch sử; nếu cần giữ lịch sử offer, bỏ UNIQUE và thêm cột `is_current`. Ở v1, chọn đơn giản: 1 offer/application, tạo offer mới = update dòng cũ). Xem `offer_approvals.attempt_no` (mục 14) — cặp `(current_approval_level, current_approval_attempt)` xác định chính xác đang ở cấp nào, lần duyệt thứ mấy.

---

## 14. offer_approvals

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| offer_id | BIGINT | NN | — | Offer cần duyệt | FK → offers.id, ON DELETE CASCADE |
| approver_id | BIGINT | NN | — | Người duyệt ở cấp này | FK → users.id, ON DELETE RESTRICT |
| level | INT | NN | — | Cấp duyệt: 1 = Hiring Manager, 2 = Head of HR, 3 = Finance | CHECK level BETWEEN 1 AND 3 |
| attempt_no **[v1.1]** | INT | NN | 1 | Lần duyệt thứ mấy — tăng lên mỗi khi "duyệt lại từ cấp 1" sau Request Change | CHECK attempt_no > 0 |
| decision | ENUM `approval_decision` | NN | 'PENDING' | PENDING / APPROVED / REJECTED / REQUEST_CHANGE | — |
| comment | TEXT | NULL | NULL | Ghi chú khi reject/request change | — |
| decided_at | TIMESTAMP | NULL | NULL | Thời điểm ra quyết định | — |
| created_at | TIMESTAMP | NN | now() | — | — |

**Ràng buộc bổ sung [v1.1]:** `UNIQUE(offer_id, level, attempt_no)` — trước đây là `UNIQUE(offer_id, level)`,
đã phát hiện qua audit Chương 3 của B rằng constraint cũ **chặn** đúng cơ chế "duyệt lại từ cấp 1"
mà chính ghi chú này mô tả (tạo lại dòng approval cùng level thì sẽ đụng UNIQUE cũ). Thêm
`attempt_no` để mỗi lần chạy lại toàn bộ quy trình duyệt (UC-04 A4.1) là 1 attempt riêng biệt,
giữ đủ lịch sử qua `AuditLog` như ý định ban đầu mà không vi phạm ràng buộc duy nhất.

---

## 15. email_templates

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| template_key | VARCHAR(100) | NN | — | Khoá định danh, VD `offer_sent_vn` | UNIQUE |
| subject | VARCHAR(255) | NN | — | Chủ đề email | — |
| body | TEXT | NN | — | Nội dung email (hỗ trợ placeholder `{{candidate_name}}`) | — |
| variables | JSONB | NULL | NULL | Danh sách biến hợp lệ trong `body` | — |
| created_at | TIMESTAMP | NN | now() | — | — |
| updated_at | TIMESTAMP | NN | now() | — | — |

---

## 16. audit_logs

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| actor_id | BIGINT | NULL | NULL | Người/hệ thống thực hiện (NULL = System/cron) | FK → users.id, ON DELETE SET NULL |
| action | VARCHAR(100) | NN | — | VD `OFFER_APPROVED`, `INTERVIEW_RESCHEDULED` | — |
| entity_type | VARCHAR(50) | NN | — | Tên entity bị tác động, VD `Offer` | — |
| entity_id | BIGINT | NN | — | id của entity bị tác động | — |
| payload | JSONB | NULL | NULL | Dữ liệu chi tiết trước/sau thay đổi | — |
| created_at | TIMESTAMP | NN | now() | — | — |

**Ghi chú:** `entity_type` + `entity_id` là **polymorphic reference** (không FK cứng vì có thể trỏ tới nhiều loại bảng khác nhau) — đánh đổi mất kiểm tra ràng buộc toàn vẹn ở DB, đổi lại 1 bảng log dùng chung cho mọi entity thay vì N bảng log riêng.

---

## 17. notifications

| Field | Kiểu | Null? | Default | Mô tả | Ràng buộc |
|---|---|---|---|---|---|
| id | BIGSERIAL | NN | auto | Khoá chính | PK |
| user_id | BIGINT | NN | — | Người nhận | FK → users.id, ON DELETE CASCADE |
| type | VARCHAR(50) | NN | — | VD `SLA_REMINDER`, `INTERVIEW_INVITE` | — |
| payload | JSONB | NULL | NULL | Dữ liệu hiển thị (link, tên liên quan...) | — |
| is_read | BOOLEAN | NN | FALSE | Đã đọc chưa | — |
| created_at | TIMESTAMP | NN | now() | — | — |

**Ghi chú [v1.2]:** Chỉ phục vụ user nội bộ (`users`). Candidate nhận thông báo qua **email** (NotificationService → EmailGateway, BR-12), không có hàng trong `notifications` — Candidate không phải `User`.

---

## Tổng hợp Index (ngoài PK/UNIQUE đã nêu ở từng bảng)

| Bảng | Index | Lý do |
|---|---|---|
| users | `department_id` | FK, filter theo phòng ban |
| job_descriptions | `department_id`, `hiring_manager_id`, `recruiter_id`, `status` | FK + filter danh sách JD theo trạng thái (spec mục 11: NFR hiệu năng) |
| interview_processes | `jd_id`, `scorecard_template_id` | FK |
| applications | `candidate_id`, `jd_id`, `status` | FK + filter pipeline kanban theo trạng thái |
| application_status_history | `application_id`, `changed_at`, `to_status` | **[v1.2]** time-in-stage / funnel |
| interviews | `application_id`, `scheduled_at` | FK + hỗ trợ kiểm tra xung đột lịch (BR-03) |
| interview_participants | `interview_id`, `interviewer_id` | FK 2 chiều cho N–N |
| feedbacks | `interview_id`, `interviewer_id` | FK |
| feedback_criteria | `feedback_id` | FK |
| offers | `application_id`, `status`, `deadline` | FK + query offer sắp hết hạn (BR-09) |
| offer_approvals | `offer_id`, `approver_id` | FK |
| attachments | `candidate_id` | FK |
| audit_logs | `actor_id`, `(entity_type, entity_id)` | FK + tra cứu lịch sử theo entity |
| notifications | `user_id`, `is_read` | FK + query "thông báo chưa đọc" |

Chi tiết cài đặt xem `sql/schema.sql`.

**Quy ước timestamp [v1.2]:** Bảng mutable có `created_at` + `updated_at`. Bảng append-only (`audit_logs`, `notifications`, `application_status_history`, `feedback_criteria`, `interview_participants`, `offer_approvals`) chỉ có `created_at` hoặc `changed_at` — không bắt buộc `updated_at`.
