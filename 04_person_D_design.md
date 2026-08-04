# Person D — System & UI Designer + Demo Lead

**Chương phụ trách:** Chương 5 + Chương 6 (~20% khối lượng viết, nhưng nhiều diagram và slide)
**Vai trò phụ:** Chủ trì làm slide bảo vệ, chủ trì demo/prototype.

---

## 1. Deliverables cuối cùng

| # | Deliverable | Format | Ước lượng |
|---|---|---|---|
| D1 | Chương 5: Thiết kế hệ thống — kiến trúc, thành phần, triển khai | Word/Doc, ~8-10 trang | Tuần 3-4 |
| D2 | Chương 6: Kết luận, hạn chế, hướng phát triển | Word/Doc, ~3 trang | Tuần 4-5 |
| D3 | Component Diagram | draw.io | Tuần 3 |
| D4 | Deployment Diagram | draw.io | Tuần 3 |
| D5 | Wireframe / mockup ≥8 màn hình chính | Figma | Tuần 2-3 |
| D6 | Danh sách chi tiết NFR (từ spec mở rộng) | Word/Doc, ~2 trang | Tuần 4 |
| D7 | Slide bảo vệ (25-30 slide) | PowerPoint / Google Slides | Tuần 5 |
| D8 | Prototype/demo (nếu có) | HTML click-through hoặc Figma prototype | Tuần 4-5 |

---

## 2. Danh sách cụ thể phải làm

### Kiến trúc
- **Component Diagram** — mô hình hoá các module/service:
  - Frontend (Web UI)
  - API Gateway / BFF
  - Auth Service
  - Recruitment Core Service
  - Scheduling Service
  - Notification Service
  - Reporting Service
  - File Service
  - Scheduler/Cron worker
  - Data stores: PostgreSQL, Redis, Object Storage
  - External: Email Gateway, SSO Provider

- **Deployment Diagram** — mô hình hoá triển khai vật lý:
  - Client (browser, mobile)
  - Load Balancer
  - App server (containers)
  - DB server (primary + replica)
  - Cache server (Redis)
  - Object storage (S3/MinIO)
  - External services

### Wireframe (≥8 màn hình)
Ưu tiên các màn hình sau (theo spec mục 13):
1. Dashboard Recruiter
2. JD Detail — Kanban Pipeline
3. Candidate Profile
4. Schedule Interview Modal
5. Scorecard (interview feedback form)
6. Offer Wizard
7. Candidate Portal (view status)
8. Reports Dashboard
9. (Optional) Admin — Users & Departments
10. (Optional) Login / SSO redirect

### NFR chi tiết
Từ spec mục 11, mở rộng mỗi NFR thành 1 đoạn có: mục tiêu định lượng, cách đo, cách đạt được.

---

## 3. Task breakdown theo tuần

### Tuần 1 — Chuẩn bị & wireframe sớm

- [ ] Đọc `spec_ats.md` mục 11 (NFR), 12 (kiến trúc), 13 (giao diện).
- [ ] Đọc UC list của A (dù chưa có detail) — nắm bức tranh có bao nhiêu màn hình.
- [ ] Cài Figma (free tier đủ), tạo file team.
- [ ] Vẽ **user flow tổng thể** trên giấy: đi từ Dashboard → Candidate profile → Schedule interview.
- [ ] Bắt đầu wireframe low-fidelity 2-3 màn hình đầu (Dashboard, JD Detail).

**Output tuần 1:** Figma file khởi tạo, wireframe low-fi 2-3 màn.

---

### Tuần 2 — Wireframe song song với A

- [ ] Ngay khi A giao UC list chính thức, mapping "UC → màn hình nào".
- [ ] Hoàn thiện wireframe low-fi cho 8 màn hình bắt buộc.
- [ ] Bắt đầu nâng lên mid-fi cho 4 màn hình quan trọng nhất (Dashboard, JD Detail, Schedule Modal, Scorecard).

**Output tuần 2:** 8 wireframe low-fi + 4 wireframe mid-fi.

---

### Tuần 3 — Kiến trúc + wireframe final

- [ ] Sau khi B có sequence diagram, đối chiếu lifeline → đặt tên component.
- [ ] Sau khi C có ERD, xác nhận DB technology → hoàn thiện deployment diagram.
- [ ] Vẽ **Component Diagram** v1: đủ 10-12 component, có interface/port rõ.
- [ ] Vẽ **Deployment Diagram** v1: đủ node vật lý, có protocol trên arrow (HTTPS, TCP, JDBC).
- [ ] Nâng wireframe lên mid/high-fi cho các màn còn lại.

