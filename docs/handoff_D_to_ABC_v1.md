# Handoff ngược từ D cho A, B, C — sau khi Chương 5–6 xong

Bản đối ứng của `docs/handoff_A_D_after_BC_v12.md` (B/C bàn giao cho A và D). File này không thay
`04_person_D_design.md`; nó chỉ liệt kê những điểm A, B, C cần chỉnh để bốn chương khớp nhau khi ghép
thành bản nộp.

Nguồn: sổ mâu thuẫn X-01…X-07 và mục 4 của `docs/design_decisions_D.md`, cộng với phần đối chiếu trực
tiếp `docs/chapter-A.docx` v1.0 ↔ `report/chapter_3_behavior.md` ↔ `sql/schema.sql` v1.2 mà D thực hiện
khi dựng Chương 5.

**D không sửa bất kỳ tệp nào của A, B hoặc C.** Toàn bộ nội dung dưới đây là đề nghị chờ Sync S4.

---

## 1. Tóm tắt

1. D đã xong: COMP-01 (`diagrams/D_comp_architecture_v1.md`), DEP-01 (`diagrams/D_deploy_topology_v1.md`), 11 wireframe `SCR-01`…`SCR-11`, NFR-01…NFR-14 (`docs/nfr_detail_D.md`), 12 ADR + sổ mâu thuẫn (`docs/design_decisions_D.md`), prototype một tệp (`prototype/index.html`); Chương 5–6 ở `report/chapter_5_design.md` và `report/chapter_6_conclusion.md`.
2. Hai việc chặn (P0): mốc SLA xác nhận lịch là 24 giờ hay hai mốc 24/48 giờ (X-01), và có bổ sung trạng thái `SHORTLISTED` hay không (X-02) — cả hai đều quyết định nội dung hiển thị trên `SCR-03`, `SCR-05`, `SCR-09`.
3. Việc nặng nhất về công là của C: 9 đề xuất schema + 6 index; nếu duyệt hết P0 và P1 thì số bảng đi từ 18 lên 20, duyệt cả P2 thì lên 21.
4. Có một việc mang tính biên tập cần cả nhóm quyết: phần phác Chương 5–6 trong `docs/chapter-A.docx` giữ lại ở dạng nào sau khi Chương 5–6 chính thức của D được phát hành.
5. Có một danh mục **không** cần ai đụng tới (mục 6) — liệt kê để B và C không mất thời gian rà lại những chỗ D đã cân nhắc và cố ý giữ nguyên.

---

## 2. Quyết định cần chốt ở Sync S4

Sắp theo mức khẩn. Ba dòng đầu chặn trực tiếp việc hoàn thiện Chương 5.

| # | Vấn đề | Hai phương án | Đề xuất của D | Ai quyết | Hệ quả nếu không chốt |
|---|---|---|---|---|---|
| 1 | SLA xác nhận lịch phỏng vấn (X-01) | **PA1** — một mốc 24 giờ, quá hạn chuyển `NEED_RESCHEDULE` (theo `spec_ats (1).md` BR-05, STATE-01, STATE-02, SEQ-01). **PA2** — hai mốc: nhắc ở 24 giờ, chuyển `NEED_RESCHEDULE` ở 48 giờ (theo `chapter-A.docx`, BR-05 và UC-01 A18.1) | **PA2** — hợp lý hơn về vận hành và đồng dạng với mô hình 24/48/72 giờ mà B đã dùng cho SLA feedback ở SEQ-03 | A chủ trì, B thực hiện | `SCR-05` và `SCR-09` hiển thị đồng hồ đếm ngược lệch với thời điểm hệ thống thật sự đổi trạng thái; `SLAService` (C14) không có con số để cấu hình |
| 2 | Thiếu trạng thái `SHORTLISTED` (X-02) | **PA1** — giữ 17 giá trị enum, kanban gộp "đã shortlist" vào cột `SCREENING`. **PA2** — thêm giá trị, enum lên 18 | **PA2** — postcondition UC-02 của A đã dùng tên này ở hơn mười chỗ; sửa ngược lại đắt hơn nhiều so với thêm một giá trị enum | A chủ trì, C và B thực hiện | `SCR-03` mất cột "Đã shortlist — chờ xếp lịch", tức mất đúng hàng đợi việc phải làm của Recruiter; postcondition UC-02 không có chỗ lưu trong DB |
| 3 | Cột `version` cho `applications`, `feedbacks`, `offers` (ADR-08) | **PA1** — C bổ sung ba cột. **PA2** — không bổ sung, D hạ ADR-08 xuống mức giả định hoặc chuyển sang khoá bi quan | **PA1** — chính `chapter-A.docx` đã dùng cụm "optimistic version" trong UC-02, ở bước kiểm tra cuối trước khi chuyển Application sang `SHORTLISTED` hoặc `REJECTED`, và dùng `offerVersion` làm điều kiện chống ghi đè trong UC-04 (pre-condition, bước kiểm tra trước khi ghi, nhánh E9.1); phần phác Chương 5 của A cũng ghi "Optimistic locking bằng version cho Application, Feedback và Offer" | C | ADR-08 và câu chữ trong UC của A không có cơ sở lưu trữ; rủi ro ghi đè im lặng phá NFR-06 |
| 4 | Trùng mã BR-13 (X-04) | **PA1** — A đổi mã quy tắc override lịch trùng thành **BR-26**. **PA2** — spec, B và C đổi mã quy tắc hold timeout | **PA1** — BR-26 là số trống đầu tiên sau dải BR-03…BR-25 của A; B (STATE-01) và C (Bảng 4.1) đã tham chiếu BR-13 theo nghĩa hold timeout | A | Một mã trỏ tới hai quy tắc khác nhau; lộ ngay khi hội đồng tra ngược mã BR |
| 5 | Số phận phần phác Chương 5–6 trong `docs/chapter-A.docx` | **PA1** — bỏ hẳn, thay bằng con trỏ tới `report/chapter_5_design.md` và `report/chapter_6_conclusion.md`. **PA2** — giữ một phần dạng tóm tắt kèm bảng ánh xạ sang deliverable của D | **PA2** có chọn lọc — chi tiết ở mục 3, việc A-05 | A và D | Bản nộp có hai phiên bản Chương 5 khác nhau về danh mục component, bảng NFR và danh mục màn hình |
| 6 | Phạm vi use case (X-07) | **PA1** — 5 UC đặc tả đầy đủ + UC-06 rút gọn. **PA2** — mở rộng lên 10–12 UC theo tài liệu hướng dẫn | **PA1** — đúng `spec_ats (1).md` mục 5 và `chapter-A.docx`; `SCR-11` phục vụ F09 được ghi rõ là ngoài năm UC trọng tâm | A | Tiêu chí "mỗi UC có ít nhất một wireframe" (`06_conventions_shared.md` mục 5) không kiểm được |
| 7 | Tên vai trò duyệt tài chính trên diagram (X-06) | **PA1** — `FinanceApprover` (theo A). **PA2** — `Finance` (theo SEQ-02 của B và Class Diagram của C) | **PA2** — khớp giá trị enum `FINANCE` trong `user_role` và tên class `Finance` ở Chương 4; A chỉ phải sửa nhãn trong docx, B và C không phải sửa gì | A | COMP-01 của D và SEQ-02 của B dùng hai chuỗi khác nhau cho cùng một vai trò |
| 8 | Tên trạng thái offer (X-03) | **PA1** — giữ hai enum `application_status` và `offer_status` tách rời, ánh xạ ở tầng nhãn hiển thị. **PA2** — gộp, dùng `OFFER_APPROVED` thay `SIGNED_BY_COMPANY` | **PA1** — xem lập luận ở việc A-04 | A rút lại đề nghị gộp | Chương 2 đề nghị gộp trong khi Chương 3 và Chương 4 giữ tách; mâu thuẫn hiện ra trong bản nộp |
| 9 | `System / Scheduler` là actor hay component (X-05) | **PA1** — component nội bộ `SchedulerWorker` (C17). **PA2** — actor ngoài đường bao hệ thống | **PA1** kèm chú thích rằng cách vẽ của B ở SEQ-03 vẫn đúng | A xác nhận, D chú thích | Bốn người trả lời khác nhau nếu hội đồng hỏi worker nằm trong hay ngoài hệ thống |
| 10 | NFR-13, NFR-14 và cách hiểu số học của NFR-03 | **PA1** — A duyệt hai mã mới do D phát hành và chốt cách hiểu NFR-03. **PA2** — D hạ hai yêu cầu xuống ghi chú không mã | **PA1** | A | Hai yêu cầu vận hành và khả năng tiếp cận không có mã chính thức để tham chiếu trong Chương 5, Chương 6 và slide |

