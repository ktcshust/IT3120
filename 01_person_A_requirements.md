# Person A — Business Analyst / Requirements Owner

**Chương phụ trách:** Chương 1 + Chương 2 (~35% khối lượng viết)
**Vai trò phụ:** Team lead điều phối, duy trì glossary chung.

---

## 1. Deliverables cuối cùng

| # | Deliverable | Format | Ước lượng |
|---|---|---|---|
| A1 | Chương 1: Giới thiệu — bối cảnh, mục tiêu, phạm vi | Word/Doc, ~8 trang | Tuần 1 |
| A2 | Chương 2: Phân tích yêu cầu — actor, use case, business rule, đặc tả UC | Word/Doc, ~15-20 trang | Tuần 2-3 |
| A3 | Use Case Diagram tổng thể | draw.io / PlantUML | Cuối tuần 1 |
| A4 | 10-12 đặc tả use case theo mẫu (basic flow, alt flow, precondition, postcondition) | Word/Doc | Tuần 2 |
| A5 | Bảng Business Rules (BR-01 → BR-12+) | Word/Doc | Tuần 2 |
| A6 | Glossary / thuật ngữ nghiệp vụ | Google Doc share | Duy trì suốt project |
| A7 | Báo cáo khảo sát hiện trạng (nếu có phỏng vấn HR) | Word, ~3 trang | Tuần 1 |

---

## 2. Task breakdown theo tuần

### Tuần 1 — Khảo sát & định hình yêu cầu

**Đầu tuần:**
- [ ] Đọc kỹ `spec_ats.md`, viết lại bằng ngôn ngữ của mình để đảm bảo hiểu đúng.
- [ ] Điều phối buổi kickoff S1: chốt scope, tool, phân vai.

**Giữa tuần:**
- [ ] (Tùy chọn) Liên hệ phỏng vấn 1-2 HR/Recruiter (bạn học, người quen, cựu sinh viên) — hỏi 5 câu:
  1. Quy trình tuyển hiện tại có mấy vòng?
  2. Điểm đau lớn nhất khi tuyển?
  3. Ai duyệt mức lương? Có bao nhiêu cấp?
  4. Xếp lịch phỏng vấn hiện tại làm sao?
  5. Có đo time-to-hire không? Đo bằng gì?
- [ ] Viết Chương 1 (bối cảnh + mục tiêu + phạm vi + out-of-scope).
- [ ] Lập danh sách actor cuối cùng, chốt tên (Việt/Anh).

**Cuối tuần — Sync S2:**
- [ ] Trình bày: Actor list, Use Case list (chỉ tên UC, chưa detail), Use Case Diagram v1.
- [ ] Nhận feedback, chỉnh actor/UC list nếu cần.

**Output cuối tuần 1 (bắt buộc):**
- Chương 1 draft.
- Use Case Diagram v1 (file draw.io).
- Bảng liệt kê 12-15 UC (chỉ tên + actor + mô tả 1 dòng).

---

### Tuần 2 — Đặc tả use case & business rules

**Đầu tuần:**
- [ ] Viết đặc tả 5 UC ưu tiên trước (dùng cho B và C bắt đầu):
  - UC-01: Xếp lịch phỏng vấn
  - UC-02: Sàng lọc CV
  - UC-03: Ghi feedback
  - UC-04: Duyệt offer
  - UC-05: Xem báo cáo
- [ ] **Bàn giao sớm** 5 UC này cho B và C ngay khi xong, không đợi hết tuần.

**Giữa tuần:**
- [ ] Viết Business Rules BR-01 → BR-12 (dùng spec làm gốc, mở rộng nếu cần).
- [ ] Viết đặc tả các UC còn lại (nộp CV, đăng JD, quản lý user...).

**Cuối tuần — Sync S3 (Handoff quan trọng):**
- [ ] Bàn giao toàn bộ UC detail + Business Rules cho B, C, D.
- [ ] Xác nhận với C: **entity nào đã có tên chốt** để C bắt đầu ERD không phải đoán.
- [ ] Xác nhận với B: **UC nào cần vẽ sequence diagram** — chốt 3 UC.

**Output cuối tuần 2 (bắt buộc):**
- 10-12 UC đặc tả đầy đủ.
- Bảng Business Rules hoàn chỉnh.
- Glossary v1 (danh sách 20-30 thuật ngữ, có định nghĩa).

---

### Tuần 3 — Hoàn thiện Chương 2 & hỗ trợ

- [ ] Viết phần dẫn dắt của Chương 2 (giới thiệu phương pháp phân tích, cấu trúc mô tả UC).
- [ ] Rà soát toàn bộ đặc tả UC, đảm bảo:
  - Precondition/postcondition không mâu thuẫn.
  - Alternative flow đủ (mỗi UC ít nhất 1 alt flow).
  - Business rules được reference đúng mã.
- [ ] Hỗ trợ D làm mapping "UC → màn hình nào" cho phần wireframe.
- [ ] Cập nhật glossary khi B, C, D phát hiện thuật ngữ mới.

