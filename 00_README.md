# Chia việc bài tập lớn — ATS mini
## Nhóm 4 người: A, B, C, D

---

## 1. Nguyên tắc chia việc

Bài tập lớn PTTKHT có 4 khối công việc **tương đối độc lập nhưng nối tiếp nhau**:
1. **Phân tích yêu cầu** (khảo sát → use case → business rule).
2. **Phân tích hành vi** (activity, state, sequence).
3. **Phân tích cấu trúc dữ liệu** (domain model, class, ERD).
4. **Thiết kế hệ thống** (kiến trúc, giao diện, NFR, slide bảo vệ).

Chia 4 người theo 4 khối này để không ai bị "kẹt" chờ người khác quá lâu, đồng thời mỗi người sở hữu 1 chương báo cáo → phần present cũng rõ ràng.

---

## 2. Phân vai tổng quan

| Người | Vai trò | Chương báo cáo | Phù hợp với ai |
|---|---|---|---|
| **A** | Business Analyst — Requirements Owner | Chương 1 + 2 | Người viết tốt, giao tiếp ổn, có thể phỏng vấn HR |
| **B** | Behavior / Process Analyst | Chương 3 | Người tư duy logic, thích quy trình, thạo UML |
| **C** | Data Architect | Chương 4 | Người thạo DB, hiểu quan hệ, biết chuẩn hóa |
| **D** | System & UI Designer + Team Lead demo | Chương 5 + 6 | Người thẩm mỹ, biết Figma/wireframe, sẽ dẫn demo |

**Team lead (điều phối chung):** đề xuất **A** vì có tầm nhìn tổng thể sớm nhất và là người phải giao tiếp nhiều nhất trong pha đầu. **D** đóng vai trò dẫn slide/demo cuối cùng.

---

## 3. Sơ đồ phụ thuộc (ai chờ ai)

```
      [A: Requirements]
       │        │        │
       ▼        ▼        ▼
   [B: Behavior]  [C: Data]   [D: UI Draft]
       │        │        │
       └────┬───┘        │
            ▼            │
       [C v2: ERD refine]│
            │            │
            └────────────┼────────▶ [D: Kiến trúc + Wireframe final]
                                          │
                                          ▼
                                  [Cả nhóm: Integration + Slide + Demo]
```

**Đường găng (critical path):** A → B → C → D. Nếu A trễ, toàn nhóm trễ. Ưu tiên push A hoàn thành sớm nhất.

---

## 4. Timeline tổng (5 tuần)

| Tuần | Milestone chính | Ai làm chính |
|---|---|---|
| Tuần 1 | Kickoff, chốt scope, A xong khảo sát + actor list + UC list | A (chính), B/C/D đọc spec, setup tool |
| Tuần 2 | A xong use case detail v1 + business rules. B/C/D bắt đầu song song | A + B + C + D |
| Tuần 3 | B xong activity/state v1, C xong ERD v1, D xong wireframe v1 | B + C + D |
| Tuần 4 | Cross-review, sửa v2, integration | Cả nhóm |
| Tuần 5 | Chốt báo cáo, làm slide, tập demo, bảo vệ | Cả nhóm |

Chi tiết theo ngày: xem `05_timeline_milestones.md`.

---

## 5. Sync points bắt buộc

Không cần họp mỗi ngày, nhưng **6 sync sau đây bắt buộc có đủ 4 người**:

| Sync | Thời điểm | Mục đích | Deliverable phải có sẵn |
|---|---|---|---|
| S1 — Kickoff | Đầu tuần 1 | Chốt scope, tool, phân vai | Đọc xong spec_ats.md |
| S2 — UC Review | Cuối tuần 1 | A trình bày use case list, cả nhóm góp ý | A: UC list + actor map |
| S3 — Handoff | Cuối tuần 2 | A bàn giao UC detail v1 cho B & C & D | A: 5-10 UC đặc tả đầy đủ, business rules |
| S4 — Cross-review | Cuối tuần 3 | B/C/D show diagram, review chéo | Mỗi người: bản v1 diagram của mình |
| S5 — Integration | Giữa tuần 4 | Ghép báo cáo, sửa mâu thuẫn | Bản draft chương của từng người |
| S6 — Dry run | Cuối tuần 4 / đầu tuần 5 | Tập bảo vệ, sửa slide | Slide draft, demo (nếu có) |

**Kênh liên lạc hàng ngày:** Discord/Zalo group. Ai bị chặn (blocker) phải ping trong ngày, không để qua đêm.

---

