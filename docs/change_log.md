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

2026-08-17 | Nhóm | Chốt bản chính thức của Chương 3-6 là report/chapter_3_behavior.md (B), report/chapter_4_data.md (C), report/chapter_5_design.md và report/chapter_6_conclusion.md (D). docs/chapter-A.docx giữ vai trò Chương 1-2 + phụ lục. | Ảnh hưởng: A, B, C, D [quyết định của nhóm]

2026-08-17 | B (sửa lỗi render) | diagrams/B_seq_offer_approval_v1.md dòng 78: đổi dấu chấm phẩy thành dấu phẩy trong nhãn "25a. Application=ACCEPTED; other apps=ON_HOLD (BR-10)". Dấu ; là ký tự kết thúc câu lệnh của Mermaid nên phần sau nó bị đọc thành một lệnh mới -> parse error. Hệ quả: SEQ-02 chưa từng render được và diagrams/rendered/ vẫn thiếu b-seq-offer-approval-v1-01.png, dù Chương 3 gọi SEQ-02 là "diagram phức tạp nhất, trọng tâm bảo vệ". Nội dung sơ đồ không đổi. | Ảnh hưởng: B (1 ký tự), D (ảnh render) [đã sửa và render lại thành công]

2026-08-17 | Nhóm | scripts/render_mermaid_D.py: dò đường dẫn Chrome theo hệ điều hành thay vì ghi cứng đường dẫn macOS (có thể ghi đè bằng biến CHROME_PATH), và giải đường dẫn npx bằng shutil.which vì trên Windows npx là npx.cmd nên subprocess không gọi trực tiếp được. Bổ sung report/chapter_3_behavior.md và report/chapter_4_data.md vào DEFAULT_SOURCES — 9 sơ đồ trong chính văn Chương 3 và Chương 4 trước đây không được render. Chạy lại toàn bộ: 32/32 sơ đồ thành công. | Ảnh hưởng: D (script), diagrams/rendered/ (24 ảnh render lại + 10 ảnh mới) [hoàn tất]

2026-08-17 | Nhóm | scripts/md_to_docx_D.py: khối ```mermaid nay được nhúng thẳng ảnh render từ diagrams/rendered/ (tra theo đúng quy ước tên <slug>-NN.png) thay vì chỉ chèn khung placeholder để người thật dán ảnh vào. Giữ hành vi cũ khi chưa có ảnh, và có cờ --no-images để quay lại hành vi cũ. | Ảnh hưởng: D (script), bản Word xuất ra [hoàn tất]

2026-08-17 | Nhóm | Thêm scripts/build_full_report.py và bản nộp docs/bao_cao_day_du_v1.docx: ghép docs/chapter-A.docx (bìa, mục lục, tóm tắt, Chương 1-2, phụ lục) với bốn chương Markdown của B, C, D thành một file Word duy nhất — 98 tiêu đề, 57 bảng, 21 ảnh, 15/15 sơ đồ Mermaid đã nhúng ảnh. Script bỏ phần phác Chương 3-6 còn sót trong docx (chỉ còn đoạn con trỏ) và chuẩn hoá 8 dòng mục lục vì số trang cũ không còn đúng. Việc số 4 trong docs/README_part_D.md mục "còn lại" (ghép docx + dán ảnh thủ công) nay đã tự động hoá. | Ảnh hưởng: cả nhóm [hoàn tất; số trang mục lục vẫn phải sinh lại trong Word]

2026-08-17 | Nhóm | Thực hiện việc A-05 của docs/handoff_D_to_ABC_v1.md: gỡ phần TRÙNG trong Chương 3-6 của docs/chapter-A.docx. Gỡ 7 sơ đồ (ACT-01, STATE-01, SEQ-01, SEQ-02, SEQ-03, Domain Model, kiến trúc logic) vì bản mới hơn đã có ở report/ và diagrams/rendered/; gỡ 6 bảng đụng số hiệu với bảng của B/C/D (Bảng 3.1, 4.1, 4.2, 5.1, 6.1, 6.2); gỡ Bảng 5.3 (6 màn) vì Bảng 5.91 của D phủ 11 màn SCR-01…SCR-11; gỡ 3 danh sách đã lỗi thời (ràng buộc & chỉ mục — thiếu attempt_no và UNIQUE(application_id, round_order) của schema v1.2; kiểm soát bảo mật & vận hành; tiêu chí nghiệm thu). Giữ nguyên đoạn dẫn của A ở mỗi chương, Bảng 5.2 (A là chủ sở hữu dải mã NFR-01…NFR-12) và phần Kết luận; mỗi chương được chèn một đoạn con trỏ tới file bản đầy đủ. Sửa 4 dòng mục lục vì số trang không còn đúng. File: 5.554 KB → 471 KB. | Ảnh hưởng: A (chapter-A.docx) [đã thực hiện, cần A rà lại khi mở bằng Word]
```

---

## Việc còn lại cần người thật xác nhận (không thể tự động hoá)

Các mục trên được phiên audit tự động sửa trực tiếp để có diff cụ thể, nhưng vẫn cần:

1. **A** xác nhận: số 24h (SLA), số 14 ngày (BR-13 hold timeout), đổi số UC-05→UC-06, và actor/role `HEAD_OF_HR` / `FINANCE` (có cần cập nhật Use Case Diagram không).
2. **C** (người thật) xác nhận: các thay đổi schema v1.1–v1.2 không phá vỡ giả định khác trong slide/demo của chính C.
3. **B** xác nhận: STATE-02 giả định "reschedule = update cùng dòng" vẫn đúng với UNIQUE mới.
4. Cả nhóm xác nhận quyết định Mermaid ở Sync S4.
5. Sau khi xác nhận, xoá tag "[cần xác nhận]" và tính Done theo `00_README.md` mục 9.
6. **A** mở lại `docs/chapter-A.docx` bằng Word sau đợt rút gọn ngày 2026-08-17 để: kiểm tra ngắt trang giữa các chương còn hợp lý không, và xử lý các việc A-01, A-02, A-04, A-06, A-07, A-09, A-10, A-11 trong `docs/handoff_D_to_ABC_v1.md` mục 3 — những việc này nằm ở Chương 1, Chương 2 và phụ lục nên **không** được đợt rút gọn đụng tới.
