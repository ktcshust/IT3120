# Quy ước chung & Checklist toàn nhóm

---

## 1. Quy ước đặt tên (chốt ở S1, không đổi giữa chừng)

### Ngôn ngữ
- **Báo cáo (chương):** tiếng Việt.
- **Diagram, code, database:** tiếng Anh (chuẩn nghiệp vụ IT).
- **Actor:** tiếng Việt trong báo cáo (VD: "Ứng viên"), tên Anh trong diagram (VD: "Candidate"). Bảng ánh xạ đặt trong glossary.

### Ký hiệu
| Thứ | Format | Ví dụ |
|---|---|---|
| Use case | `UC-XX` (2 chữ số) | `UC-01`, `UC-12` |
| Business rule | `BR-XX` | `BR-03` |
| Non-functional requirement | `NFR-XX` | `NFR-05` |
| Activity diagram | `ACT-XX` | `ACT-01` |
| State diagram | `STATE-XX` | `STATE-01` |
| Sequence diagram | `SEQ-XX` | `SEQ-02` |
| Component | PascalCase | `SchedulingService` |
| Table (DB) | snake_case | `interview_participant` |
| Entity (class diagram) | PascalCase | `InterviewParticipant` |
| Attribute (class) | camelCase | `scheduledAt` |
| Column (DB) | snake_case | `scheduled_at` |
| Constant / enum value | UPPER_SNAKE | `OFFER_PENDING` |

### File
- Diagram: `<owner>_<type>_<name>_v<ver>.<ext>` — `B_seq_offer_approval_v2.drawio`
- Báo cáo: `chapter_<n>_<slug>.md` — `chapter_3_behavior.md`
- Slide: `defense_slides_v<ver>.pptx`

---

## 2. Git / Drive workflow

Nếu dùng **GitHub**:
- Branch: `main` (protected), mỗi người 1 branch `feature/<name>-<what>` (VD: `feature/A-usecase-detail`).
- Merge qua PR, ít nhất 1 approve.
- Không commit trực tiếp lên main.

Nếu dùng **Google Drive**:
- Cấu trúc thư mục theo mục 6 của `00_README.md`.
- Không xóa file cũ — đổi tên thành `_archive_<date>` nếu không dùng nữa.
- Mọi file có phiên bản đánh vX trong tên.

---

## 3. Change log

Mọi thay đổi lớn (thêm/xóa UC, đổi tên entity, sửa business rule) phải ghi vào `docs/change_log.md`:

```
2026-08-05 | A | Đổi tên actor "HR Manager" → "Head of HR" | Ảnh hưởng: A, D
2026-08-06 | C | Bỏ bảng `Role`, gộp vào `User.role` enum | Ảnh hưởng: A (glossary), D (slide)
```

Thay đổi mà không ghi → người khác sẽ không biết và bị lệch.

---

## 4. Review chéo (cross-review) — bắt buộc

| Deliverable | Người làm | Người review chính |
|---|---|---|
| Chương 1-2 | A | B (rà logic UC), C (rà entity list) |
| Chương 3 (diagram hành vi) | B | A (rà khớp UC), C (rà khớp state = enum) |
| Chương 4 (data) | C | B (rà state), D (rà kiến trúc) |
| Chương 5 (design) | D | B (rà component = lifeline), C (rà DB) |
| Slide | D | Cả nhóm |

**Rule:** không có review chéo → không được tính Done.

---

## 5. Checklist review chéo

### Khi review Chương 2 (A)
- [ ] Actor list có bao nhiêu, có đúng vai trò trong Chương 3 và 5 không?
- [ ] Mỗi UC có precondition/postcondition không?
- [ ] Mỗi UC có ít nhất 1 alt flow không?
- [ ] Business Rules có được reference từ UC nào không?
- [ ] Tên entity trong UC có khớp Class Diagram của C không?

### Khi review Chương 3 (B)
- [ ] Activity có swimlane không? Có decision node không?
- [ ] State trong STATE-01 có khớp cột `status` trong ERD không?
- [ ] Sequence có message return không?
- [ ] Sequence có fragment (alt/opt/loop) không?
- [ ] Tên lifeline có khớp Component Diagram của D không?