## 6. Cấu trúc thư mục dự án (đề xuất)

```
btl_pttkht_ats/
├── report/
│   ├── chapter_1_intro.md          (A)
│   ├── chapter_2_requirements.md   (A)
│   ├── chapter_3_behavior.md       (B)
│   ├── chapter_4_data.md           (C)
│   ├── chapter_5_design.md         (D)
│   ├── chapter_6_conclusion.md     (D + cả nhóm)
│   └── final_report.pdf
├── diagrams/
│   ├── A_use_case/
│   ├── B_activity/
│   ├── B_state/
│   ├── B_sequence/
│   ├── C_class/
│   ├── C_erd/
│   └── D_architecture/
├── wireframes/                      (D)
├── slides/
│   └── defense_slides.pptx
├── docs/
│   ├── spec_ats.md                  (gốc)
│   ├── glossary.md                  (A duy trì)
│   └── change_log.md                (cả nhóm)
└── tasks/
    └── (các file này)
```

---

## 7. Naming convention & rule chung

- **Use case:** `UC-01`, `UC-02`, ... đánh số theo thứ tự chốt ở S2.
- **Business rule:** `BR-01`, `BR-02`, ...
- **Actor:** viết hoa chữ đầu, thống nhất tên tiếng Việt hoặc tiếng Anh — **chốt ở S1**, không đổi giữa chừng.
- **Entity trong class/ERD:** PascalCase (`JobDescription`, `InterviewParticipant`) trong báo cáo; snake_case (`job_description`) trong SQL.
- **File diagram:** `<prefix>_<type>_<name>_v<version>.<ext>` — ví dụ `B_seq_schedule_interview_v2.drawio`.
- **Version:** mọi diagram/tài liệu quan trọng đánh v1, v2... trong tên file, không ghi đè bản cũ.

---

## 8. Tool đề xuất (chốt ở S1)

| Loại | Lựa chọn A | Lựa chọn B | Ghi chú |
|---|---|---|---|
| Vẽ diagram | **draw.io** (miễn phí, dễ collab) | PlantUML (text-based, git-friendly) | Nên chọn 1, tránh mix |
| Báo cáo | **Google Docs** (dễ review chéo) | LaTeX/Overleaf | Google Docs an toàn hơn cho nhóm không quen LaTeX |
| Slide | Google Slides | PowerPoint | |
| Task tracking | **Notion** hoặc Trello | GitHub Projects | Cần cho tuần 4-5 khi nhiều task nhỏ |
| Version control | GitHub repo private | Google Drive folder | GitHub nếu có mã prototype; Drive nếu chỉ tài liệu |
| Wireframe | Figma (free tier) | Balsamiq / draw.io | Figma tốt nhất cho D |

---

## 9. Định nghĩa "Done"

Một task được coi là **Done** khi:
1. Có deliverable file cụ thể, upload lên nơi lưu chung.
2. Được **1 người khác trong nhóm review** (không phải người làm).
3. Đã chỉnh sửa theo comment reviewer.
4. Ghi vào `change_log.md`: ai làm, ngày xong, ai review.

Không có bước 2 → không được tính Done, kể cả đã xong bản viết.

---

## 10. Xử lý rủi ro

| Rủi ro | Xử lý |
|---|---|
| A không xong UC đúng hạn → B/C bị chặn | Bàn giao **UC ưu tiên** (5 UC cốt lõi) sớm ngay cuối tuần 1, phần còn lại làm song song |
| Diagram của B và ERD của C mâu thuẫn (VD: state trong sequence không khớp field trong ERD) | Sync S4 là điểm bắt buộc để phát hiện; sửa ngay trong tuần 4 |
| D không có input để làm kiến trúc | D có thể bắt đầu wireframe từ tuần 1 dựa trên UC list, không cần chờ toàn bộ |
| Một thành viên bận đột xuất | Task ưu tiên (đường găng) phải có người thứ hai backup — mặc định A backup B, C backup D và ngược lại |
| Bảo vệ bị hỏi câu ngoài chương của mình | Mỗi người phải đọc ít nhất 1 lần chương của người khác trước S6 |

---

## 11. Điểm cần đọc tiếp

- `01_person_A_requirements.md` — task chi tiết của A
- `02_person_B_behavior.md` — task chi tiết của B
- `03_person_C_data.md` — task chi tiết của C
- `04_person_D_design.md` — task chi tiết của D
- `05_timeline_milestones.md` — timeline chi tiết theo ngày
- `06_conventions_shared.md` — quy ước chung sâu hơn