**Output cuối tuần 3:**
- Chương 2 v1 hoàn chỉnh.

---

### Tuần 4 — Integration & review

- [ ] Review chương của C: có UC nào entity không có trong ERD không? Có entity nào ERD có nhưng không UC nào dùng không?
- [ ] Sửa Chương 1 + 2 theo feedback nhóm.
- [ ] Đồng bộ số thứ tự UC, BR với các chương khác (B và C tham chiếu chéo).

---

### Tuần 5 — Slide & bảo vệ

- [ ] Làm slide phần Chương 1 + 2 (~5-7 slide).
- [ ] Tập trình bày phần của mình (~3-5 phút).
- [ ] Ôn tập câu hỏi có thể bị hỏi: xem `06_conventions_shared.md` mục "Câu hỏi bảo vệ".

---

## 3. Input cần từ ai

| Cần cái gì | Từ ai | Khi nào |
|---|---|---|
| Feedback về scope | Cả nhóm | S1 |
| Xác nhận actor list | Cả nhóm | S2 |
| Danh sách entity C dự kiến dùng | C | Đầu tuần 2 (để đồng bộ tên) |
| Feedback đặc tả UC | B, D | Sync S3 |

---

## 4. Output giao cho ai

| Giao cái gì | Cho ai | Khi nào | Vì sao họ cần |
|---|---|---|---|
| 5 UC ưu tiên (detail) | B | Đầu tuần 2 | B bắt đầu vẽ activity/sequence |
| 5 UC ưu tiên (detail) | C | Đầu tuần 2 | C hiểu entity behavior để thiết kế ERD |
| UC list + actor list | D | Cuối tuần 1 | D bắt đầu vạch cấu trúc màn hình |
| Toàn bộ UC + BR | B, C, D | Cuối tuần 2 (S3) | Input đầy đủ cho tất cả |
| Glossary | Cả nhóm | Liên tục | Đảm bảo dùng thuật ngữ nhất quán |

---

## 5. Tiêu chí "Done" cho từng deliverable

- **Chương 1:** đủ 5 mục (bối cảnh, vấn đề, mục tiêu, phạm vi, out-of-scope). Có ít nhất 1 đoạn về khảo sát thực tế (nếu có phỏng vấn).
- **Use Case Diagram:** có đủ 5 actor chính + 12-15 UC + ít nhất 3 quan hệ `<<include>>` hoặc `<<extend>>`.
- **Đặc tả UC:** mỗi UC có đủ 8 mục (ID, tên, actor, pre, post, trigger, basic flow, alt flow). Basic flow ít nhất 5 bước.
- **Business Rules:** ít nhất 12 rule, có ID rõ ràng, được ít nhất 1 UC reference.
- **Glossary:** ít nhất 20 thuật ngữ, mỗi thuật ngữ 1-2 câu định nghĩa.

---

## 6. Phối hợp cụ thể với từng người

### Với B (Behavior)
- **A cung cấp:** UC detail có basic flow rõ → B chuyển thành activity/sequence.
- **A cần từ B:** Nếu B thấy flow không rõ ràng hoặc thiếu case, ping A ngay để bổ sung UC.
- **Xung đột thường gặp:** B có thể thêm bước không có trong UC → A phải quyết định: sửa UC hay B bỏ bước đó.

### Với C (Data)
- **A cung cấp:** Entity xuất hiện trong UC (chỉ tên) + Business Rules ràng buộc dữ liệu.
- **A cần từ C:** Danh sách entity C dự kiến (để A đảm bảo mọi entity đều xuất hiện trong ít nhất 1 UC).
- **Xung đột thường gặp:** C có thể muốn thêm entity technical (VD: `AuditLog`, `Notification`) không có UC → A ghi nhận nhưng không cần viết UC cho chúng.

### Với D (Design)
- **A cung cấp:** UC + mapping "UC nào ứng với màn hình nào".
- **A cần từ D:** Sơ đồ màn hình để check xem có UC nào không có UI (missing) hoặc UI nào không phục vụ UC (thừa).
- **Xung đột thường gặp:** D muốn ghép nhiều UC vào 1 màn hình cho gọn → A cần confirm business logic cho phép.

---

## 7. Sai lầm cần tránh

- **Viết UC quá tổng quát** ("Người dùng đăng nhập") → thầy sẽ hỏi "đăng nhập bằng gì? có 2FA không?". Phải đặc tả cụ thể.
- **Business rule chung chung** ("Hệ thống phải bảo mật") → BR phải kiểm chứng được (VD: "Phiên đăng nhập hết hạn sau 30 phút không hoạt động").
- **Actor "System" xuất hiện quá nhiều** — chỉ dùng System khi có action tự động rõ ràng (cron, trigger). Đừng biến System thành "cái gì cũng System làm".
- **Không phân biệt UC và feature** — "Đăng ký ứng viên" là UC. "Có nút màu xanh" không phải UC.
- **Bỏ qua alternative flow** — chương 2 chỉ có basic flow là điểm trừ nặng, vì thầy sẽ hỏi "nếu ứng viên không xác nhận thì sao?".

