# Bộ wireframe hệ thống ATS mini — SCR-01…SCR-11

*Người phụ trách: D — System & UI Designer + Demo Lead. Tài liệu này là deliverable **D5**, phục vụ
mục 5.3 (Thiết kế giao diện) của Chương 5 và phần demo của Chương 6. Nội dung bám nguyên vẹn danh
mục màn hình đã chốt, ma trận RBAC và bộ dữ liệu mẫu trong hợp đồng thiết kế của D; mọi tên
component, mã NFR, mã ADR được giữ nguyên, không phát sinh mã mới.*

| Mục | Giá trị |
|---|---|
| Mã deliverable | D5 |
| Phiên bản | v1.0 |
| Ngày phát hành | 16/08/2026 |
| Đầu vào đã đối chiếu | `spec_ats (1).md` v1.1; `report/chapter_3_behavior.md` v1.1 (B); `report/chapter_4_data.md` v1.2 và `sql/schema.sql` v1.2 (C); `docs/handoff_A_D_after_BC_v12.md` |
| Đầu ra liên quan | `wireframes/README.md` (screen map, user flow, design system), `report/chapter_5_design.md`, `prototype/index.html` |
| Trạng thái review chéo | Chưa review — cần B rà lifeline và C rà tên bảng trước khi tính Done theo `06_conventions_shared.md` mục 4 |

---

## 0. Phạm vi, công cụ và quy ước đọc wireframe

### 0.1. Vì sao wireframe được thể hiện bằng ASCII thay vì Figma

Bảng phân công ở `04_person_D_design.md` gợi ý dựng wireframe trên Figma. Trong điều kiện làm việc
hiện tại, toàn bộ tài liệu của nhóm được quản lý bằng Git dưới dạng văn bản thuần (quy ước
`06_conventions_shared.md` mục 2), nên wireframe được vẽ bằng ký tự khung trong khối `text`. Cách làm
này được chọn vì ba lý do, và cũng có ba điểm phải chấp nhận đánh đổi:

| Được | Mất |
|---|---|
| Diff được theo từng dòng, review chéo trực tiếp trên pull request | Không mô phỏng được màu sắc, bóng đổ, kích thước pixel thật |
| Không phụ thuộc tài khoản hay đường truyền khi bảo vệ (đúng tinh thần ADR-12) | Không click-through được — phần đó do prototype `prototype/index.html` đảm nhiệm |
| Ép người thiết kế mô tả bằng nhãn thật và dữ liệu thật, khó "vẽ đẹp mà rỗng" | Tốn công căn khung; mỗi lần đổi nhãn phải căn lại |

Độ trung thực về mặt thị giác được bù bằng `wireframes/README.md` (bảng màu, thang chữ, khoảng cách,
thư viện thành phần) và bằng prototype tĩnh dùng khi demo.

### 0.2. Quy ước đánh số hình và bảng

Các deliverable khác của D đã chiếm sẵn một số dải số trong Chương 5, và mỗi số chỉ được mang đúng
một nội dung trong toàn bộ phần việc của D: `report/chapter_5_design.md` dùng Hình 5.1–5.8 và
Bảng 5.1–5.11; `diagrams/D_comp_architecture_v1.md` dùng Hình 5.1 và 5.9, Bảng 5.2–5.4 cùng
Bảng 5.20–5.22; `diagrams/D_deploy_topology_v1.md` dùng Hình 5.10 và Bảng 5.12–5.19;
`docs/nfr_detail_D.md` dùng 5.30–5.46; `docs/design_decisions_D.md` dùng 5.50–5.57;
`wireframes/README.md` dùng Hình 5.20–5.23 và Bảng 5.90–5.108; `docs/traceability_matrix_D.md` dùng
Bảng 5.110–5.119 và giữ trống dải Hình 5.110 trở lên. Để không giẫm số khi ghép vào bản báo
cáo cuối, toàn bộ hình và bảng của bộ wireframe được đánh số **từ 5.60 trở đi**: Hình 5.60–5.85 và
Bảng 5.60–5.74.

Bản kê dải số ngay trên đây là bản kê chuẩn cho toàn bộ phần việc của D; khi thêm hình hoặc bảng mới
vào bất kỳ tệp nào, phải mở rộng dải của chính tệp đó và cập nhật lại bản kê này, không lấn sang dải
của tệp khác.

### 0.3. Ba mức độ chi tiết

| Mức | Ý nghĩa | Áp dụng cho |
|---|---|---|
| low-fi | Chỉ bố cục khối và nhãn chính; chi tiết còn chờ chốt nghiệp vụ | SCR-01, SCR-11 |
| mid-fi | Đủ nhãn nút, nhãn cột, quy tắc hiển thị; chưa cố định vi tương tác | SCR-04, SCR-08, SCR-09, SCR-10 |
| high-fi | Đủ dữ liệu mẫu, đủ trạng thái, đủ thông báo lỗi, sẵn sàng dựng prototype | SCR-02, SCR-03, SCR-05, SCR-06, SCR-07 |

Năm màn được đẩy lên high-fi là năm màn mang tải nghiệp vụ nặng nhất và cũng là những màn được hỏi
nhiều nhất khi bảo vệ: khối lượng việc hằng ngày của Recruiter, pipeline (BR-02, BR-04), chống trùng
lịch (BR-03, BR-26), scorecard (BR-06, BR-07) và chuỗi duyệt offer (BR-08, BR-09).

### 0.4. Quy ước ký hiệu trong khối ASCII

Bảng 5.60 liệt kê các ký hiệu dùng lại trong toàn bộ 25 khối wireframe; người dựng giao diện chỉ cần
đọc bảng này một lần là đọc được mọi hình phía sau.

| Ký hiệu | Ý nghĩa |
|---|---|
| `[ Nhãn ]` | Nút bấm; nhãn bên trong là nhãn thật sẽ xuất hiện trên giao diện |
| `[ Nhãn ]*` | Nút đang bị vô hiệu hoá tại trạng thái đang vẽ |
| `( ) / (o)` | Radio chưa chọn / đã chọn |
| `[ ] / [x]` | Checkbox chưa tích / đã tích |
| `[.......]` | Ô nhập văn bản một dòng |
| `v` cuối ô | Danh sách thả xuống |
| `>` đầu dòng | Mục điều hướng đang được chọn |
| `!` đầu dòng | Cảnh báo hoặc vi phạm quy tắc nghiệp vụ |
| `#` đầu dòng | Thông tin chỉ đọc do hệ thống sinh |
| `···` | Nội dung bị cắt bớt do giới hạn bề ngang của khối ASCII |

*Bảng 5.60 — Quy ước ký hiệu trong wireframe ASCII*

---

## 1. Danh mục màn hình và ánh xạ Use Case

Bảng 5.61 là bản chốt danh mục màn hình; đây cũng là bảng được gửi cho A để đối chiếu tiêu chí "mọi
UC có ít nhất một wireframe phục vụ" (`06_conventions_shared.md` mục 5). Mười một màn phủ đủ năm use
case trọng tâm UC-01…UC-05, phủ UC-06 ở nhánh counter-offer của SCR-09, và phủ thêm chức năng F09
nằm ngoài năm UC trọng tâm ở SCR-11 (ghi rõ theo mâu thuẫn X-07).

| Mã | Màn hình | Actor chính | UC phục vụ | Độ chi tiết | Số trạng thái vẽ |
|---|---|---|---|---|---|
| SCR-01 | Đăng nhập / SSO redirect | Cả 6 role nội bộ | Tiền đề mọi UC, NFR-04 | low-fi | 2 |
| SCR-02 | Dashboard | Recruiter là chính; các vai trò khác thấy biến thể | UC-01, UC-02, UC-03 (biến thể Interviewer), UC-06, F10 | high-fi | 2 |
| SCR-03 | JD Detail — Kanban Pipeline | Recruiter, Hiring Manager | UC-02 nối UC-01 | high-fi | 2 |
| SCR-04 | Candidate Profile và Timeline | Recruiter, Hiring Manager | UC-02, UC-03 (xem), UC-04 | mid-fi | 2 |
| SCR-05 | Schedule Interview (modal) | Recruiter | UC-01 | high-fi | 3 |
| SCR-06 | Scorecard | Interviewer | UC-03 | high-fi | 2 |
| SCR-07 | Offer Wizard 4 bước | Recruiter | UC-04, UC-06 | high-fi | 3 |
| SCR-08 | Offer Approval Inbox | Hiring Manager, Head of HR, Người duyệt Tài chính | UC-04 | mid-fi | 2 |
| SCR-09 | Candidate Portal | Candidate | UC-01, UC-04, UC-06 | mid-fi | 3 |
| SCR-10 | Reports Dashboard | HR Admin, Head of HR | UC-05 | mid-fi | 2 |
| SCR-11 | Admin — Users và Departments | HR Admin | F09 (ngoài 5 UC trọng tâm) | low-fi | 2 |

*Bảng 5.61 — Danh mục màn hình SCR-01…SCR-11 và ánh xạ Use Case*

---

## 2. Kịch bản dữ liệu mẫu xuyên suốt

Toàn bộ wireframe dùng chung một kịch bản duy nhất để người đọc theo dõi được một ứng viên đi hết
pipeline, thay vì mỗi màn một bộ dữ liệu rời rạc. Doanh nghiệp giả định là **Công ty CP Công nghệ Vạn
Xuân (VXTech)**, domain nội bộ `@vxtech.vn`. Sáu người dùng nội bộ, ba ứng viên và ba JD được lấy
nguyên từ bộ dữ liệu mẫu đã chốt.

Mỗi khối wireframe là một lát cắt tại một thời điểm; thời điểm đó luôn được in ở góc phải thanh trên.
Bảng 5.62 cho biết lát cắt nào rơi vào mốc nào của kịch bản.

| Mốc thời gian | Sự kiện | Màn hình chụp tại mốc này |
|---|---|---|
| 05/08/2026 | Hoàng Thị Mai Chi nộp hồ sơ vào JD-01 qua nguồn REFERRAL, tạo APP-1042 | — |
| 06/08/2026 09:12 | APP-1042 chuyển `SCREENING` | — |
| 07/08/2026 10:30 | APP-1042 được shortlist | — |
| 11/08/2026 14:00–15:00 | Vòng 1 `Technical Round 1`, INT-2078, người phỏng vấn Vũ Ngọc Lan | — |
| 12/08/2026 09:40 | Feedback vòng 1: HIRE, điểm 4,20 | — |
| 14/08/2026 09:00–10:00 | Ngô Phương Thảo phỏng vấn vòng 1 của JD-02 | — |
| 17/08/2026 10:00 | Quá 72 giờ chưa có feedback vòng 1 của Ngô Phương Thảo, hệ thống escalate | — |
| 17/08/2026 15:48 | Recruiter mở pipeline JD-01 | SCR-03 |
| 17/08/2026 15:52 | Recruiter xếp lịch vòng 2 cho APP-1042, gặp xung đột lịch | SCR-05 |
| 17/08/2026 16:00 | Gửi lời mời INT-2087, đặt hạn xác nhận 18/08/2026 16:00 theo BR-05 | — |
| 17/08/2026 16:40 | Recruiter quay lại bảng điều khiển | SCR-02 |
| 17/08/2026 21:18 | Ứng viên mở liên kết mời, xác nhận lịch | SCR-09 |
| 18/08/2026 10:15 | HR Admin mở báo cáo | SCR-10 |
| 18/08/2026 11:05 | HR Admin mở màn quản trị người dùng | SCR-11 |
| 20/08/2026 16:00–17:30 | Vòng 2 `System Design`, INT-2087 | — |
| 21/08/2026 09:15 | Vũ Ngọc Lan nhập scorecard vòng 2 ở dạng nháp | SCR-06 (trạng thái nháp) |
| 21/08/2026 11:40 | Gửi scorecard vòng 2 | — |
| 22/08/2026 11:40 | Scorecard bị khoá sau 24 giờ | — |
| 24/08/2026 10:00–11:00 | Vòng 3 `Culture Fit`, INT-2094 | — |
| 24/08/2026 15:10 | Recruiter tạo offer OFF-317 cho Ngô Phương Thảo, mức lương trong band | SCR-07 (trạng thái 1 cấp) |
| 25/08/2026 09:05 | Recruiter tạo offer OFF-318 cho Hoàng Thị Mai Chi, vượt band 15,0% | SCR-07 (trạng thái 3 cấp) |
| 25/08/2026 15:45 | Lê Thu Hà chọn `REQUEST_CHANGE` ở cấp 2, `attempt_no` tăng lên 2 | — |
| 26/08/2026 08:50 | Recruiter hạ mức lương còn 51.840.000 VND, vượt band 8,0%, gửi duyệt lại | SCR-07 (bước 4) |
| 26/08/2026 10:12 | Lê Thu Hà mở hộp duyệt offer | SCR-08 |
| 26/08/2026 14:30 | Ứng viên nhận offer, mở ô đề xuất thương lượng | SCR-09 (trạng thái offer) |
| 07/09/2026 17:00 | Hạn phản hồi offer theo BR-09 (7 ngày làm việc, đã trừ ngày lễ 02/09) | — |
| 15/09/2026 | Ngày dự kiến nhận việc ghi trên offer | — |

*Bảng 5.62 — Kịch bản dữ liệu mẫu xuyên suốt 11 màn hình*

Ba con số cần nói rõ là **giả định**, vì không có nguồn nghiệp vụ nào trong repo quy định: mức lương
55.200.000 VND của lần duyệt thứ nhất (dùng để minh hoạ nhánh ba cấp của BR-08), toàn bộ số liệu trên
bốn biểu đồ của SCR-10, và số lượng hồ sơ trên từng cột kanban của SCR-03. Các số còn lại đều suy ra
được từ band lương, từ BR-05, BR-06, BR-09 hoặc từ bộ dữ liệu mẫu đã chốt.

---

## 3. Khung bố cục dùng chung cho ứng dụng nội bộ

Chín trong mười một màn hình chạy trong `InternalWebApp` (C01) và dùng chung một khung: thanh bên
trái rộng 220px, thanh trên cố định, vùng nội dung co giãn. SCR-01 không có khung này vì người dùng
chưa được xác thực, còn SCR-09 dùng khung rút gọn của `CandidatePortalApp` (C02). Hình 5.60 mô tả
khung dùng chung đó.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  <breadcrumb: JD của tôi › JD-01 › Pipeline>                                       │
│              [ Tìm ứng viên, JD, mã offer ............. ]   Thông báo (3)   VI|EN   NMA v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ THANH ĐIỀU HƯỚNG   │ VÙNG NỘI DUNG — co giãn theo bề rộng cửa sổ, tối thiểu 1024px               │
│ rộng 220px         ├─────────────────────────────────────────────────────────────────────────────┤
│ ────────────────── │ Hàng 1: tiêu đề màn hình + nhóm nút hành động chính (căn phải)              │
│ Tối đa 6 mục,      │ Hàng 2: dải bộ lọc / tab (nếu màn có lọc)                                   │
│ dựng động theo     │ Hàng 3..n: nội dung chính — bảng, board, biểu mẫu hoặc biểu đồ              │
│ role đang đăng     ├─────────────────────────────────────────────────────────────────────────────┤
│ nhập (ma trận      │ Vùng thông báo hệ thống (toast) neo góc phải dưới, tự ẩn sau 6 giây;        │
│ RBAC — mục 9 hợp   │ lỗi chặn thao tác thì dùng dải cảnh báo cố định trên đầu vùng nội dung,     │
│ đồng thiết kế).    │ không dùng toast, để trình đọc màn hình kịp đọc (NFR-14).                   │
│ Mục không có       │                                                                             │
│ quyền thì KHÔNG    │                                                                             │
│ render, không chỉ  │                                                                             │
│ làm mờ (ADR-10).   │                                                                             │
│ ────────────────── │                                                                             │
│ Chân thanh: tên,   │                                                                             │
│ role, phòng ban,   │                                                                             │
│ [ Đăng xuất ]      │                                                                             │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.60 — Khung bố cục dùng chung của `InternalWebApp` (app shell)*

Ba quyết định bố cục đáng chú ý. Thứ nhất, thanh điều hướng được dựng động từ ma trận RBAC chứ không
dựng cứng rồi ẩn bớt: mục nào không có quyền thì không render, tránh việc người dùng đoán được cấu
trúc chức năng mình không được phép dùng. Thứ hai, ô tìm kiếm nằm ở thanh trên và luôn hiện, vì
Recruiter thao tác tìm ứng viên nhiều lần trong ngày. Thứ ba, mọi lỗi chặn thao tác đều hiển thị bằng
dải cảnh báo cố định thay vì toast tự tắt — toast tắt sau vài giây là bẫy quen thuộc với người dùng
bàn phím và người dùng trình đọc màn hình.

---

## 4. SCR-01 — Đăng nhập / SSO redirect

- **Actor:** cả 6 role nội bộ (Recruiter, Hiring Manager, Interviewer, HR Admin, Head of HR, Finance) | **UC phục vụ:** tiền đề của mọi use case, hiện thực hoá NFR-04 | **Độ chi tiết:** low-fi
- **Mục tiêu người dùng:** xác thực danh tính bằng tài khoản Google Workspace nội bộ để vào hệ thống với đúng vai trò và đúng phạm vi phòng ban.

**Wireframe — trạng thái mặc định**

Hình 5.61 vẽ trạng thái mặc định. Màn hình cố tình chỉ có **một** lối vào cho người dùng nội bộ là nút
SSO; không có ô mật khẩu nội bộ nào, đúng ADR-05 (mọi hệ thống ngoài đi qua cổng `IdentityPort`) và
NFR-04. Lối vào thứ hai dành cho ứng viên chỉ là một dòng chỉ dẫn, không phải biểu mẫu, vì theo ADR-09
ứng viên không phải một `User` và không đăng nhập.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS                                                                        VI | EN        │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                                  │
│                                                                                                  │
│                    ┌──────────────────────────────────────────────┐                              │
│                    │                                              │                              │
│                    │            VXTech ATS                        │                              │
│                    │   Hệ thống quản lý tuyển dụng nội bộ         │                              │
│                    │                                              │                              │
│                    │   ┌──────────────────────────────────────┐   │                              │
│                    │   │ [ Đăng nhập bằng tài khoản VXTech ]  │   │                              │
│                    │   │        (Google Workspace)            │   │                              │
│                    │   └──────────────────────────────────────┘   │                              │
│                    │                                              │                              │
│                    │   # Bạn sẽ được chuyển sang trang đăng       │                              │
│                    │   # nhập của Google Workspace, sau đó        │                              │
│                    │   # quay lại đây.                            │                              │
│                    │                                              │                              │
│                    │   ──────────────────────────────────────     │                              │
│                    │   Bạn là ứng viên?                           │                              │
│                    │   Hãy dùng liên kết cá nhân trong email      │                              │
│                    │   mời của VXTech. Cổng ứng viên không        │                              │
│                    │   dùng tài khoản và mật khẩu.                │                              │
│                    │   [ Gửi lại liên kết vào email của tôi ]     │                              │
│                    │                                              │                              │
│                    └──────────────────────────────────────────────┘                              │
│                                                                                                  │
│                                                                                                  │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS v1.0  ·  Hỗ trợ: hai.yen.do@vxtech.vn  ·  Trình duyệt hỗ trợ: Chrome, Edge, Firefox   │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.61 — SCR-01, trạng thái mặc định*

**Wireframe — trạng thái lỗi: tài khoản không còn hiệu lực**

Hình 5.62 vẽ trạng thái quay về từ `IdentityProvider` khi xác thực thành công nhưng bản ghi `users`
tương ứng có `is_active = false`. Đây là ranh giới quan trọng cần thể hiện trên giao diện: xác thực
(authentication) đã đạt, nhưng phân quyền (authorization) từ chối. Thông báo nêu đúng nguyên nhân và
đúng người cần liên hệ, không dùng câu chung chung kiểu "đã có lỗi xảy ra".

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS                                                                        VI | EN        │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                                  │
│                    ┌──────────────────────────────────────────────┐                              │
│                    │                                              │                              │
│                    │            VXTech ATS                        │                              │
│                    │                                              │                              │
│                    │  ┌────────────────────────────────────────┐  │                              │
│                    │  │ ! Không thể vào hệ thống               │  │                              │
│                    │  │                                        │  │                              │
│                    │  │ Tài khoản ngoc.lan.vu@vxtech.vn đã     │  │                              │
│                    │  │ được xác thực nhưng đang ở trạng thái  │  │                              │
│                    │  │ ngừng hoạt động.                       │  │                              │
│                    │  │                                        │  │                              │
│                    │  │ Mã lỗi: AUTH-403                       │  │                              │
│                    │  │ Thời điểm: 17/08/2026 08:02            │  │                              │
│                    │  │ Mã theo dõi: 7f2c-91ab                 │  │                              │
│                    │  │                                        │  │                              │
│                    │  │ Liên hệ HR Admin Đỗ Hải Yến            │  │                              │
│                    │  │ (hai.yen.do@vxtech.vn) để mở lại.      │  │                              │
│                    │  └────────────────────────────────────────┘  │                              │
│                    │                                              │                              │
│                    │   [ Thử lại với tài khoản khác ]             │                              │
│                    │                                              │                              │
│                    └──────────────────────────────────────────────┘                              │
│                                                                                                  │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS v1.0  ·  Hỗ trợ: hai.yen.do@vxtech.vn                                                 │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.62 — SCR-01, trạng thái lỗi tài khoản không còn hiệu lực*

**Thành phần chính**

Bảng 5.63 liệt kê thành phần của SCR-01. Màn này ít thành phần nhất trong cả bộ, nhưng lại là màn duy
nhất chạm trực tiếp vào `AuthService` (C04) và `IdentityAdapter` (C22).

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Thanh trên | Chuyển ngôn ngữ VI/EN | Ngôn ngữ đang chọn | Ghi vào `localStorage`; áp dụng cho cả trang lỗi (NFR-09) |
| Thẻ giữa | Nút SSO | "Đăng nhập bằng tài khoản VXTech" | Gọi luồng OIDC qua `IdentityAdapter` (C22) tới Google Workspace (NFR-04) |
| Thẻ giữa | Dòng giải thích chuyển hướng | Câu mô tả bước tiếp theo | Chỉ đọc; giảm hoang mang khi trình duyệt đổi domain |
| Thẻ giữa | Khối chỉ dẫn cho ứng viên | Câu hướng dẫn dùng liên kết trong email | Không phải biểu mẫu đăng nhập; ứng viên vào bằng magic link (ADR-09) |
| Thẻ giữa | Nút gửi lại liên kết | Ô email và nút gửi lại | Gọi `NotificationService` (C12) phát hành token mới hạn 7 ngày; giới hạn 3 lần trong 1 giờ theo địa chỉ email |
| Thẻ lỗi | Dải cảnh báo AUTH-403 | Email, mã lỗi, thời điểm, mã theo dõi, người liên hệ | Mã theo dõi chính là `correlationId` của NFR-13, giúp HR Admin tra `audit_logs` |
| Chân trang | Thông tin phiên bản và trình duyệt | Danh sách trình duyệt hỗ trợ | Khai báo phạm vi tương thích của NFR-14 |

