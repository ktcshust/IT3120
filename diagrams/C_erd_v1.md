# C_erd_v1 — Entity Relationship Diagram (Physical)

**Người vẽ:** C (Data Architect)
**Phiên bản:** v1.2 (đồng bộ schema sau audit Chương 3 + 4 — xem `docs/change_log.md`)
**Mức trừu tượng:** Physical — sát SQL, có PK/FK/UK, kiểu dữ liệu SQL cụ thể, cardinality chính xác (bao gồm optional/mandatory).

**Quy ước đặt tên bảng:** danh từ số nhiều, snake_case (`departments`, `job_descriptions`...) — áp dụng nhất quán cho toàn bộ schema, khớp với `sql/schema.sql`.

Đây là bản chuyển đổi vật lý của `C_class_diagram_v1.md`:
- Quan hệ N–N `Interview` ↔ `User` → bảng trung gian `interview_participants` với surrogate key `id` + `UNIQUE(interview_id, interviewer_id)`.
- Inheritance `User → Recruiter/HiringManager/Interviewer/HRAdmin/HeadOfHR/Finance` → **single-table inheritance**: 1 bảng `users` + cột `role` (ENUM, 6 giá trị). Xem lý do trong `report/chapter_4_data.md` mục Normalization Analysis.
- Interface `Approvable` → không có bảng riêng (interface không tồn tại ở tầng lưu trữ), thể hiện qua việc `job_descriptions` và `offers` đều có cột `status` dạng ENUM theo state machine riêng.

---

## Diagram

```mermaid
erDiagram
    DEPARTMENTS {
        bigint id PK
        varchar name UK
        bigint parent_id FK
        timestamp created_at
        timestamp updated_at
    }

    USERS {
        bigint id PK
        varchar email UK
        varchar name
        user_role role
        bigint department_id FK
        boolean is_active
        timestamp created_at
        timestamp updated_at
    }

    JOB_DESCRIPTIONS {
        bigint id PK
        varchar title
        bigint department_id FK
        varchar level
        decimal salary_band_min
        decimal salary_band_max
        bigint hiring_manager_id FK
        bigint recruiter_id FK
        jd_status status
        int headcount
        timestamp opened_at
        timestamp closed_at
        timestamp created_at
        timestamp updated_at
    }

    INTERVIEW_PROCESSES {
        bigint id PK
        bigint jd_id FK
        int round_order
        varchar round_name
        int required_interviewers
        bigint scorecard_template_id FK
        timestamp created_at
        timestamp updated_at
    }

    SCORECARD_TEMPLATES {
        bigint id PK
        varchar name
        jsonb criteria
        timestamp created_at
        timestamp updated_at
    }

    CANDIDATES {
        bigint id PK
        varchar full_name
        varchar email UK
        varchar phone
        varchar current_company
        int years_of_experience
        text experience_summary
        candidate_source source
        jsonb parsed_profile
        timestamp created_at
        timestamp updated_at
    }

    ATTACHMENTS {
        bigint id PK
        bigint candidate_id FK
        varchar file_url
        varchar file_name
        int version
        timestamp uploaded_at
        timestamp created_at
        timestamp updated_at
    }

    APPLICATIONS {
        bigint id PK
        bigint candidate_id FK
        bigint jd_id FK
        application_status status
        timestamp applied_at
        int current_round
        varchar rejection_reason
        timestamp created_at
        timestamp updated_at
    }

    APPLICATION_STATUS_HISTORY {
        bigint id PK
        bigint application_id FK
        application_status from_status
        application_status to_status
        bigint actor_id FK
        timestamp changed_at
        varchar note
    }

    INTERVIEWS {
        bigint id PK
        bigint application_id FK
        int round_order
        timestamp scheduled_at
        int duration_min
        varchar meeting_link
        interview_status status
        timestamp created_at
        timestamp updated_at
    }

    INTERVIEW_PARTICIPANTS {
        bigint id PK
        bigint interview_id FK
        bigint interviewer_id FK
        participant_role role
        timestamp created_at
    }

    FEEDBACKS {
        bigint id PK
        bigint interview_id FK
        bigint interviewer_id FK
        verdict verdict
        decimal total_score
        timestamp submitted_at
        boolean is_locked
        timestamp created_at
        timestamp updated_at
    }

    FEEDBACK_CRITERIA {
        bigint id PK
        bigint feedback_id FK
        varchar criterion_name
        int score
        text comment
        timestamp created_at
    }

    OFFERS {
        bigint id PK
        bigint application_id FK
        decimal salary
        date start_date
        jsonb benefits
        date deadline
        offer_status status
        int current_approval_level
        int current_approval_attempt
        timestamp created_at
        timestamp updated_at
    }

    OFFER_APPROVALS {
        bigint id PK
        bigint offer_id FK
        bigint approver_id FK
        int level
        int attempt_no
        approval_decision decision
        text comment
        timestamp decided_at
        timestamp created_at
    }

    EMAIL_TEMPLATES {
        bigint id PK
        varchar template_key UK
        varchar subject
        text body
        jsonb variables
        timestamp created_at
        timestamp updated_at
    }

    AUDIT_LOGS {
        bigint id PK
        bigint actor_id FK
        varchar action
        varchar entity_type
        bigint entity_id
        jsonb payload
        timestamp created_at
    }

    NOTIFICATIONS {
        bigint id PK
        bigint user_id FK
        varchar type
        jsonb payload
        boolean is_read
        timestamp created_at
    }

    DEPARTMENTS |o--o{ DEPARTMENTS : parent_of
    DEPARTMENTS ||--o{ USERS : employs
    DEPARTMENTS ||--o{ JOB_DESCRIPTIONS : owns
    USERS ||--o{ JOB_DESCRIPTIONS : recruits
    USERS ||--o{ JOB_DESCRIPTIONS : hiring_manager_of
    JOB_DESCRIPTIONS ||--o{ INTERVIEW_PROCESSES : defines
    SCORECARD_TEMPLATES ||--o{ INTERVIEW_PROCESSES : used_by
    JOB_DESCRIPTIONS ||--o{ APPLICATIONS : receives
    CANDIDATES ||--o{ APPLICATIONS : submits
    CANDIDATES ||--o{ ATTACHMENTS : uploads
    APPLICATIONS ||--o{ INTERVIEWS : has
    APPLICATIONS ||--o| OFFERS : results_in
    APPLICATIONS ||--o{ APPLICATION_STATUS_HISTORY : tracks
    USERS |o--o{ APPLICATION_STATUS_HISTORY : triggers
    INTERVIEWS ||--o{ INTERVIEW_PARTICIPANTS : involves
    USERS ||--o{ INTERVIEW_PARTICIPANTS : participates_as
    INTERVIEWS ||--o{ FEEDBACKS : receives
    USERS ||--o{ FEEDBACKS : gives
    FEEDBACKS ||--|{ FEEDBACK_CRITERIA : composed_of
    OFFERS ||--o{ OFFER_APPROVALS : requires
    USERS ||--o{ OFFER_APPROVALS : approves
    USERS |o--o{ AUDIT_LOGS : performs
    USERS ||--o{ NOTIFICATIONS : receives
```

