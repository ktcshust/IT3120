# Change Log

Định dạng theo `06_conventions_shared.md` mục 3:

```
YYYY-MM-DD | Người | Nội dung | Ảnh hưởng
```

Các thay đổi mang tag **[cần xác nhận]** đã được sửa trực tiếp trong tài liệu để nhóm có bản
diff cụ thể để duyệt nhanh ở Sync S4, nhưng **chưa được A/C ký xác nhận chính thức** — theo đúng
`06_conventions_shared.md` §4, không có review chéo thì không tính Done.

---

```
2026-08-06 | B | Đồng bộ SLA xác nhận lịch UC-01 A6.1 (48h → 24h, khớp BR-05). Trước đó spec_ats.md tự mâu thuẫn: UC-01 A6.1 ghi 48h, BR-05 ghi 24h, trong khi mọi diagram của B (STATE-01, SEQ-01) đã ngầm dùng 24h. | Ảnh hưởng: A (spec_ats.md) [cần xác nhận]

2026-08-06 | B | Đổi UC tham chiếu trong UC-04 A6.1 từ "UC-05 Đàm phán lương" thành "UC-06 Đàm phán lương" + thêm đặc tả rút gọn UC-06. UC-05 đã được dùng cho "Xem báo cáo tuyển dụng" nên bị trùng số. | Ảnh hưởng: A (spec_ats.md), B (Bảng 3.1, chapter_3_behavior.md) [cần xác nhận]

2026-08-06 | B | Thêm BR-13 (Application ON_HOLD quá 14 ngày làm việc hoặc JD đóng trong lúc hold → tự REJECTED) làm cơ sở cho transition `ON_HOLD → REJECTED` vốn đã có trong STATE-01 nhưng chưa có rule gốc. | Ảnh hưởng: A (spec_ats.md, mục Business Rules), C (nên rà lại service logic liên quan ON_HOLD) [cần xác nhận số ngày 14]

2026-08-06 | B | Thêm Bảng 3.1b đối chiếu 2 chiều `application_status` ↔ `offer_status` trong report/chapter_3_behavior.md — 2 enum độc lập mô tả cùng giai đoạn offer nhưng khác tên, trước đây không có bảng ánh xạ nào. | Ảnh hưởng: C (offer_status), D (component sẽ tiêu thụ cả 2 enum) [đã hoàn tất, không cần sửa code]

2026-08-06 | B | Thêm STATE-02 — vòng đời `Interview` (`interview_status`: SCHEDULED/COMPLETED/CANCELLED/NEED_RESCHEDULE) tại diagrams/B_state_interview_v1.md. Trước đây chỉ Application có state diagram, Interview thì chưa dù có enum riêng trong schema. | Ảnh hưởng: C (interview_status), D (Component Diagram) [cần C xác nhận giả định "reschedule = update cùng dòng"]

2026-08-06 | C (theo đề nghị của B) | sql/schema.sql: thêm cột `offer_approvals.attempt_no` và `offers.current_approval_attempt`; đổi `UNIQUE(offer_id, level)` thành `UNIQUE(offer_id, level, attempt_no)`. Lý do: constraint cũ chặn đúng cơ chế "duyệt lại từ cấp 1 sau Request Change" (UC-04 A4.1) mà ACT-02/SEQ-02 của B thiết kế và data_dictionary_C.md mục 14 mô tả. | Ảnh hưởng: C (schema.sql, data_dictionary_C.md), B (SEQ-02 không đổi logic, chỉ đổi tầng lưu trữ) [cần C xác nhận]

2026-08-06 | C (theo đề nghị của B) | sql/schema.sql: thêm `UNIQUE(application_id, round_order)` vào bảng `interviews`. Lý do: không có ràng buộc này thì DB cho phép 2 dòng interview cùng vòng cho cùng application, mâu thuẫn với giả định "reschedule = update cùng dòng" trong STATE-02 mới. | Ảnh hưởng: C (schema.sql, data_dictionary_C.md) [cần C xác nhận]

2026-08-06 | Team | Chốt chính thức: chấp nhận Mermaid tương đương PlantUML cho diagram (00_README.md mục 8) vì B đã dùng Mermaid cho toàn bộ Chương 3 và tool này git-friendly như PlantUML. Lưu ý kèm theo: Mermaid flowchart không có fork/join + swimlane chuẩn UML như PlantUML thật, cân nhắc vẽ lại ACT-01/ACT-02 bằng PlantUML nếu cần đúng ký hiệu UML nghiêm ngặt khi bảo vệ. | Ảnh hưởng: B, D (nếu D cũng dùng Mermaid cho Component/Deployment Diagram) [quyết định của nhóm, không cần A/C duyệt riêng]

2026-08-06 | C | Thêm HEAD_OF_HR, FINANCE vào user_role + subtype Class Diagram (HeadOfHR, Finance). Trước đó chỉ 4 role — không khớp BR-08 / ACT-02 / SEQ-02 (cấp duyệt 2 và 3). HR_ADMIN giữ vai trò cấu hình, không gộp với Head of HR. | Ảnh hưởng: A (actor list), B (SEQ-02), D (RBAC) [cần A xác nhận tên actor]

2026-08-06 | C | Đồng bộ ERD / Class / Domain / Bảng 4.2 / kết luận Chương 4 với schema v1.1 (attempt_no, UNIQUE interview round) và v1.2. | Ảnh hưởng: diagrams/C_*.md, report/chapter_4_data.md [hoàn tất]

2026-08-06 | C | Bổ sung BR-05, BR-12, BR-13 vào Bảng 4.1 ánh xạ BR → constraint. | Ảnh hưởng: report/chapter_4_data.md [hoàn tất]

2026-08-06 | C | Thêm bảng application_status_history (append-only) phục vụ time-in-stage + audit chuyển trạng thái Application; cập nhật Domain/Class/ERD/dictionary. Số bảng: 17 → 18. | Ảnh hưởng: schema, B (có thể tham chiếu khi giải thích STATE-01), D (reporting) [hoàn tất kỹ thuật]

2026-08-06 | C | Làm rõ quy ước timestamp: bảng append-only không bắt buộc updated_at; Candidate không có hàng notifications (chỉ email). Bỏ Candidate.linkEmail() khỏi Class vì chưa có bảng đa email. | Ảnh hưởng: ERD ghi chú, Class Diagram [hoàn tất]
```

---

## Việc còn lại cần người thật xác nhận (không thể tự động hoá)

Các mục trên được phiên audit tự động sửa trực tiếp để có diff cụ thể, nhưng vẫn cần:

1. **A** xác nhận: số 24h (SLA), số 14 ngày (BR-13 hold timeout), đổi số UC-05→UC-06, và actor/role `HEAD_OF_HR` / `FINANCE` (có cần cập nhật Use Case Diagram không).
2. **C** (người thật) xác nhận: các thay đổi schema v1.1–v1.2 không phá vỡ giả định khác trong slide/demo của chính C.
3. **B** xác nhận: STATE-02 giả định "reschedule = update cùng dòng" vẫn đúng với UNIQUE mới.
4. Cả nhóm xác nhận quyết định Mermaid ở Sync S4.
5. Sau khi xác nhận, xoá tag "[cần xác nhận]" và tính Done theo `00_README.md` mục 9.