---

## 3. Gửi A

| # | Sửa gì | Ở đâu trong `docs/chapter-A.docx` | Sửa thành | Vì sao | Công |
|---|---|---|---|---|---|
| A-01 | Mã quy tắc override lịch trùng | Bảng 2.15a, dòng `BR-13`; và hai chỗ liệt kê "BR-03, BR-05, BR-13, BR-19, BR-21, BR-22" ở bảng tóm tắt UC-01 và mục "Business Rule ref" của UC-01 | `BR-26` — nội dung giữ nguyên: "Override lịch trùng chỉ dành cho người có quyền; bắt buộc lý do và AuditLog" | `spec_ats (1).md` v1.1 mục 6 đã dùng BR-13 cho quy tắc hold timeout, và `diagrams/B_state_application_v1.md` (dòng 14, 59) cùng `report/chapter_4_data.md` Bảng 4.1 (dòng 339) đã tham chiếu theo nghĩa đó. Đổi phía A rẻ hơn đổi phía B và C | 3 dòng |
| A-02 | Mốc SLA xác nhận lịch | Bảng 2.15a dòng `BR-05`; UC-01 luồng A18.1; mục "Thay đổi so với bản trước" | Giữ nguyên câu chữ của A ("24 giờ gửi reminder; quá 48 giờ chuyển `NEED_RESCHEDULE`") nhưng **ghi rõ đây là hai mốc khác nhau**: mốc nhắc và mốc đổi trạng thái | Hiện `spec_ats (1).md` BR-05 và bốn nhãn guard của B đều dùng 24 giờ cho việc **đổi trạng thái**. A cần "ký" phương án hai mốc để B có căn cứ sửa 19 dòng ở 5 tệp (xem mục 4) | 1 dòng, chủ yếu là xác nhận |
| A-03 | Trạng thái `SHORTLISTED` | Không sửa gì trong docx | Giữ nguyên; A chủ trì để C thêm giá trị enum | `chapter-A.docx` dùng `SHORTLISTED` ở hơn mười chỗ (precondition UC-01, postcondition và các bước 4–7 của UC-02, bảng state). Nếu C từ chối, chính A là người phải sửa toàn bộ những chỗ đó về `SCREENING` — khoảng 12 dòng, đắt hơn nhiều so với C thêm một giá trị enum | 0 nếu duyệt; ~12 dòng nếu bác |
| A-04 | Đề nghị chuẩn hoá tên trạng thái offer | Mục "Thay đổi / chuẩn hoá", câu "Dùng OFFER_APPROVED nhất quán thay cho SIGNED_BY_COMPANY" | Rút lại câu này; thay bằng một câu ghi rõ `application_status.OFFER_APPROVED` và `offer_status.SIGNED_BY_COMPANY` thuộc hai enum của hai thực thể khác nhau, ánh xạ theo Bảng 3.1b của B | `sql/schema.sql` khai `offer_status` có **cả** `APPROVED` lẫn `SIGNED_BY_COMPANY`; gộp về một tên sẽ mất phân biệt giữa "đã duyệt đủ cấp" và "đã ký, đã gửi ứng viên". Chính UC-04 của A đang trộn hai enum trong một dòng ("Offer status: PENDING_APPROVAL…, OFFER_APPROVED hoặc OFFER_REJECTED_INTERNALLY/DRAFT"), nên câu chuẩn hoá này đang tạo lỗi chứ không sửa lỗi. D đã ánh xạ xong 9 trạng thái sang nhãn tiếng Việt ở Bảng 5.99 (`wireframes/README.md`) và Bảng 5.56 (`docs/design_decisions_D.md`) | 2 dòng |
| A-05 | Phần phác Chương 5–6 | Toàn bộ khối từ "CHƯƠNG 5 — THIẾT KẾ KIẾN TRÚC VÀ GIAO DIỆN" đến hết Bảng 6.2 | Thay bằng `report/chapter_5_design.md` và `report/chapter_6_conclusion.md` của D. Xử lý từng bảng: **Bảng 5.1 — giữ dạng tóm tắt**, đổi tiêu đề thành "nhóm chức năng" và thêm một cột ánh xạ sang COMP-01 (bảng ánh xạ ở ngay dưới). **Bảng 5.2 — giữ dạng tóm tắt**, A là chủ sở hữu dải mã NFR-01…NFR-12, phần khai triển 5 mục nằm ở `docs/nfr_detail_D.md`. **Bảng 5.3 — bỏ hẳn**, thay bằng con trỏ tới Bảng 5.91 của `wireframes/README.md`. **Bảng 6.1 và Bảng 6.2 — giữ**, phần khai triển nằm ở `docs/demo_runbook_D.md` và Chương 6 của D | Bảng 5.1 của A gọi tên 8 component ở mức gộp (`WebUI / BFF`, `RecruitmentCore`, `Scheduler/Worker`…), trong khi COMP-01 tách 24 component để khớp đủ 13 lifeline của B; giữ song song hai danh mục mà không có ánh xạ sẽ tạo hai "sự thật" về tên component. Bảng 5.3 liệt kê 6 màn không mã, đã được Bảng 5.91 (11 màn `SCR-01`…`SCR-11`, có cả cột UC và cột bước UC) phủ hoàn toàn | Bỏ 1 bảng, thêm 1 cột và 1 đoạn dẫn ~6 dòng |
| A-06 | Glossary thiếu vai trò | Bảng A.1 — Thuật ngữ sử dụng trong báo cáo và diagram | Dán Bảng 5.55 (ánh xạ ba tầng: báo cáo tiếng Việt — tên trên diagram — giá trị enum, 7 dòng) từ `docs/design_decisions_D.md` mục 6 | Bảng A.1 hiện chỉ có 5 vai trò, thiếu `HeadOfHR` và vai trò duyệt tài chính, dù chính docx của A ở mục "Thay đổi so với bản trước" đã bổ sung hai actor này và `sql/schema.sql` v1.2 đã có `HEAD_OF_HR`, `FINANCE` trong `user_role` | 3 dòng |
| A-07 | Phiên bản spec trong danh mục tham chiếu | Mục "Tài liệu tham chiếu nội bộ", dòng 1 | "spec_ats.md — …, phiên bản **1.1**" | Spec đã bump lên v1.1 sau đợt audit của B, ghi ở `docs/change_log.md` | 1 dòng |
| A-08 | Xác nhận BR-14 và BR-15 là mã chính thức | Bảng 2.15a / 2.15b | Không sửa, chỉ xác nhận | Hai mã này không có trong `spec_ats (1).md` (dải BR-01…BR-13). D cần trích BR-14 cho quy tắc khoá feedback sau 24 giờ ở `SCR-06` và `FeedbackService` (C09); hiện D đang phải trích BR-06/BR-07 vì chưa có mã chính thức | 0 |
| A-09 | Con số của NFR-03 | Bảng 5.2, dòng NFR-03 | Ghi rõ hai mức: sàn cam kết ≥ 99 % và ngưỡng vận hành nội bộ ≤ 13 phút/tháng (tương đương 99,9 %) | Bảng 5.2 của A và `spec_ats (1).md` mục 11 chỉ ghi "≥ 99 % giờ hành chính". Con số "≤ 13 phút/tháng" do D bổ sung khi định lượng; 99 % của khoảng 220 giờ hành chính mỗi tháng là 132 phút, không phải 13 phút. Nếu để cả hai con số cùng một dòng mà không phân tầng thì bảng NFR tự mâu thuẫn về số học | 1 dòng |
| A-10 | Hai mã NFR mới | Bảng 5.2, thêm hai dòng | `NFR-13` khả năng vận hành / observability và `NFR-14` khả năng tiếp cận, ghi chú "do D phát hành" | Cần có mã chính thức để Chương 5, Chương 6 và slide tham chiếu; chi tiết 5 mục đã có sẵn ở `docs/nfr_detail_D.md` | 2 dòng |
| A-11 | Actor khái quát `OfferApprover` | Use Case Diagram và bảng actor của UC-04 | Giữ `OfferApprover` như một generalization, nhưng ghi rõ ba vai trò con `HiringManager`, `HeadOfHR`, `Finance` ứng với cấp duyệt 1, 2, 3 | Ma trận RBAC của D (Bảng 5.54) và `SCR-08` phân quyền theo **cấp duyệt**, không theo actor khái quát; nếu docx chỉ ghi `OfferApprover` thì không suy ra được ai duyệt cấp nào | 1 dòng |

