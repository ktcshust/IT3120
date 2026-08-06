# Đặc tả Bài tập lớn — Phân tích & Thiết kế Hệ thống
## Hệ thống quản lý quy trình tuyển dụng (ATS mini) cho công ty IT

**Phiên bản:** 1.1 (đã vá qua audit Chương 3 — xem `docs/change_log.md`)
**Domain:** Human Resources — Recruitment / Talent Acquisition
**Loại hệ thống:** Web application, multi-tenant nội bộ một doanh nghiệp

---

## 1. Bối cảnh & Vấn đề nghiệp vụ

### 1.1. Hiện trạng giả định
Công ty IT quy mô ~500–1000 nhân sự, tuyển dụng liên tục các vị trí Software Engineer, Data Engineer, AI Engineer, PM, BA, QC... Quy trình tuyển dụng hiện tại bị phân mảnh:

- CV nhận qua email, LinkedIn, website tuyển dụng, referral — lưu rải rác trên Google Drive.
- Lịch phỏng vấn xếp thủ công qua Outlook/Google Calendar, thường xuyên trùng lịch giữa các interviewer.
- Feedback phỏng vấn ghi trên file Word/Excel riêng của từng người, không tập trung.
- Không có số liệu funnel (bao nhiêu CV → phỏng vấn → offer → nhận việc), không đo được thời gian tuyển trung bình (time-to-hire).
- Ứng viên bị "im lặng" vì không có cơ chế nhắc HR phản hồi đúng SLA.

### 1.2. Mục tiêu hệ thống
Xây dựng hệ thống quản lý tuyển dụng tập trung, giúp:
1. Chuẩn hóa quy trình từ mở JD → tuyển được người.
2. Loại bỏ trùng lịch phỏng vấn, tự động hóa việc xếp lịch.
3. Tập trung mọi feedback, cho phép Hiring Manager ra quyết định trên cùng một dashboard.
4. Cung cấp báo cáo funnel, time-to-hire, hiệu quả nguồn tuyển.
5. Đảm bảo mọi ứng viên nhận phản hồi trong SLA cam kết.

### 1.3. Ngoài phạm vi (Out of scope)
- Chấm công, tính lương, quản lý nhân sự sau onboarding.
- Website tuyển dụng public (chỉ có portal ứng viên đăng nhập bằng link mời).
- Tích hợp thanh toán hoa hồng cho headhunter bên ngoài (chỉ ghi nhận nguồn).
- Đánh giá năng lực bằng AI (module gợi ý match CV-JD là **optional stretch goal**).

---

## 2. Stakeholders & Actors

### 2.1. Stakeholders
| Stakeholder | Quan tâm |
|---|---|
| CEO / CTO | Time-to-hire, chất lượng tuyển, chi phí/hire |
| Head of HR | Funnel conversion, hiệu quả từng nguồn, SLA phản hồi |
| Hiring Manager | Chất lượng ứng viên đến vòng cuối, tốc độ ra quyết định |
| Recruiter | Công cụ vận hành hằng ngày, giảm thao tác lặp |
| Ứng viên | Trải nghiệm minh bạch, phản hồi nhanh |

### 2.2. Actors (dùng cho Use Case Diagram)

| Actor | Vai trò | Ghi chú |
|---|---|---|
| **HR Admin** | Cấu hình hệ thống, quản lý user, phòng ban, template email | Toàn quyền |
| **Recruiter** | Tạo/quản lý JD, sàng lọc CV, xếp lịch, giao tiếp ứng viên | Actor chính |
| **Hiring Manager** | Duyệt JD, xem shortlist, quyết định offer | Trưởng bộ phận cần người |
| **Interviewer** | Nhận lịch phỏng vấn, ghi feedback, chấm điểm theo scorecard | Có thể là dev senior, tech lead |
| **Ứng viên (Candidate)** | Nộp CV, xem trạng thái, xác nhận lịch, ký offer | Actor ngoài |
| **System (Scheduler)** | Actor phụ trợ: gửi email tự động, tính SLA, cảnh báo trễ hạn | Cron/worker |

---

## 3. Danh sách chức năng chính

