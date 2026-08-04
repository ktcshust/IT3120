# Person B — Behavior / Process Analyst

**Chương phụ trách:** Chương 3 — Phân tích hành vi (~25% khối lượng)
**Vai trò phụ:** Reviewer chính cho Chương 2 của A (kiểm tra logic flow).

---

## 1. Deliverables cuối cùng

| # | Deliverable | Format | Ước lượng |
|---|---|---|---|
| B1 | Chương 3: Phân tích hành vi — mở đầu, phương pháp | Word/Doc, ~2 trang | Tuần 3 |
| B2 | 2 Activity Diagrams | draw.io / PlantUML | Tuần 3 |
| B3 | 1 State Machine Diagram cho Application | draw.io / PlantUML | Tuần 3 |
| B4 | 3 Sequence Diagrams (SEQ-01, SEQ-02, SEQ-03) | draw.io / PlantUML | Tuần 3-4 |
| B5 | Phần diễn giải mỗi diagram trong Chương 3 | Word/Doc, ~10 trang | Tuần 4 |

---

## 2. Danh sách cụ thể các diagram phải làm

### Activity diagram
- **ACT-01 — Toàn bộ quy trình tuyển 1 ứng viên**
  - Swimlane: Recruiter, Hiring Manager, Interviewer, Candidate, System.
  - Từ lúc "Ứng viên nộp CV" → "Onboard xong hoặc bị loại".
  - Phải có decision node ở các điểm: sàng lọc, sau mỗi vòng phỏng vấn, sau khi gửi offer.
  - Ước tính 20-30 activity nodes.

- **ACT-02 — Quy trình duyệt offer multi-level**
  - Swimlane: Recruiter, Hiring Manager, Head of HR, Finance, Candidate.
  - Decision node: mức lương so với band (3 nhánh).
  - Có loop: reject → sửa → duyệt lại.
  - Ước tính 15-20 activity nodes.

### State machine diagram
- **STATE-01 — Vòng đời của Application**
  - Dùng đúng state trong `spec_ats.md` mục 7.
  - Vẽ đủ transition với trigger (event) + guard condition khi cần.
  - Chú ý các state đặc biệt: `ON_HOLD`, `TALENT_POOL`.

### Sequence diagram (chốt ở S3 với A)
- **SEQ-01 — Xếp lịch phỏng vấn có kiểm tra xung đột**
  - Objects: Recruiter (actor) → UI → SchedulingService → CalendarRepo → NotificationService → EmailGateway.
  - Có nhánh alt: xung đột lịch → gợi ý slot khác.
  - Có nhánh alt: override khi không có slot.

- **SEQ-02 — Duyệt offer multi-level (dài, khó nhất)**
  - Objects: Recruiter → OfferService → ApprovalWorkflow → HiringManager → HeadOfHR → Finance → CandidatePortal.
  - Có loop `alt` cho 3 mức: trong band, vượt ≤10%, vượt >10%.
  - Có return message khi Approve/Reject.

- **SEQ-03 — Nhắc SLA feedback trễ hạn**
  - Objects: Cron/Scheduler (actor) → SLAService → FeedbackRepo → NotificationService → EscalationService.
  - Có loop 24h/48h/72h với hành vi khác nhau.

---

## 3. Task breakdown theo tuần

### Tuần 1 — Chuẩn bị & học

- [ ] Đọc `spec_ats.md`, đặc biệt mục 7 (state machine) và mục 9 (sequence).
- [ ] Ôn lại syntax UML: activity notation, state notation, sequence (lifeline, message, alt/loop/opt).
- [ ] Cài & thử tool đã chốt (draw.io / PlantUML).
- [ ] Cùng A rà soát UC list — check xem UC nào có flow phức tạp đủ để vẽ sequence.
- [ ] Vẽ **draft nhanh trên giấy** ACT-01 (toàn quy trình) để nắm bức tranh lớn.

**Output tuần 1:** Nắm được UC list, có bản nháp tay ACT-01.

---

### Tuần 2 — Đợi A + bắt đầu diagram không phụ thuộc

- [ ] **Ngay khi A giao 5 UC ưu tiên** (đầu tuần 2):
  - Vẽ ACT-01 v1 (toàn quy trình) trên tool.
  - Vẽ STATE-01 v1.
- [ ] Vẽ SEQ-01 (xếp lịch) — dùng UC-01 đã có.
- [ ] Nếu có thời gian: bắt đầu ACT-02 (duyệt offer).

**Output tuần 2:** ACT-01 v1, STATE-01 v1, SEQ-01 v1.

---

### Tuần 3 — Deep work, vẽ hết diagram

- [ ] Vẽ ACT-02 (duyệt offer).
- [ ] Vẽ SEQ-02 (duyệt offer) — cùng logic với ACT-02 nhưng góc nhìn khác (object interaction).
- [ ] Vẽ SEQ-03 (SLA nhắc).
- [ ] Viết Chương 3: phần mở đầu (2 trang) + diễn giải mỗi diagram (1-2 trang/diagram).

**Cuối tuần — Sync S4 (Cross-review):**
- [ ] Trình bày các diagram cho A, C, D.
- [ ] Chú ý mismatch với C: state trong STATE-01 có khớp cột `status` trong ERD của C không?
- [ ] Chú ý mismatch với A: alt flow trong sequence có đúng alt flow trong UC không?

**Output tuần 3:** Toàn bộ 6 diagram v1 + Chương 3 v1.

---

### Tuần 4 — Sửa v2 theo feedback