**Bảng ánh xạ D gửi kèm cho việc A-05** — 8 nhóm chức năng ở Bảng 5.1 của A ↔ 24 component của COMP-01:

| Bảng 5.1 của A | Component tương ứng trên COMP-01 |
|---|---|
| `WebUI / BFF` | `InternalWebApp` (C01), `CandidatePortalApp` (C02), `ApiGateway` (C03) |
| `AuthService` | `AuthService` (C04) |
| `RecruitmentCore` | `JdService` (C05), `CandidateService` (C06), `ApplicationService` (C07), `FeedbackService` (C09), `OfferService` (C10), `ApprovalWorkflow` (C11) |
| `SchedulingService` | `SchedulingService` (C08), `LockManager` (C24), `CalendarAdapter` (C21) |
| `NotificationService` | `NotificationService` (C12), `EscalationService` (C13), `EmailAdapter` (C20) |
| `ReportingService` | `ReportingService` (C18) |
| `FileService` | `FileService` (C15), `ObjectStorageAdapter` (C23) |
| `Scheduler/Worker` | `SchedulerWorker` (C17) |
| *(không có trong Bảng 5.1)* | `SLAService` (C14), `AuditService` (C16), `PersistenceLayer` (C19), `IdentityAdapter` (C22) — bốn component tách ra vì SEQ-03 của B có lifeline `SLAService` riêng, NFR-06 cần một nơi ghi audit duy nhất, ghi chú 3.5.4 của B nói repo không map 1-1 với bảng, và ADR-05 buộc mọi hệ thống ngoài đi qua adapter |

