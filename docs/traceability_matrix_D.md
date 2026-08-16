# Ma trận truy vết xuyên suốt Chương 1 đến Chương 6

*Phụ lục tích hợp của Chương 5 — Người phụ trách: D (System & UI Designer). Tài liệu này không phát
hành thêm bất kỳ mã số mới nào: mọi mã `UC`, `BR`, `F0x` thuộc về A và `spec_ats (1).md`; mọi mã
diagram `ACT`, `STATE`, `SEQ` thuộc về B; mọi tên bảng, cột và giá trị enum thuộc về C; chỉ các mã
`SCR`, `ADR`, `X`, `COMP-01`, `DEP-01`, `C01…C24`, `N01…N14` là do D phát hành và đã chốt trong hợp
đồng thiết kế.*

---

## 1. Mục đích, cách đọc và quy ước ký hiệu

### 1.1. Vấn đề mà tài liệu này giải quyết

Một báo cáo phân tích thiết kế gồm sáu chương do bốn người viết song song có một rủi ro đặc trưng:
mỗi chương tự nó đúng, nhưng ghép lại thì xuất hiện những "đảo hoang" — một yêu cầu ở Chương 2
không dẫn tới bất kỳ thiết kế nào ở Chương 4 hay Chương 5, hoặc ngược lại, một bảng dữ liệu và một
màn hình được thiết kế mà không phục vụ yêu cầu nào. Loại lỗi này không lộ ra khi đọc từng chương
riêng lẻ, chỉ lộ ra khi hội đồng đặt câu hỏi bắc cầu: "cái này ở Chương 2 thì tương ứng với cái gì
ở Chương 5".

Tài liệu này là phép kiểm tra hai chiều cho toàn bộ báo cáo. Chiều xuôi trả lời câu hỏi "mỗi yêu
cầu được hiện thực hoá ở đâu"; chiều ngược trả lời câu hỏi "mỗi thành phần thiết kế phục vụ yêu cầu
nào". Mục 7 — phân tích khoảng trống — là mục quan trọng nhất, vì nó ghi lại **những chỗ hai chiều
không khép kín**, thay vì che đi.

### 1.2. Cách đọc

Sáu ma trận được sắp theo thứ tự từ trừu tượng tới cụ thể và có thể đọc độc lập:

| Mục | Ma trận | Trả lời câu hỏi | Đọc khi |
|---|---|---|---|
| 2 | Use case → toàn bộ tầng thiết kế | Một use case chạm vào những gì trong sáu chương | Cần trả lời câu hỏi bắc cầu của hội đồng |
| 3 | Business rule → cơ chế thực thi | Quy tắc nghiệp vụ này được **chặn ở đâu** trong hệ thống | Bị hỏi "nếu người dùng cố tình làm sai thì sao" |
| 4 | Trạng thái → nơi thay đổi | Ai hoặc cái gì làm trạng thái này đổi, ghi ở đâu, hiện ở màn nào | Bị hỏi về state machine và vai trò của cron |
| 5 | Bảng dữ liệu → module ghi → màn hình đọc | Bảng này ai được ghi, màn nào đọc, có bảng nào thừa không | Bị hỏi "thiết kế dữ liệu có được dùng hết không" |
| 6 | NFR → component và node | Yêu cầu phi chức năng này do thành phần nào gánh | Bị hỏi "làm sao đạt được con số này" |
| 7 | Phân tích khoảng trống | Chỗ nào chưa khép kín và vì sao | Trước Sync S4 và trước buổi bảo vệ |

### 1.3. Quy ước ký hiệu

- `UC-01`…`UC-06`: use case do A chốt — năm use case có kịch bản đầy đủ cộng UC-06 đặc tả rút gọn
  (`spec_ats (1).md` mục 5; `chapter-A.docx` Bảng 2.3; mâu thuẫn X-07 đã chốt theo A).
- `BR-xx (spec)` và `BR-xx (A)`: **hai hệ đánh số song song**, xem mục 1.4.
- `C01`…`C24`: component của COMP-01 (`diagrams/D_comp_architecture_v1.md` Bảng 5.2).
- `N01`…`N14`: node của DEP-01 (`diagrams/D_deploy_topology_v1.md` Bảng 5.13).
- `SCR-01`…`SCR-11`: màn hình (`wireframes/D_wireframes_v1.md` Bảng 5.61).
- `NFR-01`…`NFR-14`: yêu cầu phi chức năng (`docs/nfr_detail_D.md` Bảng 5.30); NFR-13 và NFR-14 do
  D bổ sung, **chờ A xác nhận**.
- Dấu `—` nghĩa là **không có**, không phải "chưa điền". Mọi ô `—` trong tài liệu này đều đã được
  kiểm tra và đều được giải thích ở mục 7 nếu đó là khoảng trống thật.
- *(đề xuất)* đánh dấu những thứ D đã gửi C hoặc A nhưng **chưa được chốt**: chúng chưa tồn tại
  trong `sql/schema.sql` v1.2 và không được tính vào bất kỳ con số thống kê nào ở mục 8.
- Quy ước đánh số của phụ lục này: bảng đánh từ `Bảng 5.110` trở lên (`Bảng 5.110`…`Bảng 5.119`);
  tài liệu không có hình nào, nhưng dải `Hình 5.110` trở lên cũng được giữ trống cho phụ lục này nếu
  sau này cần thêm hình. Dải được chọn là dải chưa bị bất kỳ tệp nào của D chiếm: chính văn Chương 5
  dùng 5.1–5.11, hai tệp diagram dùng 5.1–5.22, `docs/nfr_detail_D.md` dùng 5.30–5.46,
  `docs/design_decisions_D.md` dùng 5.50–5.57, `wireframes/D_wireframes_v1.md` dùng Hình 5.60–5.85
  và Bảng 5.60–5.74, `wireframes/README.md` dùng Hình 5.20–5.23 và Bảng 5.90–5.108. Bản kê đầy đủ
  các dải nằm ở mục 0.2 của `wireframes/D_wireframes_v1.md`.

### 1.4. Xử lý hai hệ đánh số Business Rule song song

Đây là điểm bắt buộc phải nói rõ trước khi đọc mục 3, vì nếu không thì mọi tham chiếu BR trong báo
cáo đều mơ hồ. Hiện có **hai danh sách Business Rule đang tồn tại song song** trong repo:

- `spec_ats (1).md` v1.1 mục 6 phát hành **BR-01 … BR-13** (13 quy tắc). B và C đã tham chiếu theo
  hệ này: `report/chapter_4_data.md` Bảng 4.1 ánh xạ BR-01…BR-13 sang ràng buộc dữ liệu, và
  `diagrams/B_state_application_v1.md` gắn nhãn transition `ON_HOLD → REJECTED` bằng `BR13`.
- `chapter-A.docx` v1.0 Bảng 2.15a và 2.15b phát hành dải **BR-03 … BR-25**, trong đó liệt kê 16 mã
  thực sự được năm use case dùng: BR-03, BR-05, BR-06, BR-08, BR-12, BR-13, BR-14, BR-15, BR-16,
  BR-19, BR-20, BR-21, BR-22, BR-23, BR-24, BR-25. Chính A ghi chú rằng bảng chỉ giữ những quy tắc
  trực tiếp được UC-01…UC-05 sử dụng, nên các mã còn lại trong dải không xuất hiện.

Hai hệ này **trùng nhau ở phần lớn nội dung** với mã giống nhau (BR-03 xung đột lịch, BR-05 SLA xác
nhận, BR-06 SLA feedback, BR-08 cấp duyệt offer, BR-12 template email đã duyệt), nhưng **va chạm
đúng một điểm**:

> **Điểm va chạm — mã BR-13.**
> `spec_ats (1).md` v1.1: BR-13 = Application ở `ON_HOLD` quá 14 ngày làm việc, hoặc JD đóng trong
> lúc đang hold, thì tự chuyển `REJECTED`.
> `chapter-A.docx` v1.0 Bảng 2.15a: BR-13 = override lịch trùng chỉ dành cho người có quyền, bắt
> buộc nhập lý do và ghi AuditLog.

Đây là mâu thuẫn **X-04** trong `docs/design_decisions_D.md`, mức khẩn P1, người phải quyết là A.
Phương án D đề xuất và đang áp dụng trong toàn bộ tài liệu của mình: **giữ BR-13 theo nghĩa của
`spec_ats (1).md`** (hold timeout), vì B đã tham chiếu nghĩa này trong STATE-01 và C đã tham chiếu
trong Bảng 4.1 — sửa theo chiều ngược lại kéo theo nhiều tệp hơn; đồng thời **đề nghị A đổi mã quy
tắc override thành BR-26**, là số còn trống ngay sau dải BR-03…BR-25 mà A đã phát hành.
`diagrams/D_comp_architecture_v1.md` đã dùng `BR-26` cho `C08 SchedulingService` và `C16
AuditService` đúng theo đề xuất này.

Hệ quả cho cách đọc mục 3: **ma trận BR được trình bày thành hai bảng riêng**, một cho hệ của
`spec_ats (1).md` và một cho hệ của A, thay vì ép gộp thành một bảng duy nhất. Gộp lại sẽ tạo ra một
bảng trông thống nhất nhưng che mất chính điểm va chạm mà nhóm cần chốt ở Sync S4.

---

## 2. Ma trận chính — Use case xuyên suốt sáu chương

Bảng 5.110 là ma trận trung tâm của tài liệu: mỗi dòng là một use case, mỗi cột là một tầng của báo
cáo. Đọc một dòng từ trái sang phải chính là đi từ Chương 2 (actor, business rule) qua Chương 3
(hành vi), Chương 4 (dữ liệu), tới Chương 5 (component, màn hình, NFR).

**Bảng 5.110 — Ma trận truy vết use case qua sáu chương**