- [ ] Sửa các diagram theo feedback S4.
- [ ] Đảm bảo naming đồng bộ với ERD của C (tên entity, tên field).
- [ ] Review chéo Chương 2 của A: có UC nào flow không rõ, thiếu alt case?

**Output tuần 4:** Chương 3 final, diagram final.

---

### Tuần 5 — Slide & bảo vệ

- [ ] Làm slide phần Chương 3 (~5-6 slide, trong đó 3 slide dành cho diagram).
- [ ] Chuẩn bị nói ~4-5 phút, focus vào SEQ-02 (offer approval) vì đây là diagram phức tạp nhất, dễ được hỏi.

---

## 4. Input cần từ ai

| Cần cái gì | Từ ai | Khi nào | Nếu chưa có thì làm gì |
|---|---|---|---|
| UC-01 detail | A | Đầu tuần 2 | Không thể bắt đầu SEQ-01 — ping A ngay |
| UC-04 detail (offer) | A | Đầu tuần 2 | Không thể bắt đầu ACT-02, SEQ-02 |
| Danh sách state chính thức | A + tự tra spec | Tuần 1 | Có thể dùng spec làm gốc |
| Tên entity/service để đặt lifeline | C | Cuối tuần 2 | Dùng tên tạm, sửa sau |
| Business rules về SLA | A | Đầu tuần 3 | Không thể vẽ SEQ-03 chính xác |

---

## 5. Output giao cho ai

| Giao cái gì | Cho ai | Khi nào | Vì sao họ cần |
|---|---|---|---|
| State list chính thức từ STATE-01 | C | Cuối tuần 2 | C dùng để định nghĩa enum trong ERD |
| Sequence diagrams | D | Cuối tuần 3 | D dùng để design kiến trúc component |
| Feedback về UC của A | A | Sync S4 | A biết chỗ nào UC còn thiếu |

---

## 6. Tiêu chí "Done" cho từng diagram

### Activity diagram
- [ ] Có start node và end node rõ ràng.
- [ ] Có ít nhất 2 decision node (rẽ nhánh).
- [ ] Có swimlane cho mỗi actor liên quan.
- [ ] Không có "arrow tự lơ lửng" (mọi transition đều có nguồn và đích).
- [ ] Có ít nhất 1 join/fork nếu có action song song.

### State machine
- [ ] Có initial state.
- [ ] Có final state (hoặc nhiều final).
- [ ] Mỗi transition có label: `event [guard] / action`.
- [ ] Không có state "cô lập" không thể vào hoặc ra.
- [ ] State phải khớp với `status` trong ERD của C.

### Sequence diagram
- [ ] Có ít nhất 4 lifeline (actor + 3 object).
- [ ] Có message return (đường đứt nét) — không chỉ có message đi.
- [ ] Có ít nhất 1 fragment: `alt`, `opt`, `loop`, hoặc `par`.
- [ ] Thứ tự message rõ ràng, có đánh số nếu phức tạp.
- [ ] Không có "hộp active" bỏ dở (mở activation phải có close).

---

## 7. Phối hợp cụ thể với từng người

### Với A (Requirements)
- **B nhận từ A:** UC detail, alt flow, business rules.
- **B đưa lại A:** Phát hiện flow thiếu case, đề nghị A bổ sung UC.
- **Ví dụ tương tác:** A viết UC-01 chỉ có 1 alt flow "xung đột lịch". B khi vẽ SEQ-01 thấy còn case "candidate không xác nhận" cần alt flow riêng → ping A.

### Với C (Data)
- **B nhận từ C:** Tên entity chính thức, tên service trong kiến trúc (để đặt lifeline).
- **B đưa lại C:** Danh sách state của Application (để C set kiểu enum trong ERD).
- **Xung đột thường gặp:** B đặt tên service "InterviewScheduler" nhưng C không có bảng nào tương ứng → cần thống nhất: B đang mô hình hoá service layer, C đang mô hình hoá persistence layer, không nhất thiết trùng 1-1.

### Với D (Design)
- **B đưa cho D:** Sequence diagram → D dùng để vẽ component diagram (mỗi lifeline có thể thành 1 component).
- **B nhận từ D:** Xác nhận kiến trúc có đủ service như B đã giả định trong sequence.

---

## 8. Sai lầm cần tránh

- **Vẽ activity diagram = flowchart** — thiếu swimlane, thiếu synchronization bar. Activity diagram phải có yếu tố UML rõ ràng.
- **Sequence diagram không có message return** — sai UML, mất điểm dễ nhất.
- **Sequence dùng lifeline là "System" chung chung** — phải chia nhỏ thành các service/component cụ thể.
- **State machine thiếu event trên transition** — chỉ có mũi tên mà không có label → không biết cái gì trigger.
- **Vẽ diagram đẹp nhưng không diễn giải** — chương 3 phải có phần chữ giải thích từng diagram, không chỉ dán ảnh.
- **State machine không khớp UC** — VD: UC có action "gửi offer" nhưng state machine không có transition tương ứng.

---

## 9. Câu hỏi bảo vệ có thể bị hỏi (B nên chuẩn bị)

- Sao chọn 3 sequence này, không phải cái khác?
- Trong SEQ-02, tại sao ApprovalWorkflow là 1 service riêng, không nhét vào OfferService?
- STATE-01 tại sao có state `ON_HOLD`? Khi nào transition sang đó?
- Trong ACT-01, khi Interviewer từ chối phỏng vấn thì đi đâu?
- Vì sao vẽ activity mà không dùng BPMN?