---

## 4. Gửi B

Số dòng là ước tính dựa trên việc tra trực tiếp các tệp trong repo; số hiệu dòng ghi kèm để B đối chiếu nhanh.

| # | Việc | Tệp và vị trí | Ước tính | Điều kiện |
|---|---|---|---|---|
| B-01 | Đổi nhãn guard `[after24h]` thành `[after48h]` ở STATE-01 | `diagrams/B_state_application_v1.md` — dòng 30 (trong khối Mermaid) và dòng 79 (bảng transition) | **2 dòng** | Chỉ khi Sync S4 chọn phương án 48 giờ (X-01) |
| B-02 | Đổi nhãn guard `[after24h]` thành `[after48h]` ở STATE-02 | `diagrams/B_state_interview_v1.md` — dòng 25 (khối Mermaid) và dòng 46 (bảng transition) | **2 dòng** | Như trên |
| B-03 | Thêm bước nhắc ở mốc 24 giờ vào SEQ-01 | `diagrams/B_seq_schedule_interview_v1.md` — dòng 66 đổi `setConfirmSLA(deadline=now+24h)` thành dạng có hai mốc (`remindAt=+24h`, `expireAt=+48h`); viết lại `Note` ở dòng 71; thêm một cặp message hoặc một `Note` mô tả lần nhắc thứ nhất | **≈5 dòng** | Như trên |
| B-04 | Đồng bộ con số 24 giờ trong chính văn Chương 3 | `report/chapter_3_behavior.md` — dòng 50, 57, 144, 178, 229, 368 | **6 dòng** | Như trên |
| B-05 | *(D tự đối chiếu, không có trong sổ mâu thuẫn)* Con số 24 giờ còn nằm trong ACT-01 | `diagrams/B_act_recruitment_flow_v1.md` — dòng 24 (`CandConfirm`), dòng 64 (`SysSetSLA`), dòng 108 (nhãn cạnh), dòng 163 (bảng giải thích) | **4 dòng** | Như trên. Nếu bỏ sót thì Chương 3 tự mâu thuẫn giữa activity và state |
| | **Tổng cho X-01** | 5 tệp | **≈19 dòng** | |
| B-06 | Thêm state `SHORTLISTED` vào STATE-01 | `diagrams/B_state_application_v1.md` — dòng 27 đổi `SCREENING --> INTERVIEWING : shortlist()` thành `SCREENING --> SHORTLISTED : shortlist()`, thêm `SHORTLISTED --> INTERVIEWING : interviewScheduled()`; dòng 11 sửa "17 giá trị enum" thành 18; bảng transition dòng 77 sửa và thêm một dòng mới. Tuỳ chọn: thêm `SHORTLISTED --> ON_HOLD` và `SHORTLISTED --> REJECTED` để phủ BR-10 | **5–7 dòng** | Chỉ khi X-02 được duyệt |
| B-07 | Đồng bộ STATE-01 trong chính văn | `report/chapter_3_behavior.md` — dòng 142 (bản sao khối Mermaid) và một dòng transition mới; dòng 178 (bảng state đặc biệt); dòng 184 "Tất cả 17 giá trị" → 18; dòng 379 "(17 giá trị)" → 18 | **≈5 dòng** | Như trên |
| | **Tổng cho X-02** | 2 tệp | **≈10–12 dòng** | |
| B-08 | Xác nhận bảng ánh xạ lifeline → component của D là đúng | Bảng ánh xạ nằm ở `diagrams/D_comp_architecture_v1.md`. D đã đối chiếu đủ 13 lifeline: SEQ-01 (`UI`, `SchedulingService`, `CalendarRepo`, `NotificationService`, `EmailGateway`), SEQ-02 (`OfferService`, `ApprovalWorkflow`, `HiringManager`, `HeadOfHR`, `Finance`, `CandidatePortal`), SEQ-03 (`CronScheduler`, `SLAService`, `FeedbackRepo`, `EscalationService`) | **0 dòng sửa**, chỉ xác nhận | Không điều kiện |
| B-09 | Xác nhận hai chỗ ánh xạ **không** phải một-một, để B không hiểu nhầm là D vẽ sai | `UI` (SEQ-01) tương ứng `InternalWebApp` (C01) **và** `ApiGateway` (C03); `CalendarRepo` (SEQ-01) tương ứng `PersistenceLayer.CalendarRepo` (C19) **và** `CalendarAdapter` (C21) — đúng ghi chú 3.5.4 của B rằng repository không map 1-1 với bảng, và đúng ADR-05 buộc lịch bên ngoài đi qua adapter | **0 dòng** | Không điều kiện |
| B-10 | Xác nhận `CronScheduler` là actor trên sequence nhưng là component nội bộ trên component diagram — **hai cách nhìn không mâu thuẫn** | Trên SEQ-03, `CronScheduler` được vẽ ở vị trí actor vì luồng không do người dùng nào khởi tạo; đây là quy ước hợp lệ của sequence diagram và B giữ nguyên. Trên COMP-01 và DEP-01, cùng thực thể đó là `SchedulerWorker` (C17) chạy trên `WorkerNode` (N05), nằm **bên trong** đường bao hệ thống. D đã ghi chú giải thích ngay trên COMP-01 | **0 dòng** | Cần A xác nhận cách hiểu (X-05) |
| B-11 | Không phải sửa gì nếu A đổi mã override thành BR-26 | D đã tra: hai chỗ B ghi BR-13 (`diagrams/B_state_application_v1.md` dòng 14 và dòng 59) đều dùng đúng nghĩa hold timeout của `spec_ats (1).md`, không phải quy tắc override | **0 dòng** | Ghi ở đây để B khỏi phải rà lại |
| B-12 | **Sửa lỗi làm SEQ-02 không render được** | `diagrams/B_seq_offer_approval_v1.md` dòng 78: thay dấu `;` trong `25a. Application=ACCEPTED; other apps=ON_HOLD (BR-10)` bằng dấu phẩy hoặc `<br/>`. Mermaid coi `;` là dấu kết thúc câu lệnh nên phần sau dấu chấm phẩy trở thành câu lệnh rác và cả sơ đồ parse lỗi | **1 dòng** | **Không điều kiện — đây là lỗi chặn.** `diagrams/rendered/` hiện thiếu hẳn ảnh của SEQ-02 (22/23 sơ đồ render thành công), trong khi bản nộp Word và slide đều cần ảnh PNG của sơ đồ này |