### Khi review Chương 4 (C)
- [ ] Mọi entity trong UC của A có trong Class Diagram không?
- [ ] Class Diagram có datatype cụ thể không? Có method không?
- [ ] ERD có PK/FK/index đủ không?
- [ ] N-N đã tách bảng trung gian chưa?
- [ ] ENUM trong ERD có khớp state của B không?

### Khi review Chương 5 (D)
- [ ] Component Diagram có khớp lifeline sequence của B không?
- [ ] Deployment Diagram có protocol trên connection không?
- [ ] Mỗi UC có ít nhất 1 wireframe phục vụ không?
- [ ] NFR có định lượng không?

---

## 6. Câu hỏi bảo vệ dự kiến (chuẩn bị chung)

### Câu hỏi về scope & bối cảnh (A trả lời chính)
- Sao chọn đề tài này, không phải cái khác?
- Nếu công ty đã có LinkedIn Recruiter thì hệ thống này có cần không?
- Định nghĩa "time-to-hire" là gì?

### Câu hỏi về phân tích (A/B trả lời)
- UC nào là phức tạp nhất? Vì sao?
- Nếu ứng viên apply cùng lúc 3 JD thì xử lý sao?
- Business rule nào khó implement nhất?

### Câu hỏi về data (C trả lời chính)
- Sao chọn PostgreSQL?
- Nếu 10.000 CV/ngày thì DB có chịu nổi không?
- Cột JSON có vi phạm 1NF không?
- Recruiter rời công ty thì dữ liệu xử lý sao?

### Câu hỏi về kiến trúc (D trả lời chính)
- Modular monolith vs microservices — chọn cái nào và sao?
- Redis dùng làm gì?
- Nếu có tải cao thì scale theo chiều nào?
- Bảo mật thông tin ứng viên xử lý sao?

### Câu hỏi bẫy
- "Hệ thống của em khác gì Greenhouse / Lever?" → Điểm khác biệt: nội bộ, không SaaS, tuỳ biến sâu cho công ty IT Việt Nam, tích hợp SSO nội bộ.
- "Đây có phải AI không?" → Không. Nếu có làm F11 (match CV-JD) thì là AI-assisted, không AI-first.
- "Em nghĩ hệ thống này bán được không?" → Không phải mục tiêu của bài; mục tiêu là hệ thống nội bộ.

---

## 7. Nguyên tắc viết báo cáo

### Ngôi & giọng
- Dùng ngôi "chúng em" hoặc bị động ("Hệ thống được thiết kế..."), không dùng "tôi".
- Câu chủ động, ngắn gọn, không viết như văn nghị luận.

### Trình bày
- Mỗi hình có caption đầy đủ (Hình X.Y — Tên hình).
- Mỗi bảng có caption (Bảng X.Y — Tên bảng).
- Diagram lớn → xoay ngang trang.
- ERD/Class quá lớn → đưa vào phụ lục, chỉ show phần trọng tâm trong chính văn.

### Không viết
- Không viết "Chúng em sẽ..." (là báo cáo phân tích, không phải kế hoạch tương lai).
- Không copy nguyên spec — phải reword.
- Không dùng emoji, không dùng slang.

---

## 8. Backup & risk

- **Backup người:** mỗi nhiệm vụ đường găng phải có người thứ 2 nắm sơ.
- **Backup file:** báo cáo có bản PDF được export vào cuối tuần 4.
- **Backup slide:** slide có 2 bản: pptx và PDF.
- **Backup demo:** demo có 1 video record 3-5 phút phòng khi live demo lỗi.

---

## 9. Câu chốt trước bảo vệ (đọc trước 30 phút)

1. Chúng ta đã đọc đủ 4 chương ít nhất 1 lần chưa?
2. Có ai trong nhóm không hiểu 1 diagram của người khác không?
3. Có backup PDF slide chưa?
4. Đồng hồ ai giữ?
5. Ai trả lời câu hỏi thuộc chương nào — đã chốt chưa?

Nếu 5 câu trên đều "Rồi" → sẵn sàng.

