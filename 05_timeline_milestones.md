# Timeline chi tiết & Milestones

Kế hoạch 5 tuần (35 ngày). Điều chỉnh nếu deadline khác — chỉ cần giữ tỷ lệ.

---

## Bảng tổng quan

| Tuần | Ai làm chính | Milestone bắt buộc | Sync |
|---|---|---|---|
| 1 | A (dẫn) | UC list + actor + Chương 1 draft | S1 (đầu), S2 (cuối) |
| 2 | A | 5 UC ưu tiên detail + business rules | S3 (cuối) |
| 3 | B + C + D (song song) | Diagram v1 của B, C, D; wireframe v1 | S4 (cuối) |
| 4 | Cả nhóm | Chương v1 của mỗi người; integration | S5 (giữa) |
| 5 | D (dẫn slide) | Slide + demo + tập duyệt | S6 (cuối) |

---

## Timeline theo ngày

### Tuần 1 — Setup & Requirements khởi động

| Ngày | A | B | C | D |
|---|---|---|---|---|
| Ngày 1 (T2) | Tổ chức S1: kickoff, chốt scope, tool, phân vai | Đọc spec | Đọc spec | Đọc spec |
| Ngày 2 | Viết Chương 1 phần bối cảnh + mục tiêu | Ôn UML activity/state/sequence | Cài draw.io + dbdiagram.io, vẽ nháp domain model tay | Cài Figma, vẽ user flow tổng thể tay |
| Ngày 3 | (Optional) Phỏng vấn HR, viết khảo sát hiện trạng | Nắm UC list nháp của A, vẽ ACT-01 nháp tay | Đề xuất tên entity với A | Vẽ wireframe low-fi 2-3 màn (Dashboard, JD Detail) |
| Ngày 4 | Hoàn thiện Chương 1 draft + Actor list + UC list (12-15 UC, chỉ tên) | Chuẩn bị câu hỏi review UC | Ping A chốt tên entity | Wireframe low-fi thêm 2 màn |
| Ngày 5 (T6/T7) | Chuẩn bị S2 | | | |
| Cuối tuần | **Sync S2**: A trình UC list + actor + diagram. Cả nhóm review, chốt. | | | |

**Milestone tuần 1:**
- ✅ A: Chương 1 draft, Actor list chốt, UC list chốt, Use Case Diagram v1.
- ✅ B: Nắm UC list, ACT-01 draft giấy.
- ✅ C: Domain model nháp, danh sách entity chốt tên với A.
- ✅ D: 2-3 wireframe low-fi.

---

### Tuần 2 — Requirements deep + song song bắt đầu

| Ngày | A | B | C | D |
|---|---|---|---|---|
| Ngày 8 (T2) | Viết UC-01 (xếp lịch) + UC-02 (sàng lọc) chi tiết | Chờ UC-01 → bắt đầu SEQ-01 nháp | Domain Model đầy đủ trên tool | Wireframe low-fi màn 4-6 |
| Ngày 9 | Viết UC-03 (feedback) + UC-04 (offer) chi tiết | ACT-01 v1 trên tool | Class Diagram v1 (attribute + datatype) | Wireframe mid-fi Dashboard |
| Ngày 10 | Viết UC-05 (báo cáo) + các UC còn lại | STATE-01 v1 | Bắt đầu ERD (chuyển N-N thành bảng trung gian) | Wireframe mid-fi JD Detail |
| Ngày 11 | Business Rules BR-01 → BR-12 | SEQ-01 v1 | ERD tiếp: PK, FK, index | Wireframe mid-fi Scorecard |
| Ngày 12 (T6/T7) | Rà soát tất cả UC, chuẩn bị handoff | | | |
| Cuối tuần | **Sync S3 — Handoff**: A giao toàn bộ UC + BR cho B, C, D. Chốt 3 UC vẽ sequence. | | | |

**Milestone tuần 2:**
- ✅ A: 10-12 UC detail, BR list, Chương 2 draft.
- ✅ B: ACT-01 v1, STATE-01 v1, SEQ-01 v1.
- ✅ C: Domain Model final, Class Diagram v1, ERD in progress.
- ✅ D: 8 wireframe low-fi + 3-4 mid-fi.

---

### Tuần 3 — Deep work song song, hoàn thiện diagram

| Ngày | A | B | C | D |
|---|---|---|---|---|
| Ngày 15 (T2) | Viết mở đầu Chương 2, dẫn dắt phương pháp | ACT-02 (offer approval) | ERD v1 finish + Data Dictionary start | Wireframe mid-fi Offer Wizard |
| Ngày 16 | Rà soát UC vs ERD của C | SEQ-02 (offer approval, khó nhất) | Data Dictionary tiếp | Wireframe mid-fi Candidate Portal |
| Ngày 17 | Hỗ trợ D map UC → màn hình | SEQ-03 (SLA nhắc) | Chương 4 mở đầu | Wireframe high-fi 4 màn quan trọng nhất |
| Ngày 18 | Cập nhật Glossary | Viết diễn giải các diagram | Rà ERD với STATE-01 của B (khớp status enum?) | Component Diagram v1 |
| Ngày 19 | Chuẩn bị S4 | | | Deployment Diagram v1 |
| Ngày 20 (T7) | | | | |
| Cuối tuần | **Sync S4 — Cross-review**: B, C, D show diagram; A review UC bổ sung nếu cần. | | | |

