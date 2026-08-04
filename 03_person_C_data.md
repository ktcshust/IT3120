# Person C — Data Architect

**Chương phụ trách:** Chương 4 — Phân tích cấu trúc dữ liệu (~25% khối lượng)
**Vai trò phụ:** Reviewer chính cho Chương 3 của B (kiểm tra state khớp field).

---

## 1. Deliverables cuối cùng

| # | Deliverable | Format | Ước lượng |
|---|---|---|---|
| C1 | Chương 4 mở đầu: phương pháp phân tích dữ liệu | Word/Doc, ~2 trang | Tuần 3 |
| C2 | Domain Model / Class Diagram (conceptual) | draw.io / PlantUML | Tuần 2-3 |
| C3 | ERD chi tiết (physical) | draw.io / dbdiagram.io | Tuần 3 |
| C4 | Data Dictionary (bảng mô tả từng field) | Word/Excel | Tuần 3-4 |
| C5 | Ràng buộc & normalization analysis | Word/Doc, ~3 trang | Tuần 4 |
| C6 | Phần diễn giải class/ERD trong Chương 4 | Word/Doc, ~8 trang | Tuần 4 |

---

## 2. Danh sách entity phải mô hình hoá

Dựa trên `spec_ats.md` mục 8, phải có tối thiểu 15 entity:

| Nhóm | Entity |
|---|---|
| User & tổ chức | `User`, `Department`, `Role` (nếu tách khỏi User) |
| JD & quy trình | `JobDescription`, `InterviewProcess`, `ScorecardTemplate` |
| Ứng viên & apply | `Candidate`, `Application` |
| Phỏng vấn | `Interview`, `InterviewParticipant`, `Feedback`, `FeedbackCriterion` |
| Offer | `Offer`, `OfferApproval` |
| Hạ tầng | `EmailTemplate`, `AuditLog`, `Notification`, `Attachment` (cho CV file) |

**Ràng buộc:** phải có ít nhất **1 quan hệ N-N** (gợi ý: `Interview` ↔ `User` qua `InterviewParticipant`), **1 quan hệ đệ quy** (gợi ý: `Department` cha-con), và **1 subtype/inheritance** trong class diagram (gợi ý: `User` → `Recruiter`, `HiringManager`, `Interviewer` — hoặc dùng Role).

---

## 3. Sự khác nhau giữa 3 diagram (dễ nhầm)

Ba diagram khác nhau về **mục đích và mức trừu tượng**:

| Diagram | Mục đích | Mức trừu tượng | Có gì |
|---|---|---|---|
| **Domain Model (conceptual)** | Nắm khái niệm nghiệp vụ | Cao — không quan tâm DB | Tên class, association, multiplicity. Không có method, không có datatype. |
| **Class Diagram (logical)** | Thiết kế hướng đối tượng | Trung bình | Class + attribute có kiểu (String, Date...) + method + inheritance |
| **ERD (physical)** | Triển khai DB | Thấp — sát SQL | Table + column có kiểu SQL (VARCHAR(255), TIMESTAMP...) + PK, FK, index, constraint |

**Lời khuyên:** làm Domain Model trước (nhanh), rồi từ đó phát triển thành Class Diagram và ERD song song.

---

## 4. Task breakdown theo tuần

### Tuần 1 — Chuẩn bị

- [ ] Đọc `spec_ats.md` mục 6 (business rules) và mục 8 (domain model).
- [ ] Cài & thử tool: draw.io (cho class diagram) và dbdiagram.io hoặc DBeaver (cho ERD).
- [ ] Vẽ nháp trên giấy Domain Model từ spec.
- [ ] Đề xuất với A: danh sách entity — chốt tên (VD: `Candidate` hay `Applicant`?).

**Output tuần 1:** Danh sách entity đã chốt tên với A, domain model nháp.

---

### Tuần 2 — Domain model & class diagram v1

- [ ] Vẽ **Domain Model** đầy đủ trên tool: 15+ class, association với multiplicity đúng (1..*, 0..1, 1..1).
- [ ] Ngay khi A giao 5 UC ưu tiên, rà lại: mọi entity trong UC có mặt trong domain model chưa?
- [ ] Bắt đầu **Class Diagram**: thêm attribute và datatype cho từng class (String, LocalDateTime, Enum, BigDecimal cho tiền).
- [ ] Ping B: xin danh sách state của Application (nếu B đã có STATE-01).

**Output tuần 2:** Domain Model v1, Class Diagram v1 (chưa method).