| UC | Actor chính | BR áp dụng | State bị tác động | Diagram hành vi của B | Bảng dữ liệu chính của C | Component của D | Màn hình SCR | NFR liên quan |
|---|---|---|---|---|---|---|---|---|
| **UC-01** Xếp lịch phỏng vấn | `Recruiter`; actor phụ `Interviewer`, `Candidate`, cron | spec: BR-03, BR-05, BR-07 · A: BR-03, BR-05, BR-13*(→ đề xuất BR-26)*, BR-19, BR-21, BR-22 | `applications`: `INTERVIEWING`, `NEED_RESCHEDULE` · `interviews`: `SCHEDULED`, `NEED_RESCHEDULE`, `CANCELLED` | ACT-01, **SEQ-01**, STATE-01, STATE-02 | `interviews`, `interview_participants`, `applications`, `application_status_history`, `audit_logs`, `notifications` | C01, C03, **C08**, **C24**, C21, C19, C12, C14, C16, C17 | SCR-02, SCR-03, SCR-04, **SCR-05**, SCR-09 | NFR-01, **NFR-02**, NFR-06, NFR-11, NFR-13 |
| **UC-02** Sàng lọc CV | `Recruiter` | spec: BR-02, BR-04, BR-12 · A: BR-12, BR-19, **BR-20**, BR-21, BR-25 | `applications`: `NEW`, `SCREENING`, `REJECTED`, `TALENT_POOL`, *(đề xuất `SHORTLISTED`)* | ACT-01, STATE-01 | `candidates`, `attachments`, `applications`, `application_status_history`, `email_templates`, `notifications`, `audit_logs` | C01, C03, **C06**, **C07**, C15, C23, C12, C16, C19 | SCR-02, SCR-03, **SCR-04** | NFR-01, **NFR-05**, NFR-06, NFR-12 |
| **UC-03** Ghi feedback phỏng vấn | `Interviewer`; escalate tới `HiringManager` | spec: BR-06, BR-07 · A: BR-06, BR-14, BR-15, BR-19, BR-20, BR-21 | `interviews`: `COMPLETED` · `applications`: `INTERVIEWING` → `OFFER_PENDING` hoặc `REJECTED` | ACT-01, **SEQ-03**, STATE-01, STATE-02 | `feedbacks`, `feedback_criteria`, `interviews`, `scorecard_templates`, `applications`, `notifications`, `audit_logs` | C01, C03, **C09**, C14, **C13**, C17, C12, C16, C19 | SCR-02 *(biến thể Interviewer — chưa vẽ)*, **SCR-06**, SCR-04 | NFR-05, NFR-06, NFR-11, **NFR-14** |
| **UC-04** Duyệt offer nhiều cấp | spec: `Recruiter` khởi tạo · A Bảng 2.3: `HiringManager` / `HeadOfHR` / `FinanceApprover` *(khác biệt, xem mục 7e)* | spec: BR-08, BR-09, BR-10 · A: **BR-08**, BR-16, BR-19, BR-21, BR-23 | `applications`: `OFFER_PENDING`, `OFFER_APPROVED`, `OFFER_SENT`, `ACCEPTED`, `DECLINED`, `EXPIRED`, `NEGOTIATING`, `OFFER_REJECTED_INTERNALLY`, `ON_HOLD` | **ACT-02**, **SEQ-02**, STATE-01, Bảng 3.1b | `offers`, `offer_approvals`, `applications`, `application_status_history`, `notifications`, `audit_logs` | C01, C02, C03, **C10**, **C11**, C07, C12, C17, C16, C19 | SCR-04, **SCR-07**, **SCR-08**, SCR-09 | NFR-06, NFR-09, NFR-11 |
| **UC-05** Xem báo cáo tuyển dụng | `HRAdmin`, `HeadOfHR` | spec: — *(không có mục "Business rules áp dụng")* · A: BR-20, BR-21, **BR-24**, **BR-25** | Không đổi trạng thái nào — use case chỉ đọc | **Không có diagram hành vi riêng** *(xem mục 7)* | Chỉ đọc: `application_status_history`, `applications`, `candidates`, `job_descriptions`, `offers`, `interviews`; *(đề xuất bốn bảng `rm_*`)* | **C18**, C17 *(làm mới read model)*, C03, C01, C19 | **SCR-10** | **NFR-10**, NFR-01, NFR-05, NFR-13 |
| **UC-06** Đàm phán lương *(rút gọn, `<<extend>>` UC-04)* | `Candidate`; actor phụ `Recruiter` | spec: BR-09 *(hạn phản hồi)* · A: không có dòng riêng trong Bảng 2.15 vì bảng chỉ phủ UC-01…UC-05 | `applications`: `OFFER_SENT` → `NEGOTIATING` → `OFFER_PENDING` | ACT-02 *(nhánh counter)*, STATE-01 | `offers`, `applications`, `application_status_history`, `notifications` | **C02**, C04 *(token magic link)*, C10, C07, C12, C19 | **SCR-09**, SCR-02, SCR-07 | NFR-04, NFR-06 |

Hai dòng bổ sung dưới đây không phải use case nhưng phải có mặt để bảng ngược ở mục 5 khép kín; cả
hai là chức năng trong danh mục F01–F10 của `spec_ats (1).md` mục 3.1.

**Bảng 5.111 — Hai chức năng ngoài năm use case trọng tâm**

| Chức năng | BR áp dụng | Bảng dữ liệu | Component | Màn hình | Ghi chú phạm vi |
|---|---|---|---|---|---|
| **F09** Quản lý user, phân quyền theo phòng ban | A: BR-21 | `users`, `departments`, `email_templates` | C04 *(đề xuất làm chủ sở hữu ghi)*, C16 | **SCR-11** | Nằm ngoài năm UC trọng tâm theo X-07; giữ lại vì nếu không có nơi tạo user và gán phòng ban thì ma trận RBAC không kiểm chứng được |
| **F10** Thông báo và nhắc SLA tự động | spec: BR-05, BR-06, BR-09, BR-13 · A: BR-25 | `notifications`, `email_templates`, *(đề xuất `outbox_events`)* | **C12**, **C14**, **C17**, C13, C20 | Không có màn riêng — chuông thông báo trên thanh trên của SCR-02…SCR-08, SCR-10, SCR-11; ứng viên nhận qua email | Màn "Trung tâm thông báo" đã bị **loại bỏ trước khi vẽ** vì nhân đôi thông tin, ghi tại `wireframes/README.md` mục 5.1 |

Ba nhận xét rút ra từ Bảng 5.110. Thứ nhất, **UC-01 là use case chạm vào nhiều tầng nhất**: mười
component, năm màn hình, bốn diagram của B và hai state machine — đây là lý do nó được chọn làm
luồng demo chính. Thứ hai, **UC-05 là use case duy nhất không ghi dữ liệu**, nên cột trạng thái để
trống một cách hợp lệ chứ không phải thiếu sót; đổi lại nó là use case duy nhất phụ thuộc `C18` và
`N08`. Thứ ba, cột "State bị tác động" của UC-04 dài nhất trong bảng — chín trong mười bảy giá trị
`application_status` chỉ đạt tới được qua luồng offer, giải thích vì sao `SCR-07` và `SCR-08` phải
vẽ nhiều trạng thái nhất.

---

## 3. Ma trận Business Rule → cơ chế hiện thực hoá

Cột "Được kiểm soát ở đâu" trong hai bảng dưới đây phân loại nơi quy tắc thực sự bị chặn thành bốn
mức: **ràng buộc DB** (PostgreSQL từ chối ghi), **tầng service** (mã nghiệp vụ từ chối), **giao
diện** (chỉ ngăn thao tác sai, không phải biện pháp chặn), và **job định kỳ** (`SchedulerWorker`
quét và tự chuyển trạng thái). Phân loại này quan trọng vì hội đồng thường hỏi thẳng: "nếu ai đó gọi
API trực tiếp, không qua giao diện, thì quy tắc còn hiệu lực không".

### 3.1. Hệ đánh số của `spec_ats (1).md` v1.1 — BR-01 … BR-13

**Bảng 5.112 — BR theo `spec_ats (1).md` và cơ chế hiện thực hoá**

| Mã | Nội dung rút gọn | Được kiểm soát ở đâu | Component chịu trách nhiệm | Bằng chứng |
|---|---|---|---|---|
| BR-01 | Một JD có đúng 1 Recruiter phụ trách và 1 Hiring Manager duyệt | **Ràng buộc DB** — hai cột `recruiter_id`, `hiring_manager_id` `NOT NULL` với FK riêng tới `users` | C05 `JdService` | `sql/schema.sql` bảng `job_descriptions`; `report/chapter_4_data.md` Bảng 4.1 |
| BR-02 | JD chỉ mở khi Hiring Manager duyệt; không nhận CV khi `DRAFT`/`CLOSED` | **Tầng service** — enum `jd_status` chỉ giữ giá trị, việc chặn tạo `Application` nằm ở service | C05 gọi C11 `ApprovalWorkflow` qua `IJobDescription.requestOpenApproval` | Bảng 4.1; `diagrams/D_comp_architecture_v1.md` Bảng 5.2 dòng C05, Bảng 5.22 dòng `IJobDescription` |
| **BR-03** | Không xếp hai phỏng vấn chồng giờ cho cùng một interviewer, kể cả một phút | **Tầng service, không thể bằng ràng buộc DB** — xem mục 3.3 | C08 `SchedulingService` trong vùng khoá của C24 `LockManager`; index hỗ trợ `idx_interviews_scheduled_at`, `idx_ipart_interviewer_id` | `sql/schema.sql` "Ghi chú triển khai" mục 1; Bảng 4.1; ADR-03; `diagrams/B_seq_schedule_interview_v1.md` |
| **BR-04** | Ứng viên chỉ được apply lại cùng JD sau 6 tháng kể từ lần reject gần nhất | **Tầng service, không thể bằng ràng buộc DB** — xem mục 3.3 | C06 `CandidateService` / C07 `ApplicationService` khi tạo `Application`; index hỗ trợ `idx_applications_candidate_jd_applied` | `sql/schema.sql` "Ghi chú triển khai" mục 1 và comment tại dòng index; Bảng 4.1 |
| BR-05 | Ứng viên xác nhận lịch trong 24 giờ, quá hạn chuyển `NEED_RESCHEDULE` | **Job định kỳ** đặt trên nền **tầng service** — C14 tính deadline, C17 quét quá hạn | C14 `SLAService` *(nơi duy nhất định nghĩa mọi hằng số SLA)*, C17 `SchedulerWorker`, C08 đăng ký deadline | Bảng 4.1 dòng BR-05; `diagrams/D_comp_architecture_v1.md` Bảng 5.22 dòng `ISlaPolicy`; **mốc 24h/48h chờ chốt X-01** |
| BR-06 | Feedback phải submit trong 48 giờ sau phỏng vấn | **Job định kỳ** — ba mốc 24/48/72 giờ theo SEQ-03 | C14, C17, C13 `EscalationService`, C09 `FeedbackService` | `diagrams/B_seq_sla_feedback_v1.md`; Bảng 4.1 dòng BR-06 |
| BR-07 | Vòng có ≥2 interviewer thì cần ≥50 % kết luận `HIRE` trở lên mới pass | **Tầng service** — suy ra khi cần từ `feedbacks.verdict`, cố ý **không cache** | C09 qua `IFeedback.evaluateRound(interviewId)` | Bảng 4.1 dòng BR-07; `diagrams/D_comp_architecture_v1.md` Bảng 5.22 dòng `IFeedback` |
| BR-08 | Cấp duyệt offer phụ thuộc mức lương so với band | **Ràng buộc DB một phần + tầng service** — `offer_approvals.level` có `CHECK (level BETWEEN 1 AND 3)`; số cấp do service tính | C11 qua `IApproval.determineLevels(Approvable)` | `sql/schema.sql` `chk_offer_approval_level_range`; Bảng 4.1 dòng BR-08; *(đề xuất P1 `offers.band_snapshot_min/max` để tính lại đúng tỷ lệ vượt band)* |
| BR-09 | Offer có hạn phản hồi tối đa 7 ngày làm việc | **Ràng buộc DB một phần + job định kỳ** — `offers.deadline NOT NULL` với `idx_offers_deadline`; việc hết hạn do job | C10 `OfferService.expire` chỉ được C17 gọi; C14 tính deadline | `sql/schema.sql` bảng `offers`; Bảng 4.1 dòng BR-09; Bảng 5.22 dòng `IOffer` |
| BR-10 | Ứng viên nhận offer thì mọi pipeline khác của cùng ứng viên chuyển `ON_HOLD` | **Tầng service** — enum `ON_HOLD` chỉ giữ giá trị, việc lan sang application khác là logic | C10 kích hoạt, C07 thực hiện qua `IApplication.placeOnHold` | Bảng 4.1 dòng BR-10/BR-11; STATE-01 transition `OFFER_SENT → ACCEPTED / BR10_onHoldOthers` |
| BR-11 | Đã hire nhưng không onboard đúng ngày → `GHOSTED`, JD mở lại | **Job định kỳ + tầng service** | C17 phát hiện, C07 chuyển trạng thái, C05 `reopen(jdId)` | STATE-01 transition `ACCEPTED → GHOSTED / reopenJD`; Bảng 5.22 dòng `IJobDescription` |
| BR-12 | Mọi email ra ngoài phải dùng template được HR Admin duyệt | **Tầng service** — `INotification` chỉ nhận `TemplateKey`, không nhận nội dung thô | C12 `NotificationService`; C20 `EmailAdapter` gửi | Bảng 5.22 dòng `INotification`; **hạn chế**: `email_templates` chưa có `is_active`/`locale`, xem mục 7b |
| **BR-13 (spec)** | `ON_HOLD` quá 14 ngày làm việc, hoặc JD đóng khi đang hold → `REJECTED` | **Job định kỳ** | C14 định nghĩa hạn hold, C17 quét, C07 chuyển trạng thái | STATE-01 transition `ON_HOLD → REJECTED : holdExpiredOrClosed() [after14WD_or_jdClosed] / BR13`; Bảng 4.1 dòng BR-13 |