**Milestone tuần 3:**
- ✅ A: Chương 2 v1 hoàn chỉnh.
- ✅ B: Tất cả 6 diagram v1 + Chương 3 draft.
- ✅ C: Class Diagram final, ERD v1, Data Dictionary v1, Chương 4 mở đầu.
- ✅ D: Component + Deployment diagram v1, 8 wireframe mid/high-fi.

---

### Tuần 4 — Integration, sửa v2, viết chương

| Ngày | A | B | C | D |
|---|---|---|---|---|
| Ngày 22 (T2) | Sửa Chương 1-2 theo feedback S4 | Sửa diagram theo feedback | Sửa ERD theo feedback | Sửa kiến trúc theo feedback |
| Ngày 23 | Review Chương 4 của C | Viết diễn giải sequence chi tiết | Viết normalization analysis | Viết Chương 5 mục 5.1 (kiến trúc tổng thể) |
| Ngày 24 | Review Chương 3 của B (rà mismatch) | Viết diễn giải activity + state | Hoàn thiện Data Dictionary | Viết Chương 5 mục 5.2 + 5.3 |
| Ngày 25 | Duy trì Glossary final | Chương 3 final | Chương 4 final | Chương 5 mục 5.4 (NFR) + bắt đầu prototype |
| Ngày 26 | Tổng rà soát Chương 1-2 | | | Prototype (Figma) |
| Ngày 27 (T7) | | | | |
| Cuối tuần / giữa tuần | **Sync S5 — Integration**: ghép báo cáo, sửa mâu thuẫn, chốt version. | | | |

**Milestone tuần 4:**
- ✅ Tất cả 4 chương v2 (chỉnh sau S4).
- ✅ Báo cáo được ghép, đọc từ đầu đến cuối 1 lần.
- ✅ Prototype/demo sẵn sàng.

---

### Tuần 5 — Slide, demo, bảo vệ

| Ngày | A | B | C | D |
|---|---|---|---|---|
| Ngày 29 (T2) | Slide Chương 1-2 (5-7 slide) | Slide Chương 3 (5-6 slide) | Slide Chương 4 (4-5 slide) | Slide template + Slide Chương 5 (7 slide) |
| Ngày 30 | Tập nói phần của mình | Tập nói | Tập nói | Slide demo screenshot, Chương 6 |
| Ngày 31 | Ôn câu hỏi bảo vệ | Ôn | Ôn | Backup slide PDF |
| Ngày 32 | | | | **Sync S6 — Dry run**: tập cả nhóm, đo giờ, sửa slide dài |
| Ngày 33 | Sửa slide theo feedback dry run | Sửa | Sửa | Sửa + test máy present |
| Ngày 34 | | | | Chuẩn bị máy demo, backup mạng |
| Ngày 35 | **Bảo vệ** | | | |

**Milestone tuần 5:**
- ✅ Slide 25-30 trang final.
- ✅ Demo/prototype chạy trên máy present.
- ✅ Đã dry run ít nhất 1 lần đủ nhóm.

---

## Đường găng (Critical Path) — không được trễ

```
A: UC list (cuối T1) ──▶ A: 5 UC detail (đầu T2) ──▶ B/C bắt đầu ──▶ B/C v1 (cuối T3) ──▶ Integration (T4) ──▶ Slide (T5)
```

**Nếu A trễ 1 ngày ở milestone "5 UC detail":** cả B và C bị chặn 1 ngày → nhóm mất 2 người-ngày → khó bù kịp trong 5 tuần.

**Nếu B/C/D trễ ở milestone cuối tuần 3:** integration tuần 4 bị dồn → dễ mắc lỗi mâu thuẫn không kịp sửa.

---

## Buffer & xử lý trễ

- Mỗi tuần có 1-2 ngày cuối tuần dùng làm buffer.
- Nếu trễ 1 ngày ở milestone: **báo trong group ngay**, không giấu.
- Backup pair (mặc định A↔B, C↔D): nếu 1 người bận đột xuất, người kia takeover phần ưu tiên.

---

## Rule "no surprise before defense"

Từ đầu tuần 5 trở đi:
- Không thêm feature mới vào báo cáo.
- Không đổi kiến trúc.
- Không đổi tên entity/UC.
- Chỉ sửa lỗi typo, format, và câu chữ.

Vi phạm rule này = tự sinh lỗi mâu thuẫn không kịp fix.