---

### Tuần 3 — Class diagram v2 + ERD v1

- [ ] Thêm method vào Class Diagram (không cần đủ, chỉ những method chính: `Application.submit()`, `Offer.approve(level)`, `Interview.checkConflict(user, time)`).
- [ ] Thêm inheritance/subtype nếu chọn approach đó.
- [ ] Vẽ **ERD**:
  - Đổi association N-N thành bảng trung gian (`InterviewParticipant`, `OfferApproval`).
  - Thêm PK (`id BIGINT AUTO_INCREMENT`) cho mọi bảng.
  - Thêm FK với ON DELETE rule (CASCADE / RESTRICT / SET NULL).
  - Chọn kiểu SQL cụ thể: `VARCHAR(255)` cho tên, `TEXT` cho note dài, `TIMESTAMP` cho ngày giờ, `ENUM` cho status.
  - Đánh dấu index: mọi FK phải có index, cột dùng để filter thường xuyên (`Application.status`, `JobDescription.status`) cũng nên có index.
- [ ] Bắt đầu Data Dictionary (bảng: entity, field, type, null?, mô tả, ràng buộc).

**Cuối tuần — Sync S4:**
- [ ] Trình bày class diagram và ERD.
- [ ] Check với B: state trong STATE-01 có khớp cột `Application.status` không?
- [ ] Check với A: mọi entity đều xuất hiện trong ít nhất 1 UC?
- [ ] Check với D: kiến trúc D dự kiến có phù hợp với ERD (VD: reporting service dùng read replica → ERD cần index báo cáo).

**Output tuần 3:** Domain Model final, Class Diagram v1, ERD v1, Data Dictionary v1.

---

### Tuần 4 — Sửa v2 + normalization + viết chương 4

- [ ] Sửa diagram theo feedback S4.
- [ ] Viết phần **Normalization analysis**: chứng minh ERD đạt 3NF. Chỉ ra 1-2 chỗ **cố ý denormalize** để tối ưu đọc (VD: cache `total_score` trong bảng Feedback thay vì tính lại từ FeedbackCriterion).
- [ ] Hoàn thiện Data Dictionary: đủ mọi field, có comment mô tả.
- [ ] Viết Chương 4: mở đầu → domain model → class diagram → ERD → normalization → data dictionary (đưa vào phụ lục).

**Output tuần 4:** Chương 4 final.

---

### Tuần 5 — Slide & bảo vệ

- [ ] Làm slide phần Chương 4 (~4-5 slide).
- [ ] Slide chính: ERD tổng thể (crop 1 phần trọng tâm, không show hết vì quá to).
- [ ] Slide phụ: 1 bảng "quyết định thiết kế đáng chú ý" (VD: vì sao dùng bi-temporal, vì sao denormalize chỗ nào).

---

## 5. Input cần từ ai

| Cần cái gì | Từ ai | Khi nào | Nếu chưa có thì làm gì |
|---|---|---|---|
| Danh sách entity nghiệp vụ | A | Cuối tuần 1 | Dùng spec làm gốc, có thể start |
| Business rules ràng buộc dữ liệu | A | Đầu tuần 2 | Cần cho ràng buộc constraint (VD: `salary_band_max >= salary_band_min`) |
| Danh sách state | B | Cuối tuần 2 | Dùng spec mục 7 làm gốc |
| Sequence diagram (để biết object nào cần persist) | B | Cuối tuần 3 | Có thể suy đoán từ UC |

---

## 6. Output giao cho ai

| Giao cái gì | Cho ai | Khi nào | Vì sao họ cần |
|---|---|---|---|
| Tên entity chính thức | A + B + D | Cuối tuần 1 | Đồng bộ ngôn ngữ |
| Class diagram | D | Cuối tuần 3 | D dùng để design domain layer trong kiến trúc |
| ERD | D | Cuối tuần 3 | D dùng để chọn DB technology & lên deployment |
| Data Dictionary | Cả nhóm | Cuối tuần 4 | Reference chung khi viết báo cáo |

---

## 7. Tiêu chí "Done" cho từng deliverable

### Domain Model
- [ ] Có ≥15 class.
- [ ] Mọi association có multiplicity ở cả 2 đầu.
- [ ] Không có class "cô lập" (không có association nào).
- [ ] Có ít nhất 1 quan hệ N-N (đã đổi thành association class hoặc chưa cũng OK ở tầng conceptual).

