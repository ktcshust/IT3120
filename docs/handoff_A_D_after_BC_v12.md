# Handoff cho A & D — sau khi B/C xong v1.2

B và C đã có Chương 3–4 + diagram + schema. A và D **chưa** có deliverable trong repo.
File này không thay `01_person_A_requirements.md` / `04_person_D_design.md` — chỉ truyền **tinh thần + chỗ phải khớp**, để không làm lại lỗi B/C vừa vá.

Chi tiết thay đổi: `docs/change_log.md`. Spec gốc đã bump: `spec_ats (1).md` **v1.1**.

---

## Tinh thần chung (cả nhóm)

1. **Một nguồn sự thật** — số giờ, số UC, tên actor/role phải giống nhau giữa Chương 2 / 3 / 4 / 5. Lệch một chỗ là cả nhóm bị hỏi.
2. **Done = có file + 1 người khác review + ghi `change_log.md`** (`00_README.md` mục 9). Tự viết xong chưa đủ.
3. **Diagram dùng Mermaid được** (đã chốt). Activity nếu hội đồng đòi UML chuẩn thì cân nhắc PlantUML sau.
4. Đọc `change_log.md` trước khi bắt đầu — đừng viết theo bản spec cũ trong đầu.

---

## A — Requirements (Chương 1–2)

**Việc của bạn:** Actor, Use Case Diagram, đặc tả UC, Business Rules, glossary, Chương 1–2. Bạn là người **chốt ngôn ngữ nghiệp vụ** — B/C/D phải bám theo bạn.

### Phải xác nhận / phản ánh vào Chương 2 (đã sửa sẵn trong spec — cần A “ký”)

| Mục | Quyết định hiện tại | Việc A |
|---|---|---|
| SLA xác nhận lịch | **24h** (UC-01 A6.1 = BR-05) | Xác nhận; đừng để lại 48h trong UC |
| Đàm phán lương | **UC-06** (UC-05 = báo cáo) | Đặc tả đủ + Use Case Diagram có `<<extend>>` |
| Hold hết hạn | **BR-13** (ON_HOLD → REJECTED, giả định 14 ngày LV) | Chốt số ngày; ghi vào bảng BR |
| Actor duyệt offer | **Head of HR**, **Finance** (tách khỏi HR Admin) | Actor list + UC-04; C đã có role `HEAD_OF_HR` / `FINANCE` |

### Tinh thần viết UC / BR

- Mỗi UC: pre/post, basic ≥5 bước, **≥1 alt flow** — thầy hay hỏi “nếu không xác nhận / không phản hồi thì sao?”.
- BR phải **đo được** (“24h”, “7 ngày làm việc”), không viết “hệ thống phải nhanh/bảo mật”.
- Reference chéo: UC ghi mã BR; BR được ≥1 UC dùng.
- Actor **System** chỉ khi cron/tự động (SLA, expire offer) — đừng biến System thành “làm hết”.

### Đọc trước khi viết

- `spec_ats (1).md` v1.1 (đã vá)
- `report/chapter_3_behavior.md` Bảng 3.1 — xem B đã map UC/BR thế nào
- `docs/change_log.md` các dòng gắn A

### Output tối thiểu để B/C/D không bị chặn

Cuối tuần 2 / Sync S3: **5 UC ưu tiên đủ detail** (UC-01…05) + BR list + actor list. UC-06 nên có sớm vì B/C đã dùng tên đó.

---

## D — Design + Demo (Chương 5–6 + slide)

**Việc của bạn:** Component + Deployment, wireframe ≥8 màn, NFR, Chương 5–6, **lead slide & demo**. Không bắt buộc code app.

### Tinh thần kiến trúc

- **Component ≠ Deployment** — cái trước là module/service; cái sau là máy/container + protocol (HTTPS, TCP 5432…).
- Lifeline sequence của B ≈ tên component: `SchedulingService`, `OfferService`, `ApprovalWorkflow`, `SLAService`, `NotificationService`, `EscalationService`…
- C đã chọn PostgreSQL + gợi ý Redis lock lịch — Component/Deployment phải phản ánh, đừng vẽ Mongo “cho vui”.
- **6 role user:** Recruiter, Hiring Manager, Interviewer, HR Admin, Head of HR, Finance — wireframe / RBAC đừng chỉ vẽ 4 role cũ.
- Candidate **không** login nội bộ như User: portal + **email**; bảng `notifications` chỉ cho user nội bộ.

### Demo — đừng tham code

- **Đủ điểm:** Figma prototype click-through (hoặc walkthrough screenshot).
- HTML/React static chỉ khi còn thời gian thừa. Task guide đã cảnh báo: cố code thật dễ trễ slide.

### Wireframe tối thiểu (map UC)

Dashboard Recruiter · Kanban JD · Candidate Profile · Schedule Interview · Scorecard · Offer Wizard (có bước duyệt cấp 2/3) · Candidate Portal · Reports. Mỗi màn ghi UC nào phục vụ.

### Đọc trước khi vẽ

- Sequence B: `diagrams/B_seq_*.md`
- ERD + schema C: `diagrams/C_erd_v1.md`, `sql/schema.sql`
- Spec mục 11–13 (NFR, kiến trúc, màn hình)

### Tuần 5

Bạn điều phối slide + dry run. Mỗi chương ~5 phút; backup PDF slide + video demo phòng hỏng máy.

---

## Việc A & D phải làm ở Sync S4

| Ai | Việc |
|---|---|
| A | Xác nhận 24h / UC-06 / BR-13 / actor Head of HR + Finance; review Chương 3 khớp UC |
| D | So component với lifeline B; so DB với ERD C; mọi UC có ≥1 wireframe |
| Cả nhóm | Ghi kết quả vào `docs/change_log.md` rồi mới tính Done |

---

## Không làm gì

- Không viết lại spec theo bản nhớ cũ (48h, UC-05 = đàm phán lương, chỉ 4 role).
- Không mở rộng data/schema thêm (C đã chốt 18 bảng) trừ khi cả nhóm đồng ý.
- D không cần implement SQL/API — chỉ thiết kế và demo UI.

Hết. Chi tiết task theo tuần vẫn nằm ở `01_…` và `04_…`.