---

## Giải thích các lựa chọn thiết kế physical

| Bảng / cột | Lựa chọn | Lý do |
|---|---|---|
| `departments.parent_id` | FK nullable, self-reference | Cho phép phòng ban gốc (không cha) — tránh reference vòng khi insert bản ghi đầu tiên (đúng cảnh báo ở `03_person_C_data.md` mục 9). |
| `users.role` | ENUM `user_role` (6 giá trị) | Single-table inheritance. **[v1.2]** Thêm `HEAD_OF_HR`, `FINANCE` để khớp BR-08 / ACT-02 / SEQ-02 (cấp duyệt 2 và 3). `HR_ADMIN` giữ vai trò cấu hình hệ thống, không gộp với Head of HR. |
| `job_descriptions.hiring_manager_id`, `recruiter_id` | 2 FK riêng tới `users` | Ánh xạ đúng BR-01 (đúng 1 recruiter + 1 hiring manager). |
| `interview_participants` | Bảng trung gian có surrogate key `id` + `UNIQUE(interview_id, interviewer_id)` | Giải quyết N–N, đồng thời mang thêm thuộc tính `role` (primary/secondary). |
| `interviews` | `UNIQUE(application_id, round_order)` **[v1.1]** | Reschedule = UPDATE cùng dòng (STATE-02 của B), không tạo dòng mới cùng vòng. |
| `offers.current_approval_attempt` / `offer_approvals.attempt_no` | **[v1.1]** | Hỗ trợ "duyệt lại từ cấp 1" (UC-04 A4.1) mà không đụng UNIQUE cũ. |
| `application_status_history` | Bảng append-only **[v1.2]** | Time-in-stage + audit chuyển trạng thái chặt hơn `audit_logs` polymorphic. |
| `feedbacks.total_score` | Cột cache (denormalize) | Tránh `AVG()` mỗi lần đọc dashboard. |
| `applications.current_round` | Cột cache (denormalize) | Tránh `MAX(round_order)` mỗi lần render kanban. |
| `email_templates` | Không có FK trỏ tới bảng này | Tra `template_key` ở tầng service (BR-12). |
| `notifications` | Chỉ FK tới `users` | Candidate nhận thông báo qua **email** (EmailGateway), không có tài khoản nội bộ — không nhét `candidate_id` vào bảng này. |
| Timestamp | Mutable: `created_at` + `updated_at`; append-only: chỉ `created_at` / `changed_at` | **[v1.2]** Sửa ghi chú cũ "mọi bảng có updated_at" — bảng lịch sử/log không cần `updated_at`. |

Chi tiết từng cột (kiểu, null, default, constraint) xem `docs/data_dictionary_C.md`. DDL chạy được xem `sql/schema.sql`.