*Bảng 5.63 — Thành phần chính của SCR-01*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **NFR-04** — toàn bộ đăng nhập nội bộ đi qua SSO OIDC, không có kho mật khẩu riêng của ứng dụng.
- **ADR-09** — ứng viên không phải `User`; màn này không cung cấp đường đăng nhập cho ứng viên.
- **ADR-10** — kết quả phân quyền được quyết ở tầng dịch vụ; giao diện chỉ phản ánh kết quả đó.
- **NFR-09** — nhãn và thông báo lỗi có đủ bản tiếng Việt và tiếng Anh.
- **NFR-13** — mọi lần đăng nhập hỏng đều kèm mã theo dõi để tra ngược log.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** không áp dụng — màn không hiển thị danh sách dữ liệu nào.
- **Đang tải:** sau khi bấm nút SSO, nút chuyển thành "Đang chuyển tới Google Workspace..." và bị vô hiệu hoá để chặn bấm hai lần; sau 10 giây chưa chuyển hướng thì hiện đường dẫn dự phòng dạng chữ.
- **Lỗi:** ba nhánh được phân biệt rõ — `AUTH-403` tài khoản ngừng hoạt động (Hình 5.62); `AUTH-401` xác thực thất bại tại IdP, đề nghị thử lại; `AUTH-503` không gọi được `IdentityProvider`, hiển thị "Hệ thống định danh đang không phản hồi" kèm mã theo dõi và không cho bấm lại trong 15 giây.

**Phân quyền**

Màn hình công khai với mọi người truy cập được mạng nội bộ. Sau khi xác thực, `AuthService` (C04) trả
về vai trò và phạm vi phòng ban; thanh điều hướng ở màn kế tiếp được dựng theo đúng ma trận RBAC.
Người có vai trò `INTERVIEWER` sau khi đăng nhập chỉ thấy hai mục điều hướng, người có vai trò
`HR_ADMIN` thấy đủ nhóm Quản trị.

**Ghi chú thiết kế**

Phương án bị loại là màn đăng nhập có cả ô email/mật khẩu nội bộ song song với nút SSO. Phương án đó
tiện khi demo nhưng tạo thêm một kho mật khẩu phải bảo vệ, mâu thuẫn với NFR-04 và làm phình bề mặt
tấn công. Đổi lại, khi `IdentityProvider` gặp sự cố thì không ai vào được hệ thống — rủi ro này được
chấp nhận và đối ứng bằng NFR-03 (mục tiêu khả dụng tính theo giờ hành chính) cùng cảnh báo của
NFR-13. Thông báo lỗi cố ý nêu đích danh email và người liên hệ thay vì che giấu, vì đây là hệ thống
nội bộ, người dùng đã được xác thực, nên việc lộ trạng thái tài khoản cho chính chủ không tạo thêm rủi
ro.

---

## 5. SCR-02 — Dashboard Recruiter

- **Actor:** Recruiter (Nguyễn Minh Anh) | **UC phục vụ:** UC-01, UC-02 | **Độ chi tiết:** high-fi
- **Mục tiêu người dùng:** trong vòng vài giây nhìn ra hôm nay phải xử lý việc gì trước, và mở thẳng được vào JD hoặc ứng viên tương ứng mà không phải đi vòng qua menu.

**Wireframe — trạng thái trống (tài khoản chưa được giao JD nào)**

Hình 5.63 vẽ trạng thái trống, xảy ra khi HR Admin vừa cấp tài khoản Recruiter mà chưa gán JD nào
theo BR-01. Trạng thái này được vẽ riêng vì nó là ấn tượng đầu tiên của người dùng mới: nếu chỉ hiện
một bảng rỗng thì người dùng không biết phải làm gì tiếp.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Bảng điều khiển                                                                   │
│              [ Tìm ứng viên, JD, mã offer ............. ]   Thông báo (0)   VI|EN   NMA v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Bảng điều khiển                                       03/08/2026 08:30      │
│ ────────────────── ├─────────────────────────────────────────────────────────────────────────────┤
│ > Bảng điều khiển  │                                                                             │
│   JD của tôi       │            ┌─────────────────────────────────────────────────┐              │
│   Ứng viên         │            │                                                 │              │
│   Lịch phỏng vấn   │            │   Chưa có JD nào được giao cho bạn              │              │
│   Offer            │            │                                                 │              │
│   Báo cáo          │            │   Theo BR-01, mỗi JD phải có đúng một Recruiter │              │
│ ────────────────── │            │   phụ trách. Tài khoản của bạn chưa được gán    │              │
│ Nguyễn Minh Anh    │            │   JD nào nên chưa có pipeline để theo dõi.      │              │
│ Recruiter          │            │                                                 │              │
│ Khối Nhân sự       │            │   Ba việc có thể làm ngay:                      │              │
│                    │            │   1. [ Tạo JD mới ]  — JD sẽ ở trạng thái       │              │
│                    │            │      DRAFT và cần Hiring Manager duyệt mở       │              │
│                    │            │      trước khi nhận hồ sơ (BR-02).              │              │
│                    │            │   2. [ Yêu cầu được giao JD ] — gửi HR Admin    │              │
│                    │            │      Đỗ Hải Yến.                                │              │
│                    │            │   3. [ Xem hướng dẫn quy trình tuyển dụng ]     │              │
│                    │            │                                                 │              │
│                    │            └─────────────────────────────────────────────────┘              │
│                    │                                                                             │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ VIỆC CẦN XỬ LÝ HÔM NAY                                                      │
│                    │ # Không có việc nào. Danh sách lấy từ SLAService (C14) và chỉ hiện          │
│                    │ # các việc thuộc JD do bạn phụ trách.                                       │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.63 — SCR-02, trạng thái trống khi tài khoản chưa được giao JD*

**Wireframe — trạng thái đầy dữ liệu**

Hình 5.64 vẽ cùng màn hình vào 17/08/2026 16:40, sau khi Recruiter vừa xếp xong lịch vòng 2 cho Hoàng
Thị Mai Chi. Bố cục chia ba tầng theo mức độ khẩn: dải bốn chỉ số ở trên cùng để nắm khối lượng, danh
sách việc quá hạn hoặc sắp hết hạn ở giữa, bảng JD ở dưới để đi sâu.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Bảng điều khiển                                                                   │
│              [ Tìm ứng viên, JD, mã offer ............. ]   Thông báo (3)   VI|EN   NMA v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Bảng điều khiển                                       17/08/2026 16:40      │
│ ────────────────── ├─────────────────────────────────────────────────────────────────────────────┤
│ > Bảng điều khiển  │ ┌───────────────┐┌───────────────┐┌───────────────┐┌───────────────┐        │
│   JD của tôi       │ │ JD đang mở    ││ Hồ sơ chưa    ││ Phỏng vấn 7   ││ Việc quá hạn  │        │
│   Ứng viên         │ │               ││ sàng lọc      ││ ngày tới      ││ SLA           │        │
│   Lịch phỏng vấn   │ │      2        ││      10       ││      4        ││      1        │        │
│   Offer            │ └───────────────┘└───────────────┘└───────────────┘└───────────────┘        │
│   Báo cáo          ├─────────────────────────────────────────────────────────────────────────────┤
│ ────────────────── │ VIỆC CẦN XỬ LÝ HÔM NAY                              [ Chỉ hiện quá hạn ]    │
│ Nguyễn Minh Anh    │ ┌─────────────────────────────────────────────────────────────────────┐     │
│ Recruiter          │ │ ! QUÁ HẠN 30 GIỜ · Feedback vòng 1 — Ngô Phương Thảo — JD-02        │     │
│ Khối Nhân sự       │ │   Người phỏng vấn Vũ Ngọc Lan. Hạn nộp 16/08/2026 10:00 (BR-06).    │     │
│                    │ │   Đã escalate tới Trần Quốc Bảo lúc 17/08/2026 10:02.               │     │
│                    │ │                                     [ Nhắc lại ]  [ Mở scorecard ]  │     │
│                    │ ├─────────────────────────────────────────────────────────────────────┤     │
│                    │ │ ! CÒN 23 GIỜ 20 · Chờ ứng viên xác nhận lịch — Hoàng Thị Mai Chi    │     │
│                    │ │   INT-2087 · System Design · 20/08/2026 16:00. Hạn xác nhận         │     │
│                    │ │   18/08/2026 16:00; quá hạn chuyển NEED_RESCHEDULE (BR-05).         │     │
│                    │ │                                  [ Gửi nhắc ]  [ Xem buổi PV ]      │     │
│                    │ ├─────────────────────────────────────────────────────────────────────┤     │
│                    │ │   HÔM NAY · 10 hồ sơ mới chưa sàng lọc, cũ nhất từ 12/08/2026       │     │
│                    │ │                                       [ Mở danh sách sàng lọc ]     │     │
│                    │ └─────────────────────────────────────────────────────────────────────┘     │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ JD ĐANG PHỤ TRÁCH                          [ + Tạo JD ]   [ Bộ lọc v ]      │
│                    │ ┌──────┬───────────────────────────────┬────────┬────┬────┬─────┬─────┐     │
│                    │ │ Mã   │ Vị trí                        │ T.thái │Mới │ PV │Offer│Hire │     │
│                    │ ├──────┼───────────────────────────────┼────────┼────┼────┼─────┼─────┤     │
│                    │ │JD-01 │Senior Backend Engineer (Java) │ OPEN   │ 7  │ 4  │  0  │ 0/2 │     │
│                    │ │JD-02 │Data Engineer                  │ OPEN   │ 3  │ 2  │  0  │ 0/1 │     │
│                    │ │JD-03 │AI Engineer                    │ DRAFT  │ 0  │ 0  │  0  │ 0/1 │     │
│                    │ └──────┴───────────────────────────────┴────────┴────┴────┴─────┴─────┘     │
│                    │ # JD-03 ở DRAFT nên không nhận hồ sơ; chờ Trần Quốc Bảo duyệt mở (BR-02).   │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ LỊCH PHỎNG VẤN TUẦN NÀY                                                     │
│                    │ 20/08/2026 14:00–15:00  Technical Round 1  Bùi Tuấn Kiệt      Vũ Ngọc Lan   │
│                    │ 20/08/2026 16:00–17:30  System Design      Hoàng Thị Mai Chi  Vũ Ngọc Lan,  │
│                    │                                                               Trần Quốc Bảo │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.64 — SCR-02, trạng thái đầy dữ liệu*

**Thành phần chính**

Bảng 5.64 mô tả từng vùng của SCR-02 kèm ràng buộc tương ứng.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Dải chỉ số | 4 thẻ số | JD đang mở 2; hồ sơ chưa sàng lọc 10; phỏng vấn 7 ngày tới 4; việc quá hạn SLA 1 | Truy vấn gộp qua `ApiGateway` (C03) trong một lần gọi; đếm chỉ trong phạm vi JD do người dùng phụ trách (BR-20) |
| Dải chỉ số | Thẻ "Việc quá hạn SLA" | Số việc trễ | Bấm vào lọc danh sách bên dưới; số do `SLAService` (C14) tính, không tính lại ở giao diện |
| Việc cần xử lý | Thẻ feedback quá hạn | Tên ứng viên, JD, người phỏng vấn, hạn nộp, mốc escalate | Sinh bởi `SchedulerWorker` (C17) theo ba mốc 24h/48h/72h của SEQ-03; nút "Nhắc lại" ghi outbox, không gửi trực tiếp (ADR-06) |
| Việc cần xử lý | Thẻ chờ xác nhận lịch | Mã INT, vòng, giờ phỏng vấn, hạn xác nhận, hệ quả quá hạn | Đếm ngược tính từ `interviews.created_at` cộng 24 giờ (BR-05); quá hạn thì thẻ đổi nhãn thành `NEED_RESCHEDULE` |
| Việc cần xử lý | Thẻ hồ sơ chưa sàng lọc | Số hồ sơ và ngày cũ nhất | Mở thẳng SCR-03 với bộ lọc cột `NEW` (UC-02) |
| Bảng JD | Cột Mã, Vị trí, Trạng thái, Mới, PV, Offer, Hire | 3 JD của Nguyễn Minh Anh | Cột Hire hiển thị dạng `đã tuyển/headcount` lấy từ `job_descriptions.headcount`; bấm dòng mở SCR-03 |
| Bảng JD | Dòng ghi chú DRAFT | Câu giải thích JD-03 chưa nhận hồ sơ | Diễn giải trực quan cho BR-02 |
| Lịch tuần | Danh sách buổi phỏng vấn | Ngày giờ, vòng, ứng viên, người phỏng vấn | Lấy từ `interviews` nối `interview_participants`; chỉ hiện buổi thuộc JD của người dùng |

*Bảng 5.64 — Thành phần chính của SCR-02*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **BR-01** — trạng thái trống được giải thích bằng đúng quy tắc "mỗi JD có đúng một Recruiter phụ trách".
- **BR-02** — JD-03 ở `DRAFT` được hiển thị nhưng có ghi chú không nhận hồ sơ.
- **BR-05** — thẻ chờ xác nhận lịch đếm ngược 24 giờ và nêu rõ hệ quả `NEED_RESCHEDULE`.
- **BR-06** — thẻ feedback quá hạn nêu mốc 48 giờ và mốc escalate 72 giờ.
- **BR-20** — mọi con số đều giới hạn trong phạm vi JD do người dùng phụ trách.
- **NFR-01** — toàn màn nạp trong 2 giây ở phân vị 95 với dữ liệu quy mô 50 JD mở và 200 ứng viên mỗi JD.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** Hình 5.63 — thay bảng rỗng bằng lời giải thích lý do và ba hành động cụ thể. Nếu có JD nhưng không có việc quá hạn, khối "Việc cần xử lý" hiện dòng "Không có việc quá hạn" thay vì biến mất, để bố cục không nhảy.
- **Đang tải:** bốn thẻ chỉ số và các dòng bảng hiển thị khung xám mô phỏng đúng số dòng dự kiến; không dùng vòng xoay toàn trang để tránh nhấp nháy khi phần lớn dữ liệu đã có sẵn trong bộ nhớ đệm.
- **Lỗi:** nếu truy vấn gộp hỏng, dải cảnh báo trên đầu vùng nội dung ghi "Không tải được số liệu tổng hợp — Mã theo dõi 3a91-77de" kèm nút "Tải lại"; các khối tải được vẫn hiển thị bình thường thay vì trắng cả trang.

**Phân quyền**

Theo ma trận RBAC, chỉ vai trò `RECRUITER` thấy màn này ở dạng đầy đủ. Hiring Manager truy cập cùng
đường dẫn sẽ được chuyển sang bảng điều khiển riêng của mình, ở đó JD hiện dưới quyền chỉ đọc kèm
nút duyệt mở JD. Interviewer không có mục điều hướng tới màn này. Nút "Tạo JD" chỉ hiện với
`RECRUITER` và `HR_ADMIN`; việc ẩn nút chỉ là lớp thuận tiện, quyết định thật vẫn nằm ở tầng dịch vụ
(ADR-10).

**Ghi chú thiết kế**

Phương án bị loại là bảng điều khiển kiểu "toàn biểu đồ" với biểu đồ funnel ngay trang chủ. Phương án
đó nhìn ấn tượng nhưng sai đối tượng: Recruiter mở hệ thống để xử lý việc trong ngày, còn biểu đồ
funnel là nhu cầu của Head of HR và HR Admin, đã có SCR-10 phục vụ. Ngoài ra, đặt biểu đồ nặng ở trang
chủ sẽ kéo truy vấn báo cáo vào đường transactional, đi ngược ADR-07 và NFR-10. Đánh đổi phải chấp
nhận là bảng điều khiển trông "khô" hơn; bù lại mỗi thẻ việc đều dẫn thẳng tới thao tác kế tiếp, giảm
số lần điều hướng.

---

## 6. SCR-03 — JD Detail, Kanban Pipeline

- **Actor:** Recruiter (toàn quyền), Hiring Manager (chỉ đọc trong phạm vi JD của mình) | **UC phục vụ:** UC-02, nối tiếp sang UC-01 | **Độ chi tiết:** high-fi
- **Mục tiêu người dùng:** nhìn toàn cảnh pipeline của một JD theo trạng thái, và chuyển ứng viên sang trạng thái kế tiếp bằng thao tác kéo thả thay vì mở từng hồ sơ.

**Wireframe — trạng thái bình thường**

Hình 5.65 vẽ pipeline của JD-01 lúc 17/08/2026 15:48. Bảy cột ứng với bảy nhóm trạng thái của
STATE-01. Do bề ngang khối ASCII có hạn, nhãn cột được viết tắt trong hình và được ghi đầy đủ ở dải
chú giải ngay bên dưới bảng. Wireframe chỉ vẽ các thẻ ứng viên nằm trong bộ dữ liệu mẫu đã chốt; số
thẻ còn lại được biểu diễn bằng dòng đếm, không bịa thêm tên người.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ JD-01 · Senior Backend Engineer (Java) · Khối Công nghệ · OPEN                                   │
│ Band 35.000.000 – 48.000.000 VND · Headcount 0/2 · HM Trần Quốc Bảo · REC Nguyễn Minh Anh        │
│ 17/08/2026 15:48                          [ + Thêm hồ sơ ]  [ Đóng JD ]  [ Cấu hình vòng PV ]    │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ [ Nguồn: Tất cả v ]  [ Vòng: Tất cả v ]  [ Chỉ hiện quá hạn SLA [ ] ]  [ Tìm tên ......... ]     │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│Mới (7)      │Sàng lọc(3)  │Shortlist(2) │Đang PV (4)  │Chờ duyệt(0) │Đã gửi (0)   │Kết thúc(5)   │
│─────────────┼─────────────┼─────────────┼─────────────┼─────────────┼─────────────┼──────────────│
│┌───────────┐│┌───────────┐│┌───────────┐│┌───────────┐│(trống)      │(trống)      │┌───────────┐ │
││7 hồ sơ mới│││Ngô Phương │││2 hồ sơ chờ│││Hoàng Thị  ││             │             ││4 REJECTED │ │
││chưa mở    │││Thảo       │││xếp lịch   │││Mai Chi    ││Chưa có      │Chưa có      ││1 TALENT_  │ │
││cũ nhất    │││APP-1049   │││vòng 1     │││APP-1042   ││ứng viên     │ứng viên     ││  POOL     │ │
││12/08/2026 │││WEBSITE    ││└───────────┘││Vòng 2/3   ││ở bước này   │ở bước này   │└───────────┘ │
│└───────────┘││12/08 09:40││             ││20/08 16:00││             │             │[Xem tất cả]  │
│             │└───────────┘│             ││REFERRAL   ││             │             │              │
│             │··· 2 thẻ    │             │└───────────┘│             │             │              │
│             │    khác     │             │┌───────────┐│             │             │              │
│             │             │             ││Bùi Tuấn   ││             │             │              │
│             │             │             ││Kiệt       ││             │             │              │
│             │             │             ││APP-1045   ││             │             │              │
│             │             │             ││Vòng 1/3   ││             │             │              │
│             │             │             ││20/08 14:00││             │             │              │
│             │             │             ││LINKEDIN   ││             │             │              │
│             │             │             │└───────────┘│             │             │              │
│             │             │             │··· 2 thẻ    │             │             │              │
│             │             │             │    khác     │             │             │              │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Chú giải cột (nhãn đầy đủ trên giao diện thật):                                                  │
│ Mới = NEW · Sàng lọc = SCREENING · Shortlist = "Đã shortlist — chờ xếp lịch" (SHORTLISTED)       │
│ Đang PV = INTERVIEWING và NEED_RESCHEDULE · Chờ duyệt = OFFER_PENDING và OFFER_APPROVED          │
│ Đã gửi = OFFER_SENT, NEGOTIATING và ACCEPTED · Kết thúc = REJECTED, OFFER_REJECTED_INTERNALLY,   │
│ TALENT_POOL, DECLINED, EXPIRED, HIRED, GHOSTED, ON_HOLD                                          │
│ Bảy cột phủ đủ 17 giá trị của application_status, thành 18 nếu X-02 được chốt                    │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.65 — SCR-03, pipeline JD-01 ở trạng thái bình thường*

Cột thứ ba mang nhãn "Đã shortlist — chờ xếp lịch" ứng với giá trị `SHORTLISTED`. Giá trị này **chưa
có** trong 17 giá trị `application_status` của `sql/schema.sql` v1.2; đây chính là mâu thuẫn X-02 giữa
`chapter-A.docx` và schema của C, đã được D ghi vào sổ mâu thuẫn cùng đề xuất P0 bổ sung một giá trị
ENUM. Nếu Sync S4 không chấp nhận bổ sung, cột này được gộp vào cột `SCREENING` và trên giao diện chỉ
còn sáu cột; toàn bộ phần còn lại của wireframe không đổi.

**Wireframe — trạng thái đang kéo thả một thẻ**

Hình 5.66 vẽ khoảnh khắc Recruiter nhấc thẻ của Ngô Phương Thảo từ cột `SCREENING` sang cột
`SHORTLISTED`. Ba tín hiệu thị giác được thể hiện đồng thời: chỗ trống nét đứt tại vị trí cũ, thẻ đang
bay bám theo con trỏ, và vùng thả hợp lệ được tô đậm. Các cột mà STATE-01 không cho phép chuyển tới
được đánh dấu khoá, kèm lý do ngay trên cột thay vì để người dùng thả rồi mới báo lỗi.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ JD-01 · Senior Backend Engineer (Java) · Khối Công nghệ · OPEN                                   │
│ 17/08/2026 15:50 · Đang kéo thẻ APP-1049 — Ngô Phương Thảo                                       │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│Mới (7)      │Sàng lọc(2)  │▓Shortlist▓  │Đang PV (4)  │Chờ duyệt(0) │Đã gửi (0)   │Kết thúc(5)   │
│─────────────┼─────────────┼─────────────┼─────────────┼─────────────┼─────────────┼──────────────│
│┌───────────┐│┌ ─ ─ ─ ─ ─ ┐│█████████████│┌───────────┐│(khoá)       │(khoá)       │(hợp lệ)      │
││7 hồ sơ mới││  chỗ trống │█ THẢ VÀO  █ ││Hoàng Thị  ││             │             │               │
││chưa mở    ││  của thẻ   │█ ĐÂY      █ ││Mai Chi    ││Không thể    │Không thể    │Thả vào đây    │
│└───────────┘│  đang kéo  │█████████████││Vòng 2/3   ││chuyển thẳng │chuyển thẳng │sẽ hỏi lý do   │
│             │└ ─ ─ ─ ─ ─ ┘│┌───────────┐│└───────────┘│từ SCREENING │từ SCREENING │từ chối       │
│             │··· 2 thẻ    ││»Ngô Phương││··· 3 thẻ    │             │             │              │
│             │    khác     ││ Thảo      ││    khác     │             │             │              │
│             │             ││ APP-1049 «││             │             │             │              │
│             │             │└───────────┘│             │             │             │              │
│             │             │2 thẻ sẵn có │             │             │             │              │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Chú thích hiển thị bám con trỏ:                                                                  │
│ "Thả để chuyển Ngô Phương Thảo sang Đã shortlist — chờ xếp lịch.                                 │
│  Hệ thống sẽ ghi một dòng application_status_history và gửi email theo template đã duyệt."       │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ ! Hai cột bị khoá vì STATE-01 không có transition trực tiếp từ SCREENING sang OFFER_PENDING      │
│   hay OFFER_SENT. Thả vào cột khoá thì thẻ tự bật về chỗ cũ, không gọi API.                      │
│ # Thao tác kéo thả có thể thay bằng bàn phím: chọn thẻ bằng Space, di chuyển bằng mũi tên        │
│ # trái/phải, xác nhận bằng Enter, huỷ bằng Escape (NFR-14).                                      │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.66 — SCR-03, trạng thái đang kéo thả thẻ ứng viên*