### 3.1. Nhóm chức năng cốt lõi (in-scope, phải làm)
| Mã | Chức năng |
|---|---|
| F01 | Quản lý JD (Job Description): tạo, duyệt, mở/đóng vị trí |
| F02 | Tiếp nhận & sàng lọc CV |
| F03 | Quản lý pipeline ứng viên theo trạng thái (kanban) |
| F04 | Xếp lịch phỏng vấn, kiểm tra xung đột |
| F05 | Ghi nhận feedback phỏng vấn theo scorecard |
| F06 | Tạo & duyệt offer (multi-level approval) |
| F07 | Portal ứng viên: xem trạng thái, xác nhận lịch |
| F08 | Báo cáo: funnel, time-to-hire, nguồn tuyển |
| F09 | Quản lý user, phân quyền theo phòng ban |
| F10 | Thông báo & nhắc SLA tự động |

### 3.2. Stretch goals (nếu còn thời gian, thêm để nâng điểm)
- F11: Gợi ý match CV–JD bằng embedding (thiết kế kiến trúc, không cần cài).
- F12: Parse CV tự động thành profile ứng viên (dùng thư viện).
- F13: Talent pool — lưu lại ứng viên bị reject để tái sử dụng cho JD sau.

---

## 4. Use Case Diagram (mô tả)

**Actor chính — Recruiter** liên kết với các use case:
- Đăng JD, Sàng lọc CV, Xếp lịch phỏng vấn, Gửi offer, Theo dõi pipeline.

**Actor Hiring Manager** liên kết với:
- Duyệt JD, Xem shortlist, Duyệt offer, Đánh giá vòng cuối.

**Actor Interviewer** liên kết với:
- Nhận lịch phỏng vấn, Ghi feedback (extends Đánh giá theo scorecard).

**Actor Candidate** liên kết với:
- Nộp CV, Xem trạng thái, Xác nhận lịch phỏng vấn, Xem & phản hồi offer.

**Actor HR Admin** liên kết với:
- Quản lý user, Cấu hình template email, Cấu hình quy trình phỏng vấn cho JD, Xem báo cáo tổng thể.

**Actor System** liên kết với:
- Gửi email tự động, Tính SLA, Cảnh báo trễ hạn, Đóng JD tự động khi đủ hire.

**Quan hệ đáng lưu ý:**
- `Xếp lịch phỏng vấn` **<<include>>** `Kiểm tra xung đột lịch`.
- `Ghi feedback` **<<include>>** `Chấm scorecard`.
- `Duyệt offer` **<<extend>>** `Đàm phán lương` (UC-06, chỉ khi ứng viên counter-offer).
- `Sàng lọc CV` **<<extend>>** `Gợi ý match CV–JD` (stretch).

---

## 5. Đặc tả chi tiết Use Case (5 use case trọng tâm)

### UC-01: Xếp lịch phỏng vấn

| Mục | Nội dung |
|---|---|
| **ID** | UC-01 |
| **Tên** | Xếp lịch phỏng vấn |
| **Actor chính** | Recruiter |
| **Actor phụ** | Interviewer, Candidate, System |
| **Precondition** | Ứng viên ở trạng thái đã pass vòng trước; JD còn mở |
| **Postcondition** | Tạo bản ghi Interview với status = SCHEDULED; email đã gửi cho interviewer và candidate |
| **Trigger** | Recruiter chọn ứng viên và click "Xếp lịch" |

**Luồng chính (Basic flow):**
1. Recruiter chọn ứng viên từ pipeline của một JD.
2. Hệ thống hiển thị vòng phỏng vấn kế tiếp theo cấu hình của JD (VD: Technical R1).
3. Recruiter chọn 1–3 interviewer từ danh sách gợi ý (lọc theo skill + phòng ban).
4. Recruiter chọn khung thời gian đề xuất.
5. Hệ thống **<<include>>** kiểm tra xung đột lịch với calendar của interviewer đã chọn.
6. Nếu không xung đột, hệ thống tạo Interview record, gửi email mời đến candidate + interviewer, thêm event vào lịch nội bộ.
7. Hệ thống đặt SLA cho candidate xác nhận (VD: 24h).
8. Use case kết thúc.