### 3.2. Hệ đánh số của `chapter-A.docx` — 16 mã trong dải BR-03 … BR-25

Bảng 5.113 chỉ liệt kê những mã **không trùng nội dung** với Bảng 5.112, cộng với mã BR-13 của A để
làm rõ điểm va chạm. Năm mã BR-03, BR-05, BR-06, BR-08, BR-12 của A trùng nội dung với hệ
`spec_ats (1).md` và đã được trình bày ở trên, không lặp lại — đúng năm mã đã nêu ở mục 1.4. Riêng
BR-21 là mã chỉ có trong hệ của A (`spec_ats (1).md` chỉ phát hành tới BR-13), nên vẫn có dòng riêng
trong bảng dưới đây.

**Bảng 5.113 — BR riêng của `chapter-A.docx` và cơ chế hiện thực hoá**

| Mã | Nội dung rút gọn | Được kiểm soát ở đâu | Component chịu trách nhiệm | Bằng chứng |
|---|---|---|---|---|
| **BR-13 (A)** — *va chạm mã* | Override lịch trùng chỉ dành cho người có quyền; bắt buộc lý do và AuditLog | **Tầng service + ràng buộc giao diện** — nút xác nhận chỉ bật khi đã nhập lý do, nhưng việc chặn thật nằm ở service | C08 nhận `ScheduleRequest.force` kèm `reason`; C04 kiểm tra quyền override; C16 ghi audit | `chapter-A.docx` Bảng 2.15a; `diagrams/D_comp_architecture_v1.md` Bảng 5.22 dòng `IScheduling`. **D đề nghị A đổi mã thành BR-26 — mâu thuẫn X-04, mức P1** |
| BR-14 | Mỗi interviewer có đúng một Feedback cho mỗi Interview; sửa trong 24 giờ rồi khoá | **Ràng buộc DB + tầng service** — `UNIQUE (interview_id, interviewer_id)` chặn trùng; cột `is_locked` do service đặt | C09 `FeedbackService` | `sql/schema.sql` `uq_feedback_interview_interviewer`, cột `feedbacks.is_locked` |
| BR-15 | Mọi tiêu chí scorecard bắt buộc có điểm 1–5 **và comment** trước khi submit | **Ràng buộc DB một phần** — `CHECK (score BETWEEN 1 AND 5)` chặn điểm sai, nhưng `feedback_criteria.comment` là `TEXT` cho phép `NULL`, nên phần "bắt buộc comment" chỉ được chặn ở **tầng service và giao diện** | C09; `SCR-06` chặn Submit khi thiếu | `sql/schema.sql` `chk_feedback_criteria_score_range` và định nghĩa cột `comment`; `wireframes/README.md` Hình 5.22 nhánh "Chưa đủ 5 tiêu chí" |
| BR-16 | `REQUEST_CHANGE` đưa offer về `DRAFT`; sau khi sửa, chuỗi duyệt chạy lại từ cấp 1 | **Ràng buộc DB hỗ trợ + tầng service** — `UNIQUE (offer_id, level, attempt_no)` cho phép lưu nhiều lần duyệt; logic chạy lại ở service | C11 `ApprovalWorkflow`; cột `offers.current_approval_attempt` | `sql/schema.sql` `uq_offer_approval_level` và comment `[v1.1]`; `diagrams/B_seq_offer_approval_v1.md` |
| BR-19 | Mọi chuyển trạng thái đúng state machine và ghi AuditLog; job tự động phải idempotent | **Tầng service** — mọi thay đổi `applications.status` bắt buộc đi qua `IApplication.transitionTo`; job dùng `idempotency_key` | C07, C16 `AuditService`, C17 | Nguyên tắc "một bảng một chủ sở hữu ghi" tại `diagrams/D_comp_architecture_v1.md` mục 5.2; ADR-06; NFR-06, NFR-11 |
| BR-20 | CV đầy đủ chỉ cho Recruiter/HiringManager của JD; Interviewer chỉ xem packet được giao | **Tầng service, hai tầng kiểm tra** — gateway lọc thô theo vai trò, service kiểm tra phạm vi trên chính bản ghi | C04 `AuthService` qua `IAccessControl`, C06 trả DTO theo vai trò, C15 gắn `Principal` vào presigned URL | ADR-10; `docs/design_decisions_D.md` Hình 5.50 và Bảng 5.54; NFR-05 |
| BR-21 | Chỉ user `active`, đúng vai trò và đúng phạm vi phòng ban mới thực hiện được chức năng nội bộ | **Ràng buộc DB một phần + tầng service** — `users.is_active` và `users.department_id NOT NULL` là dữ liệu, việc chặn là logic | C04; C03 `ApiGateway` lọc thô | `sql/schema.sql` bảng `users`; ADR-10; NFR-04 |
| BR-22 | Interview chỉ được xếp cho vòng chưa hoàn tất có `roundOrder` nhỏ nhất | **Tầng service** — DB chỉ có `UNIQUE (application_id, round_order)` và `UNIQUE (jd_id, round_order)`, không biểu diễn được điều kiện "nhỏ nhất chưa hoàn tất" | C08 đọc `interview_processes` để gợi ý vòng kế tiếp | `sql/schema.sql` `uq_interviews_application_round`, `uq_interview_process_jd_round`; `spec_ats (1).md` UC-01 bước 2 |
| BR-23 | Chỉ duyệt/phát hành offer khi mọi vòng bắt buộc đã pass và kết luận tổng hợp tối thiểu `HIRE` | **Tầng service** | C09 `evaluateRound`, C10 kiểm tra tiền đề trước khi tạo draft, C11 | `chapter-A.docx` Bảng 2.15b; STATE-01 transition `INTERVIEWING → OFFER_PENDING [verdictHireOrAbove]` |
| BR-24 | Time-to-hire tính từ `appliedAt` đến `acceptedAt`; time-to-fill từ `openedAt` của JD đến `acceptedAt` | **Tầng service báo cáo** — định nghĩa metric gom về một chỗ | C18 `ReportingService`; nguồn là `application_status_history` | ADR-07; `docs/nfr_detail_D.md` NFR-10; `sql/schema.sql` bảng `application_status_history` |
| BR-25 | Mỗi giai đoạn có SLA; compliance chỉ đạt khi thông báo ra ngoài **gửi thành công** trước hạn | **Job định kỳ + tầng service**, hiện **chưa đủ dữ liệu để đo** | C12 ghi outbox, C17 gửi, C18 tính chỉ số | **Hạn chế**: `notifications` chưa có `delivery_status`; đề xuất P2 gửi C tại `docs/design_decisions_D.md` Bảng 5.52. Xem mục 7b |

### 3.3. Hai quy tắc không thể enforce bằng ràng buộc DB — BR-03 và BR-04

Đây là câu hỏi bảo vệ đã được dự báo trước trong `06_conventions_shared.md` và được
`report/chapter_4_data.md` mục 4.5 nêu thẳng, nên phần dưới trình bày đầy đủ lập luận để bốn thành
viên trả lời giống nhau.

**BR-03 — không xếp hai phỏng vấn chồng giờ cho cùng một interviewer.**
Ràng buộc `CHECK` của PostgreSQL chỉ nhìn thấy **các cột của chính dòng đang được ghi**; nó không
truy vấn được các dòng khác. Trong khi đó xung đột lịch là quan hệ **chồng lấn khoảng thời gian giữa
nhiều dòng khác nhau** của bảng `interviews`, nối qua `interview_participants` để biết ai là người
phỏng vấn: điều kiện cần kiểm tra là `newStart < existingEnd AND newEnd > existingStart` với mọi
dòng hiện có của cùng interviewer. Ràng buộc `UNIQUE` cũng không dùng được, vì không quy được xung
đột về một giá trị khoá duy nhất — hai buổi 14:00–15:00 và 14:30–15:30 có mọi cột khác nhau nhưng
vẫn chồng nhau.

Cơ chế thay thế gồm ba lớp, mô tả trong ADR-03 và hợp đồng thiết kế mục 6(1): `C24 LockManager` giữ
khoá phân tán trên cặp `(interviewer_id, time_slot)` với TTL 120 giây; `C08 SchedulingService` thực
hiện **truy vấn overlap và lệnh ghi trong cùng một vùng khoá**, đây là điểm mấu chốt vì nếu kiểm tra
nằm ngoài vùng khoá thì hai request song song vẫn cùng đọc thấy "không xung đột"; và hai index
`idx_interviews_scheduled_at` cùng `idx_ipart_interviewer_id` để truy vấn trong vùng khoá chạy nhanh,
giảm thời gian giữ khoá. NFR-02 biến quy tắc này thành phép đo được: 50 request song song, 0 cặp
chồng giờ.