**Thành phần chính**

Bảng 5.65 liệt kê thành phần của SCR-03.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Đầu trang | Khối nhận dạng JD | Mã, chức danh, phòng ban, trạng thái, band lương, headcount, Hiring Manager, Recruiter | Band và headcount đọc từ `job_descriptions`; hiển thị dạng `đã tuyển/headcount` |
| Đầu trang | Nút "Đóng JD" | Nhãn nút | Chỉ bật khi JD ở `OPEN`; đóng JD khiến các application đang `ON_HOLD` bị BR-13 quét chuyển `REJECTED` |
| Dải lọc | Lọc nguồn, lọc vòng, lọc quá hạn SLA, ô tìm tên | Giá trị đang chọn | Lọc thực hiện phía máy chủ, mục tiêu 1 giây ở phân vị 95 (NFR-01) |
| Board | 7 cột theo nhóm trạng thái | Tên nhóm và số thẻ | Nhóm cột được định nghĩa trong chú giải; cột `SHORTLISTED` phụ thuộc kết luận X-02 |
| Board | Thẻ ứng viên | Họ tên, mã application, vòng hiện tại, giờ phỏng vấn kế tiếp, nguồn | `Vòng 2/3` đọc từ cột cache `applications.current_round` chứ không tính `MAX()` mỗi lần render |
| Board | Dòng đếm "còn N thẻ khác" | Số thẻ chưa hiển thị | Cuộn dọc trong cột, nạp thêm theo lô 20 thẻ để giữ NFR-01 |
| Board | Vùng thả hợp lệ và cột khoá | Ô đậm, ô mờ kèm lý do | Danh sách transition hợp lệ lấy từ STATE-01, kiểm tra lại ở `ApplicationService` (C07) |
| Board | Hộp thoại lý do từ chối | Danh sách lý do và ô ghi chú | Bắt buộc khi thả vào nhóm Kết thúc theo UC-02 bước 5; có ô tích "Thêm vào talent pool" (UC-02 A4.1) |
| Thẻ ứng viên | Menu ngữ cảnh | "Xếp lịch", "Mở hồ sơ", "Từ chối" | "Xếp lịch" mở SCR-05 dưới dạng modal chồng lên màn này |

*Bảng 5.65 — Thành phần chính của SCR-03*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **BR-02** — nếu JD ở `DRAFT` hoặc `CLOSED`, cột `NEW` hiện dòng "JD chưa mở, không nhận hồ sơ" và mọi thao tác kéo thả bị vô hiệu hoá.
- **BR-04** — thẻ của ứng viên từng bị từ chối tại chính JD này trong vòng 6 tháng mang nhãn cảnh báo "Từ chối ngày dd/mm/yyyy — chưa đủ 6 tháng".
- **BR-07** — thẻ đang ở vòng có từ hai người phỏng vấn trở lên hiện tỷ lệ kết luận, ví dụ "1/2 HIRE", để Recruiter biết vòng đã đủ điều kiện qua hay chưa.
- **BR-13** — thẻ ở nhóm Kết thúc do hết hạn `ON_HOLD` ghi rõ lý do "Hold quá hạn / JD đóng".
- **BR-20** — Recruiter khác không mở được đường dẫn tới JD này; Hiring Manager chỉ mở được JD thuộc phòng ban mình.
- **NFR-01** — board nạp trong 2 giây với 500 bản ghi, nhờ chỉ mục `applications(jd_id, status, applied_at DESC)` mà D đề xuất bổ sung cho C.
- **NFR-06** — mỗi lần kéo thả thành công sinh một dòng `application_status_history` kèm `actor_id`.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** JD chưa có hồ sơ nào thì toàn board hiện một khối duy nhất "Chưa có hồ sơ nào cho JD này" kèm nút "Chia sẻ liên kết nộp hồ sơ" và "Nhập hồ sơ từ email"; các cột vẫn được vẽ để người dùng hình dung quy trình.
- **Đang tải:** mỗi cột hiện ba thẻ khung xám; số đếm trên tiêu đề cột chỉ hiện sau khi có dữ liệu thật, tránh việc số nhảy từ 0 lên giá trị đúng.
- **Lỗi:** thả thẻ mà máy chủ trả lỗi thì thẻ bật về vị trí cũ kèm dải cảnh báo "Không chuyển được trạng thái — APP-1049 vừa được người khác cập nhật (phiên bản 4, bạn đang xem phiên bản 3). Tải lại để xem dữ liệu mới nhất". Đây là biểu hiện giao diện của khoá lạc quan theo ADR-08.

**Phân quyền**

Recruiter phụ trách JD có toàn quyền kéo thả và mở modal xếp lịch. Hiring Manager của JD thấy nguyên
board nhưng ở chế độ chỉ đọc: thẻ không kéo được, menu ngữ cảnh chỉ còn "Mở hồ sơ". Interviewer không
có đường vào màn này. HR Admin và Head of HR đọc được board của mọi JD nhưng không thao tác chuyển
trạng thái, vì theo ma trận RBAC quyền sàng lọc thuộc riêng Recruiter.

**Ghi chú thiết kế**

Kanban được chọn thay cho bảng danh sách có cột trạng thái vì thao tác chính ở đây là **chuyển trạng
thái**, và kanban biến thao tác đó thành một cử chỉ thay vì ba lần bấm. Cái giá phải trả là kanban khó
đọc khi số cột lớn và khó dùng bằng bàn phím; hai điểm này được xử lý bằng việc gộp mười tám giá trị
trạng thái thành bảy nhóm cột, và bằng lộ trình thao tác bàn phím tương đương đã ghi trong hình.
Phương án bị loại là hiển thị đủ mười tám cột theo đúng ENUM: đúng về dữ liệu nhưng không ai cuộn ngang
mười tám cột để làm việc hằng ngày.

---

## 7. SCR-04 — Candidate Profile và Timeline

- **Actor:** Recruiter (toàn quyền trong JD của mình), Hiring Manager (chỉ đọc), Interviewer (chỉ gói phỏng vấn được giao) | **UC phục vụ:** UC-02, UC-03 ở phần xem lại, UC-04 | **Độ chi tiết:** mid-fi
- **Mục tiêu người dùng:** tập trung mọi thứ đã biết về một ứng viên vào một chỗ — hồ sơ, lịch sử trạng thái, kết quả từng vòng, tệp CV — để ra quyết định chuyển vòng hoặc tạo offer mà không phải mở thêm màn nào khác.

**Wireframe — trạng thái đủ dữ liệu, góc nhìn Recruiter**

Hình 5.67 vẽ hồ sơ của Hoàng Thị Mai Chi lúc 25/08/2026 08:55, tức là sau khi đã hoàn tất cả ba vòng
phỏng vấn và ngay trước khi Recruiter mở SCR-07 để tạo offer. Timeline được dựng trực tiếp từ bảng
`application_status_history` mà C bổ sung ở v1.2, nên mỗi dòng đều có người thực hiện và thời điểm —
đây là biểu hiện giao diện của NFR-06.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Ứng viên › Hoàng Thị Mai Chi › APP-1042                                           │
│              [ Tìm ứng viên, JD, mã offer ............. ]   Thông báo (2)   VI|EN   NMA v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Hoàng Thị Mai Chi                                     25/08/2026 08:55      │
│ ────────────────── │ mai.chi.hoang@gmail.com · 6 năm kinh nghiệm · Nguồn REFERRAL                │
│   Bảng điều khiển  │ Người giới thiệu Trần Quốc Bảo · Công ty hiện tại: chưa cập nhật            │
│   JD của tôi       │ APP-1042 · JD-01 Senior Backend Engineer (Java) · Trạng thái INTERVIEWING   │
│ > Ứng viên         │                        [ Xếp lịch vòng kế ]  [ Tạo offer ]  [ Từ chối ]     │
│   Lịch phỏng vấn   ├─────────────────────────────────────────────────────────────────────────────┤
│   Offer            │ [ Hồ sơ ] [ Timeline ] [ Feedback (3) ] [ Offer (0) ] [ Tệp đính kèm (2) ]  │
│   Báo cáo          ├─────────────────────────────────────────────────────────────────────────────┤
│ ────────────────── │ TỆP ĐÍNH KÈM                                                                │
│ Nguyễn Minh Anh    │ CV_HoangThiMaiChi_v2.pdf · 1,8 MB · tải lên 05/08/2026 20:11 · phiên bản 2  │
│ Recruiter          │                          [ Tải xuống ]  [ Xem trước ]  [ Xem phiên bản 1 ]  │
│                    │ # Liên kết tải chỉ có hiệu lực 10 phút và mỗi lượt tải đều được ghi audit.  │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ TIMELINE (nguồn: application_status_history)                                │
│                    │ 05/08/2026 19:40  NEW           Ứng viên nộp hồ sơ qua liên kết giới thiệu  │
│                    │ 06/08/2026 09:12  SCREENING     Nguyễn Minh Anh mở hồ sơ                    │
│                    │ 07/08/2026 10:30  SHORTLISTED   Nguyễn Minh Anh — ghi chú "khớp yêu cầu JVM"│
│                    │ 07/08/2026 10:31  INTERVIEWING  Xếp lịch vòng 1 (INT-2078)                  │
│                    │ 11/08/2026 15:05  —             INT-2078 chuyển COMPLETED                   │
│                    │ 17/08/2026 16:00  —             Gửi lời mời vòng 2 (INT-2087), hạn xác nhận │
│                    │                                 18/08/2026 16:00                            │
│                    │ 17/08/2026 21:18  —             Ứng viên xác nhận tham gia                  │
│                    │ 20/08/2026 17:30  —             INT-2087 chuyển COMPLETED                   │
│                    │ 24/08/2026 11:00  —             INT-2094 (Culture Fit) chuyển COMPLETED     │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ KẾT QUẢ TỪNG VÒNG                                                           │
│                    │ ┌───────────────────┬────────────────┬────────────┬────────┬──────────────┐ │
│                    │ │ Vòng              │ Người phỏng vấn│ Ngày        │ Điểm  │ Kết luận     │ │
│                    │ ├───────────────────┼────────────────┼────────────┼────────┼──────────────┤ │
│                    │ │ 1 Technical R1    │ Vũ Ngọc Lan    │ 11/08/2026 │ 4,20   │ HIRE         │ │
│                    │ │ 2 System Design   │ Vũ Ngọc Lan    │ 20/08/2026 │ 4,20   │ HIRE         │ │
│                    │ │ 2 System Design   │ Trần Quốc Bảo  │ 20/08/2026 │ 4,60   │ STRONG_HIRE  │ │
│                    │ │ 3 Culture Fit     │ Trần Quốc Bảo  │ 24/08/2026 │ 4,40   │ HIRE         │ │
│                    │ └───────────────────┴────────────────┴────────────┴────────┴──────────────┘ │
│                    │ # Vòng 2 có 2 người phỏng vấn, 2/2 kết luận từ HIRE trở lên = 100% ≥ 50%    │
│                    │ # nên vòng được tính là PASS theo BR-07.                                    │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.67 — SCR-04, hồ sơ đầy đủ dưới góc nhìn Recruiter*

**Wireframe — trạng thái bị chặn theo phạm vi dữ liệu**

Hình 5.68 vẽ đúng đường dẫn đó nhưng do Vũ Ngọc Lan mở, lúc 20/08/2026 15:40, tức là 20 phút trước
buổi phỏng vấn vòng 2. Theo BR-20 và NFR-05, người phỏng vấn chỉ được thấy **gói phỏng vấn** của buổi
mình được giao. Điểm quan trọng về mặt thiết kế: các vùng bị chặn vẫn được vẽ ra kèm lời giải thích,
thay vì biến mất không dấu vết — để người phỏng vấn hiểu là hệ thống cố tình giới hạn, không phải dữ
liệu bị thiếu.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Việc cần feedback › Hoàng Thị Mai Chi › INT-2087                                  │
│              [ Tìm ............................. ]          Thông báo (1)   VI|EN   VNL v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Hoàng Thị Mai Chi                                     20/08/2026 15:40      │
│ ────────────────── │ Gói phỏng vấn được giao: INT-2087 · System Design · 20/08/2026 16:00–17:30  │
│   Bảng điều khiển  │ Vai trò của bạn trong buổi: PRIMARY                                         │
│ > Việc cần feedback├─────────────────────────────────────────────────────────────────────────────┤
│   Lịch của tôi     │ TỆP ĐƯỢC PHÉP XEM                                                           │
│ ────────────────── │ CV_HoangThiMaiChi_v2.pdf                              [ Xem trước ]         │
│ (4 mục bị ẩn theo  │ Mô tả công việc JD-01 (bản rút gọn cho người phỏng vấn) [ Xem ]             │
│  RBAC deny-by-     │ Scorecard mẫu của vòng System Design                   [ Mở scorecard ]     │
│  default, ADR-10)  ├─────────────────────────────────────────────────────────────────────────────┤
│ ────────────────── │ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ Vũ Ngọc Lan        │ │ ! Bạn không có quyền xem mục "Thông tin liên hệ"                        │ │
│ Interviewer        │ │   Email và số điện thoại ứng viên chỉ hiển thị với Recruiter phụ trách  │ │
│ Khối Công nghệ     │ │   và Hiring Manager của JD (BR-20, NFR-05).                             │ │
│                    │ └─────────────────────────────────────────────────────────────────────────┘ │
│                    │ ┌─────────────────────────────────────────────────────────────────────────┐ │
│                    │ │ ! Bạn không có quyền xem mục "Kết quả các vòng khác"                    │ │
│                    │ │   Điểm và kết luận của vòng 1 bị ẩn để không ảnh hưởng đánh giá độc lập │ │
│                    │ │   của bạn ở vòng 2. Mục này mở lại sau khi bạn gửi feedback.            │ │
│                    │ └─────────────────────────────────────────────────────────────────────────┘ │
│                    │ ┌─────────────────────────────────────────────────────────────────────────┐ │
│                    │ │ ! Bạn không có quyền xem mục "Offer"                                    │ │
│                    │ │   Chỉ Recruiter, Hiring Manager, Head of HR và Người duyệt Tài chính    │ │
│                    │ │   thấy thông tin lương (ma trận RBAC).                                  │ │
│                    │ └─────────────────────────────────────────────────────────────────────────┘ │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ TIMELINE (bản rút gọn)                                                      │
│                    │ 17/08/2026 16:00  Bạn được mời tham gia INT-2087                            │
│                    │ 17/08/2026 21:18  Ứng viên xác nhận tham gia                                │
│                    │ # Các mốc khác của hồ sơ không thuộc phạm vi gói phỏng vấn của bạn.         │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.68 — SCR-04, cùng hồ sơ dưới góc nhìn Interviewer bị giới hạn phạm vi*

**Thành phần chính**

Bảng 5.66 mô tả thành phần của SCR-04 và cho biết vùng nào bị che khi phạm vi dữ liệu không cho phép.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Đầu trang | Khối nhận dạng ứng viên | Họ tên, email, số năm kinh nghiệm, nguồn, người giới thiệu | Email và điện thoại bị che với Interviewer (BR-20); trường "công ty hiện tại" để trống khi `candidates.current_company` chưa có dữ liệu |
| Đầu trang | Khối nhận dạng application | Mã APP, JD, trạng thái hiện tại | Một ứng viên có nhiều application; thanh chọn ở đầu trang cho phép đổi giữa các JD mà ứng viên đã nộp |
| Đầu trang | Nhóm nút hành động | "Xếp lịch vòng kế", "Tạo offer", "Từ chối" | "Tạo offer" chỉ bật khi mọi vòng đã PASS theo BR-07; "Xếp lịch vòng kế" mở SCR-05 |
| Tab | 5 tab | Hồ sơ, Timeline, Feedback, Offer, Tệp đính kèm | Số trong ngoặc là số bản ghi; tab không có quyền thì không render |
| Tệp đính kèm | Danh sách tệp CV | Tên tệp, dung lượng, thời điểm tải lên, số phiên bản | Đọc từ bảng `attachments`; nút tải xuống gọi `FileService` (C15) sinh liên kết ký hạn 10 phút (NFR-12) |
| Timeline | Danh sách mốc trạng thái | Thời điểm, trạng thái đích, người thực hiện, ghi chú | Nguồn là `application_status_history`; dòng do cron sinh ra thì cột người thực hiện để trống, đúng quy ước `actor_id` NULL của C |
| Kết quả từng vòng | Bảng 5 cột | Vòng, người phỏng vấn, ngày, điểm, kết luận | Điểm lấy từ cột cache `feedbacks.total_score`; dòng chú thích diễn giải BR-07 |
| Vùng bị chặn | Dải giải thích quyền | Tên mục bị chặn và lý do kèm mã BR | Nội dung do máy chủ trả về, giao diện không tự suy diễn (ADR-10) |

*Bảng 5.66 — Thành phần chính của SCR-04*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **BR-04** — nếu ứng viên từng bị từ chối tại chính JD này chưa đủ 6 tháng, đầu trang hiện dải cảnh báo kèm ngày từ chối gần nhất và khoá nút chuyển vòng.
- **BR-07** — dòng chú thích dưới bảng kết quả nêu rõ tỷ lệ kết luận và kết quả PASS hay FAIL của vòng có nhiều người phỏng vấn.
- **BR-10** — khi ứng viên nhận offer ở JD khác, thanh chọn application hiện nhãn `ON_HOLD` trên các JD còn lại.
- **BR-20 và NFR-05** — ba vùng bị che ở Hình 5.68 là biểu hiện trực tiếp của quy tắc phạm vi dữ liệu.
- **NFR-06** — timeline chính là bản trình bày của yêu cầu 100% chuyển trạng thái có dòng audit.
- **NFR-12** — mọi lượt tải CV đi qua liên kết ký hạn 10 phút và được ghi audit.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** ứng viên chưa qua vòng nào thì bảng kết quả hiện "Chưa có kết quả phỏng vấn"; chưa có tệp thì khối tệp hiện "Chưa có CV — nhắc ứng viên nộp qua cổng ứng viên" kèm nút gửi nhắc.
- **Đang tải:** khung xám theo đúng số dòng dự kiến của timeline; tệp CV nạp riêng, không chặn phần còn lại.
- **Lỗi:** tải CV thất bại thì hiện "Không lấy được tệp từ kho lưu trữ — Mã theo dõi 5b12-04cc" và nút thử lại; lỗi này tách bạch với lỗi thiếu quyền để người dùng không hiểu nhầm thành bị chặn.

**Phân quyền**

Recruiter phụ trách JD có toàn quyền. Hiring Manager của JD đọc được toàn bộ nhưng không có nút "Từ
chối" và "Xếp lịch". Interviewer chỉ thấy gói phỏng vấn của buổi được giao như Hình 5.68. HR Admin và
Head of HR đọc được hồ sơ nhưng không thao tác chuyển vòng. Người duyệt Tài chính không có đường vào
màn này, chỉ thấy thông tin lương trong SCR-08.

**Ghi chú thiết kế**

Việc ẩn kết quả các vòng trước với người phỏng vấn của vòng sau là một lựa chọn có tranh cãi: nó làm
người phỏng vấn mất ngữ cảnh, nhưng đổi lại tránh hiệu ứng mỏ neo khi chấm điểm, và giữ đúng tinh thần
"mỗi interviewer một feedback độc lập" của BR-07. Ranh giới được đặt ở chỗ vùng bị ẩn sẽ mở lại ngay
sau khi người phỏng vấn gửi feedback, nên thông tin không bị giấu vĩnh viễn. Phương án bị loại là ẩn
luôn cả sự tồn tại của các mục đó; phương án này gọn hơn nhưng khiến người dùng tưởng hệ thống lỗi và
đi hỏi Recruiter, tạo thêm công việc thủ công.

---

## 8. SCR-05 — Schedule Interview (modal)

- **Actor:** Recruiter | **UC phục vụ:** UC-01 kèm hai luồng thay thế A5.1 và A5.2 | **Độ chi tiết:** high-fi
- **Mục tiêu người dùng:** đặt được một buổi phỏng vấn hợp lệ cho vòng kế tiếp mà chắc chắn không đụng lịch của người phỏng vấn, và nếu buộc phải đụng thì để lại lý do có thể truy vết.

Đây là màn hình mang nhiều tải nghiệp vụ nhất trong bộ wireframe: nó là bề mặt giao diện của BR-03, của
cơ chế khoá phân tán trong ADR-03, và của quy tắc override có kiểm toán. Vì vậy màn được vẽ ở ba trạng
thái tách rời.

**Wireframe — trạng thái 1: không phát hiện xung đột**