**Cuối tuần — Sync S4:**
- [ ] Trình bày kiến trúc và wireframe.
- [ ] Check với B: component D vẽ có khớp service B đã dùng trong sequence?
- [ ] Check với C: DB choice có phù hợp ERD?
- [ ] Check với A: mọi UC đều có ít nhất 1 wireframe minh hoạ?

**Output tuần 3:** Component + Deployment diagram v1, 8 wireframe mid/high-fi.

---

### Tuần 4 — Chương 5 + NFR + prototype (nếu có)

- [ ] Sửa kiến trúc và wireframe theo feedback S4.
- [ ] Viết Chương 5:
  - Mục 5.1: Kiến trúc tổng thể — trình bày component diagram, giải thích lý do chọn từng thành phần.
  - Mục 5.2: Kiến trúc triển khai — trình bày deployment diagram.
  - Mục 5.3: Thiết kế giao diện — trình bày wireframe, giải thích flow người dùng.
  - Mục 5.4: NFR chi tiết.
  - Mục 5.5: Công nghệ đề xuất (tùy chọn, không bắt buộc).
- [ ] Nếu làm prototype:
  - Cách 1 — Figma prototype (click-through, không code, nhanh nhất).
  - Cách 2 — HTML/React static (đẹp hơn nhưng tốn thời gian).
- [ ] Bắt đầu Chương 6: kết quả đạt được, hạn chế, hướng phát triển.

**Output tuần 4:** Chương 5 v1, Chương 6 draft, prototype (nếu chọn làm).

---

### Tuần 5 — Slide bảo vệ + tổng duyệt

**Đây là tuần D làm việc nhiều nhất vì phải lead slide và demo.**

- [ ] Làm **slide bảo vệ** (25-30 slide), chia đều cho 4 chương + intro + kết luận:
  - Slide 1-2: Title, giới thiệu nhóm.
  - Slide 3-6: Chương 1 + 2 (do A trình bày).
  - Slide 7-12: Chương 3 (do B trình bày).
  - Slide 13-17: Chương 4 (do C trình bày).
  - Slide 18-24: Chương 5 (do D trình bày).
  - Slide 25-27: Demo screenshot / prototype.
  - Slide 28-30: Chương 6 kết luận, câu hỏi thảo luận.
- [ ] Chốt template slide (font, màu, layout) — thống nhất toàn bộ.
- [ ] Chuẩn bị demo:
  - Nếu có prototype: setup máy, backup video record đề phòng lỗi mạng.
  - Nếu không: dùng Figma prototype hoặc walkthrough screenshot.
- [ ] **Tổ chức Sync S6 (dry run)** — cả nhóm tập 1 lần, đo giờ, chỉnh phần dài quá.

**Output tuần 5:** Slide final, prototype/demo sẵn sàng.

---

## 4. Input cần từ ai

| Cần cái gì | Từ ai | Khi nào | Nếu chưa có thì làm gì |
|---|---|---|---|
| UC list | A | Tuần 1 | Bắt đầu user flow tổng thể |
| UC detail | A | Tuần 2 | Bắt đầu wireframe |
| Sequence diagram | B | Cuối tuần 3 | Đặt tên component từ spec làm nháp |
| ERD | C | Cuối tuần 3 | Chọn DB technology từ spec |
| Diagram v1 của A, B, C | Cả nhóm | Đầu tuần 5 | Không thể làm slide nếu thiếu |

---

## 5. Output giao cho ai

| Giao cái gì | Cho ai | Khi nào | Vì sao họ cần |
|---|---|---|---|
| Sơ đồ màn hình (screen map) | A | Cuối tuần 2 | A check UC đủ, không thiếu |
| Component naming | B | Cuối tuần 3 | B đối chiếu với lifeline sequence |
| Slide template | Cả nhóm | Đầu tuần 5 | Đảm bảo slide đồng nhất |
| Dry run agenda | Cả nhóm | Trước S6 | Để mọi người biết present phần nào bao nhiêu phút |

---

## 6. Tiêu chí "Done" cho từng deliverable

### Component Diagram
- [ ] Có ≥10 component.
- [ ] Có ≥1 external system (Email, SSO).
- [ ] Interface/port thể hiện rõ (không chỉ box đứng cạnh nhau).
- [ ] Có ghi chú protocol (REST, gRPC, event) trên connector nếu khác nhau.