**Luồng thay thế (Alternative flows):**
- **A5.1 — Xung đột lịch:** Ở bước 5, nếu có xung đột, hệ thống hiển thị interviewer bị trùng và gợi ý 3 khung giờ trống khác. Recruiter chọn lại → về bước 5.
- **A5.2 — Không có interviewer rảnh:** Recruiter có thể ép chọn khung giờ (override) với lý do bắt buộc; hệ thống ghi audit log.
- **A6.1 — Candidate không xác nhận trong SLA:** System (actor phụ) gửi nhắc trước hạn; quá **24h** chưa xác nhận (đúng BR-05), chuyển ứng viên sang trạng thái NEED_RESCHEDULE. *(v1.1: trước đây ghi 48h, gây lệch với BR-05 — đã đồng bộ về 24h, xem `docs/change_log.md`.)*

**Business rules áp dụng:** BR-03, BR-05, BR-07 (xem mục 6).

---

### UC-02: Sàng lọc CV

| Mục | Nội dung |
|---|---|
| **ID** | UC-02 |
| **Actor chính** | Recruiter |
| **Precondition** | CV đã được nộp qua portal / import email |
| **Postcondition** | Ứng viên có trạng thái SHORTLISTED hoặc REJECTED, kèm lý do |

**Luồng chính:**
1. Recruiter mở danh sách CV mới cho một JD.
2. Hệ thống hiển thị CV kèm điểm match (nếu module F11 bật).
3. Recruiter mở từng CV, đọc, đối chiếu với JD.
4. Recruiter chọn "Shortlist" hoặc "Reject".
5. Nếu Reject → bắt buộc chọn lý do từ danh sách (thiếu kinh nghiệm, lệch skill, quá xa location...).
6. Hệ thống cập nhật trạng thái, gửi email cho candidate (template tùy theo hành động).
7. Nếu Shortlist → chuyển sang trạng thái sẵn sàng xếp lịch UC-01.

**Alternative:**
- **A4.1 — Đánh dấu talent pool:** Nếu Reject nhưng ứng viên tốt, Recruiter tick "Add to talent pool" để tái sử dụng cho JD khác.

---

### UC-03: Ghi feedback phỏng vấn

| Mục | Nội dung |
|---|---|
| **ID** | UC-03 |
| **Actor chính** | Interviewer |
| **Precondition** | Interview đã diễn ra, ở trạng thái COMPLETED |
| **Postcondition** | Feedback được lưu, tổng điểm được tính, notify Recruiter |

**Luồng chính:**
1. Interviewer đăng nhập, thấy danh sách phỏng vấn cần feedback.
2. Interviewer mở scorecard tương ứng với vòng phỏng vấn.
3. Chấm điểm 5 tiêu chí (technical, problem-solving, communication, culture fit, growth mindset) theo thang 1–5, kèm comment cho mỗi tiêu chí.
4. Ghi kết luận: STRONG_HIRE / HIRE / NO_HIRE / STRONG_NO_HIRE.
5. Submit → hệ thống tính điểm tổng, khóa feedback (không sửa được sau 24h).
6. Notify Recruiter + Hiring Manager.

**Alternative:**
- **A5.1 — Chỉnh sửa trong 24h:** Interviewer có thể quay lại chỉnh; hệ thống ghi log version.
- **A2.1 — Không kịp deadline:** Sau 48h chưa có feedback, System gửi nhắc; sau 72h, escalate lên Hiring Manager của interviewer.

---

### UC-04: Duyệt offer (multi-level approval)

| Mục | Nội dung |
|---|---|
| **ID** | UC-04 |
| **Actor chính** | Recruiter (khởi tạo) |
| **Actor phụ** | Hiring Manager, Head of HR, Finance (nếu vượt band) |
| **Precondition** | Ứng viên pass tất cả vòng, có kết luận HIRE trở lên |
| **Postcondition** | Offer được ký duyệt hoặc bị từ chối; nếu duyệt → gửi cho candidate |

**Luồng chính:**
1. Recruiter tạo Offer draft: mức lương, ngày bắt đầu, phúc lợi, thời hạn phản hồi.
2. Hệ thống xác định cấp duyệt theo BR-08:
   - Mức lương trong band → duyệt 1 cấp (Hiring Manager).
   - Mức lương vượt band ≤10% → 2 cấp (Hiring Manager + Head of HR).
   - Vượt band >10% → 3 cấp (thêm Finance).