Hình 5.69 vẽ trường hợp thuận lợi. Điều đáng chú ý là dải xác nhận không chỉ nói "không xung đột" mà
nêu đủ ba thông tin cần để kiểm chứng: kiểm tra lúc nào, kiểm tra trên khoảng nào, và khoá slot còn hiệu
lực bao lâu. Đồng hồ khoá phản ánh đúng tham số `LockManager.acquire(interviewerId, slot, ttl=120s)`
của `LockManager` (C24).

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ (Nền mờ: SCR-03 — pipeline JD-01)                                              17/08/2026 15:52  │
│                                                                                                  │
│    ┌──────────────────────────────────────────────────────────────────────────────────────┐      │
│    │ Xếp lịch phỏng vấn — Hoàng Thị Mai Chi (APP-1042)                            [ X ]   │      │
│    ├──────────────────────────────────────────────────────────────────────────────────────┤      │
│    │ Vị trí : JD-01 Senior Backend Engineer (Java)                                        │      │
│    │ Vòng   : 2 — System Design   # tự lấy từ InterviewProcess của JD-01                  │      │
│    │                                                                                      │      │
│    │ NGƯỜI PHỎNG VẤN — chọn 1 đến 3, danh sách gợi ý lọc theo kỹ năng và phòng ban        │      │
│    │  [x] Vũ Ngọc Lan     Senior Backend, Khối Công nghệ      vai trò PRIMARY             │      │
│    │  [x] Trần Quốc Bảo   Hiring Manager, Khối Công nghệ      vai trò SECONDARY           │      │
│    │  [ ] Đỗ Hải Yến      HR Admin, Khối Nhân sự              không khớp kỹ năng          │      │
│    │                                                                                      │      │
│    │ Ngày [ 20/08/2026 v ]   Giờ bắt đầu [ 16:00 v ]   Thời lượng [ 90 phút v ]           │      │
│    │ Hình thức  (o) Trực tuyến — Google Meet   ( ) Trực tiếp — Phòng họp Sông Hồng        │      │
│    │ Liên kết họp  # sinh tự động sau khi lưu, đẩy sang Google Calendar                   │      │
│    │ Ghi chú gửi ứng viên [ Vui lòng chuẩn bị môi trường lập trình sẵn ............ ]     │      │
│    ├──────────────────────────────────────────────────────────────────────────────────────┤      │
│    │ KIỂM TRA XUNG ĐỘT LỊCH (BR-03)                                                       │      │
│    │  Không phát hiện xung đột cho 2 người phỏng vấn đã chọn.                             │      │
│    │  Kiểm tra lúc 17/08/2026 15:52 trên khoảng 20/08/2026 16:00 – 17:30.                 │      │
│    │  Đang giữ khoá slot (interviewer_id, time_slot) — còn 01:47 trước khi hết hạn.       │      │
│    ├──────────────────────────────────────────────────────────────────────────────────────┤      │
│    │ # Khi lưu: tạo Interview ở trạng thái SCHEDULED, gửi email mời cho ứng viên và       │      │
│    │ # người phỏng vấn bằng template đã duyệt (BR-12), đặt hạn xác nhận 24 giờ tới        │      │
│    │ # là 18/08/2026 16:00 (BR-05).                                                       │      │
│    │                                        [ Huỷ ]   [ Xác nhận và gửi lời mời ]         │      │
│    └──────────────────────────────────────────────────────────────────────────────────────┘      │
│                                                                                                  │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.69 — SCR-05, trạng thái không phát hiện xung đột lịch*

**Wireframe — trạng thái 2: phát hiện xung đột và gợi ý ba khung giờ**

Hình 5.70 vẽ đúng thời điểm Recruiter chọn khung 20/08/2026 14:00 cho Vũ Ngọc Lan, trùng với buổi
INT-2061 của Bùi Tuấn Kiệt. Dải cảnh báo nêu tên buổi bị trùng, khoảng thời gian trùng, và in ra ngay
quy tắc chồng lấn `newStart < existingEnd AND newEnd > existingStart` để người dùng hiểu vì sao hai
khung 14:00–15:30 và 14:00–15:00 bị coi là đụng nhau. Ba khung giờ gợi ý do `SchedulingService` (C08)
tính, ứng với luồng thay thế A5.1 của UC-01.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ (Nền mờ: SCR-03 — pipeline JD-01)                                              17/08/2026 15:50  │
│                                                                                                  │
│    ┌──────────────────────────────────────────────────────────────────────────────────────┐      │
│    │ Xếp lịch phỏng vấn — Hoàng Thị Mai Chi (APP-1042)                            [ X ]   │      │
│    ├──────────────────────────────────────────────────────────────────────────────────────┤      │
│    │ Vòng 2 — System Design   Ngày [ 20/08/2026 v ]  Giờ [ 14:00 v ]  [ 90 phút v ]       │      │
│    │ Người phỏng vấn: [x] Vũ Ngọc Lan (PRIMARY)   [x] Trần Quốc Bảo (SECONDARY)           │      │
│    ├──────────────────────────────────────────────────────────────────────────────────────┤      │
│    │ ! PHÁT HIỆN XUNG ĐỘT LỊCH — không thể lưu ở khung giờ hiện tại (BR-03)               │      │
│    │                                                                                      │      │
│    │   Vũ Ngọc Lan đã có buổi INT-2061                                                    │      │
│    │     Bùi Tuấn Kiệt · Technical Round 1 · JD-01                                        │      │
│    │     20/08/2026 14:00 – 15:00   (trùng 60 phút với khung bạn chọn)                    │      │
│    │                                                                                      │      │
│    │   Trần Quốc Bảo: không xung đột.                                                     │      │
│    │                                                                                      │      │
│    │   # Quy tắc chồng lấn: newStart < existingEnd AND newEnd > existingStart             │      │
│    │   # 20/08 14:00 < 20/08 15:00  và  20/08 15:30 > 20/08 14:00  →  chồng lấn           │      │
│    ├──────────────────────────────────────────────────────────────────────────────────────┤      │
│    │ BA KHUNG GIỜ TRỐNG GẦN NHẤT CHO CẢ 2 NGƯỜI PHỎNG VẤN                                 │      │
│    │   (o) 20/08/2026 16:00 – 17:30   thứ Năm, cùng ngày, sau buổi hiện có 60 phút        │      │
│    │   ( ) 21/08/2026 09:30 – 11:00   thứ Sáu, buổi sáng                                  │      │
│    │   ( ) 21/08/2026 14:00 – 15:30   thứ Sáu, buổi chiều                                 │      │
│    │   # Gợi ý tính trong 5 ngày làm việc kế tiếp, giờ hành chính 08:30–17:30.            │      │
│    ├──────────────────────────────────────────────────────────────────────────────────────┤      │
│    │  [ Huỷ ]   [ Đổi người phỏng vấn ]   [ Dùng khung giờ đã chọn ]   [ Ép đặt lịch ]    │      │
│    │  # "Ép đặt lịch" chỉ hiển thị với Recruiter và HR Admin (ma trận RBAC).              │      │
│    └──────────────────────────────────────────────────────────────────────────────────────┘      │
│                                                                                                  │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.70 — SCR-05, trạng thái phát hiện xung đột kèm ba khung giờ gợi ý*

**Wireframe — trạng thái 3: ép đặt lịch, bắt buộc nhập lý do**

Hình 5.71 vẽ tấm chắn cuối cùng trước khi hệ thống chấp nhận một buổi phỏng vấn trùng giờ. Nút xác
nhận bị vô hiệu hoá cho tới khi hai điều kiện cùng đúng: ô lý do có ít nhất 20 ký tự và ô cam kết đã
được tích. Đây là hiện thực hoá quy tắc override có kiểm toán mà `chapter-A.docx` đánh số BR-13 và D đề
nghị đổi thành **BR-26** để tránh trùng với BR-13 "hold quá hạn" của `spec_ats (1).md` — nội dung mâu
thuẫn X-04 trong sổ mâu thuẫn của D.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ (Nền mờ: SCR-03 — pipeline JD-01)                                              17/08/2026 15:51  │
│                                                                                                  │
│    ┌──────────────────────────────────────────────────────────────────────────────────────┐      │
│    │ Ép đặt lịch trùng giờ — cần lý do                                            [ X ]   │      │
│    ├──────────────────────────────────────────────────────────────────────────────────────┤      │
│    │ Buổi sắp tạo : Hoàng Thị Mai Chi · System Design · 20/08/2026 14:00 – 15:30          │      │
│    │ Buổi bị trùng: Bùi Tuấn Kiệt   · Technical Round 1 · 20/08/2026 14:00 – 15:00        │      │
│    │ Người bị trùng: Vũ Ngọc Lan                                                          │      │
│    │                                                                                      │      │
│    │ Lý do ép đặt lịch  (bắt buộc, tối thiểu 20 ký tự)                                    │      │
│    │ ┌──────────────────────────────────────────────────────────────────────────────┐     │      │
│    │ │ Ứng viên chỉ còn khung 14:00 ngày 20/08 trước khi đi công tác; Vũ Ngọc Lan   │     │      │
│    │ │ đã đồng ý bàn giao buổi INT-2061 cho Trần Quốc Bảo.                          │     │      │
│    │ └──────────────────────────────────────────────────────────────────────────────┘     │      │
│    │ # Đã nhập 142/20 ký tự tối thiểu.                                                    │      │
│    │                                                                                      │      │
│    │ [x] Tôi xác nhận Vũ Ngọc Lan sẽ có 2 buổi phỏng vấn trùng giờ và tôi chịu trách      │      │
│    │     nhiệm về quyết định này.                                                         │      │
│    │                                                                                      │      │
│    │ ! Hành động này ghi 1 dòng audit_logs với action = INTERVIEW_CONFLICT_OVERRIDE,      │      │
│    │   kèm actor Nguyễn Minh Anh, thời điểm, và payload chứa lý do vừa nhập (BR-26).      │      │
│    │   Hiring Manager của JD nhận thông báo trong ứng dụng ngay sau khi lưu.              │      │
│    │                                                                                      │      │
│    │                            [ Quay lại chọn khung khác ]  [ Ép đặt lịch và gửi mời ]  │      │
│    └──────────────────────────────────────────────────────────────────────────────────────┘      │
│                                                                                                  │
│ # Khi lý do dưới 20 ký tự hoặc ô cam kết chưa tích, nút [ Ép đặt lịch và gửi mời ]* bị mờ        │
│ # và trình đọc màn hình được thông báo "Nút bị vô hiệu hoá: cần nhập lý do ép đặt lịch".         │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.71 — SCR-05, trạng thái ép đặt lịch với ô lý do bắt buộc*

**Thành phần chính**

Bảng 5.67 mô tả thành phần của SCR-05 ở cả ba trạng thái.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Đầu modal | Nhãn ứng viên và vòng | Họ tên, mã APP, số vòng, tên vòng | Vòng kế tiếp lấy từ `interview_processes` theo `round_order`, không cho người dùng tự chọn để tránh nhảy vòng |
| Chọn người | Danh sách người phỏng vấn có ô tích | Họ tên, chức danh, phòng ban, vai trò PRIMARY hoặc SECONDARY | Giới hạn 1 đến 3 người theo UC-01 bước 3; vai trò ghi vào `interview_participants.role` |
| Chọn thời gian | Ô ngày, ô giờ bắt đầu, ô thời lượng | 20/08/2026, 16:00, 90 phút | Thời lượng mặc định 60 phút theo `interviews.duration_min`; mọi thay đổi kích hoạt kiểm tra xung đột lại |
| Chọn hình thức | Radio trực tuyến hoặc trực tiếp | Google Meet hoặc phòng họp | Trực tuyến thì liên kết họp sinh tự động qua `CalendarAdapter` (C21) |
| Kiểm tra xung đột | Dải kết quả | Thời điểm kiểm tra, khoảng kiểm tra, thời gian còn lại của khoá | Kiểm tra và ghi nằm trong cùng vùng khoá của `LockManager` (C24), đúng cơ chế trọng tâm của Chương 5 |
| Kiểm tra xung đột | Dải cảnh báo | Mã buổi trùng, ứng viên, vòng, khoảng thời gian trùng, số phút chồng lấn | Truy vấn `interviews` nối `interview_participants` theo quy tắc chồng lấn in ngay trên màn |
| Gợi ý | 3 radio khung giờ trống | Ngày, giờ, thứ trong tuần, ghi chú ngữ cảnh | Tính trong 5 ngày làm việc kế tiếp, giờ hành chính 08:30–17:30 (giả định vận hành) |
| Ép đặt lịch | Ô lý do bắt buộc | Nội dung lý do và bộ đếm ký tự | Tối thiểu 20 ký tự; kiểm tra lại ở `SchedulingService` (C08), không chỉ ở trình duyệt |
| Ép đặt lịch | Ô cam kết | Câu cam kết trách nhiệm | Bắt buộc tích; cùng với ô lý do quyết định trạng thái bật hay tắt của nút xác nhận |
| Ép đặt lịch | Dải thông báo audit | Tên hành động ghi vào `audit_logs` và người nhận thông báo | Ghi trong cùng giao dịch với việc tạo `Interview` (NFR-06) |
| Chân modal | Nhóm nút | Huỷ, Đổi người phỏng vấn, Dùng khung giờ đã chọn, Ép đặt lịch | Nút ép đặt lịch chỉ render với `RECRUITER` và `HR_ADMIN` |

*Bảng 5.67 — Thành phần chính của SCR-05*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **BR-03** — không cho lưu buổi phỏng vấn trùng giờ của cùng một người phỏng vấn, kể cả trùng một phút; quy tắc chồng lấn được in trực tiếp lên giao diện.
- **BR-26 (mâu thuẫn X-04)** — override phải kèm lý do và sinh dòng `audit_logs`.
- **BR-05** — dòng chú thích ở chân modal nêu hạn xác nhận 24 giờ và hệ quả nếu quá hạn.
- **BR-12** — email mời dùng template đã được HR Admin duyệt.
- **NFR-02** — mục tiêu 0 lịch trùng khi hai Recruiter cùng đặt một khung, với 50 yêu cầu song song; đồng hồ khoá trên giao diện là phần người dùng nhìn thấy của cơ chế này.
- **NFR-06 và NFR-11** — hành động lưu vừa ghi audit, vừa ghi bản ghi outbox để email và sự kiện lịch được gửi lại an toàn nếu cổng ngoài lỗi.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** khi không tìm được khung trống nào trong 5 ngày làm việc kế tiếp, khối gợi ý đổi thành "Không còn khung trống chung trong 5 ngày làm việc tới" kèm hai lối thoát: mở rộng phạm vi tìm sang 10 ngày, hoặc bỏ bớt một người phỏng vấn.
- **Đang tải:** trong lúc kiểm tra xung đột, dải kết quả hiện "Đang kiểm tra lịch của 2 người phỏng vấn..." và nút xác nhận bị vô hiệu hoá, tránh việc người dùng lưu trước khi có kết quả.
- **Lỗi:** ba nhánh — không lấy được khoá vì Recruiter khác đang giữ đúng slot đó, hiện "Khung giờ này đang được người khác thao tác, thử lại sau 30 giây"; `CalendarProvider` lỗi, buổi phỏng vấn vẫn được tạo và gắn nhãn `CALENDAR_SYNC_PENDING` kèm câu "Lịch nội bộ đã tạo, đang chờ đồng bộ sang Google Calendar" đúng luồng E18.1 của UC-01; hết hạn khoá 120 giây trước khi người dùng bấm lưu, hiện "Phiên giữ chỗ đã hết hạn, hệ thống sẽ kiểm tra lại xung đột" và tự chạy lại kiểm tra.

**Phân quyền**

Chỉ `RECRUITER` mở được modal này, và chỉ với JD mình phụ trách. Nút ép đặt lịch hiển thị cho
`RECRUITER` và `HR_ADMIN`; bốn vai trò còn lại không có nút và cũng bị `SchedulingService` từ chối nếu
gọi thẳng API. Hiring Manager thấy kết quả xếp lịch trên SCR-03 nhưng không mở được modal.

**Ghi chú thiết kế**

Ba trạng thái được tách thành ba khối riêng thay vì một khối có chú thích, vì đây là chỗ dễ trình bày
sai nhất khi bảo vệ: hội đồng thường hỏi "nếu hai người cùng đặt một khung thì sao" và "override rồi
thì ai chịu trách nhiệm". Việc in quy tắc chồng lấn và thời gian còn lại của khoá lên giao diện là có
chủ ý, giúp trả lời hai câu đó bằng chính ảnh chụp màn hình. Đánh đổi là dải cảnh báo hơi dày chữ so
với chuẩn giao diện thương mại; phương án gọn hơn — chỉ hiện "Trùng lịch" kèm biểu tượng — bị loại vì
người dùng không kiểm chứng được và sẽ mất niềm tin vào kết quả kiểm tra. Một phương án nữa bị loại là
chặn hoàn toàn việc override; phương án đó an toàn về dữ liệu nhưng đẩy người dùng ra ngoài hệ thống,
họ sẽ hẹn miệng với ứng viên rồi nhập sau, khiến dữ liệu còn sai hơn.

---

## 9. SCR-06 — Scorecard

- **Actor:** Interviewer (Vũ Ngọc Lan) | **UC phục vụ:** UC-03 kèm luồng thay thế A5.1 | **Độ chi tiết:** high-fi
- **Mục tiêu người dùng:** chấm điểm năm tiêu chí và ghi kết luận cho buổi phỏng vấn vừa xong, trong thời hạn cho phép, mà không phải nhớ mình còn nợ buổi nào.

**Wireframe — trạng thái nháp đang nhập**

Hình 5.72 vẽ scorecard vòng 2 lúc 21/08/2026 09:15, tức 15 giờ 45 phút sau khi buổi phỏng vấn kết
thúc. Điểm tổng được tính lại ngay khi đổi bất kỳ ô điểm nào, dùng đúng trọng số của
`ScorecardTemplate` gắn với vòng, và hiển thị cả phép tính để người phỏng vấn không phải đoán vì sao ra
con số đó.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Việc cần feedback › INT-2087 › Scorecard                                          │
│              [ Tìm ............................. ]          Thông báo (1)   VI|EN   VNL v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Scorecard — System Design (vòng 2/3)                  21/08/2026 09:15      │
│ ────────────────── │ Ứng viên Hoàng Thị Mai Chi · INT-2087 · phỏng vấn 20/08/2026 16:00–17:30    │
│   Bảng điều khiển  │ Vai trò của bạn PRIMARY · Mẫu chấm điểm "Backend Senior v3"                 │
│ > Việc cần feedback│ ! Hạn nộp 22/08/2026 17:30 — còn 32 giờ 15 phút (BR-06)         [ Nháp ]    │
│   Lịch của tôi     ├─────────────────────────────────────────────────────────────────────────────┤
│ ────────────────── │ ┌────────────────────────┬──────┬──────────────────┬───────────────────────┐│
│ (4 mục bị ẩn theo  │ │ Tiêu chí               │Trọng │ Điểm (1–5)       │ Nhận xét bắt buộc     ││
│  RBAC deny-by-     │ ├────────────────────────┼──────┼──────────────────┼───────────────────────┤│
│  default, ADR-10)  │ │ Technical              │ 30%  │ ( )1 ( )2 ( )3   │ [ Nắm chắc JVM ..... ]││
│ ────────────────── │ │                        │      │ (o)4 ( )5        │                       ││
│ Vũ Ngọc Lan        │ │ Problem-solving        │ 25%  │ (o)4             │ [ Chia bài toán tốt ] ││
│ Interviewer        │ │ Communication          │ 20%  │ (o)5             │ [ Trình bày mạch lạc ]││
│ Khối Công nghệ     │ │ Culture fit            │ 15%  │ (o)4             │ [ Hợp lối làm việc . ]││
│                    │ │ Growth mindset         │ 10%  │ (o)4             │ [ Chủ động học hỏi . ]││
│                    │ └────────────────────────┴──────┴──────────────────┴───────────────────────┘│
│                    │ # Điểm tổng = 4x0,30 + 4x0,25 + 5x0,20 + 4x0,15 + 4x0,10 = 4,20             │
│                    │                                                                             │
│                    │ ĐIỂM TỔNG   4,20 / 5,00                                                     │
│                    │                                                                             │
│                    │ KẾT LUẬN (bắt buộc)                                                         │
│                    │   ( ) STRONG_HIRE   (o) HIRE   ( ) NO_HIRE   ( ) STRONG_NO_HIRE             │
│                    │                                                                             │
│                    │ Ghi chú chung [ Đề nghị hỏi thêm về vận hành hệ thống ở vòng 3 ......... ]  │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ # Vòng này có 2 người phỏng vấn. Theo BR-07, vòng chỉ PASS khi ít nhất      │
│                    │ # 50% kết luận đạt HIRE trở lên. Bạn không thấy kết luận của người còn lại  │
│                    │ # cho tới khi bạn gửi feedback (BR-20).                                     │
│                    │                                                                             │
│                    │                        [ Lưu nháp ]        [ Gửi feedback ]                 │
│                    │ # Sau khi gửi, bạn còn 24 giờ để sửa; sau đó feedback bị khoá (UC-03 A5.1). │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.72 — SCR-06, scorecard ở trạng thái nháp đang nhập*

**Wireframe — trạng thái đã gửi và bị khoá sau 24 giờ**

Hình 5.73 vẽ cùng scorecard lúc 24/08/2026 08:30, tức sau khi cửa sổ 24 giờ đã đóng. Mọi ô nhập chuyển
sang chỉ đọc, cột `feedbacks.is_locked` mang giá trị đúng, và lối duy nhất để sửa là gửi yêu cầu mở
khoá tới HR Admin — một đường có kiểm soát thay vì cấm tuyệt đối.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Việc cần feedback › INT-2087 › Scorecard                                          │
│              [ Tìm ............................. ]          Thông báo (0)   VI|EN   VNL v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Scorecard — System Design (vòng 2/3)                  24/08/2026 08:30      │
│ ────────────────── │ Ứng viên Hoàng Thị Mai Chi · INT-2087                          [ Đã khoá ]  │
│   Bảng điều khiển  ├─────────────────────────────────────────────────────────────────────────────┤
│ > Việc cần feedback│ ┌─────────────────────────────────────────────────────────────────────────┐ │
│   Lịch của tôi     │ │ ! Feedback đã bị khoá lúc 22/08/2026 11:40                              │ │
│ ────────────────── │ │   Gửi lúc 21/08/2026 11:40, hết cửa sổ chỉnh sửa 24 giờ (UC-03 A5.1).   │ │
│ (4 mục bị ẩn theo  │ │   Mọi trường bên dưới chỉ đọc.                                          │ │
│  RBAC deny-by-     │ │                                        [ Gửi yêu cầu mở khoá tới HR ]   │ │
│  default, ADR-10)  │ └─────────────────────────────────────────────────────────────────────────┘ │
│ ────────────────── │                                                                             │
│ Vũ Ngọc Lan        │ ┌────────────────────────┬──────┬────────┬──────────────────────────────┐   │
│ Interviewer        │ │ Tiêu chí               │Trọng │ Điểm   │ Nhận xét                     │   │
│ Khối Công nghệ     │ ├────────────────────────┼──────┼────────┼──────────────────────────────┤   │
│                    │ │ Technical              │ 30%  │   4    │ Nắm chắc JVM và tuning GC    │   │
│                    │ │ Problem-solving        │ 25%  │   4    │ Chia bài toán tốt            │   │
│                    │ │ Communication          │ 20%  │   5    │ Trình bày mạch lạc           │   │
│                    │ │ Culture fit            │ 15%  │   4    │ Hợp lối làm việc nhóm        │   │
│                    │ │ Growth mindset         │ 10%  │   4    │ Chủ động học hỏi             │   │
│                    │ └────────────────────────┴──────┴────────┴──────────────────────────────┘   │
│                    │ ĐIỂM TỔNG 4,20 / 5,00        KẾT LUẬN: HIRE                                 │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ LỊCH SỬ PHIÊN BẢN                                                           │
│                    │ 21/08/2026 09:15  Lưu nháp        Vũ Ngọc Lan   phiên bản 1                 │
│                    │ 21/08/2026 11:40  Gửi feedback    Vũ Ngọc Lan   phiên bản 2                 │
│                    │ 21/08/2026 14:02  Sửa nhận xét    Vũ Ngọc Lan   phiên bản 3                 │
│                    │ 22/08/2026 11:40  Khoá tự động    Hệ thống      phiên bản 3                 │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ KẾT QUẢ VÒNG 2 (mở khoá sau khi bạn đã gửi)                                 │
│                    │ Vũ Ngọc Lan    4,20  HIRE          Trần Quốc Bảo  4,60  STRONG_HIRE         │
│                    │ # 2/2 kết luận đạt HIRE trở lên = 100% ≥ 50% → vòng 2 PASS (BR-07).         │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.73 — SCR-06, scorecard đã gửi và bị khoá sau 24 giờ*