---

## 5. Gửi C

**D không sửa `sql/schema.sql`, `docs/data_dictionary_C.md` hay `report/chapter_4_data.md`.** Toàn bộ mục
này là đề xuất chờ C duyệt, đúng nguyên tắc "không mở rộng schema thêm trừ khi cả nhóm đồng ý" ở
`docs/handoff_A_D_after_BC_v12.md`. Nếu C từ chối mục nào, D điều chỉnh Chương 5 theo, chứ không tự thêm
bảng hay cột.

### 5.1. Đề xuất bổ sung schema

| Ưu tiên | Đề xuất | Màn hình / cơ chế của D cần nó | Công sửa ước tính |
|---|---|---|---|
| P0 | Thêm giá trị `SHORTLISTED` vào `application_status` | `SCR-03` cần cột kanban "Đã shortlist — chờ xếp lịch"; `SCR-02` đếm thẻ việc cần làm theo cột đó; `SCR-04` hiển thị đúng mốc trên timeline | `sql/schema.sql` dòng 34–39 thêm một giá trị (1 dòng); `docs/data_dictionary_C.md` dòng 134 sửa "(17 giá trị)" thành 18 (1 dòng); `report/chapter_4_data.md` Bảng 4.2 (1 dòng). **≈3 dòng** |
| P0 | Cột `version INT NOT NULL DEFAULT 1` cho `applications`, `feedbacks`, `offers` | `SCR-04` (hai Recruiter cùng chuyển trạng thái), `SCR-06` (Interviewer sửa feedback sát mốc khoá 24 giờ), `SCR-07` và `SCR-08` (hai cấp duyệt thao tác sau `REQUEST_CHANGE`); nền của ADR-08 | 3 dòng schema + 3 dòng dictionary + 1 dòng Bảng 4.2. **≈7 dòng** |
| P1 | `offers.band_snapshot_min` và `offers.band_snapshot_max` kiểu `DECIMAL(12,2)` | `SCR-07` bước 2 hiển thị "vượt band 8 %" tại thời điểm tạo offer; `SCR-08` để người duyệt thấy lại đúng tỷ lệ đó về sau. Khái niệm "band snapshot" đã có sẵn trong UC-04 của A nên đây không phải yêu cầu nghiệp vụ mới | 2 dòng schema + 2 dòng dictionary. **≈4 dòng** |
| P1 | Bảng `outbox_events(id, aggregate_type, aggregate_id, event_type, payload JSONB, idempotency_key UNIQUE, status, attempt_count, next_retry_at, created_at)` | Không có màn hình trực tiếp, nhưng đứng sau mọi email của `SCR-05`, `SCR-07`, `SCR-09` và là nguồn số liệu cho cảnh báo tồn đọng của NFR-13; nền của ADR-06 | ~12 dòng `CREATE TABLE` + 2 index + 1 mục dictionary. **Số bảng 18 → 19** |
| P1 | Bảng `candidate_portal_tokens(id, candidate_id, application_id, token_hash, expires_at, used_at, revoked_at)` | Toàn bộ nhánh ứng viên `SCR-09`: xác nhận lịch, xem offer, counter-offer; nền của ADR-09 | ~10 dòng + 1 mục dictionary. **19 → 20** |
| P1 | `email_templates`: thêm `locale`, `version`, `is_active`; đổi UNIQUE `(template_key)` thành `(template_key, locale, version)` | `SCR-11` (HR Admin quản lý template) và mọi email của `SCR-05`, `SCR-07`, `SCR-09`; BR-12 đòi template active đã duyệt, NFR-09 đòi đủ bản VI và EN | 3 cột + 1 ràng buộc UNIQUE + 1 mục dictionary. **≈5 dòng** |
| P2 | `notifications.delivery_status` + bảng `notification_deliveries` cho kênh email ra ngoài | `SCR-10` biểu đồ SLA compliance — chỉ số của BR-25 chỉ đúng khi thông báo **gửi thành công** trước hạn | 1 cột + ~10 dòng bảng mới. **20 → 21** |
| P2 | `interview_processes.scorecard_template_version` | `SCR-06` phải mở đúng bộ tiêu chí của phiên bản template tại thời điểm phỏng vấn; đúng rủi ro "template đổi giữa chừng" trong Bảng 6.2 của A | 1 dòng schema + 1 dòng dictionary. **≈2 dòng** |
| P2 | Bốn bảng read model `rm_funnel_daily`, `rm_time_to_hire`, `rm_source_effectiveness`, `rm_sla_compliance` trong schema `reporting` | `SCR-10` bốn biểu đồ và chỉ báo `dataFreshness`; nền của ADR-07 và NFR-10 | ~30 dòng. Đề nghị đặt ở phụ lục và **không tính vào con số "18 bảng"** của Chương 4 vì nằm trong schema tách riêng |

Nếu duyệt P0 và P1 thì Chương 4 đi từ 18 lên **20 bảng**; duyệt cả P2 thì **21 bảng**, chưa kể bốn bảng
`rm_*` ở schema `reporting`. Đây chính là lý do toàn bộ danh mục được đưa ra Sync S4 thay vì D tự thêm.

### 5.2. Index đề xuất bổ sung