**BR-04 — không apply lại cùng một JD trong 6 tháng kể từ lần reject gần nhất.**
Quy tắc có ba yếu tố mà `CHECK` không nắm được: nó tham chiếu **dòng khác** của cùng bảng
`applications`, nó phụ thuộc vào **thời điểm hiện tại** (hàm không tất định, PostgreSQL không cho
dùng trong `CHECK`), và nó phụ thuộc vào **trạng thái lịch sử** — cụ thể là lần chuyển sang
`REJECTED` gần nhất, dữ liệu nằm ở `application_status_history` chứ không nằm trên dòng đang ghi.
Cơ chế thay thế: kiểm tra ở tầng service khi tạo `Application`, với index
`idx_applications_candidate_jd_applied` trên `(candidate_id, jd_id, applied_at)` để truy vấn lịch sử
apply chạy nhanh; comment ngay tại dòng index trong `sql/schema.sql` ghi rõ index này tồn tại để
phục vụ BR-04.

**Điểm chung cần nói khi bảo vệ.** Cả hai đều là ràng buộc **liên dòng có yếu tố thời gian**, và đây
là ranh giới tự nhiên giữa những gì cơ sở dữ liệu bảo vệ được và những gì tầng ứng dụng phải bảo vệ.
Việc nhận ra ranh giới này và bù bằng cơ chế tương xứng — khoá phân tán cho BR-03, index cộng kiểm
tra service cho BR-04 — chính là nội dung được đánh giá, chứ không phải việc cố ép mọi quy tắc vào
schema.

---

## 4. Ma trận State → nơi thay đổi

### 4.1. Mười bảy giá trị `application_status`

Bảng 5.114 trả lời ba câu hỏi cho từng trạng thái: cái gì làm nó đổi, component nào thực sự viết vào
`applications.status`, và người dùng nhìn thấy nó ở màn nào. Cột "Nhãn tiếng Việt" lấy nguyên từ
`wireframes/README.md` Bảng 5.98 để bảo đảm báo cáo, wireframe và prototype dùng cùng một chuỗi chữ.

Một quy tắc chung cần nêu trước: theo nguyên tắc "một bảng chỉ có đúng một module sở hữu quyền ghi"
tại `diagrams/D_comp_architecture_v1.md` mục 5.2, **mọi thay đổi `applications.status` đều đi qua
`C07 ApplicationService.transitionTo(...)`**. Vì vậy cột "Component ghi" ghi tên module **kích hoạt**
chuyển trạng thái, với ngầm hiểu rằng lệnh ghi cuối cùng luôn do C07 thực hiện và luôn sinh một dòng
`application_status_history`.

**Bảng 5.114 — Mười bảy giá trị `application_status`: nguồn thay đổi, nơi ghi, nơi hiển thị**

| # | Giá trị enum | Nhãn tiếng Việt | Ai / cái gì làm nó đổi | Component kích hoạt → ghi | Màn hình hiển thị | Transition nguồn (STATE-01) |
|---|---|---|---|---|---|---|
| 1 | `NEW` | Mới nộp | Ứng viên nộp hồ sơ qua portal hoặc import email | C06 → **C07** | SCR-03 *(cột "Mới nộp")*, SCR-04, SCR-09 | `[*] --> NEW : applySubmitted()` |
| 2 | `SCREENING` | Đang sàng lọc | Recruiter mở sàng lọc; **hoặc** Recruiter chỉnh offer bị từ chối nội bộ; **hoặc** ứng viên được nhả khỏi hold | **C07**; từ `OFFER_REJECTED_INTERNALLY` do C10 kích hoạt | SCR-03, SCR-04 | `NEW → SCREENING`; `OFFER_REJECTED_INTERNALLY → SCREENING`; `ON_HOLD → SCREENING` |
| 3 | `REJECTED` | Đã từ chối hồ sơ | Recruiter bấm Reject kèm lý do; **hoặc** trượt vòng theo BR-07; **hoặc** **cron** khi hold quá hạn theo BR-13 | C09 *(trượt vòng)*, **C17** *(hold quá hạn)* → **C07** | SCR-03, SCR-04, SCR-09 | `SCREENING → REJECTED`; `INTERVIEWING → REJECTED`; `ON_HOLD → REJECTED` |
| 4 | `INTERVIEWING` | Đang phỏng vấn | Recruiter shortlist; **hoặc** ứng viên xác nhận lịch mới sau khi lỡ hạn; **hoặc** nhả khỏi hold | C08 *(khi lịch được tạo)* → **C07** | SCR-03, SCR-04, SCR-09 | `SCREENING → INTERVIEWING`; `NEED_RESCHEDULE → INTERVIEWING`; `ON_HOLD → INTERVIEWING` |
| 5 | `NEED_RESCHEDULE` | Cần xếp lại lịch | **Cron** — không ai bấm nút: `SchedulerWorker` quét quá hạn xác nhận theo BR-05 | **C14** tính hạn, **C17** quét → **C07** | SCR-03, SCR-05, SCR-09 | `INTERVIEWING → NEED_RESCHEDULE : confirmSLAMissed() [after24h] / BR05` — **mốc chờ chốt X-01** |
| 6 | `OFFER_PENDING` | Chờ duyệt offer | Recruiter tạo offer draft sau khi đủ kết luận HIRE; **hoặc** tạo lại offer sau counter-offer | C10 → **C07** | SCR-04, SCR-07, SCR-08 | `INTERVIEWING → OFFER_PENDING`; `NEGOTIATING → OFFER_PENDING` |
| 7 | `OFFER_APPROVED` | Offer đã duyệt nội bộ | Cấp duyệt cuối cùng bấm Duyệt — số cấp do BR-08 quyết định | C11 → C10 → **C07** | SCR-07, SCR-08 | `OFFER_PENDING → OFFER_APPROVED : allLevelsApproved() [BR08]` |
| 8 | `OFFER_SENT` | Đã gửi offer cho ứng viên | Recruiter bấm gửi offer cho ứng viên | C10 → **C07**; C12 phát email kèm magic link | SCR-07, SCR-09 | `OFFER_APPROVED → OFFER_SENT / setDeadline7WD` |
| 9 | `ACCEPTED` | Ứng viên đã đồng ý | **Phản hồi của ứng viên** trên Candidate Portal, cần token dùng-một-lần | C02 → C10 → **C07**; kéo theo BR-10 | SCR-04, SCR-09 | `OFFER_SENT → ACCEPTED : candidateAccepts() / BR10_onHoldOthers` |
| 10 | `HIRED` | Đã nhận việc | Recruiter/HR xác nhận ứng viên onboard đúng ngày | **C07** | SCR-04, SCR-10 *(funnel)* | `ACCEPTED → HIRED : onboardSuccess() [onStartDate]` |
| 11 | `GHOSTED` | Không đến nhận việc | **Cron** phát hiện quá ngày bắt đầu mà không onboard, theo BR-11; kéo theo mở lại JD | **C17** → **C07**; C05 `reopen(jdId)` | SCR-04, SCR-10 | `ACCEPTED → GHOSTED : onboardMissed() [afterStartDate] / reopenJD` |
| 12 | `DECLINED` | Ứng viên từ chối offer | **Phản hồi của ứng viên** | C02 → C10 → **C07** | SCR-04, SCR-09 | `OFFER_SENT → DECLINED : candidateDeclines()` |
| 13 | `NEGOTIATING` | Đang đàm phán lương | **Phản hồi của ứng viên** — chọn counter-offer, kích hoạt UC-06 | C02 → C10 → **C07**; C12 báo Recruiter | SCR-04, SCR-07, SCR-09 | `OFFER_SENT → NEGOTIATING : candidateCounters()` |
| 14 | `EXPIRED` | Offer hết hạn phản hồi | **Cron** — hết hạn 7 ngày làm việc theo BR-09, ứng viên không phản hồi | **C17** gọi `IOffer.expire` → C10 → **C07** | SCR-04, SCR-09 | `OFFER_SENT → EXPIRED : deadlinePassed() [noResponse] / BR09` |
| 15 | `OFFER_REJECTED_INTERNALLY` | Offer bị từ chối ở cấp duyệt | Một cấp duyệt bấm Từ chối | C11 → C10 → **C07** | SCR-07, SCR-08 | `OFFER_PENDING → OFFER_REJECTED_INTERNALLY : approvalRejected()` |
| 16 | `ON_HOLD` | Tạm giữ chờ kết quả JD khác | **Hệ thống** — cùng ứng viên chấp nhận offer của JD khác, theo BR-10 | C10 kích hoạt → **C07** `placeOnHold` | SCR-03, SCR-04 | `SCREENING / INTERVIEWING / OFFER_PENDING → ON_HOLD : otherOfferAccepted()` |
| 17 | `TALENT_POOL` | Đã đưa vào nguồn dự trữ | Recruiter bấm Reject nhưng tick "Add to talent pool" theo UC-02 A4.1 | **C07**; C06 phục vụ tìm kiếm lại | SCR-04; tìm kiếm talent pool qua `ICandidate.searchTalentPool` | `SCREENING → TALENT_POOL : rejectAndPool() [goodFitOtherJD]` |

Ba kết luận rút ra từ Bảng 5.114. Thứ nhất, **bốn trạng thái chỉ đạt tới được bằng cron**, không có
nút bấm nào dẫn tới: `NEED_RESCHEDULE`, `GHOSTED`, `EXPIRED`, và nhánh hold-quá-hạn của `REJECTED`.
Đây là bằng chứng cụ thể cho vai trò của `C17 SchedulerWorker` và là lý do `N05 WorkerNode` bị cấm
auto-scale — hai worker chạy song song sẽ chuyển trạng thái hai lần. Thứ hai, **ba trạng thái chỉ
đạt tới được từ hành động của ứng viên** — `ACCEPTED`, `DECLINED`, `NEGOTIATING` — và cả ba đều đi
qua `C02 CandidatePortalApp` với token magic link theo ADR-09, nên `SCR-09` là màn hình duy nhất
ngoài tường lửa nghiệp vụ có thể làm đổi trạng thái pipeline. Thứ ba, **mười ba trong mười bảy trạng
thái xuất hiện trên `SCR-04`**, xác nhận nhận định của `wireframes/README.md` rằng Candidate Profile
là trục nối ba use case.

### 4.2. Bốn giá trị `interview_status`

**Bảng 5.115 — Bốn giá trị `interview_status`: nguồn thay đổi, nơi ghi, nơi hiển thị**