**Thành phần chính**

Bảng 5.68 mô tả thành phần của SCR-06.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Đầu trang | Khối nhận dạng buổi phỏng vấn | Vòng, ứng viên, mã INT, thời gian, vai trò, tên mẫu chấm điểm | Tên mẫu kèm số phiên bản, khớp đề xuất P2 của D về `interview_processes.scorecard_template_version` |
| Đầu trang | Dải hạn nộp | Hạn nộp và thời gian còn lại | 48 giờ kể từ khi buổi phỏng vấn kết thúc (BR-06); đổi màu và đổi nhãn khi quá hạn |
| Bảng chấm | 5 dòng tiêu chí | Tên tiêu chí, trọng số, thang điểm 1–5, ô nhận xét | Danh sách tiêu chí đọc từ cột JSONB `scorecard_templates.criteria`; nhận xét bắt buộc với mọi tiêu chí |
| Bảng chấm | Dòng công thức điểm tổng | Phép nhân trọng số đầy đủ | Kết quả ghi vào cột cache `feedbacks.total_score`, kiểu DECIMAL(4,2) |
| Kết luận | 4 radio | STRONG_HIRE, HIRE, NO_HIRE, STRONG_NO_HIRE | Bắt buộc chọn; ghi vào `feedbacks.verdict` |
| Chú thích BR-07 | Dải giải thích | Số người phỏng vấn của vòng và ngưỡng 50% | Chỉ hiện khi vòng có từ 2 người phỏng vấn |
| Chân trang | Nút Lưu nháp và Gửi feedback | Nhãn nút | "Gửi feedback" gọi `FeedbackService` (C09), sinh thông báo cho Recruiter và Hiring Manager |
| Trạng thái khoá | Dải thông báo khoá | Thời điểm khoá, thời điểm gửi, lý do | Ứng với cột `feedbacks.is_locked`; nút yêu cầu mở khoá gửi tới HR Admin |
| Trạng thái khoá | Lịch sử phiên bản | Thời điểm, hành động, người thực hiện, số phiên bản | Nguồn là `audit_logs`; số phiên bản chính là cột `version` mà D đề xuất bổ sung theo ADR-08 |
| Trạng thái khoá | Khối kết quả vòng | Điểm và kết luận của mọi người phỏng vấn trong vòng | Chỉ mở sau khi người dùng đã gửi feedback của mình (BR-20) |

*Bảng 5.68 — Thành phần chính của SCR-06*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **BR-06** — hạn nộp 48 giờ hiển thị dưới dạng đồng hồ đếm ngược ngay đầu trang.
- **BR-07** — ngưỡng 50% kết luận HIRE được nêu thành câu và được tính lại ở khối kết quả vòng.
- **BR-20** — kết quả của người phỏng vấn khác bị che cho tới khi người dùng đã gửi feedback của mình.
- **UC-03 A5.1** — cửa sổ chỉnh sửa 24 giờ và cơ chế khoá sau đó.
- **ADR-08** — số phiên bản trong lịch sử là cột `version` phục vụ khoá lạc quan.
- **NFR-06** — mọi lần lưu nháp, gửi, sửa và khoá đều để lại dấu vết.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** khi người phỏng vấn không còn buổi nào cần feedback, danh sách ở mục điều hướng hiện "Bạn không còn buổi nào cần đánh giá" kèm liên kết tới lịch sắp tới, thay vì một bảng trắng.
- **Đang tải:** khung xám cho 5 dòng tiêu chí; ô nhận xét chỉ bật sau khi mẫu chấm điểm nạp xong, tránh việc người dùng gõ rồi bị ghi đè.
- **Lỗi:** gửi feedback trùng thời điểm với người khác chỉnh cùng bản ghi thì hiện "Feedback này vừa được cập nhật ở nơi khác (phiên bản 3, bạn đang giữ phiên bản 2). Tải lại để giữ cả hai thay đổi"; nếu quá hạn 48 giờ, nút vẫn bật nhưng dải cảnh báo đổi thành "Nộp muộn — buổi này đã được escalate tới Trần Quốc Bảo lúc 23/08/2026 17:30", vì chặn nộp muộn sẽ khiến hệ thống mất luôn dữ liệu đánh giá.

**Phân quyền**

Chỉ người phỏng vấn được giao buổi đó mới nhập và sửa được scorecard của chính mình. Recruiter, Hiring
Manager và Head of HR đọc được scorecard nhưng không sửa. HR Admin không đọc nội dung nhận xét, chỉ xử
lý yêu cầu mở khoá và thấy siêu dữ liệu như thời điểm nộp và trạng thái khoá. Người duyệt Tài chính
không có quyền nào trên tài nguyên này.

**Ghi chú thiết kế**

Hai quyết định đáng bàn. Thứ nhất, hệ thống vẫn cho nộp muộn sau 48 giờ thay vì khoá cứng: mục tiêu của
BR-06 là có dữ liệu đúng hạn, không phải trừng phạt người nộp muộn, nên cơ chế đối ứng là nhắc và
escalate chứ không phải chặn. Thứ hai, việc in cả công thức tính điểm tổng lên màn hình làm giao diện
dài thêm vài dòng, nhưng loại bỏ hoàn toàn câu hỏi "vì sao em chấm 4-4-5-4-4 mà tổng lại là 4,20" —
một câu rất dễ bị hỏi khi bảo vệ, và cũng là chỗ mà cột cache `total_score` của C cần được giải thích.
Phương án bị loại là chấm điểm bằng thanh trượt: đẹp nhưng khó thao tác bằng bàn phím và khó đọc chính
xác giá trị, đi ngược NFR-14.

---

## 10. SCR-07 — Offer Wizard 4 bước

- **Actor:** Recruiter | **UC phục vụ:** UC-04 kèm luồng thay thế A4.1 | **Độ chi tiết:** high-fi
- **Mục tiêu người dùng:** soạn một offer đúng khung lương, biết trước mình sẽ phải xin ai duyệt, và gửi đi mà không phải hỏi ai xem quy trình duyệt gồm mấy cấp.

Wizard chia bốn bước: (1) Thông tin offer, (2) Kiểm tra band và cấp duyệt, (3) Phúc lợi và thời hạn,
(4) Xem lại và gửi duyệt. Bước 2 là bước quyết định, nên hai trong ba khối wireframe dưới đây đều tập
trung vào bước này.

**Wireframe — trạng thái mức lương trong band, chuỗi duyệt 1 cấp**

Hình 5.74 vẽ bước 2 của offer OFF-317 cho Ngô Phương Thảo trên JD-02 Data Engineer, mức 38.000.000 VND
nằm gọn trong band 28.000.000 – 40.000.000. Hệ thống kết luận chỉ cần một cấp duyệt là Hiring Manager,
đúng nhánh thứ nhất của BR-08.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Offer › OFF-317 › Bước 2                                                          │
│              [ Tìm ứng viên, JD, mã offer ............. ]   Thông báo (1)   VI|EN   NMA v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Tạo offer — Ngô Phương Thảo (APP-1051)                24/08/2026 15:10      │
│ ────────────────── ├─────────────────────────────────────────────────────────────────────────────┤
│   Bảng điều khiển  │ (1) Thông tin ── (2) Band và cấp duyệt ── (3) Phúc lợi ── (4) Xem lại       │
│   JD của tôi       │                  ^ đang ở bước 2                                            │
│   Ứng viên         ├─────────────────────────────────────────────────────────────────────────────┤
│   Lịch phỏng vấn   │ Vị trí   JD-02 Data Engineer · Khối Công nghệ                               │
│ > Offer            │ Band JD  28.000.000 – 40.000.000 VND/tháng                                  │
│   Báo cáo          │          # bản chụp band tại thời điểm tạo offer, band JD có thể đổi sau    │
│ ────────────────── │ Mức lương đề xuất  [ 38.000.000 ............ ] VND/tháng (gross)            │
│ Nguyễn Minh Anh    │                                                                             │
│ Recruiter          │ ┌─────────────────────────────────────────────────────────────────────────┐ │
│                    │ │ TRONG BAND — không vượt trần                                            │ │
│                    │ │   38.000.000 nằm trong khoảng 28.000.000 – 40.000.000. Lệch so với      │ │
│                    │ │   trần band: 0,0%.                                                      │ │
│                    │ │   Theo BR-08, mức trong band chỉ cần 1 cấp duyệt.                       │ │
│                    │ └─────────────────────────────────────────────────────────────────────────┘ │
│                    │                                                                             │
│                    │ CHUỖI DUYỆT HỆ THỐNG XÁC ĐỊNH                                               │
│                    │ ┌───────┬──────────────────┬────────────────────┬───────────────────────┐   │
│                    │ │ Cấp   │ Người duyệt      │ Vai trò            │ Trạng thái            │   │
│                    │ ├───────┼──────────────────┼────────────────────┼───────────────────────┤   │
│                    │ │ Cấp 1 │ Trần Quốc Bảo    │ Hiring Manager     │ Nhận yêu cầu đầu tiên │   │
│                    │ └───────┴──────────────────┴────────────────────┴───────────────────────┘   │
│                    │ # Không phát sinh cấp 2 và cấp 3.                                           │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │                              [ Quay lại bước 1 ]   [ Tiếp tục bước 3 ]      │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.74 — SCR-07 bước 2, mức lương trong band và chuỗi duyệt 1 cấp*

**Wireframe — trạng thái vượt band trên 10%, chuỗi duyệt 3 cấp**

Hình 5.75 vẽ cùng bước 2 nhưng cho offer OFF-318 của Hoàng Thị Mai Chi trên JD-01, mức đề xuất
55.200.000 VND so với trần band 48.000.000 VND. Phần trăm lệch được in kèm phép tính, và chuỗi duyệt
tự động dài ra thành ba cấp theo nhánh thứ ba của BR-08. Bảng chuỗi duyệt cũng thể hiện quy ước tên ba
tầng của mâu thuẫn X-06: báo cáo gọi "Người duyệt Tài chính", sơ đồ gọi `FinanceApprover`, cơ sở dữ
liệu lưu `FINANCE`.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Offer › OFF-318 › Bước 2                                                          │
│              [ Tìm ứng viên, JD, mã offer ............. ]   Thông báo (1)   VI|EN   NMA v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Tạo offer — Hoàng Thị Mai Chi (APP-1042)              25/08/2026 09:05      │
│ ────────────────── ├─────────────────────────────────────────────────────────────────────────────┤
│   Bảng điều khiển  │ (1) Thông tin ── (2) Band và cấp duyệt ── (3) Phúc lợi ── (4) Xem lại       │
│   JD của tôi       │                  ^ đang ở bước 2                                            │
│   Ứng viên         ├─────────────────────────────────────────────────────────────────────────────┤
│   Lịch phỏng vấn   │ Vị trí   JD-01 Senior Backend Engineer (Java) · Khối Công nghệ              │
│ > Offer            │ Band JD  35.000.000 – 48.000.000 VND/tháng                                  │
│   Báo cáo          │ Mức lương đề xuất  [ 55.200.000 ............ ] VND/tháng (gross)            │
│ ────────────────── │                                                                             │
│ Nguyễn Minh Anh    │ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ Recruiter          │ │ ! VƯỢT TRẦN BAND 15,0%                                                  │ │
│                    │ │   (55.200.000 − 48.000.000) / 48.000.000 = 0,150 = 15,0%                │ │
│                    │ │   Vượt trên 10% nên cần đủ 3 cấp duyệt (BR-08).                         │ │
│                    │ │   [ Hạ về mức trần 48.000.000 ]   [ Hạ về mức vượt 10% = 52.800.000 ]   │ │
│                    │ └─────────────────────────────────────────────────────────────────────────┘ │
│                    │                                                                             │
│                    │ CHUỖI DUYỆT HỆ THỐNG XÁC ĐỊNH                                               │
│                    │ ┌───────┬──────────────────┬────────────────────────┬───────────────────┐   │
│                    │ │ Cấp   │ Người duyệt      │ Vai trò                │ Trạng thái        │   │
│                    │ ├───────┼──────────────────┼────────────────────────┼───────────────────┤   │
│                    │ │ Cấp 1 │ Trần Quốc Bảo    │ Hiring Manager         │ Nhận yêu cầu đầu  │   │
│                    │ │ Cấp 2 │ Lê Thu Hà        │ Head of HR             │ Chờ cấp 1         │   │
│                    │ │ Cấp 3 │ Phạm Đức Duy     │ Người duyệt Tài chính  │ Chờ cấp 2         │   │
│                    │ └───────┴──────────────────┴────────────────────────┴───────────────────┘   │
│                    │ # Nếu một cấp chọn "Yêu cầu chỉnh sửa", quy trình chạy lại TỪ CẤP 1 và      │
│                    │ # attempt_no tăng thêm 1 để giữ nguyên lịch sử lần duyệt trước (UC-04 A4.1).│
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │                              [ Quay lại bước 1 ]   [ Tiếp tục bước 3 ]      │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.75 — SCR-07 bước 2, mức lương vượt band 15,0% và chuỗi duyệt 3 cấp*

**Wireframe — bước 4, xem lại và gửi duyệt lại sau khi bị yêu cầu chỉnh sửa**

Hình 5.76 vẽ bước cuối lúc 26/08/2026 08:50, sau khi Lê Thu Hà đã chọn "Yêu cầu chỉnh sửa" ở cấp 2 của
lần duyệt thứ nhất. Recruiter hạ mức lương xuống 51.840.000 VND, tương ứng vượt trần band 8,0%, nên
chuỗi duyệt rút còn hai cấp. Khối lịch sử ở cuối màn là bề mặt giao diện của cặp cột
`offers.current_approval_attempt` và `offer_approvals.attempt_no` mà C bổ sung ở v1.1.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Offer › OFF-318 › Bước 4                                                          │
│              [ Tìm ứng viên, JD, mã offer ............. ]   Thông báo (2)   VI|EN   NMA v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Xem lại và gửi duyệt — OFF-318                        26/08/2026 08:50      │
│ ────────────────── │ Lần duyệt số 2 (attempt_no = 2)                                             │
│   Bảng điều khiển  ├─────────────────────────────────────────────────────────────────────────────┤
│   JD của tôi       │ (1) Thông tin ── (2) Band và cấp duyệt ── (3) Phúc lợi ── (4) Xem lại       │
│   Ứng viên         │                                                          ^ đang ở bước 4    │
│   Lịch phỏng vấn   ├─────────────────────────────────────────────────────────────────────────────┤
│ > Offer            │ Ứng viên      Hoàng Thị Mai Chi (mai.chi.hoang@gmail.com)                   │
│   Báo cáo          │ Vị trí        JD-01 Senior Backend Engineer (Java)                          │
│ ────────────────── │ Mức lương     51.840.000 VND/tháng (gross) — vượt trần band 8,0%            │
│ Nguyễn Minh Anh    │               (51.840.000 − 48.000.000) / 48.000.000 = 0,080 = 8,0%         │
│ Recruiter          │ Ngày bắt đầu  15/09/2026                                                    │
│                    │ Phúc lợi      Lương tháng 13; thử việc hưởng 100% lương; bảo hiểm sức khoẻ  │
│                    │               mở rộng; 15 ngày phép năm; ngân sách đào tạo 15.000.000/năm   │
│                    │ Hạn phản hồi  07/09/2026 17:00                                              │
│                    │               # 7 ngày làm việc kể từ khi gửi, đã trừ ngày lễ 02/09 (BR-09) │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ CHUỖI DUYỆT CỦA LẦN DUYỆT NÀY (2 cấp do vượt band 8,0% ≤ 10%)               │
│                    │ ┌───────┬──────────────────┬────────────────────┬───────────────────────┐   │
│                    │ │ Cấp   │ Người duyệt      │ Vai trò            │ Trạng thái            │   │
│                    │ ├───────┼──────────────────┼────────────────────┼───────────────────────┤   │
│                    │ │ Cấp 1 │ Trần Quốc Bảo    │ Hiring Manager     │ Sẽ nhận yêu cầu       │   │
│                    │ │ Cấp 2 │ Lê Thu Hà        │ Head of HR         │ Chờ cấp 1             │   │
│                    │ └───────┴──────────────────┴────────────────────┴───────────────────────┘   │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ LỊCH SỬ DUYỆT LẦN 1 (attempt_no = 1, mức 55.200.000, vượt band 15,0%)       │
│                    │ 25/08/2026 09:10  Cấp 1  Trần Quốc Bảo  APPROVED                            │
│                    │                          "Đồng ý, ứng viên đúng nhu cầu đội Backend"        │
│                    │ 25/08/2026 15:45  Cấp 2  Lê Thu Hà      REQUEST_CHANGE                      │
│                    │                          "Vượt trần band 15%, đề nghị đưa về mức ≤10%"      │
│                    │ 25/08/2026 15:45  Cấp 3  Phạm Đức Duy   PENDING → huỷ do quy trình chạy lại │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │                    [ Quay lại bước 3 ]   [ Gửi duyệt lần 2 ]                │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.76 — SCR-07 bước 4, xem lại và gửi duyệt lần thứ hai*

**Thành phần chính**

Bảng 5.69 mô tả thành phần của SCR-07.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Đầu trang | Thanh 4 bước | Tên bốn bước và bước đang đứng | Không cho nhảy tới bước 4 khi bước 2 chưa hợp lệ |
| Bước 2 | Khối band JD | Band tối thiểu và tối đa kèm ghi chú bản chụp | Ứng với đề xuất P1 của D về hai cột `offers.band_snapshot_min` và `band_snapshot_max`, vì band JD có thể đổi sau khi offer đã tạo |
| Bước 2 | Ô mức lương đề xuất | Số tiền theo VND mỗi tháng, dạng gross | Định dạng phân nhóm ba chữ số ngay khi gõ; kiểm tra lớn hơn 0 khớp ràng buộc `chk_offers_salary_positive` |
| Bước 2 | Dải kết luận band | Kết luận trong band hay vượt bao nhiêu phần trăm, kèm phép tính | Ba nhánh của BR-08; phần trăm tính trên trần band chứ không trên giữa band |
| Bước 2 | Nút hạ mức nhanh | "Hạ về mức trần" và "Hạ về mức vượt 10%" | Giúp Recruiter thấy được ngưỡng làm đổi số cấp duyệt, giảm số vòng thương lượng nội bộ |
| Bước 2 | Bảng chuỗi duyệt | Cấp, người duyệt, vai trò, trạng thái | Người duyệt suy ra từ `job_descriptions.hiring_manager_id` và từ vai trò `HEAD_OF_HR`, `FINANCE` trong bảng `users` |
| Bước 3 | Phúc lợi và hạn phản hồi | Danh sách phúc lợi, ngày bắt đầu, hạn phản hồi | Phúc lợi ghi vào cột JSONB `offers.benefits`; hạn phản hồi tính 7 ngày làm việc theo BR-09 và trừ ngày lễ |
| Bước 4 | Khối xem lại | Toàn bộ thông tin offer ở dạng chỉ đọc | Là nơi cuối cùng còn quay lại sửa được trước khi `ApprovalWorkflow` (C11) khởi động |
| Bước 4 | Khối lịch sử lần duyệt trước | Cấp, người duyệt, quyết định, ghi chú, thời điểm | Nguồn là `offer_approvals` lọc theo `attempt_no` nhỏ hơn lần hiện tại |
| Bước 4 | Nút gửi duyệt | Nhãn ghi rõ số lần duyệt | Mỗi lần bấm tăng `offers.current_approval_attempt` và tạo lại các dòng `offer_approvals` từ cấp 1 |

*Bảng 5.69 — Thành phần chính của SCR-07*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **BR-08** — ba nhánh cấp duyệt được thể hiện bằng hai khối wireframe khác nhau và một bảng chuỗi duyệt sinh động theo mức lương.
- **BR-09** — hạn phản hồi tối đa 7 ngày làm việc, có trừ ngày lễ, in kèm cách tính.
- **UC-04 A4.1** — khi bị yêu cầu chỉnh sửa, quy trình chạy lại từ cấp 1 và số lần duyệt tăng.
- **BR-01** — người duyệt cấp 1 luôn là Hiring Manager của chính JD, không cho chọn tay.
- **BR-16** — cùng một engine `ApprovalWorkflow` phục vụ cả offer lẫn JD, nên bố cục bảng chuỗi duyệt được thiết kế để dùng lại cho màn duyệt mở JD.
- **ADR-08** — mọi thao tác lưu ở bước 1 đến 3 mang theo số phiên bản để chặn ghi đè.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** khi ứng viên chưa PASS đủ vòng, wizard không mở được; nút "Tạo offer" ở SCR-04 hiện chú thích "Chưa đủ điều kiện — vòng 3 chưa có kết luận".
- **Đang tải:** trong lúc tính chuỗi duyệt, bảng chuỗi duyệt hiện khung xám ba dòng và nút "Tiếp tục bước 3" bị vô hiệu hoá; không đoán trước số cấp ở phía trình duyệt để tránh hiện sai rồi đổi.
- **Lỗi:** nếu JD bị đóng trong lúc soạn offer, dải cảnh báo ghi "JD-01 vừa chuyển sang CLOSED lúc 25/08/2026 09:02 — không tạo được offer mới"; nếu người duyệt cấp 2 hoặc cấp 3 không tồn tại hoặc đã ngừng hoạt động, hiện "Chưa có người giữ vai trò Head of HR đang hoạt động — liên hệ HR Admin" và chặn gửi duyệt, vì gửi đi sẽ tạo một quy trình treo.

**Phân quyền**

Chỉ `RECRUITER` tạo và sửa offer, và chỉ trên JD mình phụ trách. Hiring Manager, Head of HR và Người
duyệt Tài chính không vào wizard mà làm việc trên SCR-08. HR Admin đọc được offer để hỗ trợ nhưng không
sửa mức lương. Interviewer và Candidate không có quyền nào trên tài nguyên này.

**Ghi chú thiết kế**

Quyết định gây tranh cãi nhất ở màn này là hiển thị công khai số cấp duyệt **trước khi** gửi. Cách làm
này khiến Recruiter nhìn thấy ngay chi phí tổ chức của mỗi mức lương và có xu hướng tự điều chỉnh về
ngưỡng thấp hơn — vừa là ưu điểm về tốc độ, vừa là rủi ro nếu bị dùng để lách quy trình bằng cách chia
nhỏ phúc lợi ra ngoài lương. Rủi ro này được ghi nhận và đối ứng bằng việc bắt buộc kê phúc lợi ở bước
3 và lưu vào `offers.benefits`, để cấp duyệt nhìn thấy tổng chi phí chứ không chỉ con số lương. Phương
án bị loại là gộp bốn bước thành một biểu mẫu dài: nhanh hơn cho người dùng thành thạo, nhưng làm mất
khoảnh khắc dừng lại ở bước 2 — đúng khoảnh khắc mà BR-08 cần người dùng nhìn thấy hệ quả.

