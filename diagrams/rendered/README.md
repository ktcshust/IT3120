# Ảnh render của các sơ đồ Mermaid

*Sinh tự động bằng `scripts/render_mermaid_D.py` (Person D). Không sửa tay các file trong thư mục này — sửa sơ đồ ở file Markdown nguồn rồi chạy lại script.*

```bash
python3 scripts/render_mermaid_D.py
```

**Kết quả lần chạy gần nhất:** 32 sơ đồ render thành công.

| # | Ảnh | Loại sơ đồ | Caption / mục nguồn | File nguồn | Người vẽ |
|---|---|---|---|---|---|
| 1 | `b-act-recruitment-flow-v1-01.png` | `flowchart` | Diagram | `diagrams\B_act_recruitment_flow_v1.md` | Person B |
| 2 | `b-act-offer-approval-v1-01.png` | `flowchart` | Diagram | `diagrams\B_act_offer_approval_v1.md` | Person B |
| 3 | `b-state-application-v1-01.png` | `stateDiagram-v2` | Diagram | `diagrams\B_state_application_v1.md` | Person B |
| 4 | `b-state-interview-v1-01.png` | `stateDiagram-v2` | Diagram | `diagrams\B_state_interview_v1.md` | Person B |
| 5 | `b-seq-schedule-interview-v1-01.png` | `sequenceDiagram` | Diagram | `diagrams\B_seq_schedule_interview_v1.md` | Person B |
| 6 | `b-seq-offer-approval-v1-01.png` | `sequenceDiagram` | Diagram | `diagrams\B_seq_offer_approval_v1.md` | Person B |
| 7 | `b-seq-sla-feedback-v1-01.png` | `sequenceDiagram` | Diagram | `diagrams\B_seq_sla_feedback_v1.md` | Person B |
| 8 | `chapter-3-behavior-01.png` | `flowchart` | 3.2.4. Hình 3.1 — ACT-01 (rút gọn trong chính văn) | `report\chapter_3_behavior.md` | Nhóm |
| 9 | `chapter-3-behavior-02.png` | `flowchart` | 3.3.4. Hình 3.2 — ACT-02 (logic rút gọn) | `report\chapter_3_behavior.md` | Nhóm |
| 10 | `chapter-3-behavior-03.png` | `stateDiagram-v2` | 3.4.2. Hình 3.3 — STATE-01 | `report\chapter_3_behavior.md` | Nhóm |
| 11 | `chapter-3-behavior-04.png` | `sequenceDiagram` | 3.5.3. Hình 3.4 — SEQ-01 (cấu trúc chính) | `report\chapter_3_behavior.md` | Nhóm |
| 12 | `chapter-3-behavior-05.png` | `sequenceDiagram` | 3.6.3. Hình 3.5 — SEQ-02 (cấu trúc chính) | `report\chapter_3_behavior.md` | Nhóm |
| 13 | `chapter-3-behavior-06.png` | `sequenceDiagram` | 3.7.3. Hình 3.6 — SEQ-03 | `report\chapter_3_behavior.md` | Nhóm |
| 14 | `c-domain-model-v1-01.png` | `classDiagram` | Diagram | `diagrams\C_domain_model_v1.md` | Person C |
| 15 | `c-class-diagram-v1-01.png` | `classDiagram` | Diagram | `diagrams\C_class_diagram_v1.md` | Person C |
| 16 | `c-erd-v1-01.png` | `erDiagram` | Diagram | `diagrams\C_erd_v1.md` | Person C |
| 17 | `chapter-4-data-01.png` | `classDiagram` | Hình 4.1 — Domain Model (nguồn: `diagrams/C_domain_model_v1.md`) | `report\chapter_4_data.md` | Nhóm |
| 18 | `chapter-4-data-02.png` | `classDiagram` | Hình 4.2 — Class Diagram (nguồn: `diagrams/C_class_diagram_v1.md`, trích các class chính;  | `report\chapter_4_data.md` | Nhóm |
| 19 | `chapter-4-data-03.png` | `erDiagram` | Hình 4.3 — ERD tổng thể (nguồn đầy đủ: `diagrams/C_erd_v1.md`; DDL chạy được: `sql/schema. | `report\chapter_4_data.md` | Nhóm |
| 20 | `d-comp-architecture-v1-01.png` | `flowchart` | Hình 5.1 — COMP-01: Sơ đồ thành phần hệ thống ATS mini | `diagrams\D_comp_architecture_v1.md` | Person D |
| 21 | `d-comp-architecture-v1-02.png` | `flowchart` | Hình 5.9 — Chi tiết interface và port của cụm Offer trong COMP-01 | `diagrams\D_comp_architecture_v1.md` | Person D |
| 22 | `d-deploy-topology-v1-01.png` | `flowchart` | Hình 5.10 — DEP-01: Sơ đồ triển khai hệ thống ATS mini theo vùng mạng | `diagrams\D_deploy_topology_v1.md` | Person D |
| 23 | `chapter-5-design-01.png` | `flowchart` | Hình 5.1 — COMP-01: Sơ đồ thành phần hệ thống ATS mini (bản rút gọn) | `report\chapter_5_design.md` | Nhóm |
| 24 | `chapter-5-design-02.png` | `flowchart` | Hình 5.2 — DEP-01: Sơ đồ triển khai hệ thống ATS mini theo vùng mạng | `report\chapter_5_design.md` | Nhóm |
| 25 | `chapter-5-design-03.png` | `sequenceDiagram` | Hình 5.3 — Trình tự lấy khoá, kiểm tra chồng lấn, ghi và nhả khoá khi xếp lịch phỏng vấn | `report\chapter_5_design.md` | Nhóm |
| 26 | `chapter-5-design-04.png` | `flowchart` | Hình 5.4 — Luồng outbox: ghi nguyên tử trong transaction nghiệp vụ và gửi bất đồng bộ kèm  | `report\chapter_5_design.md` | Nhóm |
| 27 | `chapter-5-design-05.png` | `flowchart` | Hình 5.5 — User flow Recruiter: sàng lọc CV và xếp lịch phỏng vấn (UC-02 nối UC-01) | `report\chapter_5_design.md` | Nhóm |
| 28 | `chapter-6-conclusion-01.png` | `flowchart` | Hình 6.1 — Luồng demo sáu bước qua các màn hình SCR | `report\chapter_6_conclusion.md` | Nhóm |
| 29 | `readme-01.png` | `flowchart` | Hình 5.20 — Bản đồ màn hình toàn hệ thống, hai nhánh điều hướng tách rời | `wireframes\README.md` | Nhóm |
| 30 | `readme-02.png` | `flowchart` | Hình 5.21 — User flow A: Recruiter sàng lọc CV và xếp lịch phỏng vấn (UC-02 + UC-01) | `wireframes\README.md` | Nhóm |
| 31 | `readme-03.png` | `flowchart` | Hình 5.22 — User flow B: Interviewer ghi feedback theo scorecard (UC-03) | `wireframes\README.md` | Nhóm |
| 32 | `readme-04.png` | `flowchart` | Hình 5.23 — User flow C: tạo offer, duyệt nhiều cấp và phản hồi của ứng viên (UC-04 + UC-0 | `wireframes\README.md` | Nhóm |

## Dùng ảnh này ở đâu

| Nơi dùng | Cách dùng |
|---|---|
| Báo cáo Word | Chèn ảnh vào đúng vị trí khung `[Sơ đồ Mermaid — chèn ảnh render...]` do `scripts/md_to_docx_D.py` sinh ra. |
| Slide bảo vệ | Chèn trực tiếp; ảnh đã render ở tỷ lệ 2x nên không vỡ khi phóng to trên máy chiếu. |
| In A4 | Sơ đồ ngang quá khổ nên xoay ngang trang theo `06_conventions_shared.md` mục 7. |