| # | Giá trị enum | Ai / cái gì làm nó đổi | Component ghi | Màn hình hiển thị | Ghi chú |
|---|---|---|---|---|---|
| 1 | `SCHEDULED` | Recruiter tạo lịch, sau khi qua kiểm tra xung đột BR-03 hoặc override kèm lý do | **C08** | SCR-05, SCR-03, SCR-04, SCR-09 | `[*] --> SCHEDULED : createInterview() [noConflict_or_override] / BR03` |
| 2 | `NEED_RESCHEDULE` | **Cron** — ứng viên không xác nhận trong hạn BR-05; đổi **gần như đồng thời** với `applications.status` nhưng là hai cột khác nhau ở hai bảng khác nhau | C14, **C17** → C08 | SCR-05, SCR-09 | B đã ghi rõ đây là hai field khác nhau đổi đồng thời, không phải một |
| 3 | `COMPLETED` | Đến giờ và hết `duration_min` — tiền đề của UC-03 và SEQ-03 | C08 *(hoặc job đánh dấu)* | Gián tiếp qua danh sách "cần feedback" trên SCR-02 | **Không có thao tác giao diện nào trong 11 màn của D tương ứng với `markCompleted()`** — xem mục 7d |
| 4 | `CANCELLED` | Interviewer từ chối, hoặc Recruiter huỷ trước giờ, hoặc bỏ cuộc sau khi đổi lịch không thành | C08 | **Không màn nào** | B đã ghi tại `diagrams/B_state_interview_v1.md`: "Không có UC/BR nào mô tả rõ — cần A bổ sung alt flow cho UC-01". Khoảng trống này bắt nguồn từ Chương 2, xem mục 7d |

---

## 5. Ma trận bảng dữ liệu → module sở hữu quyền ghi → màn hình đọc

Bảng 5.116 có đúng 18 dòng, tương ứng 18 bảng trong `sql/schema.sql` v1.2 (đếm bằng số câu lệnh
`CREATE TABLE`). Cột "Module sở hữu quyền ghi" lấy từ `diagrams/D_comp_architecture_v1.md` Bảng 5.4;
những ô ghi *(đề xuất)* là chỗ hợp đồng thiết kế **chưa gán chủ sở hữu** và D đã suy luận, cần xác
nhận ở Sync S4.

**Bảng 5.116 — Mười tám bảng của C: chủ sở hữu quyền ghi và màn hình đọc**

| # | Bảng | Module sở hữu quyền ghi | Màn hình GHI qua giao diện | Màn hình ĐỌC | Ghi chú |
|---|---|---|---|---|---|
| 1 | `departments` | *(đề xuất)* C04 `AuthService` | SCR-11 | SCR-10 *(bộ lọc phòng ban)*, SCR-11, SCR-02 | Hợp đồng thiết kế không gán chủ sở hữu; xem mục 7c |
| 2 | `users` | *(đề xuất)* C04 `AuthService` | SCR-11 | SCR-05 *(chọn interviewer)*, SCR-08 *(danh sách cấp duyệt)*, SCR-03, SCR-04, SCR-06 | Như trên |
| 3 | `job_descriptions` | C05 `JdService` | Chưa có màn tạo/sửa JD riêng | SCR-02, SCR-03, SCR-07 *(band lương)*, SCR-10 | Xem mục 7c: JD được đọc ở bốn màn nhưng không màn nào trong 11 màn phục vụ thao tác tạo và duyệt mở JD |
| 4 | `scorecard_templates` | C05 `JdService` | **Không màn nào** | SCR-06 *(năm tiêu chí)* | Bảng bị đọc nhưng không có màn quản trị; xem mục 7c |
| 5 | `interview_processes` | C05 `JdService` | **Không màn nào** | SCR-05 *(gợi ý vòng kế tiếp)*, SCR-03, SCR-04 | Như trên |
| 6 | `candidates` | C06 `CandidateService` | SCR-04 *(sửa hồ sơ)* | SCR-03, SCR-04, SCR-09, SCR-10 *(source effectiveness)* | — |
| 7 | `attachments` | C06 `CandidateService` *(qua C15 cấp presigned URL)* | SCR-04 *(tải CV lên)* | SCR-04 | Nội dung tệp nằm ở N10, DB chỉ giữ URL, tên tệp và version theo ADR-04; checksum lấy từ metadata object qua `StoragePort.checksum` |
| 8 | `applications` | **C07** `ApplicationService` | SCR-03 *(kéo-thả)*, SCR-04 | SCR-02, SCR-03, SCR-04, SCR-09, SCR-10 | Bảng trung tâm: xuất hiện ở nhiều màn nhất |
| 9 | `application_status_history` | C07 **và** C16 — **hai chủ sở hữu, cần chốt** | Không ghi trực tiếp; sinh tự động theo mọi transition | SCR-04 *(timeline)*, SCR-10 *(funnel, time-in-stage)* | D đề xuất để C16 làm chủ duy nhất, C07 ghi qua `IAudit`; xem `diagrams/D_comp_architecture_v1.md` mục 5.2 |
| 10 | `interviews` | C08 `SchedulingService` | SCR-05 | SCR-03, SCR-04, SCR-06, SCR-09 | — |
| 11 | `interview_participants` | C08 `SchedulingService` | SCR-05 | SCR-04, SCR-06, SCR-09 | — |
| 12 | `feedbacks` | C09 `FeedbackService` | SCR-06 | SCR-04 *(timeline)*, SCR-08 *(người duyệt xem lại)* | — |
| 13 | `feedback_criteria` | C09 `FeedbackService` | SCR-06 | SCR-04, SCR-06 | — |
| 14 | `offers` | C10 `OfferService`; C11 cập nhật hai cột theo dõi duyệt — **ngoại lệ cần chốt** | SCR-07, SCR-09 *(phản hồi của ứng viên)* | SCR-04, SCR-07, SCR-08, SCR-09 | D đề xuất C11 gọi thao tác hẹp do C10 cung cấp thay vì viết SQL trực tiếp |
| 15 | `offer_approvals` | C11 `ApprovalWorkflow` | SCR-08 | SCR-07 *(xem trước chuỗi duyệt)*, SCR-08 | `attempt_no` cho phép giữ lịch sử các lần duyệt lại |
| 16 | `email_templates` | *(đề xuất)* C04 cho thao tác quản trị; C12 **chỉ đọc** khi gửi | **Không màn nào** trong 11 màn hiện tại | Không màn nào hiển thị trực tiếp | **Bảng mồ côi về giao diện** — xem mục 7c |
| 17 | `audit_logs` | C16 `AuditService` | Không ghi qua giao diện — sinh tự động | **Không màn nào** | **Bảng mồ côi về giao diện**, dù ma trận RBAC có dòng "Xem audit log" cấp `F` cho HR Admin và `R` cho Head of HR; xem mục 7c |
| 18 | `notifications` | C12 `NotificationService` | Không ghi qua giao diện | Chuông thông báo trên thanh trên của SCR-02…SCR-08, SCR-10, SCR-11 | Không có màn riêng — quyết định có chủ ý, ghi tại `wireframes/README.md` mục 5.1 |

Kết luận đọc theo cột: **mọi bảng trong 18 bảng đều được ít nhất một component đọc hoặc ghi**, nên
không có bảng nào hoàn toàn vô dụng ở tầng kiến trúc. Nhưng ba bảng — `email_templates`,
`audit_logs`, `scorecard_templates` — **không xuất hiện trên bất kỳ màn hình nào trong 11 màn đã
thiết kế**, và hai bảng `departments`, `users` **chưa được hợp đồng thiết kế gán chủ sở hữu ghi**.
Toàn bộ những điểm này được phân tích ở mục 7c thay vì bị làm mờ đi ở đây.

---

## 6. Ma trận NFR → component và node chịu trách nhiệm

Bảng 5.117 mở rộng Bảng 5.45 của `docs/nfr_detail_D.md` bằng hai cột mới: use case bị ảnh hưởng khi
yêu cầu không đạt, và quyết định kiến trúc đứng phía sau. Cách đọc: theo **hàng** khi một phép đo
trượt ngưỡng và cần biết soi component nào; theo **cột** khi sửa một component và cần biết phép đo
nào phải chạy lại.

**Bảng 5.117 — Mười bốn NFR: component, node, ADR và use case chịu ảnh hưởng**

| NFR | Nhóm | Component chịu trách nhiệm chính | Node liên quan | ADR nền tảng | UC bị ảnh hưởng nếu không đạt |
|---|---|---|---|---|---|
| NFR-01 | Hiệu năng danh sách | C01, C03, C07, C19 | N04, N07 | ADR-01 | UC-02, UC-01 *(kanban và danh sách CV)* |
| NFR-02 | Đồng thời | **C08, C24**, C14, C03, C19 | N09, N07 | ADR-03, ADR-08 | UC-01 |
| NFR-03 | Khả dụng | C03, C04, C17, C19 | N03, N04, N07, N08, N09 | ADR-01, ADR-02, ADR-03 | Toàn bộ UC-01…UC-06 |
| NFR-04 | Xác thực & phân quyền | **C04**, C03, C05, C07, C16, C22 | N11 | ADR-10, ADR-09 | Toàn bộ; đặc biệt UC-06 *(token magic link)* |
| NFR-05 | Quyền riêng tư | C04, **C06**, **C15**, C16, C23, C01, C02, C03 | N10 | ADR-04, ADR-10 | UC-02, UC-03, UC-05 |
| NFR-06 | Audit | **C16**, C07, C10, C11, C17, C19 | N07, N14 | ADR-06, ADR-08 | UC-01…UC-04 *(mọi chuyển trạng thái)* |
| NFR-07 | Sao lưu | C23, C19 | N07, N08, N10, **N14** | ADR-02, ADR-04 | Toàn bộ, ở tình huống khôi phục |
| NFR-08 | Mở rộng | Toàn bộ module `ats-api`, C03, C17, C18, C19, C24 | N04, N05, N06, N09 | ADR-01 | UC-01…UC-05 khi số JD và ứng viên tăng |
| NFR-09 | Đa ngôn ngữ | **C12**, C01, C02, C17, C20 | — | ADR-05, ADR-06 | UC-02, UC-04 *(email gửi ứng viên)* |
| NFR-10 | Tách tải báo cáo | **C18**, **C17**, C16, C19, C01 | N06, N08 | ADR-02, ADR-07 | UC-05 |
| NFR-11 | Tin cậy job | **C17**, C12, C13, C14, C20, C21, C19 | N05, N09, N12, N13 | ADR-05, ADR-06 | UC-01 *(E18.1)*, UC-03, UC-04 |
| NFR-12 | Bảo mật file | **C15**, **C23**, C16, C01, C02, C03 | N10, N14 | ADR-04 | UC-02 |
| NFR-13 *(D bổ sung)* | Vận hành / observability | C03, C16, C17, C18, C19, C20–C24 | N03, N07, N08 | ADR-06, ADR-07 | Không chặn UC nào trực tiếp; ảnh hưởng khả năng phát hiện sự cố của mọi UC |
| NFR-14 *(D bổ sung)* | Tiếp cận & trình duyệt | **C01, C02** | N01, N02 | ADR-12 | Toàn bộ UC ở tầng thao tác; nghiệm thu được độc lập trên prototype |

Hai điểm cần nhấn khi trình bày. Thứ nhất, **`C17 SchedulerWorker` là component chịu trách nhiệm
chính cho nhiều NFR nhất trong nhóm tin cậy** — NFR-06, NFR-10, NFR-11, NFR-13 — trong khi nó lại là
component chạy trên node duy nhất không được phép nhân bản; đây là đánh đổi cần nói rõ chứ không nên
để hội đồng tự phát hiện. Thứ hai, **NFR-14 là yêu cầu duy nhất nằm hoàn toàn ở tầng trình bày**,
nên nó có thể nghiệm thu ngay trên `prototype/index.html` mà không cần bất cứ thành phần phía máy
chủ nào — đây là lý do ADR-12 chọn prototype HTML tĩnh thay vì Figma.