---

## 11. SCR-08 — Offer Approval Inbox

- **Actor:** Hiring Manager (cấp 1), Head of HR (cấp 2), Người duyệt Tài chính (cấp 3) | **UC phục vụ:** UC-04 các bước 3 đến 5 | **Độ chi tiết:** mid-fi
- **Mục tiêu người dùng:** thấy ngay offer nào đang chờ chính mình quyết định, hiểu vì sao mình được hỏi ý kiến, và ra một trong ba quyết định mà không phải mở email hay hỏi lại Recruiter.

**Wireframe — danh sách chờ duyệt**

Hình 5.77 vẽ hộp duyệt của Lê Thu Hà lúc 26/08/2026 10:12. Ba tab tách bạch ba nhu cầu khác nhau:
việc phải quyết, việc đã quyết để tra lại, và việc chỉ theo dõi. Cột "Cấp của tôi" là cột quan trọng
nhất vì cùng một offer có thể xuất hiện ở hộp của ba người với vai trò khác nhau.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Duyệt offer                                                                       │
│              [ Tìm mã offer, tên ứng viên ............ ]   Thông báo (1)   VI|EN   LTH v         │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Hộp duyệt offer                                       26/08/2026 10:12      │
│ ────────────────── ├─────────────────────────────────────────────────────────────────────────────┤
│   Bảng điều khiển  │ [ Chờ tôi duyệt (1) ]  [ Đã quyết định (12) ]  [ Theo dõi (3) ]             │
│ > Duyệt offer  (1) ├─────────────────────────────────────────────────────────────────────────────┤
│   Ứng viên (đọc)   │ ┌────────┬──────────────────┬──────────────┬────────┬───────┬────────────┐  │
│   Báo cáo          │ │ Mã     │ Ứng viên         │ Mức lương    │ So band│ Cấp   │ Hạn quyết  │  │
│ ────────────────── │ ├────────┼──────────────────┼──────────────┼────────┼───────┼────────────┤  │
│ Lê Thu Hà          │ │OFF-318 │Hoàng Thị Mai Chi │51.840.000 VND│ +8,0%  │ Cấp 2 │28/08 17:00 │  │
│ Head of HR         │ │        │Senior Backend    │              │        │       │(còn 2 ngày)│  │
│ Khối Nhân sự       │ │        │Engineer (Java)   │              │        │       │            │  │
│                    │ └────────┴──────────────────┴──────────────┴────────┴───────┴────────────┘  │
│                    │ # Sắp xếp mặc định theo hạn quyết định gần nhất. Chỉ hiện offer mà bạn là   │
│                    │ # người duyệt của cấp đang chờ; offer chưa tới lượt bạn nằm ở tab Theo dõi. │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ ĐÃ QUYẾT ĐỊNH GẦN ĐÂY                                                       │
│                    │ ┌────────┬──────────────────┬──────────────┬────────┬──────────────────┐    │
│                    │ │ Mã     │ Ứng viên         │ Mức lương    │ Cấp    │ Quyết định       │    │
│                    │ ├────────┼──────────────────┼──────────────┼────────┼──────────────────┤    │
│                    │ │OFF-318 │Hoàng Thị Mai Chi │55.200.000 VND│ Cấp 2  │REQUEST_CHANGE    │    │
│                    │ │        │lần duyệt 1       │              │        │25/08/2026 15:45  │    │
│                    │ │OFF-317 │Ngô Phương Thảo   │38.000.000 VND│ —      │Không thuộc thẩm  │    │
│                    │ │        │Data Engineer     │              │        │quyền, chỉ 1 cấp  │    │
│                    │ └────────┴──────────────────┴──────────────┴────────┴──────────────────┘    │
│                    │ # Dòng OFF-317 hiển thị ở chế độ chỉ đọc theo quyền báo cáo toàn công ty    │
│                    │ # của Head of HR; không có nút quyết định trên dòng này.                    │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.77 — SCR-08, danh sách offer chờ duyệt dưới góc nhìn Head of HR*

**Wireframe — chi tiết một offer kèm ba nút quyết định**

Hình 5.78 vẽ màn chi tiết của OFF-318. Bốn khối được xếp theo đúng thứ tự câu hỏi mà một người duyệt
đặt ra: offer này là gì, nó lệch band bao nhiêu, ai đã duyệt trước mình, và lần duyệt trước đã xảy ra
chuyện gì. Ba nút quyết định đặt cuối cùng, sau khi người dùng đã có đủ dữ kiện.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Duyệt offer › OFF-318                                                             │
│              [ Tìm mã offer, tên ứng viên ............ ]   Thông báo (1)   VI|EN   LTH v         │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ OFF-318 — Hoàng Thị Mai Chi                           26/08/2026 10:12      │
│ ────────────────── │ Lần duyệt số 2 · Bạn đang được hỏi ở CẤP 2 (Head of HR)                     │
│   Bảng điều khiển  ├─────────────────────────────────────────────────────────────────────────────┤
│ > Duyệt offer  (1) │ NỘI DUNG OFFER                                                              │
│   Ứng viên (đọc)   │ Vị trí        JD-01 Senior Backend Engineer (Java) · Khối Công nghệ         │
│   Báo cáo          │ Mức lương     51.840.000 VND/tháng (gross)                                  │
│ ────────────────── │ Ngày bắt đầu  15/09/2026                                                    │
│ Lê Thu Hà          │ Phúc lợi      Lương tháng 13; thử việc hưởng 100% lương; bảo hiểm sức       │
│ Head of HR         │               khoẻ mở rộng; 15 ngày phép năm; đào tạo 15.000.000/năm        │
│ Khối Nhân sự       │ Hạn phản hồi  07/09/2026 17:00 (7 ngày làm việc — BR-09)                    │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ SO SÁNH VỚI BAND LƯƠNG CỦA JD                                               │
│                    │ Band JD-01   35.000.000 ─────────────────────────── 48.000.000              │
│                    │ Mức đề xuất                                          51.840.000  ▲          │
│                    │ ! Vượt trần band 8,0% — (51.840.000 − 48.000.000) / 48.000.000 = 0,080      │
│                    │   Theo BR-08, mức vượt band tới 10% cần 2 cấp duyệt.                        │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ CHUỖI DUYỆT LẦN NÀY                                                         │
│                    │ Cấp 1  Trần Quốc Bảo   Hiring Manager  APPROVED  26/08/2026 09:35           │
│                    │        "Mức này hợp lý so với thị trường, đội Backend cần người gấp"        │
│                    │ Cấp 2  Lê Thu Hà       Head of HR      ĐANG CHỜ BẠN                         │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ LỊCH SỬ LẦN DUYỆT TRƯỚC (attempt_no = 1)                                    │
│                    │ 25/08/2026 09:10  Cấp 1  Trần Quốc Bảo  APPROVED  (mức 55.200.000)          │
│                    │ 25/08/2026 15:45  Cấp 2  Lê Thu Hà      REQUEST_CHANGE                      │
│                    │                   "Vượt trần band 15%, đề nghị đưa về mức ≤10%"             │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ Ý kiến của bạn  [ .................................................... ]    │
│                    │ # Bắt buộc nhập khi chọn "Yêu cầu chỉnh sửa" hoặc "Từ chối".                │
│                    │                                                                             │
│                    │  [ Phê duyệt ]     [ Yêu cầu chỉnh sửa ]     [ Từ chối ]                    │
│                    │ # Phê duyệt ở cấp cuối sẽ chuyển offer sang SIGNED_BY_COMPANY và gửi cho    │
│                    │ # ứng viên; Application chuyển OFFER_SENT (Bảng 3.1b của Chương 3).         │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.78 — SCR-08, chi tiết offer kèm ba nút quyết định*

**Thành phần chính**

Bảng 5.70 mô tả thành phần của SCR-08.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Tab | 3 tab | Chờ tôi duyệt, Đã quyết định, Theo dõi | Số trong ngoặc lấy từ `offer_approvals` lọc theo `approver_id` và `decision = PENDING` |
| Danh sách | Bảng 6 cột | Mã offer, ứng viên và vị trí, mức lương, phần trăm so với band, cấp của người dùng, hạn quyết định | Sắp xếp mặc định theo hạn quyết định; chỉ mục `offers(status, deadline)` do D đề xuất phục vụ đúng truy vấn này |
| Danh sách | Khối đã quyết định gần đây | Mã, ứng viên, mức lương, cấp, quyết định và thời điểm | Dòng ngoài thẩm quyền hiện ở chế độ chỉ đọc, không có nút quyết định |
| Chi tiết | Khối nội dung offer | Vị trí, mức lương, ngày bắt đầu, phúc lợi, hạn phản hồi | Phúc lợi đọc từ cột JSONB `offers.benefits` |
| Chi tiết | Thanh so sánh band | Vạch band tối thiểu, tối đa và điểm mức đề xuất | Dùng bản chụp band lưu trên offer, không dùng band hiện tại của JD |
| Chi tiết | Dải kết luận BR-08 | Phần trăm vượt band kèm phép tính và số cấp duyệt | Đúng ba nhánh của BR-08 |
| Chi tiết | Chuỗi duyệt lần này | Cấp, người duyệt, vai trò, quyết định, thời điểm, ý kiến | Đọc `offer_approvals` lọc theo `attempt_no` hiện tại |
| Chi tiết | Lịch sử lần duyệt trước | Cùng cấu trúc, lọc theo `attempt_no` nhỏ hơn | Giữ được lịch sử nhờ ràng buộc `UNIQUE(offer_id, level, attempt_no)` của C |
| Chi tiết | Ô ý kiến | Nội dung nhận xét | Bắt buộc với "Yêu cầu chỉnh sửa" và "Từ chối"; tuỳ chọn với "Phê duyệt" |
| Chi tiết | 3 nút quyết định | Phê duyệt, Yêu cầu chỉnh sửa, Từ chối | Ghi vào `offer_approvals.decision` bằng ba giá trị `APPROVED`, `REQUEST_CHANGE`, `REJECTED`; xử lý bởi `ApprovalWorkflow` (C11) |

*Bảng 5.70 — Thành phần chính của SCR-08*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **BR-08** — cấp của người dùng và tổng số cấp được nêu rõ ngay đầu màn chi tiết.
- **UC-04 A4.1** — "Yêu cầu chỉnh sửa" trả offer về Recruiter và làm quy trình chạy lại từ cấp 1.
- **BR-09** — hạn phản hồi của ứng viên được in để người duyệt biết mình đang giữ bao nhiêu thời gian của người khác.
- **BR-16** — cùng khung giao diện này được dùng lại cho luồng duyệt mở JD, vì cả hai đối tượng đều là `Approvable`.
- **NFR-06** — mỗi quyết định sinh một dòng `audit_logs` kèm người thực hiện, thời điểm và nội dung ý kiến.
- **ADR-08** — hai người duyệt cùng cấp thao tác song song sẽ bị khoá lạc quan chặn, chỉ một quyết định được ghi nhận.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** không có offer chờ duyệt thì tab hiện "Bạn không có offer nào cần quyết định" kèm số offer đang theo dõi, để người dùng biết hệ thống vẫn chạy chứ không phải hỏng.
- **Đang tải:** danh sách hiện ba dòng khung xám; màn chi tiết nạp khối nội dung offer trước, khối lịch sử duyệt sau, vì khối đầu là thứ người dùng đọc trước.
- **Lỗi:** nếu offer vừa bị Recruiter thu hồi hoặc vừa được người duyệt khác quyết trong lúc màn đang mở, ba nút bị vô hiệu hoá và dải cảnh báo ghi "OFF-318 vừa được cập nhật lúc 26/08/2026 10:14 — tải lại để xem trạng thái mới"; nếu ghi quyết định thất bại, ý kiến vừa nhập được giữ lại trong ô thay vì mất trắng.

**Phân quyền**

Theo ma trận RBAC, cấp 1 chỉ dành cho Hiring Manager, cấp 2 cho Head of HR, cấp 3 cho Người duyệt Tài
chính. Không vai trò nào duyệt được cấp không thuộc về mình, kể cả HR Admin. Recruiter không có nút
quyết định nhưng theo dõi được tiến độ trên SCR-07. Head of HR và HR Admin đọc được offer toàn công ty
theo quyền báo cáo, còn Người duyệt Tài chính chỉ đọc phần chi phí offer.

**Ghi chú thiết kế**

Khối "Lịch sử lần duyệt trước" là phần dễ bị bỏ sót nhất nhưng lại quan trọng nhất về mặt nghiệp vụ:
nếu không có nó, người duyệt cấp 2 ở lần thứ hai không biết chính mình đã yêu cầu chỉnh sửa gì ở lần
thứ nhất, và rất dễ yêu cầu lại một lần nữa. Đây là lý do D ủng hộ thiết kế `attempt_no` mà B đề xuất
và C đã cài đặt. Đánh đổi là màn chi tiết dài ra và phải cuộn; phương án thay thế là gấp khối lịch sử
lại mặc định, nhưng đã bị loại vì thông tin quan trọng bị giấu sau một cú bấm thì thực tế sẽ không ai
mở.

---

## 12. SCR-09 — Candidate Portal

- **Actor:** Candidate (Hoàng Thị Mai Chi) | **UC phục vụ:** UC-01 ở bước xác nhận lịch, UC-04 ở bước phản hồi offer, UC-06 ở nhánh đề xuất thương lượng | **Độ chi tiết:** mid-fi
- **Mục tiêu người dùng:** biết mình đang ở đâu trong quy trình, xác nhận hoặc xin đổi lịch phỏng vấn, và phản hồi offer — tất cả mà không cần tạo tài khoản hay nhớ mật khẩu.

Màn này chạy trong `CandidatePortalApp` (C02), là ứng dụng tách rời với `InternalWebApp`. Theo ADR-09,
ứng viên **không** phải một hàng trong bảng `users`, **không** đăng nhập SSO nội bộ, và **không** có
bản ghi `notifications` trong ứng dụng. Toàn bộ phiên làm việc dựa trên một liên kết mời chứa token có
hạn, đúng đề xuất bảng `candidate_portal_tokens` mà D gửi cho C.

**Wireframe — trạng thái xem tiến trình hồ sơ**

Hình 5.79 vẽ trang chính của cổng ứng viên lúc 17/08/2026 21:18, ngay sau khi Hoàng Thị Mai Chi bấm
liên kết trong email mời. Dải trên cùng nói rõ đây là phiên truy cập bằng liên kết cá nhân và nêu thời
điểm hết hạn — đây là điểm khác biệt căn bản so với chín màn nội bộ.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech · Tuyển dụng                                                            VI | EN           │
│ Xin chào Hoàng Thị Mai Chi                                       17/08/2026 21:18                │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ # Bạn đang truy cập bằng liên kết cá nhân gửi tới mai.chi.hoang@gmail.com.                       │
│ # Không cần tài khoản, không cần mật khẩu. Liên kết hết hạn 24/08/2026 17:00.                    │
│ # Vui lòng không chuyển tiếp liên kết này cho người khác.        [ Gửi lại liên kết mới ]        │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ HỒ SƠ CỦA BẠN                                                                                    │
│ Vị trí ứng tuyển : Senior Backend Engineer (Java) — Công ty CP Công nghệ Vạn Xuân                │
│ Ngày nộp hồ sơ   : 05/08/2026                                                                    │
│                                                                                                  │
│   (v) Nộp hồ sơ ──── (v) Sàng lọc ──── ( ● ) Phỏng vấn ──── ( ) Offer ──── ( ) Nhận việc         │
│    05/08/2026         07/08/2026        vòng 2 trên 3                                            │
│                                                                                                  │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ DIỄN BIẾN                                                                                        │
│ 05/08/2026 19:40  Chúng tôi đã nhận hồ sơ của bạn                                                │
│ 07/08/2026 10:30  Hồ sơ của bạn được chọn vào vòng phỏng vấn                                     │
│ 11/08/2026 15:05  Bạn đã hoàn thành vòng 1 — Technical Round 1                                   │
│ 17/08/2026 16:00  Bạn nhận được lời mời phỏng vấn vòng 2 — cần xác nhận                          │
│ # Trang này chỉ hiển thị các mốc công khai. Điểm số và nhận xét của người phỏng vấn              │
│ # là thông tin nội bộ và không được hiển thị cho ứng viên.                                       │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ [ Cần xác nhận lịch phỏng vấn vòng 2 ]   [ Cập nhật CV ]   [ Rút hồ sơ ứng tuyển ]               │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Liên hệ: Nguyễn Minh Anh — minh.anh.nguyen@vxtech.vn                                             │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.79 — SCR-09, trạng thái xem tiến trình hồ sơ*

**Wireframe — trạng thái xác nhận lịch phỏng vấn**

Hình 5.80 vẽ thẻ xác nhận lịch. Đồng hồ đếm ngược lấy đúng mốc 24 giờ của BR-05 và nêu rõ hệ quả nếu
bỏ trống: hồ sơ chuyển sang trạng thái cần xếp lại lịch. Câu chữ được viết cho người ngoài công ty nên
không dùng tên trạng thái kỹ thuật `NEED_RESCHEDULE`.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech · Tuyển dụng                                                            VI | EN           │
│ Xin chào Hoàng Thị Mai Chi                                       17/08/2026 21:18                │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ XÁC NHẬN LỊCH PHỎNG VẤN                                                                          │
│                                                                                                  │
│ ┌─────────────────────────────────────────────────────────────────────────────────────┐          │
│ │ ! Còn 18 giờ 42 phút để xác nhận — hạn 18/08/2026 16:00                             │          │
│ │   Nếu chưa xác nhận trước hạn, buổi phỏng vấn sẽ được huỷ và chúng tôi sẽ liên hệ   │          │
│ │   để sắp xếp lại lịch mới.                                                          │          │
│ └─────────────────────────────────────────────────────────────────────────────────────┘          │
│                                                                                                  │
│ Vòng phỏng vấn : Vòng 2 trên 3 — System Design                                                   │
│ Thời gian      : Thứ Năm, 20/08/2026, 16:00 – 17:30 (90 phút, giờ Việt Nam)                      │
│ Hình thức      : Trực tuyến qua Google Meet                                                      │
│ Liên kết họp   : sẽ hiển thị tại đây sau khi bạn xác nhận                                        │
│ Người phỏng vấn: Vũ Ngọc Lan — Senior Backend Engineer                                           │
│                  Trần Quốc Bảo — Trưởng bộ phận Công nghệ                                        │
│ Chuẩn bị       : Vui lòng chuẩn bị sẵn môi trường lập trình trên máy của bạn.                    │
│                                                                                                  │
│ [ Tôi xác nhận tham gia ]        [ Tôi cần đổi lịch ]                                            │
│                                                                                                  │
│ # Chọn "Tôi cần đổi lịch" sẽ mở ô nhập 3 khung giờ bạn thuận tiện; đề nghị của bạn               │
│ # được gửi tới Nguyễn Minh Anh và buổi phỏng vấn hiện tại được giữ nguyên cho tới khi            │
│ # có lịch thay thế.                                                                              │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ [ Thêm vào lịch của tôi (.ics) ]      Liên hệ: minh.anh.nguyen@vxtech.vn                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.80 — SCR-09, trạng thái xác nhận lịch phỏng vấn*

**Wireframe — trạng thái nhận offer và đề xuất thương lượng**

Hình 5.81 vẽ trang offer lúc 26/08/2026 14:30, sau khi Lê Thu Hà phê duyệt cấp 2. Ô đề xuất thương
lượng đang mở, tương ứng luồng `<<extend>>` UC-06. Điểm cần chú ý là hai lớp bảo vệ khác nhau: xem
offer chỉ cần token của liên kết, nhưng **chấp nhận** offer thì cần thêm một mã dùng một lần gửi về
email, đúng quy tắc "token dùng một lần cho hành động nhạy cảm" trong cơ chế vòng đời phiên của ứng
viên.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech · Tuyển dụng                                                            VI | EN           │
│ Xin chào Hoàng Thị Mai Chi                                       26/08/2026 14:30                │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ THƯ MỜI NHẬN VIỆC                                                                                │
│ ┌─────────────────────────────────────────────────────────────────────────────────────┐          │
│ │ Vị trí        Senior Backend Engineer (Java) — Khối Công nghệ                       │          │
│ │ Mức lương     51.840.000 VND/tháng (gross)                                          │          │
│ │ Ngày bắt đầu  15/09/2026                                                            │          │
│ │ Phúc lợi      Lương tháng 13                                                        │          │
│ │               Thử việc hưởng 100% lương                                             │          │
│ │               Bảo hiểm sức khoẻ mở rộng                                             │          │
│ │               15 ngày phép năm                                                      │          │
│ │               Ngân sách đào tạo 15.000.000 VND mỗi năm                              │          │
│ │ Hạn phản hồi  17:00 ngày 07/09/2026                                                 │          │
│ └─────────────────────────────────────────────────────────────────────────────────────┘          │
│ [ Tải thư mời dạng PDF ]                                                                         │
│                                                                                                  │
│ ! Còn 7 ngày làm việc để phản hồi. Sau 17:00 ngày 07/09/2026 thư mời hết hiệu lực.               │
│                                                                                                  │
│ [ Chấp nhận ]      [ Từ chối ]      [ Đề xuất thương lượng ]  ← đang mở                          │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ ĐỀ XUẤT THƯƠNG LƯỢNG                                                                             │
│ Mức lương mong muốn   [ 56.000.000 ................ ] VND/tháng                                  │
│ Ngày bắt đầu mong muốn[ 01/10/2026 v ]                                                           │
│ Lý do (bắt buộc)      [ Tôi cần thêm 2 tuần bàn giao công việc ở nơi làm hiện tại. ]             │
│                                                                                                  │
│ # Đề xuất của bạn sẽ được gửi tới bộ phận tuyển dụng. Thư mời hiện tại vẫn còn hiệu lực          │
│ # đến 17:00 ngày 07/09/2026 trong lúc hai bên trao đổi.                                          │
│                                            [ Huỷ ]     [ Gửi đề xuất ]                           │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ # Khi bấm [ Chấp nhận ], hệ thống gửi một mã xác nhận dùng một lần tới                           │
│ # mai.chi.hoang@gmail.com và yêu cầu bạn nhập mã đó trước khi ghi nhận quyết định.               │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.81 — SCR-09, trạng thái nhận offer và đề xuất thương lượng*

**Thành phần chính**