### Deployment Diagram
- [ ] Có ≥5 node vật lý.
- [ ] Có node "Client" (browser/mobile).
- [ ] Có load balancer nếu app server >1 instance.
- [ ] Protocol ghi rõ trên connection (HTTPS 443, TCP 5432...).
- [ ] Có ghi chú về scaling (VD: "auto-scale 2-10 instance").

### Wireframe
- [ ] Mỗi màn có tên rõ, mapping với UC nào.
- [ ] Low-fi cho phần chưa chốt, mid/high-fi cho phần quan trọng.
- [ ] Có ít nhất 3 màn có "state" khác nhau (VD: Dashboard trống vs Dashboard đầy dữ liệu).
- [ ] Không có Lorem Ipsum thô — thay bằng data mẫu có ý nghĩa (tên VN, email @cmc.com.vn).

### NFR
- [ ] Mỗi NFR có ≥1 số liệu định lượng.
- [ ] Có ≥1 cách đo cho mỗi NFR (VD: "load test với JMeter, 500 concurrent users").

### Slide
- [ ] Không có slide chỉ có text đặc — tối đa 5 gạch đầu dòng.
- [ ] Diagram luôn có nguồn (do ai vẽ), số hiệu (Hình 3.1, Hình 4.2).
- [ ] Slide cuối có mục "Câu hỏi thường gặp" (chuẩn bị trước 3-5 câu).

---

## 7. Phối hợp cụ thể với từng người

### Với A (Requirements)
- **D nhận từ A:** UC list, actor list.
- **D đưa lại A:** Sơ đồ màn hình để A check missing UC.
- **Xung đột thường gặp:** A viết UC nhưng không rõ ai thao tác trên màn hình nào; D phải chủ động hỏi.

### Với B (Behavior)
- **D nhận từ B:** Sequence diagram → lifeline = component candidate.
- **D đưa lại B:** Component naming để B đồng bộ tên lifeline trong sequence v2.
- **Xung đột thường gặp:** B chia service quá nhỏ (10 service) hoặc quá to (1 service). D cần đề xuất mức trung dung phù hợp cho scale doanh nghiệp.

### Với C (Data)
- **D nhận từ C:** ERD → quyết định DB choice, cần index gì.
- **D đưa lại C:** Yêu cầu index cho các màn dashboard/report của D.
- **Xung đột thường gặp:** D muốn màn báo cáo real-time, nhưng ERD của C nặng → D phải đề xuất reporting service tách riêng (đã có trong spec, cần argue trong Chương 5).

---

## 8. Sai lầm cần tránh

- **Deployment diagram trùng Component diagram** — 2 diagram khác nhau, không copy-paste.
  - Component = logic module/service.
  - Deployment = server vật lý và nơi chạy service.
- **Wireframe = ảnh chụp Bootstrap template** — không thể hiện flow, chỉ show component. Wireframe phải kể chuyện.
- **Bắt đầu wireframe khi chưa có UC** — sẽ vẽ ra thứ đẹp nhưng không dùng được. Đợi ít nhất UC list.
- **NFR chung chung** ("Hệ thống phải nhanh") — sai. Phải "Trang danh sách load ≤2s với 500 record, đo bằng JMeter, achieve bằng cách paginate + index".
- **Slide dày text** — thầy đọc slide chứ không nghe present.
- **Prototype quá tham vọng** — cố code React thật cuối cùng không kịp. Figma prototype đủ dùng cho bảo vệ.
- **Không có Chương 6** — nhiều nhóm quên. Chương 6 tuy ngắn nhưng bắt buộc.

---

## 9. Câu hỏi bảo vệ có thể bị hỏi

- Sao chọn kiến trúc modular monolith, không phải microservices?
- Nếu ứng viên nộp CV 10MB thì hệ thống lưu ở đâu?
- Reporting service tách riêng có làm phức tạp thêm không?
- Redis dùng làm gì trong hệ thống?
- Kiến trúc này chịu được bao nhiêu user đồng thời?
- Wireframe này có accessible cho người khuyết tật không?

---

## 10. Ghi chú đặc biệt về vai trò Demo Lead

D là người cuối cùng cầm sự thành công của buổi bảo vệ:
- **Test slide 2 lần** trên máy dùng để present (thường font/format lệch giữa máy).
- **Backup slide PDF** phòng khi PowerPoint lỗi.
- **Timing:** mỗi người ~5 phút, tổng ~20-25 phút present + 10 phút Q&A. D điều khiển đồng hồ.
- **Ai trả lời câu hỏi gì:** Q&A chia theo chương — mặc định người viết chương trả lời, D là "safety net" khi người viết chưa nghĩ ra.