3. Gửi cho cấp duyệt đầu tiên → chờ approve.
4. Mỗi cấp: xem chi tiết, chọn Approve/Reject/Request Change.
5. Nếu tất cả Approve → offer chuyển sang trạng thái SIGNED_BY_COMPANY, gửi cho candidate.
6. Candidate accept/decline trong deadline.

**Alternative:**
- **A4.1 — Request Change:** Trả về cho Recruiter chỉnh, quy trình duyệt bắt đầu lại từ cấp 1.
- **A6.1 — Candidate counter-offer:** **<<extend>>** UC-06 Đàm phán lương (v1.1: đổi số từ "UC-05" — UC-05 đã dùng cho "Xem báo cáo tuyển dụng", xem đặc tả rút gọn UC-06 ngay dưới UC-05).
- **A6.2 — Candidate không phản hồi:** Sau deadline, offer expired tự động.

---

### UC-05: Xem báo cáo tuyển dụng

| Mục | Nội dung |
|---|---|
| **ID** | UC-05 |
| **Actor chính** | HR Admin, Head of HR |
| **Precondition** | Có dữ liệu tuyển dụng ≥30 ngày |
| **Postcondition** | Hiển thị dashboard theo bộ lọc |

**Luồng chính:**
1. Actor chọn khoảng thời gian và bộ lọc (phòng ban, JD, nguồn tuyển).
2. Hệ thống hiển thị các chart:
   - **Funnel:** Applied → Screening → Interview → Offer → Hired.
   - **Time-to-hire:** trung bình theo phòng ban.
   - **Source effectiveness:** bao nhiêu hire từ mỗi nguồn.
   - **SLA compliance:** % ứng viên nhận phản hồi đúng hạn.
3. Actor có thể export CSV/PDF.

---

### UC-06: Đàm phán lương (đặc tả rút gọn)

| Mục | Nội dung |
|---|---|
| **ID** | UC-06 |
| **Tên** | Đàm phán lương |
| **Actor chính** | Candidate |
| **Actor phụ** | Recruiter |
| **Quan hệ** | `<<extend>>` của UC-04 (Duyệt offer), chỉ kích hoạt khi Candidate chọn "Counter-offer" ở bước phản hồi offer |
| **Precondition** | Offer đang ở trạng thái `OFFER_SENT` (Application) / `SIGNED_BY_COMPANY` (Offer) |
| **Postcondition** | Application chuyển `NEGOTIATING`; Recruiter tạo offer draft mới, quy trình duyệt (UC-04) chạy lại từ cấp 1 |

**Luồng chính:**
1. Candidate chọn "Counter-offer" trên Candidate Portal, nhập mức lương/điều kiện mong muốn.
2. Hệ thống ghi nhận, chuyển Application sang `NEGOTIATING`, notify Recruiter.
3. Recruiter xem đề nghị, tạo Offer draft mới (quay lại UC-04 bước 1).

*(v1.1: use case này trước đây được tham chiếu nhầm là "UC-05" trong UC-04 A6.1, trùng số với UC-05 "Xem báo cáo tuyển dụng" — đã đổi thành UC-06 để nhất quán, xem `docs/change_log.md`.)*

---

## 6. Business Rules