Bảng 5.71 mô tả thành phần của SCR-09.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Đầu trang | Dải giải thích phiên truy cập | Email nhận liên kết, thời điểm liên kết hết hạn | Token băm lưu ở bảng `candidate_portal_tokens` theo đề xuất P1 của D; hạn 7 ngày (ADR-09) |
| Đầu trang | Nút gửi lại liên kết mới | Nhãn nút | Phát hành token mới và thu hồi token cũ; giới hạn tần suất theo email |
| Tiến trình | Thanh 5 bước | Nộp hồ sơ, Sàng lọc, Phỏng vấn, Offer, Nhận việc | Ánh xạ mười tám giá trị `application_status` về năm bước dễ hiểu với người ngoài |
| Diễn biến | Danh sách mốc công khai | Thời điểm và câu mô tả bằng ngôn ngữ đời thường | Lọc từ `application_status_history`, bỏ hết mốc nội bộ; không hiển thị điểm và nhận xét (BR-20) |
| Xác nhận lịch | Đồng hồ đếm ngược | Thời gian còn lại và mốc hạn | 24 giờ theo BR-05; diễn đạt hệ quả bằng lời, không dùng tên trạng thái kỹ thuật |
| Xác nhận lịch | Thông tin buổi phỏng vấn | Vòng, thời gian, hình thức, người phỏng vấn, yêu cầu chuẩn bị | Liên kết họp chỉ hiện sau khi xác nhận, tránh việc liên kết bị chuyển tiếp |
| Xác nhận lịch | Hai nút quyết định | Xác nhận tham gia, Cần đổi lịch | "Cần đổi lịch" mở ô nhập ba khung giờ thuận tiện, gửi tới Recruiter |
| Xác nhận lịch | Nút tải tệp .ics | Nhãn nút | Cho phép thêm buổi phỏng vấn vào lịch cá nhân mà không cần tích hợp tài khoản |
| Offer | Thẻ nội dung offer | Vị trí, mức lương, ngày bắt đầu, phúc lợi, hạn phản hồi | Dữ liệu từ `offers`; không hiển thị band lương và không hiển thị chuỗi duyệt nội bộ |
| Offer | Ba nút phản hồi | Chấp nhận, Từ chối, Đề xuất thương lượng | Ứng với `ACCEPTED`, `DECLINED`, `NEGOTIATING` của `offer_status` |
| Offer | Biểu mẫu thương lượng | Mức lương mong muốn, ngày bắt đầu mong muốn, lý do bắt buộc | Kích hoạt UC-06; Application chuyển `NEGOTIATING`, Recruiter tạo bản offer mới |
| Offer | Ghi chú mã dùng một lần | Câu mô tả bước xác nhận thêm | Chỉ áp dụng cho hành động chấp nhận offer |

*Bảng 5.71 — Thành phần chính của SCR-09*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **ADR-09** — không có SSO, không có mật khẩu, không có bản ghi `notifications`; toàn bộ phiên dựa trên liên kết mời có token và có hạn.
- **BR-05** — đồng hồ đếm ngược 24 giờ và mô tả hệ quả nếu quá hạn.
- **BR-09** — hạn phản hồi offer 7 ngày làm việc, hiển thị cả ngày giờ tuyệt đối lẫn số ngày còn lại.
- **BR-12** — nội dung email dẫn tới trang này dùng template đã được duyệt và có cả bản tiếng Việt lẫn tiếng Anh.
- **BR-20** — điểm số, nhận xét, band lương và chuỗi duyệt nội bộ đều bị loại khỏi mọi khung nhìn của ứng viên.
- **UC-06** — nhánh đề xuất thương lượng có ô lý do bắt buộc và giữ nguyên hiệu lực offer hiện tại.
- **NFR-09** — toàn bộ nhãn và câu thông báo có bản tiếng Anh tương đương.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** khi chưa có việc gì cần ứng viên làm, khối hành động hiện "Hiện chưa cần bạn thực hiện thao tác nào — chúng tôi sẽ gửi email khi có cập nhật", để ứng viên không phải quay lại kiểm tra liên tục.
- **Đang tải:** trang tải theo từng khối, khối tiến trình ưu tiên trước; cổng ứng viên được thiết kế nhẹ vì ứng viên thường mở bằng điện thoại và mạng di động.
- **Lỗi:** ba nhánh — token hết hạn hiện "Liên kết đã hết hạn ngày 24/08/2026" kèm nút gửi liên kết mới thay vì báo lỗi kỹ thuật; token đã bị thu hồi do hồ sơ đã kết thúc thì hiện "Hồ sơ ứng tuyển này đã khép lại" kèm thông tin liên hệ; nhập sai mã dùng một lần quá 5 lần thì khoá thao tác chấp nhận trong 15 phút và ghi `audit_logs`.

**Phân quyền**

Ứng viên chỉ thấy chính hồ sơ gắn với token của mình, tương ứng ô "Của chính mình" trong ma trận RBAC.
Ứng viên không thấy bất kỳ dữ liệu nào của ứng viên khác, không thấy JD ở trạng thái `DRAFT`, và không
truy cập được bất kỳ đường dẫn nào của `InternalWebApp`. Ngược lại, sáu vai trò nội bộ không đăng nhập
được vào cổng ứng viên bằng tài khoản công ty, vì hai ứng dụng dùng hai cơ chế xác thực tách rời.

**Ghi chú thiết kế**

Việc bỏ hẳn tài khoản cho ứng viên là quyết định có đánh đổi rõ ràng. Được: không phải quản lý mật
khẩu của người ngoài công ty, không phải xử lý quên mật khẩu, giảm hẳn nghĩa vụ bảo vệ dữ liệu định
danh. Mất: ai cầm được email của ứng viên thì cầm được phiên truy cập, và ứng viên không có chỗ để xem
lại lịch sử nhiều lần ứng tuyển. Rủi ro thứ nhất được giảm bằng hạn token 7 ngày, bằng việc thu hồi
token khi hồ sơ kết thúc, và bằng mã dùng một lần cho hành động chấp nhận offer. Rủi ro thứ hai được
chấp nhận, vì trong phạm vi bài tập lớn, mục tiêu là minh bạch cho một lần ứng tuyển chứ chưa phải xây
hồ sơ cá nhân lâu dài. Phương án bị loại là cho ứng viên đăng nhập bằng Google cá nhân: tiện hơn nhưng
kéo theo việc phải xử lý ứng viên đổi email giữa chừng — đúng rủi ro đã nêu ở mục 15 của đặc tả.

---

## 13. SCR-10 — Reports Dashboard

- **Actor:** HR Admin (Đỗ Hải Yến), Head of HR (Lê Thu Hà) | **UC phục vụ:** UC-05 | **Độ chi tiết:** mid-fi
- **Mục tiêu người dùng:** trả lời bốn câu hỏi quản trị — hồ sơ rơi rụng ở khâu nào, tuyển một người mất bao lâu, nguồn nào hiệu quả, và có giữ được cam kết phản hồi ứng viên hay không.

Toàn bộ số liệu trên hai khối wireframe dưới đây là **số liệu minh hoạ giả định**, không suy ra được từ
tài liệu nào trong repo. Điều được kiểm soát chặt là tính nhất quán nội bộ: tổng số hồ sơ theo nguồn
bằng đúng bậc đầu của funnel, và tổng số người được tuyển theo phòng ban bằng đúng bậc cuối.

**Wireframe — trạng thái chưa đủ dữ liệu**

Hình 5.82 vẽ trường hợp người dùng chọn khoảng thời gian ngắn hơn điều kiện tiên quyết của UC-05 là
"có dữ liệu tuyển dụng từ 30 ngày trở lên". Thay vì vẽ bốn biểu đồ rỗng, màn hình nói rõ thiếu bao
nhiêu và đề nghị một khoảng thay thế. Nhãn "Dữ liệu cập nhật lúc" vẫn được giữ nguyên ở trạng thái
này, vì nó mô tả độ tươi của read model chứ không phụ thuộc bộ lọc.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Báo cáo tuyển dụng                                                                │
│              [ Tìm ............................. ]          Thông báo (0)   VI|EN   DHY v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Báo cáo tuyển dụng                                    18/08/2026 10:15      │
│ ────────────────── │ Dữ liệu cập nhật lúc 18/08/2026 10:15 (làm mới mỗi 15 phút)                 │
│   Bảng điều khiển  ├─────────────────────────────────────────────────────────────────────────────┤
│   Ứng viên (đọc)   │ Khoảng thời gian [ 05/08/2026 ] – [ 17/08/2026 ]   Phòng ban [ Tất cả v ]   │
│ > Báo cáo          │ JD [ Tất cả v ]   Nguồn [ Tất cả v ]      [ Áp dụng ]  [ Xuất CSV ]* [PDF]* │
│   Quản trị         ├─────────────────────────────────────────────────────────────────────────────┤
│     - Người dùng   │ ┌─────────────────────────────────────────────────────────────────────────┐ │
│     - Phòng ban    │ │ ! Chưa đủ dữ liệu để dựng báo cáo                                       │ │
│     - Template mail│ │                                                                         │ │
│     - Audit log    │ │   Khoảng bạn chọn chỉ có 13 ngày dữ liệu (05/08/2026 – 17/08/2026).     │ │
│ ────────────────── │ │   Báo cáo funnel và time-to-hire cần tối thiểu 30 ngày để số liệu có ý  │ │
│ Đỗ Hải Yến         │ │   nghĩa thống kê (điều kiện tiên quyết của UC-05).                      │ │
│ HR Admin           │ │                                                                         │ │
│                    │ │   Trong khoảng này mới có 18 hồ sơ và 0 lượt tuyển thành công, nên      │ │
│                    │ │   tỷ lệ chuyển đổi và thời gian tuyển trung bình chưa tính được.        │ │
│                    │ │                                                                         │ │
│                    │ │   [ Đổi sang khoảng 01/07/2026 – 17/08/2026 (48 ngày) ]                 │ │
│                    │ └─────────────────────────────────────────────────────────────────────────┘ │
│                    │                                                                             │
│                    │ ┌───────────────────────────┐  ┌────────────────────────────────────────┐   │
│                    │ │ FUNNEL                    │  │ TIME-TO-HIRE THEO PHÒNG BAN            │   │
│                    │ │   Chưa đủ dữ liệu         │  │   Chưa đủ dữ liệu                      │   │
│                    │ └───────────────────────────┘  └────────────────────────────────────────┘   │
│                    │ ┌───────────────────────────┐  ┌────────────────────────────────────────┐   │
│                    │ │ HIỆU QUẢ NGUỒN TUYỂN      │  │ TỶ LỆ PHẢN HỒI ĐÚNG HẠN                │   │
│                    │ │   Chưa đủ dữ liệu         │  │   91,4% (tính trên toàn bộ lịch sử)    │   │
│                    │ └───────────────────────────┘  └────────────────────────────────────────┘   │
│                    │ # Chỉ số phản hồi đúng hạn không phụ thuộc độ dài khoảng nên vẫn hiển thị.  │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.82 — SCR-10, trạng thái chưa đủ dữ liệu*

**Wireframe — trạng thái đầy đủ bốn biểu đồ**

Hình 5.83 vẽ báo cáo trên khoảng 01/07/2026 – 17/08/2026. Bốn biểu đồ đúng bằng bốn biểu đồ mà UC-05
liệt kê, và mỗi biểu đồ được nuôi bằng một bảng read model riêng theo cơ chế đã chốt: `rm_funnel_daily`,
`rm_time_to_hire`, `rm_source_effectiveness`, `rm_sla_compliance`.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Báo cáo tuyển dụng                                                                │
│              [ Tìm ............................. ]          Thông báo (0)   VI|EN   DHY v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Báo cáo tuyển dụng                                    18/08/2026 10:15      │
│ ────────────────── │ Dữ liệu cập nhật lúc 18/08/2026 10:15 (làm mới mỗi 15 phút)   [ Làm mới ]   │
│   Bảng điều khiển  ├─────────────────────────────────────────────────────────────────────────────┤
│   Ứng viên (đọc)   │ Khoảng thời gian [ 01/07/2026 ] – [ 17/08/2026 ]   Phòng ban [ Tất cả v ]   │
│ > Báo cáo          │ JD [ Tất cả v ]   Nguồn [ Tất cả v ]      [ Áp dụng ]  [ Xuất CSV ] [ PDF ] │
│   Quản trị         ├─────────────────────────────────────────────────────────────────────────────┤
│     - Người dùng   │ 1. FUNNEL TUYỂN DỤNG                                                        │
│     - Phòng ban    │ Applied    ████████████████████████████████████████████████   128           │
│     - Template mail│ Screening  ████████████████████████████████████               96  75,0%     │
│     - Audit log    │ Interview  ███████████████                                    41  42,7%     │
│ ────────────────── │ Offer      ███                                                 9  22,0%     │
│ Đỗ Hải Yến         │ Hired      █                                                   4  44,4%     │
│ HR Admin           │ # Tỷ lệ tính trên bậc liền trước. Nguồn: rm_funnel_daily.                   │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ 2. TIME-TO-HIRE THEO PHÒNG BAN (ngày, trung bình)   Mục tiêu ≤ 30 ngày      │
│                    │ Khối Công nghệ  ██████████████████████████████████  30  (3 lượt tuyển)      │
│                    │ Khối Nhân sự    ████████████████████████            22  (1 lượt tuyển)      │
│                    │ # Tính từ applied_at tới mốc HIRED trên application_status_history.         │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ 3. HIỆU QUẢ NGUỒN TUYỂN                                                     │
│                    │ ┌──────────────┬────────┬─────────┬──────────┬────────────────────────┐     │
│                    │ │ Nguồn        │ Hồ sơ  │ Phỏng   │ Tuyển    │ Tỷ lệ tuyển / hồ sơ    │     │
│                    │ │              │        │ vấn     │ được     │                        │     │
│                    │ ├──────────────┼────────┼─────────┼──────────┼────────────────────────┤     │
│                    │ │ REFERRAL     │   18   │   11    │    2     │ 11,1%                  │     │
│                    │ │ LINKEDIN     │   46   │   16    │    1     │  2,2%                  │     │
│                    │ │ WEBSITE      │   51   │   11    │    1     │  2,0%                  │     │
│                    │ │ HEADHUNTER   │   13   │    3    │    0     │  0,0%                  │     │
│                    │ ├──────────────┼────────┼─────────┼──────────┼────────────────────────┤     │
│                    │ │ Tổng         │  128   │   41    │    4     │  3,1%                  │     │
│                    │ └──────────────┴────────┴─────────┴──────────┴────────────────────────┘     │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ 4. TỶ LỆ PHẢN HỒI ĐÚNG HẠN (SLA)                     91,4%   Mục tiêu 90%   │
│                    │ Phản hồi sau sàng lọc      ████████████████████████████████  94,2%          │
│                    │ Xác nhận lịch đúng 24h     ██████████████████████████████    89,1%          │
│                    │ Feedback đúng 48h          ████████████████████████████      85,7%          │
│                    │ Gửi offer đúng hạn         ██████████████████████████████████ 100%          │
│                    │ # Toàn bộ số liệu trên màn này là số liệu minh hoạ giả định.                │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.83 — SCR-10, trạng thái đầy đủ bốn biểu đồ*

**Thành phần chính**

Bảng 5.72 mô tả thành phần của SCR-10.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Đầu trang | Nhãn độ tươi dữ liệu | "Dữ liệu cập nhật lúc 18/08/2026 10:15 (làm mới mỗi 15 phút)" | Giá trị `dataFreshness` do `ReportingService` (C18) trả về; là yêu cầu hiển thị bắt buộc của NFR-10 |
| Đầu trang | Nút làm mới | Nhãn nút | Kích hoạt đọc lại read model, không kích hoạt tính lại từ đầu, để không kéo tải sang cơ sở dữ liệu chính |
| Bộ lọc | Khoảng thời gian, phòng ban, JD, nguồn | Giá trị đang chọn | Bộ lọc áp cho cả bốn biểu đồ cùng lúc; trạng thái bộ lọc ghi vào đường dẫn để chia sẻ được |
| Bộ lọc | Nút xuất CSV và PDF | Nhãn nút | Bị vô hiệu hoá ở trạng thái chưa đủ dữ liệu; tệp xuất kèm dòng ghi khoảng thời gian và mốc `dataFreshness` |
| Biểu đồ 1 | Funnel 5 bậc | Applied, Screening, Interview, Offer, Hired kèm tỷ lệ chuyển đổi | Nguồn `rm_funnel_daily`; tỷ lệ tính trên bậc liền trước, được ghi rõ để tránh hiểu nhầm |
| Biểu đồ 2 | Time-to-hire theo phòng ban | Số ngày trung bình, số lượt tuyển, vạch mục tiêu | Nguồn `rm_time_to_hire`; định nghĩa metric thuộc BR-24, ghi ngay dưới biểu đồ |
| Biểu đồ 3 | Bảng hiệu quả nguồn | Nguồn, số hồ sơ, số lượt phỏng vấn, số tuyển được, tỷ lệ | Nguồn `rm_source_effectiveness`; giá trị nguồn khớp ENUM `candidate_source` của C |
| Biểu đồ 4 | Tỷ lệ phản hồi đúng hạn | Tỷ lệ tổng và bốn thành phần | Nguồn `rm_sla_compliance`; liên quan BR-25 về trạng thái gửi thông báo |
| Chân trang | Ghi chú số liệu giả định | Câu ghi chú | Yêu cầu trung thực khi trình bày, tránh hiểu nhầm đây là số liệu thật |

*Bảng 5.72 — Thành phần chính của SCR-10*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **UC-05** — điều kiện tiên quyết "có dữ liệu tuyển dụng từ 30 ngày trở lên" được kiểm tra và giải thích ngay trên giao diện.
- **BR-24** — định nghĩa từng metric được in cạnh biểu đồ, không để người đọc tự đoán.
- **BR-25** — biểu đồ thứ tư chỉ tính là đạt hạn khi thông báo đã gửi thành công, tương ứng đề xuất P2 của D về cột `notifications.delivery_status`.
- **NFR-10** — truy vấn biểu đồ chạy trên bản sao chỉ đọc, mục tiêu 3 giây ở phân vị 95, độ trễ dữ liệu tối đa 15 phút và bắt buộc hiển thị mốc cập nhật.
- **ADR-02 và ADR-07** — nguồn dữ liệu là bốn bảng tổng hợp trên bản sao, không phải truy vấn trực tiếp bảng nghiệp vụ.
- **BR-20** — phạm vi dữ liệu thay đổi theo vai trò, xem mục phân quyền bên dưới.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** Hình 5.82 — nêu rõ thiếu bao nhiêu ngày, có bao nhiêu bản ghi trong khoảng đang chọn, và đề nghị một khoảng thay thế bấm được ngay. Biểu đồ nào tính được thì vẫn hiển thị thay vì làm trống cả trang.
- **Đang tải:** bốn khung biểu đồ hiện khung xám đúng kích thước; nhãn độ tươi dữ liệu hiện ngay từ đầu vì nó lấy từ siêu dữ liệu nhẹ, không phải chờ dữ liệu biểu đồ.
- **Lỗi:** nếu bản sao chỉ đọc trễ quá 60 giây so với bản chính, dải cảnh báo ghi "Dữ liệu có thể chậm hơn thực tế — bản sao đang trễ 2 phút 40 giây" đúng ngưỡng cảnh báo của NFR-13, và biểu đồ vẫn hiển thị; nếu `ReportingService` không phản hồi, hiện "Không tải được báo cáo — Mã theo dõi 9c40-15ab" kèm nút thử lại, và nêu rõ sự cố này không ảnh hưởng tới thao tác tuyển dụng hằng ngày, đúng tinh thần tách tải của ADR-07.

**Phân quyền**

HR Admin và Head of HR xem báo cáo toàn công ty. Recruiter chỉ xem báo cáo giới hạn trong các JD mình
phụ trách, bộ lọc phòng ban bị khoá ở phòng ban của mình. Hiring Manager xem trong phạm vi phòng ban.
Người duyệt Tài chính chỉ thấy phần liên quan chi phí offer, ba biểu đồ còn lại không render.
Interviewer và Candidate không có đường vào màn này.

**Ghi chú thiết kế**

Nhãn độ tươi dữ liệu được đặt ngay dưới tiêu đề, không giấu trong phần chú thích cuối trang, vì đây là
cam kết trung thực quan trọng nhất của màn báo cáo: người xem phải biết mình đang nhìn số liệu của 15
phút trước chứ không phải của giây này. Đây cũng chính là câu trả lời cho câu hỏi bảo vệ "reporting
service tách riêng có làm phức tạp thêm không" — cái giá của việc tách là độ trễ 15 phút, và cái giá đó
được nói thẳng trên giao diện thay vì giấu đi. Phương án bị loại là báo cáo thời gian thực đọc thẳng
bảng nghiệp vụ: đúng tới từng giây nhưng đặt truy vấn gộp nặng lên cùng cơ sở dữ liệu đang phục vụ
kanban và xếp lịch, vi phạm NFR-01 và NFR-10.

---

## 14. SCR-11 — Admin, Users và Departments

- **Actor:** HR Admin (Đỗ Hải Yến) | **UC phục vụ:** chức năng F09, nằm ngoài năm use case trọng tâm — ghi rõ theo mâu thuẫn X-07 | **Độ chi tiết:** low-fi
- **Mục tiêu người dùng:** quản lý danh sách người dùng, gán vai trò và phòng ban, và biết ngay hệ quả của việc đổi vai trò trước khi bấm lưu.

Màn này được giữ ở mức low-fi có chủ ý: F09 không nằm trong năm use case được đặc tả chi tiết, nên
phần chưa chốt nghiệp vụ vẫn còn nhiều, và việc vẽ mid-fi sẽ tạo cảm giác đã chốt trong khi chưa.

**Wireframe — danh sách người dùng**