---

## 7. Phân tích khoảng trống

Mục này ghi lại những chỗ hai chiều truy vết **không khép kín**. Nguyên tắc viết: nêu khoảng trống,
nêu nguyên nhân, nêu ai phải xử lý và chi phí — không tự lấp bằng cách sửa tài liệu của người khác,
và không bỏ qua vì "sẽ không ai hỏi tới".

### 7a. Use case chưa có wireframe

**Không use case nào thiếu hoàn toàn wireframe.** Cả sáu use case UC-01…UC-06 và hai chức năng F09,
F10 đều có ít nhất một màn hình phục vụ, theo `wireframes/README.md` Bảng 5.91. Tuy vậy có hai điểm
cần ghi nhận:

1. **UC-03 bước 1 chưa có wireframe đúng nghĩa.** Bước 1 của UC-03 là "Interviewer đăng nhập, thấy
   danh sách phỏng vấn cần feedback", nhưng `SCR-02` trong hợp đồng thiết kế được đặt tên "Dashboard
   Recruiter" và chỉ có hai trạng thái phải vẽ, cả hai đều dành cho Recruiter. Bảng 5.91 của
   `wireframes/README.md` đã đánh dấu ô này là **"Chưa"**. Suy luận của D là `SCR-02` thực chất là
   dashboard chung render theo vai trò, và đề xuất bổ sung biến thể Interviewer làm trạng thái thứ
   ba phải vẽ. Chi phí: vẽ thêm một trạng thái, **không thêm mã màn hình mới**. Cần A và nhóm xác
   nhận ở Sync S4.
2. **UC-05 chỉ có đúng một màn hình phục vụ.** Đây không phải thiếu sót mà là bản chất use case: cả
   ba bước đều diễn ra trên cùng một dashboard với bộ lọc thay đổi. Bù lại, `SCR-10` bắt buộc phải
   vẽ **hai trạng thái** gồm cả trạng thái trống khi chưa đủ 30 ngày dữ liệu theo precondition của
   UC-05.

Ngoài ra, **UC-05 là use case duy nhất không có diagram hành vi nào của B**: Bảng 3.1 của
`report/chapter_3_behavior.md` không có dòng UC-05, và cả sáu diagram ACT/STATE/SEQ đều không mô tả
luồng xem báo cáo. Đây là hệ quả hợp lý của việc UC-05 chỉ đọc dữ liệu, không có tương tác nhiều bên
và không có chuyển trạng thái; nhưng nếu hội đồng hỏi "vì sao use case này không xuất hiện ở Chương
3" thì câu trả lời phải là lý do trên, chứ không phải sự im lặng.

### 7b. Business rule chưa có cơ chế thực thi rõ ràng

Năm điểm dưới đây được xếp theo mức nghiêm trọng giảm dần.

1. **BR-13 trỏ tới hai quy tắc khác nhau** (X-04, mức P1). Chừng nào A chưa đổi mã quy tắc override
   thành BR-26, mọi tham chiếu "BR-13" trong báo cáo đều mơ hồ. D đã xử lý tạm bằng cách gọi quy tắc
   override **bằng nội dung chứ không bằng mã** trong `wireframes/README.md`, và dùng `BR-26` trong
   `diagrams/D_comp_architecture_v1.md` theo đúng phương án đề xuất. Đây là điểm dễ bị phát hiện
   nhất nếu người đọc tra ngược mã BR.
2. **BR-25 chưa đo được** — "compliance chỉ đạt khi thông báo ra ngoài gửi thành công trước hạn".
   Bảng `notifications` hiện chỉ ghi thông báo trong ứng dụng cho người dùng nội bộ, không có cột
   trạng thái gửi; do đó biểu đồ SLA compliance trên `SCR-10` sẽ đếm cả thông báo gửi thất bại là
   đạt hạn. Đề xuất P2 gửi C: thêm `notifications.delivery_status` và bảng `notification_deliveries`.
3. **BR-12 chưa enforce được vế "template active đã duyệt"**. `email_templates` hiện có
   `UNIQUE (template_key)`, tức mỗi khoá chỉ tồn tại đúng một bản ghi — không phân biệt được bản
   đang dùng với bản cũ, và cũng không lưu được hai ngôn ngữ song song. Cơ chế hiện tại chỉ chặn
   được vế "phải dùng template" *(vì `INotification` không nhận nội dung thô)*, chưa chặn được vế
   "phải là bản đã duyệt và đang active". Đề xuất P1 gửi C: thêm `locale`, `version`, `is_active` và
   đổi ràng buộc duy nhất thành `(template_key, locale, version)`. Hệ quả kéo theo: **NFR-09 hiện
   chỉ đạt ở phần giao diện, chưa đạt ở phần email**.
4. **BR-15 chỉ enforce được một nửa ở tầng dữ liệu.** `CHECK (score BETWEEN 1 AND 5)` chặn điểm sai,
   nhưng cột `feedback_criteria.comment` kiểu `TEXT` cho phép `NULL`, nên vế "bắt buộc có comment"
   hoàn toàn nằm ở tầng service và giao diện. Nếu gọi API trực tiếp thì có thể lưu tiêu chí không
   comment. Đây là lựa chọn có thể chấp nhận *(thêm `NOT NULL` sẽ chặn cả việc lưu nháp)*, nhưng phải
   nói rõ là lựa chọn chứ không phải bỏ sót.
5. **BR-22 không có bất kỳ ràng buộc dữ liệu nào tương ứng.** "Interview chỉ được xếp cho vòng chưa
   hoàn tất có `roundOrder` nhỏ nhất" là điều kiện so sánh giữa nhiều dòng `interviews` và
   `interview_processes`, nên nằm hoàn toàn ở `C08`. Cùng loại với BR-03 và BR-04 nhưng chưa được
   `report/chapter_4_data.md` Bảng 4.1 nhắc tới, vì bảng đó chỉ phủ hệ đánh số của
   `spec_ats (1).md`.

Cuối cùng, cần ghi nhận rằng **BR-01, BR-02, BR-04, BR-07, BR-09, BR-10, BR-11 của
`spec_ats (1).md` không xuất hiện trong bảng BR của A** — không phải vì chúng bị bỏ, mà vì A ghi rõ
Bảng 2.15 chỉ giữ những quy tắc trực tiếp được UC-01…UC-05 dùng. Chúng vẫn có cơ chế thực thi đầy đủ
như trình bày ở Bảng 5.112.

### 7c. Bảng dữ liệu "mồ côi"

Ba bảng **không xuất hiện trên bất kỳ màn hình nào trong 11 màn**:

- **`audit_logs`** — nghiêm trọng nhất trong ba. Ma trận RBAC ở `docs/design_decisions_D.md` Bảng
  5.54 có hẳn một dòng "Xem audit log" cấp `F` cho HR Admin và `R` cho Head of HR, NFR-06 đặt mục
  tiêu 100 % chuyển trạng thái có dòng audit, và `IAudit.query(AuditFilter)` đã được khai báo trong
  Bảng 5.22 của COMP-01 — nhưng **không màn hình nào hiện thực hoá thao tác tra cứu đó**. Đây là một quyền trong
  ma trận RBAC không có giao diện tương ứng. Phương án rẻ nhất: bổ sung một tab "Nhật ký hoạt động"
  trong `SCR-11` thay vì tạo mã màn hình mới, giữ nguyên số 11 màn.
- **`email_templates`** — vừa chưa có chủ sở hữu quyền ghi trong hợp đồng thiết kế, vừa không có màn
  hình quản trị, trong khi BR-12 yêu cầu template phải được HR Admin duyệt và F09 giao việc "cấu
  hình template email" cho HR Admin. Cùng phương án: một tab trong `SCR-11`.
- **`scorecard_templates`** — được `SCR-06` đọc để dựng năm tiêu chí, nhưng không màn nào cho phép
  tạo hay sửa template, dù `spec_ats (1).md` mục 4 gắn use case "Cấu hình quy trình phỏng vấn cho
  JD" cho HR Admin.

Ba bảng **chưa được hợp đồng thiết kế gán chủ sở hữu quyền ghi**: `departments`, `users` và
`email_templates` — đây đúng là ba tên không xuất hiện ở cột "Bảng được phép GHI" của Bảng 5.4 trong
`diagrams/D_comp_architecture_v1.md` (`email_templates` chỉ được `C12` đọc). Cả ba đều phục vụ màn
`SCR-11` và thuộc nhóm quản trị; đề xuất của D là gán cho `C04 AuthService` — component đang sở hữu
`UserRepo` và toàn bộ logic phân quyền — đúng như đã ghi tại `diagrams/D_comp_architecture_v1.md`
mục 5.2, kèm ghi chú rằng đây là **suy luận của D ngoài phạm vi hợp đồng thiết kế**, cần xác nhận
trước khi tính là Done. Lưu ý khi đối chiếu: mục 5.2 của tệp đó nói "năm bảng chưa có
chủ sở hữu ghi" vì đếm gộp thêm hai bảng `outbox_events` và `candidate_portal_tokens` do D đề xuất
bổ sung; hai bảng này chưa có trong `sql/schema.sql` v1.2 nên không thuộc 18 bảng đang xét ở đây.

Một bảng có **hai chủ sở hữu quyền ghi**: `application_status_history` được cả `C07` và `C16` ghi
theo hợp đồng thiết kế. Vi phạm nguyên tắc "một bảng một chủ sở hữu"; D đề xuất để `C16` làm chủ duy
nhất và `C07` ghi qua `IAudit`. Tương tự, bảng `offers` do `C10` sở hữu nhưng `C11` cần cập nhật hai
cột theo dõi tiến độ duyệt; D đề xuất `C11` gọi một thao tác hẹp do `C10` cung cấp.

Ngoài phạm vi màn hình, cần ghi nhận thêm: **`job_descriptions`, `interview_processes` và
`scorecard_templates` được đọc ở nhiều màn nhưng không màn nào trong 11 màn phục vụ thao tác tạo và
duyệt mở JD**, dù F01 nằm trong danh mục chức năng cốt lõi và BR-02 mô tả quy trình duyệt mở JD.
Nguyên nhân gốc là X-07: A chốt năm use case trọng tâm và quản lý JD không nằm trong số đó, nên bộ
wireframe bám theo use case chứ không bám theo danh mục chức năng. Đây là câu trả lời cần chuẩn bị
nếu hội đồng hỏi "Recruiter tạo JD ở đâu".

### 7d. Trạng thái không có transition dẫn tới trong thiết kế của D

Toàn bộ **17 giá trị `application_status` đều có ít nhất một transition dẫn tới** trong STATE-01 và
đều có component chịu trách nhiệm ghi, như Bảng 5.114 đã chứng minh từng dòng. Không có trạng thái
mồ côi ở phía Application.