| Index đề xuất | Màn hình của D cần nó | Hiện trạng trong `sql/schema.sql` | Công |
|---|---|---|---|
| `applications(jd_id, status, applied_at DESC)` | `SCR-03` dựng kanban theo JD: lọc theo `jd_id`, chia cột theo `status`, sắp xếp theo thời gian nộp; `SCR-02` đếm thẻ mỗi cột | Ba index rời: `jd_id`, `status`, `(candidate_id, jd_id, applied_at)` | 1 dòng |
| `application_status_history(to_status, changed_at)` | `SCR-10` funnel và time-in-stage; job làm mới read model 15 phút | Hai index rời `idx_ash_to_status`, `idx_ash_changed_at` (dòng 210–211) | 1 dòng |
| `interviews(scheduled_at, status)` kết hợp `interview_participants(interviewer_id)` | `SCR-05` kiểm tra xung đột theo BR-03 — truy vấn này chạy **bên trong** vùng khoá Redis nên mỗi mili giây tiết kiệm được đều rút ngắn thời gian giữ khoá (NFR-02) | Có `idx_interviews_scheduled_at`, `idx_ipart_interviewer_id` | 1–2 dòng |
| `offers(status, deadline)` | `SCR-08` danh sách offer chờ duyệt; job hết hạn offer theo BR-09 quét mỗi chu kỳ của `SchedulerWorker` | Hai index rời `idx_offers_status`, `idx_offers_deadline` | 1 dòng |
| `candidates(source)` | `SCR-10` biểu đồ hiệu quả nguồn tuyển, nhóm theo 6 giá trị của `candidate_source` | Chưa có index nào trên cột này | 1 dòng |
| `feedbacks(interview_id, submitted_at)` | `SCR-06`; job nhắc SLA feedback theo BR-06 và SEQ-03 | Có `idx_feedbacks_interview_id` | 1 dòng |

Tổng khoảng **7 dòng `CREATE INDEX`**, cộng phần cập nhật mục index trong `docs/data_dictionary_C.md` và
câu tổng kết index ở `report/chapter_4_data.md` dòng 399.

### 5.3. Một dòng của C bị X-01 chạm tới

`report/chapter_4_data.md` Bảng 4.1 dòng 332 ghi "BR-05 — Candidate xác nhận lịch trong 24h". Nếu Sync S4
chọn mô hình hai mốc thì đây là **1 dòng** phải sửa. Không đụng tới `sql/schema.sql` vì schema không lưu
hằng số SLA.

### 5.4. Nếu C từ chối

| Đề xuất bị từ chối | D điều chỉnh thế nào |
|---|---|
| `SHORTLISTED` | `SCR-03` gộp "đã shortlist" vào cột `SCREENING`; wireframe đã dự trù sẵn nhãn và màu ở dòng cuối Bảng 5.98 nên chỉ mất một cột, không đổi bố cục |
| Cột `version` | ADR-08 hạ xuống mức "giả định thiết kế chưa có cơ sở lưu trữ", ghi rõ trong phần hệ quả tiêu cực |
| `outbox_events` | ADR-06 mô tả outbox ở mức khái niệm, không khẳng định có bảng; NFR-11 chuyển phép đo sang mức thiết kế |
| Bốn bảng `rm_*` | `ReportingService` truy vấn thẳng replica; NFR-10 phải nới ngưỡng p95 và ghi rõ rủi ro chậm dần theo lịch sử tích luỹ |

---

## 6. Những gì D **không** đề nghị đổi

Mục này liệt kê những chỗ D đã cân nhắc trong quá trình dựng Chương 5 và cố ý giữ nguyên, để B và C
không phải rà lại.

| Hạng mục | Của ai | Vì sao D không đụng vào |
|---|---|---|
| Giữ **hai enum tách rời** `application_status` và `offer_status` | C | Lập luận ở mục 3.4.5 của B là đúng: một Application có thể sinh nhiều bản offer trong khi vẫn ở cùng một giai đoạn. D giải quyết khác biệt hoàn toàn ở tầng nhãn hiển thị (Bảng 5.99 và Bảng 5.56), người dùng không bao giờ thấy tên enum |
| Giữ **single-table inheritance** cho `users` (một bảng, cột `role` ENUM 6 giá trị) | C | RBAC của D làm việc trên đúng cặp `role` + `department_id`; tách sáu bảng con chỉ khiến mọi truy vấn "ai thuộc phòng ban X" phải UNION mà không thêm gì cho phân quyền |
| Giữ **18 bảng** làm nền | C | Mọi đề xuất ở mục 5 đều là **thêm**; D không đề nghị bỏ, gộp hay tách lại bất kỳ bảng nào trong 18 bảng hiện có |
| Giữ `offer_approvals.attempt_no` và `UNIQUE(offer_id, level, attempt_no)` | C (theo đề nghị của B) | `ApprovalWorkflow` (C11) dùng đúng cơ chế này cho luồng `REQUEST_CHANGE` duyệt lại từ cấp 1; không cần đổi gì |
| Giữ `UNIQUE(application_id, round_order)` và giả định "reschedule = update cùng dòng" của STATE-02 | B và C | `SCR-05` được vẽ theo đúng giả định này: đổi lịch là sửa buổi phỏng vấn hiện có, không tạo thẻ mới trên timeline |
| Giữ `feedbacks.total_score` ở dạng phi chuẩn hoá | C | `SCR-04` và `SCR-06` đọc nhiều hơn ghi rất nhiều; D chấp nhận đánh đổi đã ghi ở mục 4 của Chương 4 |
| Giữ `audit_logs` polymorphic song song với `application_status_history` | C | Hai bảng phục vụ hai mục đích khác nhau: audit tổng quát cho mọi thực thể, và time-in-stage cho báo cáo. NFR-06 dùng cả hai |
| Giữ các cột JSONB hiện có | C | Không có màn hình nào của D cần chuẩn hoá chúng thành bảng riêng |
| Giữ cách B vẽ `CronScheduler` như actor ở SEQ-03 | B | Đúng quy ước sequence diagram; D chỉ thêm chú thích trên COMP-01 chứ không yêu cầu B vẽ lại |
| Giữ `CalendarRepo` và `FeedbackRepo` làm lifeline riêng | B | D ánh xạ chúng vào `PersistenceLayer` (C19) trong bảng ánh xạ, không đề nghị B đổi tên lifeline |
| Giữ toàn bộ tên lifeline còn lại của B | B | COMP-01 đặt tên component **theo** B chứ không ngược lại — đó là lý do `SchedulingService`, `OfferService`, `ApprovalWorkflow`, `SLAService`, `NotificationService`, `EscalationService` giữ nguyên chuỗi ký tự |
| Giữ 5 UC đặc tả đầy đủ + UC-06 rút gọn | A | D không đề nghị viết thêm UC cho đủ 10–12; `SCR-11` phục vụ F09 được ghi rõ là ngoài năm UC trọng tâm |
| Giữ nguyên nội dung Bảng 6.2 (rủi ro thiết kế) của A | A | Cả sáu rủi ro đều đúng và đã được Chương 6 của D kế thừa, chỉ bổ sung biện pháp đo |
| Giữ `notifications` chỉ dành cho user nội bộ, Candidate không có hàng | C | Đúng ADR-09 và ghi chú v1.2 của C |
| Giữ Mermaid cho toàn bộ diagram | Cả nhóm | ADR-11, đã chốt ở `docs/change_log.md` ngày 2026-08-06 |