Hình 5.84 vẽ danh sách sáu người dùng nội bộ lúc 18/08/2026 11:05. Sáu vai trò trong cột "Vai trò"
khớp đúng sáu giá trị của ENUM `user_role` sau khi C bổ sung `HEAD_OF_HR` và `FINANCE` ở v1.2.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Quản trị › Người dùng                                                             │
│              [ Tìm tên, email ......................... ]   Thông báo (0)   VI|EN   DHY v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Quản trị người dùng                                   18/08/2026 11:05      │
│ ────────────────── ├─────────────────────────────────────────────────────────────────────────────┤
│   Bảng điều khiển  │ [ Người dùng (6) ]  [ Phòng ban (6) ]  [ Template email (14) ]              │
│   Ứng viên (đọc)   │ Vai trò [ Tất cả v ]   Trạng thái [ Tất cả v ]        [ + Thêm người dùng ] │
│   Báo cáo          ├─────────────────────────────────────────────────────────────────────────────┤
│ > Quản trị         │ ┌──────────────────┬────────────────┬──────────────────┬────────┬────────┐  │
│     > Người dùng   │ │ Họ tên           │ Vai trò        │ Phòng ban        │ T.thái │ Thao   │  │
│       Phòng ban    │ │ Email            │                │                  │        │ tác    │  │
│       Template mail│ ├──────────────────┼────────────────┼──────────────────┼────────┼────────┤  │
│       Audit log    │ │ Đỗ Hải Yến       │ HR_ADMIN       │ Khối Nhân sự     │ Hoạt   │ [Sửa]  │  │
│ ────────────────── │ │ hai.yen.do@...   │                │                  │ động   │        │  │
│ Đỗ Hải Yến         │ │ Lê Thu Hà        │ HEAD_OF_HR     │ Khối Nhân sự     │ Hoạt   │ [Sửa]  │  │
│ HR Admin           │ │ thu.ha.le@...    │                │                  │ động   │        │  │
│                    │ │ Nguyễn Minh Anh  │ RECRUITER      │ Phòng Tuyển dụng │ Hoạt   │ [Sửa]  │  │
│                    │ │ minh.anh.nguyen@ │                │                  │ động   │        │  │
│                    │ │ Phạm Đức Duy     │ FINANCE        │ Khối Tài chính   │ Hoạt   │ [Sửa]  │  │
│                    │ │ duc.duy.pham@... │                │                  │ động   │        │  │
│                    │ │ Trần Quốc Bảo    │ HIRING_MANAGER │ Khối Công nghệ   │ Hoạt   │ [Sửa]  │  │
│                    │ │ quoc.bao.tran@.. │                │                  │ động   │        │  │
│                    │ │ Vũ Ngọc Lan      │ INTERVIEWER    │ Nhóm Backend     │ Hoạt   │ [Sửa]  │  │
│                    │ │ ngoc.lan.vu@...  │                │                  │ động   │        │  │
│                    │ └──────────────────┴────────────────┴──────────────────┴────────┴────────┘  │
│                    │ # Toàn bộ email thuộc miền @vxtech.vn, rút gọn để vừa bề ngang wireframe.   │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ CÂY PHÒNG BAN (tab Phòng ban)                                               │
│                    │ Công ty CP Công nghệ Vạn Xuân                                               │
│                    │  ├─ Khối Công nghệ                                                          │
│                    │  │   ├─ Nhóm Backend                                                        │
│                    │  │   └─ Nhóm Dữ liệu                                                        │
│                    │  ├─ Khối Nhân sự                                                            │
│                    │  │   └─ Phòng Tuyển dụng                                                    │
│                    │  └─ Khối Tài chính                                                          │
│                    │ # Cây nhiều cấp dựa trên departments.parent_id (quan hệ đệ quy, Chương 4).  │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.84 — SCR-11, danh sách người dùng và cây phòng ban*

**Wireframe — biểu mẫu phân quyền**

Hình 5.85 vẽ biểu mẫu sửa quyền của Vũ Ngọc Lan. Điểm thiết kế quan trọng là khối "Hệ quả của thay
đổi": trước khi lưu, người quản trị nhìn thấy đúng những gì sẽ xảy ra — phiên đăng nhập bị thu hồi,
những buổi phỏng vấn đang được giao, và dòng audit sẽ được ghi.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│ VXTech ATS  ·  Quản trị › Người dùng › Vũ Ngọc Lan                                               │
│              [ Tìm tên, email ......................... ]   Thông báo (0)   VI|EN   DHY v        │
├────────────────────┬─────────────────────────────────────────────────────────────────────────────┤
│ VXTech ATS         │ Sửa người dùng — Vũ Ngọc Lan                          18/08/2026 11:07      │
│ ────────────────── ├─────────────────────────────────────────────────────────────────────────────┤
│   Bảng điều khiển  │ Họ tên       [ Vũ Ngọc Lan ..................... ]                          │
│   Ứng viên (đọc)   │ Email        ngoc.lan.vu@vxtech.vn    # chỉ đọc, đồng bộ từ Google          │
│   Báo cáo          │                                        Workspace, dùng làm khoá duy nhất    │
│ > Quản trị         │ Vai trò      [ INTERVIEWER v ]                                              │
│     > Người dùng   │                RECRUITER · HIRING_MANAGER · INTERVIEWER                     │
│       Phòng ban    │                HR_ADMIN · HEAD_OF_HR · FINANCE                              │
│       Template mail│ Phòng ban    [ Khối Công nghệ > Nhóm Backend v ]                            │
│       Audit log    │ Trạng thái   [x] Đang hoạt động                                             │
│ ────────────────── ├─────────────────────────────────────────────────────────────────────────────┤
│ Đỗ Hải Yến         │ PHẠM VI DỮ LIỆU ĐƯỢC CẤP (tự sinh theo vai trò, không sửa tay)              │
│ HR Admin           │ Xem hồ sơ ứng viên   : chỉ gói phỏng vấn được giao (BR-20)                  │
│                    │ Ghi scorecard        : của chính mình                                       │
│                    │ Duyệt offer          : không                                                │
│                    │ Báo cáo              : không                                                │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ ┌─────────────────────────────────────────────────────────────────────────┐ │
│                    │ │ ! HỆ QUẢ NẾU BẠN ĐỔI VAI TRÒ HOẶC TẮT TRẠNG THÁI HOẠT ĐỘNG              │ │
│                    │ │   1. Phiên đăng nhập hiện tại của người dùng bị thu hồi ngay.           │ │
│                    │ │   2. Vũ Ngọc Lan đang được giao 2 buổi phỏng vấn sắp tới; các buổi này  │ │
│                    │ │      cần Recruiter chỉ định người thay trước khi tắt tài khoản.         │ │
│                    │ │   3. Hệ thống ghi 1 dòng audit_logs với action = USER_ROLE_CHANGED.     │ │
│                    │ └─────────────────────────────────────────────────────────────────────────┘ │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │ LỊCH SỬ THAY ĐỔI GẦN ĐÂY                                                    │
│                    │ 17/08/2026 07:55  Ngừng hoạt động  Đồng bộ nhầm từ danh bạ nhân sự          │
│                    │ 17/08/2026 08:20  Mở lại           Đỗ Hải Yến — "khôi phục sau khi rà lại"  │
│                    │ # Đây là nguyên nhân của lỗi AUTH-403 minh hoạ ở Hình 5.62.                 │
│                    ├─────────────────────────────────────────────────────────────────────────────┤
│                    │                                      [ Huỷ ]      [ Lưu thay đổi ]          │
└────────────────────┴─────────────────────────────────────────────────────────────────────────────┘
```

*Hình 5.85 — SCR-11, biểu mẫu phân quyền cho một người dùng*

**Thành phần chính**

Bảng 5.73 mô tả thành phần của SCR-11.

| Vùng | Thành phần | Dữ liệu hiển thị | Hành vi / ràng buộc |
|---|---|---|---|
| Tab | 3 tab | Người dùng, Phòng ban, Template email | Ba nhóm đối tượng quản trị của F09 |
| Danh sách | Bảng 5 cột | Họ tên và email, vai trò, phòng ban, trạng thái, nút sửa | Vai trò hiển thị đúng giá trị ENUM `user_role`; nhãn tiếng Việt hiện ở phần chú giải và ở biểu mẫu |
| Cây phòng ban | Cây nhiều cấp | Công ty, khối, nhóm và phòng | Dựng từ `departments.parent_id`, đúng quan hệ đệ quy trong ERD của C |
| Biểu mẫu | Ô họ tên, ô email chỉ đọc | Giá trị hiện tại | Email đồng bộ từ Google Workspace và là khoá duy nhất theo ràng buộc `uq_users_email` |
| Biểu mẫu | Danh sách vai trò | 6 giá trị `user_role` | Một người dùng giữ đúng một vai trò, khớp thiết kế bảng đơn của C |
| Biểu mẫu | Ô chọn phòng ban | Đường dẫn đầy đủ trong cây | Quyết định phạm vi dữ liệu của người dùng theo BR-21 |
| Biểu mẫu | Ô trạng thái hoạt động | Đang hoạt động hay không | Ứng với cột `users.is_active`; tắt sẽ dẫn tới lỗi AUTH-403 ở SCR-01 |
| Biểu mẫu | Khối phạm vi dữ liệu | Bốn dòng mô tả quyền suy ra từ vai trò | Chỉ đọc, sinh từ ma trận RBAC, không cho sửa tay để tránh cấu hình lệch |
| Biểu mẫu | Khối hệ quả thay đổi | Ba hệ quả cụ thể của thao tác sắp thực hiện | Số buổi phỏng vấn đang giao là dữ liệu thật, truy vấn ngay khi mở biểu mẫu |
| Biểu mẫu | Lịch sử thay đổi | Thời điểm, hành động, người thực hiện, lý do | Nguồn `audit_logs` lọc theo `entity_type = USER` |

*Bảng 5.73 — Thành phần chính của SCR-11*

**Quy tắc nghiệp vụ hiển thị trên màn**

- **BR-01** — nếu người dùng bị đổi vai trò hoặc bị tắt trong khi đang là Recruiter hoặc Hiring Manager của một JD đang mở, hệ thống chặn lưu và yêu cầu chỉ định người thay.
- **BR-12** — tab Template email là nơi HR Admin duyệt template trước khi bất kỳ email nào được gửi ra ngoài.
- **BR-20 và BR-21** — khối phạm vi dữ liệu là bản diễn giải trực tiếp của ma trận RBAC.
- **NFR-04** — mỗi người dùng có đúng một vai trò cùng một phạm vi phòng ban; đây là nguồn dữ liệu cho việc kiểm tra quyền ở cả `ApiGateway` lẫn tầng dịch vụ.
- **NFR-06** — mọi thay đổi vai trò, phòng ban hay trạng thái đều ghi `audit_logs`.
- **ADR-10** — đổi vai trò thu hồi phiên hiện tại ngay, không chờ phiên hết hạn tự nhiên.

**Trạng thái rỗng / lỗi / đang tải**

- **Rỗng:** hệ thống mới cài đặt chỉ có một tài khoản HR Admin, danh sách hiện "Mới có 1 người dùng — nhập danh sách từ Google Workspace hoặc thêm thủ công" kèm hai nút tương ứng.
- **Đang tải:** bảng hiện sáu dòng khung xám; cây phòng ban nạp riêng vì thường sâu và ít thay đổi, được lưu đệm ở trình duyệt.
- **Lỗi:** trùng email hiện "Địa chỉ ngoc.lan.vu@vxtech.vn đã thuộc về một người dùng khác" ngay dưới ô nhập chứ không phải ở đầu trang; xoá phòng ban còn người dùng bị chặn bởi khoá ngoại `ON DELETE RESTRICT` và giao diện dịch lỗi đó thành "Không xoá được Nhóm Backend vì còn 1 người dùng thuộc phòng ban này".

**Phân quyền**

Chỉ vai trò `HR_ADMIN` vào được toàn bộ màn này. Head of HR đọc được `audit_logs` nhưng không quản trị
người dùng. Bốn vai trò còn lại và Candidate không có mục điều hướng và bị chặn ở tầng dịch vụ nếu gọi
thẳng API. Một ràng buộc bổ sung được đề nghị: HR Admin không tự hạ vai trò của chính mình, để hệ thống
không rơi vào trạng thái không còn ai quản trị được.

**Ghi chú thiết kế**

Khối "Hệ quả nếu bạn đổi vai trò hoặc tắt trạng thái hoạt động" là phần tốn công nhất của màn này và
cũng là phần đáng giữ nhất: quản trị người dùng là nơi một cú bấm nhầm gây hậu quả lan rộng nhất — thu
hồi phiên, mất người phỏng vấn của buổi sắp diễn ra, hoặc để JD không còn người phụ trách. Đánh đổi là
phải truy vấn thêm khi mở biểu mẫu, làm màn chậm hơn vài trăm mili giây; đây là chỗ hoàn toàn chấp
nhận được vì tần suất dùng rất thấp. Ba tên phòng ban cấp dưới trong cây — Nhóm Backend, Nhóm Dữ liệu,
Khối Tài chính — là **suy luận bổ sung** của D, vì bộ dữ liệu mẫu đã chốt chỉ nêu Khối Công nghệ và
Khối Nhân sự nhưng lại có một người giữ vai trò `FINANCE`.

---

## 15. Đối chiếu tiêu chí Done cho Wireframe

Bảng 5.74 đối chiếu bộ wireframe này với bốn tiêu chí "Done" cho deliverable D5 ở mục 6 của
`04_person_D_design.md`, với yêu cầu số lượng ở mục 1 của cùng tài liệu, với checklist review chéo
Chương 5 ở mục 5 của `06_conventions_shared.md`, và với các yêu cầu bổ sung mà D tự đặt ra cho mình.
Cột bằng chứng trỏ tới đúng hình hoặc mục trong tài liệu này để người review không phải tìm.

| # | Tiêu chí | Nguồn tiêu chí | Kết quả | Bằng chứng |
|---|---|---|---|---|
| 1 | Wireframe cho ít nhất 8 màn hình chính | `04_person_D_design.md` mục 1, dòng D5 | Đạt — 11 màn | Bảng 5.61; SCR-01…SCR-11 |
| 2 | Mỗi màn có tên rõ và ánh xạ với use case nào | `04_person_D_design.md` mục 6 | Đạt | Bảng 5.61 và dòng đầu của mỗi mục SCR |
| 3 | Low-fi cho phần chưa chốt, mid hoặc high-fi cho phần quan trọng | `04_person_D_design.md` mục 6 | Đạt — 2 low-fi, 4 mid-fi, 5 high-fi | Mục 0.3; SCR-11 giữ low-fi vì F09 chưa có đặc tả use case |
| 4 | Ít nhất 3 màn có trạng thái khác nhau | `04_person_D_design.md` mục 6 | Vượt — 11 trên 11 màn có từ 2 trạng thái, tổng 25 khối | SCR-05 và SCR-07 và SCR-09 mỗi màn 3 khối; 8 màn còn lại mỗi màn 2 khối |
| 5 | Không dùng Lorem Ipsum, thay bằng dữ liệu mẫu có nghĩa | `04_person_D_design.md` mục 6 | Đạt kèm ghi chú | Bảng 5.62; toàn bộ tên người Việt, miền `@vxtech.vn`, ngày giờ dạng dd/mm/yyyy HH:MM |
| 6 | Mỗi use case có ít nhất một wireframe phục vụ | `06_conventions_shared.md` mục 5 | Đạt — UC-01 đến UC-06 đều được phủ | UC-01 tại SCR-05 và SCR-09; UC-02 tại SCR-03; UC-03 tại SCR-06; UC-04 tại SCR-07 và SCR-08; UC-05 tại SCR-10; UC-06 tại SCR-09 |
| 7 | SCR-05 thể hiện cảnh báo xung đột, ba khung giờ gợi ý và ô lý do bắt buộc khi ép đặt lịch | Yêu cầu bổ sung của D cho BR-03 và BR-26 | Đạt | Hình 5.69, Hình 5.70, Hình 5.71 |
| 8 | SCR-07 thể hiện phần trăm lệch so với band và chuỗi duyệt tương ứng | Yêu cầu bổ sung của D cho BR-08 | Đạt — vẽ cả nhánh 1 cấp và nhánh 3 cấp, cùng nhánh 2 cấp ở lần duyệt lại | Hình 5.74, Hình 5.75, Hình 5.76 |
| 9 | SCR-09 thể hiện ứng viên vào bằng liên kết có token, không có SSO nội bộ | ADR-09 | Đạt | Hình 5.79 dải giải thích phiên truy cập; Hình 5.81 mã dùng một lần khi chấp nhận offer |
| 10 | SCR-10 hiển thị nhãn độ tươi dữ liệu | ADR-07 và NFR-10 | Đạt — có ở cả hai trạng thái | Hình 5.82 và Hình 5.83, dòng "Dữ liệu cập nhật lúc 18/08/2026 10:15" |
| 11 | Mỗi màn mô tả trạng thái rỗng, lỗi và đang tải | Yêu cầu bổ sung của D | Đạt — 11 trên 11 màn | Mục "Trạng thái rỗng / lỗi / đang tải" trong mỗi mục SCR |
| 12 | Mỗi màn nêu rõ ai thấy gì, nút nào bị ẩn với vai trò nào | Ma trận RBAC mục 9 hợp đồng thiết kế | Đạt — 11 trên 11 màn | Mục "Phân quyền" trong mỗi mục SCR; minh hoạ trực quan tại Hình 5.68 |
| 13 | Mỗi hình và mỗi bảng có caption và được nhắc trong chính văn | `06_conventions_shared.md` mục 7 | Đạt — 26 hình và 15 bảng | Hình 5.60 đến Hình 5.85; Bảng 5.60 đến Bảng 5.74 |
| 14 | Ghi chú khả năng tiếp cận | NFR-14 | Đạt | Mục 16 |
| 15 | Review chéo bởi B và C | `06_conventions_shared.md` mục 4 | **Chưa đạt** — cần B rà tên component và C rà tên bảng, cột | Việc của Sync S4 |

*Bảng 5.74 — Đối chiếu bộ wireframe với tiêu chí "Done"*

Ba điểm còn treo, đều đã ghi vào sổ mâu thuẫn của D và cần kết luận ở Sync S4 trước khi bộ wireframe
này được coi là bản cuối. Thứ nhất, cột `SHORTLISTED` trên SCR-03 phụ thuộc kết luận của mâu thuẫn
X-02; nếu không bổ sung giá trị ENUM thì kanban rút còn sáu cột. Thứ hai, mã của quy tắc ép đặt lịch
trên SCR-05 đang được ghi là BR-26 theo đề xuất ở mâu thuẫn X-04; nếu A giữ nguyên số cũ thì phải sửa
lại nhãn ở Hình 5.71 và ở Bảng 5.67. Thứ ba, miền email `@vxtech.vn` khác với gợi ý `@cmc.com.vn`
trong `04_person_D_design.md`; D chọn miền hư cấu để không gắn tên một doanh nghiệp có thật vào ảnh
chụp màn hình của báo cáo, và việc đổi lại nếu nhóm muốn chỉ là một thao tác tìm và thay.

---

## 16. Ghi chú về khả năng tiếp cận (NFR-14)

NFR-14 đặt mục tiêu đạt WCAG 2.1 mức AA cho năm màn chính. Năm màn được chọn là SCR-02, SCR-03, SCR-05,
SCR-06 và SCR-09 — bốn màn đầu là nơi người dùng nội bộ ở lại lâu nhất mỗi ngày, còn SCR-09 là màn duy
nhất người ngoài công ty tiếp xúc, nên hỏng khả năng tiếp cận ở đó gây thiệt hại về hình ảnh lớn nhất.
Tám ghi chú dưới đây là ràng buộc bắt buộc khi dựng giao diện thật từ bộ wireframe này.

- **Tương phản màu.** Mọi chữ thường đạt tỷ lệ tương phản tối thiểu 4,5:1 so với nền, chữ lớn từ 18,66px đậm trở lên đạt tối thiểu 3:1. Ba màu trạng thái hay dùng nhất phải được kiểm bằng công cụ đo tương phản trước khi chốt bảng màu trong `wireframes/README.md`: nền cảnh báo của dải xung đột lịch ở SCR-05, nền của thẻ quá hạn SLA ở SCR-02, và màu vạch mục tiêu ở SCR-10.
- **Không dùng riêng màu để truyền thông tin.** Mọi trạng thái đều có thêm chữ hoặc ký hiệu đi kèm: thẻ quá hạn ở SCR-02 có chữ "QUÁ HẠN 30 GIỜ" chứ không chỉ đổi màu; cột kanban bị khoá ở SCR-03 có chữ "(khoá)" kèm lý do; mức lương vượt band ở SCR-07 có chữ "VƯỢT TRẦN BAND 15,0%" kèm phép tính. Đây cũng là lý do các khối ASCII trong tài liệu này đọc được mà không cần màu.
- **Thao tác hoàn toàn bằng bàn phím.** Không thao tác nào chỉ thực hiện được bằng chuột. Kanban ở SCR-03 có lộ trình bàn phím tương đương: Tab tới thẻ, Space để nhấc, mũi tên trái phải để đổi cột, Enter để thả, Escape để huỷ. Modal ở SCR-05 giam tiêu điểm bên trong modal, đóng bằng Escape, và trả tiêu điểm về đúng thẻ ứng viên đã mở nó.
- **Nhãn cho mọi ô nhập.** Mỗi ô nhập có nhãn hiển thị thường trực, không dùng chữ mờ trong ô làm nhãn — vì chữ mờ biến mất ngay khi người dùng bắt đầu gõ. Các ô đặc biệt cần nhãn mô tả thêm: ô lý do ép đặt lịch ở SCR-05 kèm mô tả "tối thiểu 20 ký tự"; ô mức lương ở SCR-07 kèm mô tả đơn vị "VND mỗi tháng, gross"; nhóm radio chấm điểm ở SCR-06 có nhãn nhóm là tên tiêu chí.
- **Thứ tự tiêu điểm theo thứ tự đọc.** Thứ tự Tab đi từ thanh trên xuống thanh điều hướng rồi vào vùng nội dung, trong vùng nội dung thì đi từ trên xuống dưới, trái sang phải. Không dùng thuộc tính thứ tự tiêu điểm dương để nhảy cóc. Mỗi màn có liên kết "Bỏ qua điều hướng, tới nội dung chính" hiện ra khi nhận tiêu điểm — đặc biệt cần cho SCR-03 và SCR-10 vì thanh điều hướng đứng trước một vùng nội dung dài.
- **Thông báo lỗi cho trình đọc màn hình.** Lỗi cấp trường được gắn trực tiếp vào ô gây lỗi và được đọc lên ngay khi xuất hiện; lỗi cấp trang dùng vùng thông báo lịch sự để không cắt ngang câu đang đọc. Đây là lý do mọi lỗi chặn thao tác đều dùng dải cảnh báo cố định thay vì toast tự tắt, như đã ghi ở Hình 5.60. Nút bị vô hiệu hoá phải kèm lý do đọc được, ví dụ "Nút bị vô hiệu hoá: cần nhập lý do ép đặt lịch" ở Hình 5.71, thay vì chỉ làm mờ nút.
- **Kích thước vùng bấm.** Mọi mục tiêu bấm đạt tối thiểu 44 nhân 44 pixel, kể cả nút chỉ có biểu tượng như nút đóng modal ở SCR-05 và nút sửa trên từng dòng của SCR-11. Hai mục tiêu bấm liền kề cách nhau tối thiểu 8 pixel; ba nút quyết định ở SCR-08 được đặt cách xa nhau hơn mức tối thiểu vì hậu quả của việc bấm nhầm "Từ chối" thay vì "Phê duyệt" là không đảo ngược được.
- **Nội dung thay đổi theo thời gian.** Các đồng hồ đếm ngược ở SCR-02, SCR-05, SCR-06 và SCR-09 không cập nhật liên tục theo từng giây trong vùng được trình đọc màn hình theo dõi, vì như vậy sẽ đọc lại không ngừng; giá trị hiển thị đổi mỗi phút và luôn có bản mô tả tuyệt đối đi kèm, ví dụ "còn 18 giờ 42 phút — hạn 18/08/2026 16:00". Nhãn độ tươi dữ liệu ở SCR-10 cũng đi theo nguyên tắc này.

Bốn điểm còn thiếu và được ghi nhận thẳng thắn: bộ wireframe chưa được kiểm bằng trình đọc màn hình
thật, chưa có bản kiểm tương phản trên bảng màu cuối, chưa thiết kế cho chế độ phóng to 200% của trình
duyệt, và chưa xử lý trường hợp người dùng bật chế độ giảm chuyển động. Bốn việc này thuộc phạm vi khi
dựng giao diện thật, nằm ngoài phạm vi bài tập lớn, và đã được nêu trong phần hạn chế của Chương 6.