| Mã | Nội dung |
|---|---|
| BR-01 | Một JD phải có đúng 1 Recruiter phụ trách và 1 Hiring Manager duyệt. |
| BR-02 | JD chỉ mở khi được Hiring Manager approve; không cho nhận CV khi ở trạng thái DRAFT hoặc CLOSED. |
| BR-03 | Không được xếp 2 phỏng vấn cho cùng 1 interviewer trong khung thời gian trùng nhau (kể cả 1 phút). |
| BR-04 | Một ứng viên chỉ được apply lại cùng 1 JD sau 6 tháng kể từ lần reject gần nhất. |
| BR-05 | Ứng viên phải xác nhận lịch phỏng vấn trong 24h; quá hạn chuyển trạng thái NEED_RESCHEDULE. |
| BR-06 | Feedback phỏng vấn phải submit trong 48h sau khi phỏng vấn kết thúc. |
| BR-07 | Một vòng phỏng vấn có ≥2 interviewer thì phải có ≥50% kết luận HIRE trở lên mới pass. |
| BR-08 | Cấp duyệt offer phụ thuộc mức lương so với band (xem UC-04). |
| BR-09 | Offer có thời hạn phản hồi tối đa 7 ngày làm việc kể từ khi gửi. |
| BR-10 | Khi ứng viên nhận offer, tất cả pipeline khác của cùng ứng viên (JD khác) chuyển thành ON_HOLD, chờ xác nhận có onboard hay không. |
| BR-11 | Ứng viên đã hire nhưng không onboard đúng ngày → auto chuyển sang GHOSTED, JD reopen. |
| BR-12 | Mọi email gửi ra ngoài phải dùng template được HR Admin duyệt. |
| BR-13 *(mới, v1.1)* | Một Application ở `ON_HOLD` quá 14 ngày làm việc mà pipeline JD khác chưa ngã ngũ (chưa `HIRED`/`GHOSTED`/`DECLINED`), hoặc JD hiện tại đã `CLOSED` trong lúc đang `ON_HOLD`, thì tự động chuyển `REJECTED` kèm lý do "Hold quá hạn / JD đóng". |

*(BR-13 được B đề xuất bổ sung khi làm STATE-01 — Chương 3 — vì transition `ON_HOLD → REJECTED` chưa có rule gốc nào chống lưng. Cần A xác nhận số ngày "14 ngày" ở Sync S4, hiện là giả định hợp lý dựa trên BR-09 (deadline offer 7 ngày làm việc) nhân đôi để chừa thời gian xử lý.)*

---

## 7. State machine — Vòng đời ứng viên (Application)

Trạng thái của một **Application** (một lần ứng viên apply vào một JD):

```
NEW
 └─▶ SCREENING
      ├─▶ REJECTED (kèm reason)
      └─▶ INTERVIEWING
           ├─▶ NEED_RESCHEDULE
           │    └─▶ INTERVIEWING (lặp)
           ├─▶ REJECTED
           └─▶ OFFER_PENDING
                ├─▶ OFFER_APPROVED
                │    ├─▶ OFFER_SENT
                │    │    ├─▶ ACCEPTED
                │    │    │    ├─▶ HIRED (onboard thành công)
                │    │    │    └─▶ GHOSTED (không onboard)
                │    │    ├─▶ DECLINED
                │    │    ├─▶ NEGOTIATING
                │    │    │    └─▶ OFFER_PENDING (loop)
                │    │    └─▶ EXPIRED
                └─▶ OFFER_REJECTED_INTERNALLY
                     └─▶ SCREENING (loop, chỉnh lại rồi duyệt lại)
```

**Trạng thái phụ:** ON_HOLD (khi ứng viên nhận offer JD khác), TALENT_POOL (giữ cho tương lai).

---

## 8. Domain model / ERD

### 8.1. Entities chính

| Entity | Thuộc tính then chốt |
|---|---|
| **User** | id, email, name, role, department_id, is_active |
| **Department** | id, name, parent_id (cây phòng ban) |
| **JobDescription (JD)** | id, title, department_id, level, salary_band_min, salary_band_max, hiring_manager_id, recruiter_id, status, headcount, opened_at, closed_at |
| **InterviewProcess** | id, jd_id, round_order, round_name, required_interviewers, scorecard_template_id |
| **ScorecardTemplate** | id, name, criteria (JSON: list of criterion + weight) |
| **Candidate** | id, full_name, email, phone, current_company, years_exp, source, cv_url, parsed_profile (JSON) |
| **Application** | id, candidate_id, jd_id, status, applied_at, current_round, rejection_reason |
| **Interview** | id, application_id, round_order, scheduled_at, duration_min, meeting_link, status |
| **InterviewParticipant** | id, interview_id, interviewer_id (User), role (primary/secondary) |
| **Feedback** | id, interview_id, interviewer_id, verdict, total_score, submitted_at, is_locked |
| **FeedbackCriterion** | id, feedback_id, criterion_name, score, comment |
| **Offer** | id, application_id, salary, start_date, benefits (JSON), deadline, status, current_approval_level |
| **OfferApproval** | id, offer_id, approver_id, level, decision, comment, decided_at |
| **EmailTemplate** | id, key, subject, body, variables |
| **AuditLog** | id, actor_id, action, entity_type, entity_id, payload, created_at |
| **Notification** | id, user_id, type, payload, is_read, created_at |