---

## 7. Đầu vào D còn thiếu

| Cần gì | Từ ai | Đang chặn phần nào của D |
|---|---|---|
| Kết quả của 10 dòng ở mục 2 | A, B, C | Chương 5 mục 5.7 (sổ mâu thuẫn) và phần rủi ro của Chương 6; nội dung slide bảo vệ |
| Số hiệu mới cho quy tắc override lịch trùng (BR-26?) | A | `SCR-05` (ô lý do bắt buộc), dòng "Override xung đột lịch" trong ma trận RBAC, mô tả `SchedulingService` (C08) |
| Tên chuẩn trên diagram cho vai trò duyệt tài chính | A | COMP-01, `SCR-08`, Bảng 5.55, slide — phải chốt trước khi khoá bản diagram để in |
| Xác nhận BR-14 và BR-15 là mã chính thức | A | `SCR-06` và `FeedbackService` (C09) hiện mô tả "khoá sửa sau 24 giờ" mà không có mã BR để trích |
| Quyết định về Bảng 5.1, 5.2, 5.3 và Bảng 6.1, 6.2 trong docx | A | Mục mở đầu Chương 5 của D phải nêu rõ quan hệ với bản phác của A; nếu để trống thì bản nộp có hai Chương 5 |
| Quyết định 9 đề xuất schema và 6 index | C | Mục 5.4 (cơ chế thiết kế) và phần cách đo của NFR-01, NFR-02, NFR-10, NFR-11 trong Chương 5 |
| Xác nhận bảng ánh xạ lifeline → component | B | Checklist review chéo Chương 5 (`06_conventions_shared.md` mục 5, dòng đầu tiên) |
| Duyệt bộ dữ liệu mẫu VXTech với domain `@vxtech.vn` thay cho `@cmc.com.vn` gợi ý trong `04_person_D_design.md` | Cả nhóm | 11 wireframe, prototype và mọi ảnh chụp màn hình trong slide đều đã dùng bộ dữ liệu này |
| Bản chốt cuối của Chương 1–2 sau khi sửa mã BR | A | D phải rà lại toàn bộ tham chiếu mã BR trong Chương 5 và slide; hạn đề nghị: trước dry-run S6 |

---

## 8. Dòng soạn sẵn cho `docs/change_log.md`

Định dạng theo `06_conventions_shared.md` mục 3. **D không tự ghi vào `docs/change_log.md`** — theo
`00_README.md` mục 9, một mục chỉ được tính Done sau khi có người thứ hai xác nhận. Các dòng dưới đây để
người phụ trách dán vào sau Sync S4.

Khối thứ nhất là **các dòng công bố phát hành deliverable D1…D10**; đây là điều kiện Done số 4 ở
`00_README.md` mục 9 mà `docs/README_part_D.md` đang tự chấm "Chưa đạt". Khối thứ hai là các dòng ghi
nhận đề nghị gửi A, B, C. Bảy dòng còn lại (đối chiếu ADR, sổ mâu thuẫn, NFR) đã được soạn sẵn ở
`docs/design_decisions_D.md` mục 8 — **không dán trùng hai nơi**.

**Khối 1 — công bố phát hành deliverable của D**

```
2026-08-16 | D | Phát hành report/chapter_5_design.md (D1) và report/chapter_6_conclusion.md (D2) — chính văn Chương 5 và Chương 6: 6 ràng buộc dẫn dắt, 3 phương án kiến trúc, 7 cơ chế then chốt, 11 màn hình, 14 NFR; Chương 6 gồm đối chiếu 5 mục tiêu, kịch bản demo 6 bước, 7 hạn chế và 9 rủi ro. | Ảnh hưởng: A (thay phần phác Chương 5–6 trong chapter-A.docx) [chờ B và C review chéo]

2026-08-16 | D | Phát hành diagrams/D_comp_architecture_v1.md (D3, COMP-01) — 24 component C01…C24, 19 hợp đồng interface/port, 3 bảng đối chiếu chéo với 13 lifeline của B và 18 bảng của C. | Ảnh hưởng: B (xác nhận ánh xạ lifeline) [chờ B review chéo]

2026-08-16 | D | Phát hành diagrams/D_deploy_topology_v1.md (D4, DEP-01) — 14 node N01…N14 theo 5 vùng mạng, ma trận 22 kênh kết nối, chiến lược mở rộng 2→6 instance, chính sách sao lưu và quy trình khôi phục 4 bước. | Ảnh hưởng: không ai phải sửa [chờ review chéo]

2026-08-16 | D | Phát hành wireframes/D_wireframes_v1.md (D5) và wireframes/README.md (D5b) — 11 màn SCR-01…SCR-11 với 25 trạng thái, bản đồ màn hình, 3 user flow, hệ thống thiết kế và checklist tiếp cận. | Ảnh hưởng: A (Bảng 5.3 trong bản phác được thay bằng Bảng 5.91) [chờ review chéo]

2026-08-16 | D | Phát hành prototype/index.html (D8) — prototype click-through 11 màn trong một tệp HTML tự chứa, chạy ngoại tuyến, kèm prototype/capture_screenshots.sh và 20 ảnh chụp ở prototype/screenshots/. | Ảnh hưởng: cả nhóm (dùng cho demo và slide) [chờ dry run S6]

2026-08-16 | D | Phát hành slides/defense_slides_v1.md (D7) — bộ slide bảo vệ cho cả nhóm, khối slide 25–27 dành cho demo theo kịch bản 6 bước. | Ảnh hưởng: A, B, C (mỗi người rà phần slide của mình) [chờ dry run S6]

2026-08-16 | D | Phát hành docs/demo_runbook_D.md (D10) — kịch bản bấm demo 6 bước có bấm giờ, agenda dry run S6, phân công Q&A và checklist máy trình chiếu. | Ảnh hưởng: cả nhóm [chờ dry run S6]

2026-08-16 | D | Phát hành docs/traceability_matrix_D.md — ma trận truy vết từ yêu cầu của A qua hành vi của B và dữ liệu của C tới thiết kế của D, kèm bảng đếm số liệu chốt (24 component, 19 interface, 14 node, 22 kênh, 11 màn, 25 trạng thái, 14 NFR) để mọi con số trích trong báo cáo đều kiểm được. | Ảnh hưởng: cả nhóm (dùng khi rà chéo) [chờ review chéo]
```

