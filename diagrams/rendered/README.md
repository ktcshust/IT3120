# Ảnh render của các sơ đồ Mermaid

*Sinh tự động bằng `scripts/render_mermaid_D.py` (Person D). Không sửa tay các file trong thư mục này — sửa sơ đồ ở file Markdown nguồn rồi chạy lại script.*

```bash
python3 scripts/render_mermaid_D.py
```

**Kết quả lần chạy gần nhất:** 6 sơ đồ render thành công.

| # | Ảnh | Loại sơ đồ | Caption / mục nguồn | File nguồn | Người vẽ |
|---|---|---|---|---|---|
| 1 | `chapter-5-design-01.png` | `flowchart` | Hình 5.1 — COMP-01: Sơ đồ thành phần (bản rút gọn) | `report/chapter_5_design.md` | Nhóm |
| 2 | `chapter-5-design-02.png` | `flowchart` | Hình 5.2 — DEP-01: Sơ đồ triển khai theo vùng mạng | `report/chapter_5_design.md` | Nhóm |
| 3 | `chapter-5-design-03.png` | `sequenceDiagram` | Hình 5.3 — Trình tự lấy khoá, kiểm tra chồng lấn, ghi và nhả khoá | `report/chapter_5_design.md` | Nhóm |
| 4 | `chapter-5-design-04.png` | `flowchart` | Hình 5.4 — Luồng outbox và idempotency key | `report/chapter_5_design.md` | Nhóm |
| 5 | `chapter-5-design-05.png` | `flowchart` | Hình 5.5 — User flow Recruiter: UC-02 nối UC-01 | `report/chapter_5_design.md` | Nhóm |
| 6 | `chapter-6-conclusion-01.png` | `flowchart` | Hình 6.1 — Luồng demo sáu bước qua các màn hình SCR | `report/chapter_6_conclusion.md` | Nhóm |

## Dùng ảnh này ở đâu

| Nơi dùng | Cách dùng |
|---|---|
| Báo cáo Word | Chèn ảnh vào đúng vị trí khung `[Sơ đồ Mermaid — chèn ảnh render...]` do `scripts/md_to_docx_D.py` sinh ra. |
| Slide bảo vệ | Chèn trực tiếp; ảnh đã render ở tỷ lệ 2x nên không vỡ khi phóng to trên máy chiếu. |
| In A4 | Sơ đồ ngang quá khổ nên xoay ngang trang theo `06_conventions_shared.md` mục 7. |