### 8.2. Quan hệ chính
- `User` 1–N `Application` (Recruiter phụ trách).
- `Department` 1–N `User`, 1–N `JobDescription`.
- `JobDescription` 1–N `InterviewProcess`, 1–N `Application`.
- `Candidate` 1–N `Application` (một ứng viên có thể apply nhiều JD).
- `Application` 1–N `Interview` (nhiều vòng), 1–1 `Offer` (nếu có).
- `Interview` N–M `User` (interviewer) qua `InterviewParticipant`.
- `Interview` 1–N `Feedback` (mỗi interviewer 1 feedback).
- `Feedback` 1–N `FeedbackCriterion`.
- `Offer` 1–N `OfferApproval` (theo cấp duyệt).

---

## 9. Sequence diagrams (đề xuất vẽ)

Chọn 3 luồng có tương tác phức tạp nhất để vẽ sequence diagram:

1. **SEQ-01 — Xếp lịch phỏng vấn có kiểm tra xung đột.**
   Actors/objects: Recruiter → UI → SchedulingService → CalendarRepo → NotificationService → EmailGateway.
2. **SEQ-02 — Duyệt offer multi-level.**
   Actors/objects: Recruiter → OfferService → ApprovalWorkflow → HiringManager → HeadOfHR → Finance → CandidatePortal.
3. **SEQ-03 — Nhắc SLA feedback trễ hạn.**
   Actors/objects: Cron/Scheduler → SLAService → FeedbackRepo → NotificationService → EscalationService.

Optional: SEQ-04 — Ứng viên nộp CV qua portal, hệ thống parse & auto-shortlist (nếu làm F11/F12).

---

## 10. Activity diagram (đề xuất vẽ)

1. **ACT-01 — Toàn bộ quy trình tuyển 1 ứng viên** (từ nộp CV → hired), có swimlane cho Recruiter / Hiring Manager / Interviewer / Candidate / System.
2. **ACT-02 — Quy trình duyệt offer** với nhánh rẽ theo mức lương so với band.

---

## 11. Non-functional requirements

| Loại | Yêu cầu |
|---|---|
| **Hiệu năng** | Trang danh sách CV load ≤2s cho ≤500 record; sàng lọc/lọc ≤1s. |
| **Bảo mật** | Đăng nhập SSO nội bộ (giả lập bằng Google OAuth); mật khẩu candidate hash bcrypt; RBAC theo phòng ban; audit log mọi hành động sửa/xoá. |
| **Quyền riêng tư** | CV & thông tin ứng viên chỉ visible với Recruiter phụ trách + Hiring Manager của JD; các Recruiter khác không thấy. |
| **Khả dụng** | 99% giờ hành chính; downtime bảo trì báo trước 24h. |
| **Khả năng mở rộng** | Thiết kế module hoá; module báo cáo tách service để không ảnh hưởng transactional. |
| **Đa ngôn ngữ** | UI Việt/Anh; email template hỗ trợ đa ngôn ngữ. |
| **Log & Audit** | Mọi thay đổi trạng thái Application/Offer đều ghi audit log kèm actor. |
| **Sao lưu** | Backup DB hằng ngày, giữ 30 ngày; CV file lưu blob storage có versioning. |

---

## 12. Kiến trúc đề xuất

### 12.1. Sơ đồ khối (mô tả bằng text)
```
[Web UI (React/Vue)]
      │
      ▼
[API Gateway / BFF]
      │
      ├──▶ [Auth Service (OAuth)]
      ├──▶ [Recruitment Core Service] ──▶ [PostgreSQL: main DB]
      ├──▶ [Scheduling Service]        ──▶ [Redis: lock lịch]
      ├──▶ [Notification Service]      ──▶ [Email Gateway]
      ├──▶ [Reporting Service]         ──▶ [Read replica / ClickHouse]
      └──▶ [File Service]              ──▶ [Object storage: S3/MinIO cho CV]

[Scheduler/Cron worker] ──▶ SLA check, auto-close JD, nhắc feedback
```