Ở phía `interview_status`, có **hai khoảng trống**:

- **`CANCELLED` không được màn hình nào của D phục vụ.** B đã ghi thẳng tại
  `diagrams/B_state_interview_v1.md`: "Không có UC/BR nào mô tả rõ — cần A bổ sung alt flow cho
  UC-01". Khoảng trống bắt nguồn từ Chương 2 chứ không phải Chương 5: vì không có luồng thay thế mô
  tả việc Interviewer từ chối buổi phỏng vấn, D không có căn cứ để thiết kế nút huỷ và luồng thông
  báo kèm theo. Nếu A bổ sung alt flow, chi phí phía D là thêm một hành động và một trạng thái vào
  `SCR-05`.
- **`COMPLETED` không có thao tác giao diện tương ứng.** Transition `markCompleted()` được B mô tả
  với guard `[afterScheduledTime + durationMin]`, tức có thể do job tự đánh dấu, nhưng
  `C17 SchedulerWorker` trong Bảng 5.2 của COMP-01 không liệt kê job này trong danh sách trách nhiệm, và không
  màn nào có nút "Đánh dấu đã phỏng vấn". Trong khi đó `COMPLETED` là **precondition của UC-03** và
  là điểm khởi phát của SEQ-03. Cần chốt: hoặc bổ sung job đánh dấu tự động vào C17, hoặc bổ sung
  một thao tác trên `SCR-04`.

Ngoài ra, giá trị `SHORTLISTED` **chưa tồn tại trong enum** nhưng đã được A dùng làm postcondition
của UC-02 và precondition của UC-01 — đây là mâu thuẫn X-02, mức P0, đã có sẵn nhãn và màu dự trù ở
dòng cuối Bảng 5.98 của `wireframes/README.md` để khi C bổ sung enum thì không phải thiết kế lại.

### 7e. Màn hình không phục vụ use case nào

**Không có màn hình thừa.** Cả 11 màn đều phục vụ ít nhất một use case hoặc một chức năng trong danh
mục F01–F10, theo bảng ngược tại `wireframes/README.md` Bảng 5.92. Hai màn cần biện minh khi bảo vệ
vì không nằm trong năm use case có kịch bản:

- **`SCR-01`** không phục vụ bước nào của use case nào, nhưng là tiền đề kỹ thuật của toàn bộ nhánh
  nội bộ và là nơi duy nhất trình bày được cơ chế OIDC của NFR-04.
- **`SCR-11`** phục vụ F09, nằm ngoài năm use case trọng tâm theo X-07. Giữ lại vì nếu không có nơi
  tạo user và gán phòng ban thì ma trận RBAC sáu vai trò trở thành cấu hình không kiểm chứng được.

Một màn hình đã bị **loại bỏ trước khi vẽ**: "Trung tâm thông báo" cho F10, vì mọi bước của F10 đã
được phục vụ bởi chuông thông báo trên thanh trên và bởi email. Việc ghi lại quyết định loại bỏ này
quan trọng ngang việc ghi lại các màn được giữ.

### 7f. Ba điểm không nhất quán về số liệu và đánh số phát hiện khi lập ma trận

Ba điểm dưới đây được phát hiện trong lúc đối chiếu và đếm; chúng không ảnh hưởng tới thiết kế nhưng
sẽ lộ ra nếu người đọc kiểm lại con số.

1. **Số ràng buộc `CHECK`.** `report/chapter_4_data.md` Bảng 4.2 ghi "Số ràng buộc CHECK: 15", trong
   khi đếm trực tiếp trong `sql/schema.sql` v1.2 được **14** *(lệnh đếm ở mục 8)*. Chênh lệch một
   đơn vị. D **không sửa tệp của C**; đây là mục để C rà lại ở Sync S4.
2. **Số diagram của Chương 3.** Mục 3.9 của `report/chapter_3_behavior.md` kết luận "6 diagram UML",
   nhưng addendum v1.1 ở mục 3.10 đã bổ sung STATE-02, và thư mục `diagrams/` hiện có **7 tệp
   `B_*.md`**, mỗi tệp một diagram. Câu kết luận chương chưa được cập nhật theo addendum.
3. **Trùng số bảng giữa các phụ lục của chính D — đã xử lý.** Trước đây
   `diagrams/D_comp_architecture_v1.md` và `diagrams/D_deploy_topology_v1.md` cùng dùng số
   `Hình 5.2` và trùng nhau ở bốn số `Bảng 5.3`…`Bảng 5.6`, còn `wireframes/README.md` trùng chín số
   `Bảng 5.30`…`Bảng 5.38` với `docs/nfr_detail_D.md`; **và bản thân tài liệu đang đọc**, khi mới
   lập, dùng `Bảng 5.70`…`Bảng 5.79` nên trùng năm số `Bảng 5.70`…`Bảng 5.74` với
   `wireframes/D_wireframes_v1.md`. Các dải đã được tách lại: COMP-01 giữ
   Hình 5.1 và 5.9 cùng Bảng 5.2–5.4, 5.20–5.22; DEP-01 dùng Hình 5.10 và Bảng 5.12–5.19;
   `wireframes/README.md` chuyển sang Bảng 5.90–5.108; tài liệu đang đọc chuyển sang
   `Bảng 5.110`…`Bảng 5.119`. Bản kê đầy đủ các dải, đã bao gồm dải mới này, nằm ở mục 0.2 của
   `wireframes/D_wireframes_v1.md`.

### 7g. Cách đã kiểm tra để khẳng định "không có khoảng trống"

Mọi kết luận phủ định trong mục 7 đều dựa trên phép kiểm tra cụ thể, có thể lặp lại:

- **UC → màn hình**: đối chiếu từng dòng Bảng 5.91 của `wireframes/README.md` với Bảng 5.61 của
  `wireframes/D_wireframes_v1.md`; đếm ô "Đã có wireframe" bằng `Chưa` để tìm ngoại lệ — được đúng
  một ô.
- **Màn hình → UC**: đối chiếu từng dòng Bảng 5.92 của `wireframes/README.md`; mọi màn đều có giá
  trị ở cột "UC / F được phục vụ".
- **Bảng → component**: liệt kê 18 bảng bằng `grep "^CREATE TABLE" sql/schema.sql`, rồi đối chiếu
  từng tên với cột "Bảng được phép GHI" của Bảng 5.4 trong
  `diagrams/D_comp_architecture_v1.md`; **ba tên** không xuất hiện ở cột đó là `departments`,
  `users` và `email_templates` — đúng ba bảng chưa có chủ sở hữu quyền ghi đã nêu ở mục 7c. Hai bảng
  `outbox_events` và `candidate_portal_tokens` mà mục 5.2 của cùng tệp đó đếm gộp thành con số năm
  là **đề xuất chưa được chốt**, chưa tồn tại trong `sql/schema.sql` v1.2 nên không nằm trong 18 tên
  do lệnh `grep` trả về và không được tính vào phép đếm này.
- **State → transition**: đối chiếu 17 giá trị trong `CREATE TYPE application_status` với các
  transition trong khối `stateDiagram-v2` của `diagrams/B_state_application_v1.md`; làm tương tự cho
  4 giá trị `interview_status` với `diagrams/B_state_interview_v1.md`.
- **Prototype → màn hình**: liệt kê thuộc tính `id="scr-xx"` trong `prototype/index.html`; thu được
  đúng 11 giá trị `scr-01`…`scr-11`, không thiếu, không thừa.

---

## 8. Bảng thống kê tổng

Bảng 5.118 là bảng con số duy nhất mà cả nhóm nên dùng khi làm slide và khi trả lời câu hỏi định
lượng. Cột "Cách đếm" tồn tại để người khác kiểm lại được mà không phải tin vào tài liệu này.

**Bảng 5.118 — Thống kê tổng toàn báo cáo và cách đếm**