### Class Diagram
- [ ] Mọi class có ≥3 attribute (không tính id).
- [ ] Mọi attribute có kiểu (String, Date, Enum, BigDecimal...).
- [ ] Có ≥5 method có ý nghĩa nghiệp vụ.
- [ ] Có ≥1 inheritance / interface (gợi ý: `Notifiable`, `Approvable`).
- [ ] Có ≥1 association class hoặc composite.

### ERD
- [ ] Mọi bảng có PK.
- [ ] Mọi FK có index.
- [ ] Bảng trung gian cho N-N có composite key hoặc surrogate key rõ ràng.
- [ ] Có ≥3 cột dùng ENUM (status field).
- [ ] Có ≥3 constraint UNIQUE ngoài PK (VD: `Candidate.email UNIQUE`).
- [ ] Có ghi rõ ON DELETE / ON UPDATE.
- [ ] Không có bảng "orphan" (bảng không có quan hệ nào).

### Data Dictionary
- [ ] Đủ mọi bảng.
- [ ] Mỗi field có: tên, kiểu, null?, default, mô tả, ràng buộc.
- [ ] Có ≥2 comment "ghi chú thiết kế" cho các field đặc biệt (VD: "cached, sync lại khi FeedbackCriterion thay đổi").

---

## 8. Phối hợp cụ thể với từng người

### Với A (Requirements)
- **C nhận từ A:** Entity list, business rules ràng buộc dữ liệu.
- **C đưa lại A:** Danh sách entity C thêm mà A chưa mention (VD: `AuditLog`, `Notification`) — A không cần viết UC nhưng cần biết để không sốc khi review.
- **Xung đột thường gặp:** A viết UC dùng thuộc tính `Candidate.experience` nhưng C thấy khó chuẩn hóa (kinh nghiệm dạng text hay dạng năm?). Cần thống nhất: dùng `years_of_experience INT` + `experience_summary TEXT`.

### Với B (Behavior)
- **C nhận từ B:** State list (để làm ENUM), tên service (để biết ranh giới persist vs runtime).
- **C đưa lại B:** Cột enum đã đặt tên → B dùng cùng tên trong sequence.
- **Xung đột thường gặp:** B vẽ sequence có service "InterviewScheduler" nhưng C không có bảng nào tương ứng. Đây là bình thường — service không nhất thiết map 1-1 với bảng. Nhưng C nên đảm bảo mọi *action persist* của service đó có bảng đích trong ERD.

### Với D (Design)
- **C đưa cho D:** ERD hoàn chỉnh → D quyết định chọn DB nào (PostgreSQL vì có ENUM và JSONB tốt).
- **C nhận từ D:** Xác nhận kiến trúc D dự định (VD: có Redis cache thì C có thể bớt index; có read replica cho reporting thì C cần thiết kế index báo cáo riêng).

---

## 9. Sai lầm cần tránh

- **Nhầm Class Diagram với ERD** — viết `VARCHAR(255)` trong class diagram là sai. Class diagram dùng `String`.
- **Domain Model có method** — sai. Domain model chỉ có association, không method.
- **N-N không giải quyết trong ERD** — phải có bảng trung gian.
- **Cột `status` là VARCHAR** — nên là ENUM để B rule enforce ở DB layer.
- **Đặt tên field kiểu Việt-Anh trộn** — `Candidate.hoTen` là sai, phải chọn 1 ngôn ngữ và giữ nhất quán.
- **Không có timestamp `created_at`, `updated_at`** — mọi bảng nên có, đặc biệt khi có AuditLog.
- **Reference vòng** — VD: `User.department_id` FK sang `Department`, `Department.manager_id` FK sang `User`. Cần cho phép NULL ở ít nhất 1 đầu để insert đầu tiên.
- **Không tách bảng trung gian ra khỏi bảng chính** — VD: nhét `interviewer_ids` dạng JSON trong bảng `Interview` là sai chuẩn hóa.

---

## 10. Câu hỏi bảo vệ có thể bị hỏi

- Vì sao chọn PostgreSQL, không phải MongoDB / MySQL?
- Bảng `Application` chuẩn hóa đến dạng nào?
- Nếu 1 ứng viên đổi email 3 lần thì lưu thế nào?
- Cột `parsed_profile JSON` có vi phạm 1NF không? Sao vẫn dùng?
- Khi Recruiter rời công ty (User.is_active = false), Application của người đó xử lý sao?
- Vì sao dùng surrogate key (id auto increment) thay vì natural key?