### 12.2. Lý do chọn kiến trúc
- **Modular monolith** (hoặc microservices nhẹ): quy mô doanh nghiệp vừa, không cần hệ phân tán phức tạp; nhưng tách rõ module để có thể refactor sau.
- **Reporting service tách riêng**, dùng read replica hoặc data warehouse nhỏ để chart nặng không ảnh hưởng transactional.
- **Object storage cho CV**: file binary không nên nhét vào DB chính.
- **Redis cho lock lịch**: tránh race condition khi 2 Recruiter xếp cùng khung giờ cho cùng 1 interviewer.

### 12.3. Công nghệ đề xuất (chỉ để tham khảo, không bắt buộc)
- Backend: NestJS (Node) / Django / Spring Boot.
- Frontend: React + TailwindCSS.
- DB: PostgreSQL, Redis.
- Storage: MinIO (self-hosted S3).
- Email: SendGrid / Amazon SES (mock trong bài tập).

---

## 13. Giao diện chính (đề xuất mô tả wireframe)

| Màn hình | Mục đích | Actor |
|---|---|---|
| Dashboard Recruiter | Danh sách JD đang phụ trách, pipeline ứng viên, task cần xử lý | Recruiter |
| JD Detail — Kanban Pipeline | Board kanban các stage của 1 JD, drag-drop candidate | Recruiter |
| Candidate Profile | CV, timeline hoạt động, feedback các vòng | Recruiter, Hiring Manager |
| Schedule Interview Modal | Chọn interviewer, khung giờ, gợi ý slot rảnh | Recruiter |
| Scorecard | Form chấm điểm, comment | Interviewer |
| Offer Wizard | Tạo/duyệt offer theo bước | Recruiter, Approver |
| Candidate Portal | Trạng thái apply, xác nhận lịch, xem offer | Candidate |
| Reports | Funnel, time-to-hire, source | HR Admin, Head of HR |
| Admin — Users & Departments | Quản trị | HR Admin |

---

## 14. Đề xuất cấu trúc báo cáo bài tập lớn

| Chương | Nội dung | Trọng số gợi ý |
|---|---|---|
| Chương 1 | Tổng quan đề tài, khảo sát hiện trạng, mục tiêu | 10% |
| Chương 2 | Phân tích yêu cầu: actor, use case diagram, đặc tả use case, business rules | 25% |
| Chương 3 | Phân tích hành vi: activity diagram, state machine, sequence diagram | 20% |
| Chương 4 | Phân tích cấu trúc: domain model, class diagram, ERD | 20% |
| Chương 5 | Thiết kế kiến trúc & giao diện: component diagram, wireframe, NFR | 15% |
| Chương 6 | Demo & kết luận | 10% |

---

## 15. Rủi ro & giả định khi thiết kế

**Giả định:**
- Công ty đã có SSO nội bộ để tích hợp, hoặc dùng Google Workspace.
- Số lượng JD mở đồng thời ≤50, ứng viên/JD ≤200.
- Không cần đa quốc gia, đa múi giờ (mọi ngưới ở VN).

**Rủi ro thiết kế:**
- Race condition khi 2 Recruiter cùng xếp lịch → giải pháp: distributed lock trên (interviewer_id, time_slot).
- Ứng viên đổi email giữa chừng → giải pháp: định danh bằng candidate_id nội bộ, cho phép link nhiều email.
- GDPR-like: ứng viên yêu cầu xoá dữ liệu → thiết kế soft-delete + hàm anonymize thay vì hard delete để giữ báo cáo.

---

## 16. Tiêu chí "hay + thiết thực" mà đề tài này đáp ứng

- Use case đa dạng, không phẳng: 5 actor chính, mỗi actor ≥3 use case riêng.
- State machine có 10+ trạng thái với vòng lặp → activity/state diagram không hình thức.
- ERD có 15+ entity với đủ 1-1, 1-N, N-N → class diagram/ERD có chiều sâu.
- Có 3 luồng phù hợp vẽ sequence diagram phức tạp.
- Business rules cụ thể, không chung chung → dễ trình bày và bảo vệ trước hội đồng.
- Kiến trúc có lý do rõ (tách reporting, dùng Redis lock, blob storage) → chương thiết kế không nhàm.

---

*Hết đặc tả v1.1. Lịch sử thay đổi: xem `docs/change_log.md`.*