**Khối 2 — đề nghị gửi A, B, C**

```
2026-08-16 | D | Phát hành docs/handoff_D_to_ABC_v1.md — bản bàn giao ngược từ D cho A, B, C sau khi Chương 5–6 hoàn tất: 10 quyết định cần chốt ở Sync S4, 11 việc gửi A, 12 việc gửi B (trong đó B-12 là lỗi chặn làm SEQ-02 không render được), 9 đề xuất schema và 6 index gửi C, kèm danh mục những chỗ D cố ý không đề nghị đổi. | Ảnh hưởng: A, B, C [chờ Sync S4]

2026-08-16 | D | Đối chiếu docs/chapter-A.docx v1.0 với report/chapter_3_behavior.md: ngoài hai nhãn guard của STATE-01 và STATE-02 đã ghi ở sổ mâu thuẫn X-01, mốc 24h còn nằm ở 4 chỗ trong ACT-01 (diagrams/B_act_recruitment_flow_v1.md dòng 24, 64, 108, 163), 6 chỗ trong chính văn Chương 3 và 1 dòng Bảng 4.1 của C. Tổng công sửa nếu chọn mô hình hai mốc: khoảng 19 dòng trên 5 tệp của B, 1 dòng của C. | Ảnh hưởng: B (5 tệp), C (report/chapter_4_data.md dòng 332) [chờ A chốt X-01]

2026-08-16 | D | Đề nghị A đổi mã quy tắc override lịch trùng từ BR-13 thành BR-26 — số trống đầu tiên sau dải BR-03…BR-25 mà A đã phát hành; BR-13 giữ nguyên nghĩa hold timeout theo spec_ats (1).md v1.1 vì STATE-01 của B và Bảng 4.1 của C đã tham chiếu theo nghĩa đó. | Ảnh hưởng: A (Bảng 2.15a, UC-01), D (Chương 5, ma trận RBAC) [cần A xác nhận]

2026-08-16 | D | Đề nghị A rút lại câu "Dùng OFFER_APPROVED nhất quán thay cho SIGNED_BY_COMPANY" trong chapter-A.docx; giữ hai enum application_status và offer_status tách rời như sql/schema.sql v1.2 và Bảng 3.1b của B, xử lý khác biệt ở tầng nhãn hiển thị theo Bảng 5.99 và Bảng 5.56 của D. | Ảnh hưởng: A (2 dòng Chương 2) [cần A xác nhận]

2026-08-16 | D | Đề nghị thay phần phác Chương 5–6 trong chapter-A.docx bằng report/chapter_5_design.md và report/chapter_6_conclusion.md: giữ Bảng 5.1 dạng tóm tắt kèm cột ánh xạ sang 24 component của COMP-01, giữ Bảng 5.2 và Bảng 6.1/6.2 dạng tóm tắt, bỏ Bảng 5.3 vì đã được Bảng 5.91 (11 màn SCR-01…SCR-11) phủ hoàn toàn. | Ảnh hưởng: A (Chương 5–6 trong docx), D (mục mở đầu Chương 5) [cần A quyết]

2026-08-16 | D | Phát hiện Bảng A.1 (glossary) trong chapter-A.docx còn thiếu HeadOfHR và vai trò duyệt tài chính, dù chính tài liệu đó đã bổ sung hai actor này và sql/schema.sql v1.2 đã có HEAD_OF_HR / FINANCE trong user_role; đề nghị A dán Bảng 5.55 (ánh xạ ba tầng, 7 dòng) từ docs/design_decisions_D.md mục 6 vào glossary. Kèm một sửa nhỏ: mục Tài liệu tham chiếu ghi spec phiên bản 1.0, cần sửa thành 1.1. | Ảnh hưởng: A (phụ lục Chương A) [cần A xác nhận]

2026-08-16 | D | Ghi nhận Bảng 5.2 của A và spec_ats (1).md mục 11 chỉ ghi "≥ 99 % giờ hành chính"; con số "≤ 13 phút downtime/tháng" do D bổ sung khi định lượng NFR-03, trong khi 99 % của khoảng 220 giờ hành chính mỗi tháng là 132 phút. Đề nghị A chốt cách hiểu hai mức: 13 phút là ngưỡng vận hành nội bộ (99,9 %), 99 % là sàn cam kết tối thiểu. | Ảnh hưởng: A (Bảng 5.2 Chương 5 phác) [cần A xác nhận]

2026-08-16 | D | Xác nhận toàn bộ 13 lifeline của SEQ-01, SEQ-02, SEQ-03 đều có component tương ứng trên COMP-01, trong đó UI ứng với InternalWebApp + ApiGateway và CalendarRepo ứng với PersistenceLayer.CalendarRepo + CalendarAdapter (không phải ánh xạ một-một, đúng ghi chú 3.5.4 của B). CronScheduler là actor trên sequence nhưng là SchedulerWorker (C17) bên trong đường bao hệ thống trên COMP-01 và DEP-01 — hai cách nhìn không mâu thuẫn, B không phải sửa SEQ-03. | Ảnh hưởng: B (chỉ xác nhận, 0 dòng sửa) [cần B xác nhận]

2026-08-16 | D | Khi chạy scripts/render_mermaid_D.py phát hiện SEQ-02 (diagrams/B_seq_offer_approval_v1.md) không render được: dòng 78 có dấu chấm phẩy trong "25a. Application=ACCEPTED; other apps=ON_HOLD (BR-10)", Mermaid coi ";" là dấu kết thúc câu lệnh nên cả sơ đồ parse lỗi và diagrams/rendered/ hiện thiếu ảnh của SEQ-02. Đề nghị B thay ";" bằng dấu phẩy hoặc <br/> (việc B-12). | Ảnh hưởng: B (1 dòng), bản nộp Word và slide [lỗi chặn, cần B sửa]
```