| Đối tượng | Số lượng | Nguồn | Cách đếm |
|---|---|---|---|
| Business actor | **7** | `chapter-A.docx` Bảng 2.1 | Đếm dòng bảng: HRAdmin, Recruiter, HiringManager, Interviewer, Candidate, HeadOfHR, FinanceApprover |
| Actor trong `spec_ats (1).md` | **6** | `spec_ats (1).md` mục 2.2 | Đếm dòng bảng; khác A ở chỗ spec liệt kê `System (Scheduler)` là actor phụ trợ — mâu thuẫn X-05, đã chốt theo A: đây là component nội bộ C17 |
| Supporting actor / hệ thống ngoài | **3 + 1** | `chapter-A.docx` Bảng 2.2 | IdentityProvider, EmailGateway, CalendarProvider là hệ thống ngoài; Scheduled trigger là kích hoạt nội bộ, không phải actor ngoài |
| Vai trò nội bộ trong DB | **6** | `sql/schema.sql` | Đếm giá trị trong `CREATE TYPE user_role`: RECRUITER, HIRING_MANAGER, INTERVIEWER, HR_ADMIN, HEAD_OF_HR, FINANCE |
| Use case | **6** = 5 kịch bản đầy đủ + 1 rút gọn | `spec_ats (1).md` mục 5; `chapter-A.docx` Bảng 2.3 | UC-01…UC-05 có kịch bản đầy đủ; UC-06 đặc tả rút gọn, quan hệ `<<extend>>` với UC-04 |
| Business rule — hệ `spec_ats (1).md` | **13** | `spec_ats (1).md` mục 6 | Đếm dòng bảng BR-01…BR-13 |
| Business rule — hệ `chapter-A.docx` | **16** mã trong dải BR-03…BR-25 | `chapter-A.docx` Bảng 2.15a, 2.15b | Đếm dòng hai bảng; A ghi rõ chỉ giữ quy tắc được UC-01…UC-05 dùng, nên BR-17 và BR-18 không xuất hiện |
| Business rule — hợp nhất hai hệ | **23 mã khác nhau**, tương ứng **24 quy tắc** | Hai nguồn trên | Hợp hai tập mã: BR-01…BR-16 cộng BR-19…BR-25 = 23 mã; riêng mã BR-13 mang hai quy tắc khác nhau nên số quy tắc là 24. Đây chính là điểm va chạm X-04 |
| Trạng thái `application_status` | **17** | `sql/schema.sql` | Đếm giá trị trong `CREATE TYPE application_status`; *(đề xuất bổ sung `SHORTLISTED` → 18, chưa được tính)* |
| Trạng thái `interview_status` | **4** | `sql/schema.sql` | Đếm giá trị trong `CREATE TYPE interview_status` |
| Tổng số giá trị enum trạng thái đã mô hình hoá | **21** | Hai dòng trên | 17 + 4; cả hai đều có state machine riêng là STATE-01 và STATE-02 |
| Kiểu ENUM | **9** | `sql/schema.sql` | `grep -c "^CREATE TYPE" sql/schema.sql` |
| Bảng dữ liệu | **18** | `sql/schema.sql` | `grep -c "^CREATE TABLE" sql/schema.sql` |
| Index tường minh | **32** | `sql/schema.sql` | `grep -c "^CREATE INDEX" sql/schema.sql` |
| Chỉ mục vật lý tổng cộng | **61** | `sql/schema.sql` | 32 index tường minh + 18 chỉ mục sinh bởi `PRIMARY KEY` + 11 chỉ mục sinh bởi ràng buộc `UNIQUE` |
| Ràng buộc UNIQUE ngoài khoá chính | **11** | `sql/schema.sql` | `grep -c "CONSTRAINT uq_" sql/schema.sql` |
| Ràng buộc CHECK | **14** | `sql/schema.sql` | `grep -c "CHECK (" sql/schema.sql`. **Lệch với con số 15 ghi ở `report/chapter_4_data.md` Bảng 4.2** — xem mục 7f |
| Index D đề xuất bổ sung | **6** *(đề xuất)* | `docs/design_decisions_D.md` Bảng 5.53 | Chưa có trong `sql/schema.sql`, không tính vào con số 32 |
| Component | **24** | `diagrams/D_comp_architecture_v1.md` Bảng 5.2 | Đếm dòng C01…C24 |
| Interface và port | **19** = 15 interface nội bộ + 4 port ra ngoài | `diagrams/D_comp_architecture_v1.md` Bảng 5.22 | Đếm dòng bảng; bốn port cuối là `EmailPort`, `CalendarPort`, `IdentityPort`, `StoragePort` |
| Node triển khai | **14** | `diagrams/D_deploy_topology_v1.md` Bảng 5.13 | Đếm dòng N01…N14; trong đó 3 node là hệ thống ngoài (N11, N12, N13) |
| Kênh kết nối giữa node | **22** = 21 vẽ trên hình + 1 kênh vận hành | `diagrams/D_deploy_topology_v1.md` Bảng 5.14 | Đếm dòng ma trận kết nối |
| Màn hình | **11** | `wireframes/D_wireframes_v1.md` Bảng 5.61 | Đếm dòng SCR-01…SCR-11; đối chiếu với `id="scr-xx"` trong `prototype/index.html` — khớp 11/11 |
| Trạng thái màn hình phải vẽ | **25** | `wireframes/D_wireframes_v1.md` Bảng 5.61 | Cộng cột "Số trạng thái vẽ": 2+2+2+2+3+2+3+2+3+2+2 |
| NFR | **14** = 12 của A + 2 do D bổ sung | `docs/nfr_detail_D.md` Bảng 5.30 | Đếm dòng NFR-01…NFR-14; NFR-13 và NFR-14 **chờ A xác nhận** |
| Quyết định kiến trúc ADR | **12** | `docs/design_decisions_D.md` Bảng 5.50 | Đếm dòng ADR-01…ADR-12 |
| Mâu thuẫn trong sổ | **7** | `docs/design_decisions_D.md` Bảng 5.51 | Đếm dòng X-01…X-07; phân bố mức khẩn: 2 P0, 2 P1, 3 P2 |
| Đề xuất schema gửi C | **9** | `docs/design_decisions_D.md` Bảng 5.52 | Đếm dòng; 2 mức P0, 4 mức P1, 3 mức P2 |
| Diagram hành vi của B | **7** | `diagrams/B_*.md` | 2 activity *(ACT-01, ACT-02)*, 2 state *(STATE-01, STATE-02)*, 3 sequence *(SEQ-01, SEQ-02, SEQ-03)*; mỗi tệp chứa đúng một khối `mermaid` |
| Diagram cấu trúc của C | **3** | `diagrams/C_*.md` | Domain model, class diagram, ERD; mỗi tệp một khối `mermaid` |
| Diagram của D | **2 chính + 7 phụ trợ = 9** | `diagrams/D_*.md`, `docs/*_D.md`, `wireframes/README.md` | COMP-01 và DEP-01 là hai diagram chính; 7 sơ đồ phụ trợ đếm bằng số khối ```` ```mermaid ````: 1 trong tệp component *(phóng to cụm Offer)*, 1 trong `nfr_detail_D.md`, 1 trong `design_decisions_D.md`, 4 trong `wireframes/README.md` |
| Tổng số diagram Mermaid toàn báo cáo | **19** | Ba dòng trên | 7 của B + 3 của C + 9 của D |
| Tệp deliverable của D | **10** | Hợp đồng thiết kế mục 11 | D1…D10; tệp đang đọc là phụ lục tích hợp bổ sung, không nằm trong danh sách mười tệp gốc |

**Ghi chú về cách dùng các con số này.** Ba con số dễ bị hỏi ngược nhất là *(a)* "17 hay 18 trạng
thái" — trả lời: **17** trong schema hiện tại, 18 nếu Sync S4 chấp thuận bổ sung `SHORTLISTED` theo
X-02; *(b)* "13 hay 25 business rule" — trả lời: hai hệ đánh số song song, 13 mã trong đặc tả gốc và
16 mã trong dải BR-03…BR-25 của A, hợp lại là 23 mã với một điểm va chạm ở BR-13 theo X-04; *(c)*
"5 hay 6 use case" — trả lời: **5 use case có kịch bản đầy đủ cộng UC-06 rút gọn**, theo X-07 đã
chốt theo A.

---

## 9. Việc cần chốt ở Sync S4 phát sinh từ tài liệu này

Bảng 5.119 chỉ liệt kê những mục **mới phát hiện khi lập ma trận**; các mục đã có trong Bảng 5.57 của
`docs/design_decisions_D.md` không lặp lại ở đây.

**Bảng 5.119 — Việc phát sinh từ ma trận truy vết**

| # | Người xác nhận | Nội dung | Nguồn | Nếu chưa chốt |
|---|---|---|---|---|
| 1 | A | Bổ sung alt flow cho UC-01 mô tả việc huỷ buổi phỏng vấn, làm cơ sở cho `interview_status = CANCELLED` | Mục 7d; ghi chú của B tại `diagrams/B_state_interview_v1.md` | Một giá trị enum tồn tại trong schema mà không có luồng nghiệp vụ và không có giao diện |
| 2 | A + D | Cơ chế chuyển `interview_status` sang `COMPLETED`: job tự động của C17 hay thao tác trên `SCR-04` | Mục 7d | Precondition của UC-03 không có nguồn gốc rõ ràng |
| 3 | D | Bổ sung tab "Nhật ký hoạt động" và tab quản trị template vào `SCR-11` để `audit_logs`, `email_templates`, `scorecard_templates` có giao diện | Mục 7c | Ba bảng không có màn hình nào; một dòng quyền trong ma trận RBAC không có giao diện tương ứng |
| 4 | A + D | Phạm vi giao diện cho F01 quản lý JD: giữ ngoài 11 màn hay bổ sung | Mục 7c | Câu hỏi "Recruiter tạo JD ở đâu" không có câu trả lời bằng wireframe |
| 5 | C | Rà lại con số "15 ràng buộc CHECK" ở `report/chapter_4_data.md` Bảng 4.2 so với 14 đếm được trong `sql/schema.sql` | Mục 7f | Số liệu trong báo cáo không khớp mã nguồn kèm theo |
| 6 | B | Cập nhật câu kết luận mục 3.9 của `report/chapter_3_behavior.md` từ "6 diagram" thành 7 sau khi thêm STATE-02 | Mục 7f | Chương 3 tự mâu thuẫn giữa phần kết luận và phần addendum |
| 7 | D | Rà lại toàn bộ dải số hình và bảng của sáu tệp thuộc D khi ghép bản nộp, đối chiếu với bản kê ở mục 0.2 của `wireframes/D_wireframes_v1.md` | Mục 7f | Các dải đã được tách lần lượt, nhưng chỉ một lượt rà tập trung mới bảo đảm không còn số nào mang hai nội dung khác nhau |

---

## 10. Tệp nguồn đã dùng để lập ma trận

Mọi khẳng định trong tài liệu này truy được về một trong các tệp dưới đây. Khi một tệp trong danh
sách thay đổi, tài liệu này phải được rà lại.

| Tệp | Dùng cho mục nào |
|---|---|
| `spec_ats (1).md` v1.1 | Mục 1.4, 2, 3.1 — actor, use case, BR-01…BR-13, state machine gốc |
| `docs/chapter-A.docx` v1.0 | Mục 1.4, 2, 3.2 — Bảng 2.1 actor, Bảng 2.3 danh mục UC, Bảng 2.15a/2.15b business rule |
| `report/chapter_3_behavior.md` | Mục 2, 7a, 7f — Bảng 3.1 mapping UC/BR sang diagram, Bảng 3.1b ánh xạ hai enum |
| `diagrams/B_state_application_v1.md` | Mục 4.1 — transition của 17 trạng thái |
| `diagrams/B_state_interview_v1.md` | Mục 4.2, 7d — transition và khoảng trống của 4 trạng thái |
| `diagrams/B_seq_schedule_interview_v1.md`, `B_seq_offer_approval_v1.md`, `B_seq_sla_feedback_v1.md` | Mục 2, 3 — SEQ-01, SEQ-02, SEQ-03 |
| `report/chapter_4_data.md` | Mục 3, 7f — Bảng 4.1 ánh xạ BR sang ràng buộc dữ liệu, Bảng 4.2 số liệu tổng quan |
| `sql/schema.sql` v1.2 | Mục 3, 4, 5, 8 — nguồn đếm bảng, index, enum, ràng buộc |
| `docs/data_dictionary_C.md` | Đối chiếu tên cột khi lập mục 5 |
| `diagrams/D_comp_architecture_v1.md` | Mục 2, 5, 6 — Bảng 5.2 component, Bảng 5.22 interface, Bảng 5.4 quyền ghi |
| `diagrams/D_deploy_topology_v1.md` | Mục 6, 8 — Bảng 5.13 node, Bảng 5.14 kênh kết nối |
| `docs/nfr_detail_D.md` | Mục 6, 8 — Bảng 5.30 tổng hợp NFR, Bảng 5.45 ma trận NFR × component |
| `docs/design_decisions_D.md` | Mục 1.4, 3, 7 — ADR-01…ADR-12, sổ mâu thuẫn X-01…X-07, đề xuất gửi C, ma trận RBAC |
| `wireframes/D_wireframes_v1.md` | Mục 2, 5, 8 — Bảng 5.61 danh mục màn hình, Bảng 5.62 kịch bản dữ liệu mẫu |
| `wireframes/README.md` | Mục 2, 4, 5, 7 — Bảng 5.91 và 5.92 đối chiếu hai chiều UC ↔ màn hình, Bảng 5.98 và 5.99 nhãn hiển thị |
| `prototype/index.html` | Mục 7g — kiểm tra độ phủ 11 màn |
| `docs/handoff_A_D_after_BC_v12.md` | Ràng buộc phạm vi cho D |

*Hết ma trận truy vết. Tài liệu này không sửa bất kỳ tệp nào của A, B hoặc C; toàn bộ điểm chưa khép
kín ở mục 7 và mục 9 là đầu vào cho Sync S4.*
