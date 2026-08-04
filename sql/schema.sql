-- =====================================================================
-- ATS mini — Schema PostgreSQL
-- Person C — Data Architect | Chương 4
-- Phiên bản: v1
-- Khớp với: diagrams/C_erd_v1.md, docs/data_dictionary_C.md
--
-- Cách chạy:
--   createdb ats_mini
--   psql -d ats_mini -f sql/schema.sql
-- =====================================================================

BEGIN;

-- ---------------------------------------------------------------------
-- 1. ENUM TYPES
-- ---------------------------------------------------------------------

CREATE TYPE user_role AS ENUM (
    'RECRUITER', 'HIRING_MANAGER', 'INTERVIEWER', 'HR_ADMIN'
);

CREATE TYPE jd_status AS ENUM (
    'DRAFT', 'OPEN', 'CLOSED'
);

CREATE TYPE candidate_source AS ENUM (
    'EMAIL', 'LINKEDIN', 'WEBSITE', 'REFERRAL', 'HEADHUNTER', 'OTHER'
);

-- Vòng đời Application — đúng state machine mục 7, spec_ats.md
CREATE TYPE application_status AS ENUM (
    'NEW', 'SCREENING', 'REJECTED', 'INTERVIEWING', 'NEED_RESCHEDULE',
    'OFFER_PENDING', 'OFFER_APPROVED', 'OFFER_SENT', 'ACCEPTED',
    'HIRED', 'GHOSTED', 'DECLINED', 'NEGOTIATING', 'EXPIRED',
    'OFFER_REJECTED_INTERNALLY', 'ON_HOLD', 'TALENT_POOL'
);

CREATE TYPE interview_status AS ENUM (
    'SCHEDULED', 'COMPLETED', 'CANCELLED', 'NEED_RESCHEDULE'
);

CREATE TYPE participant_role AS ENUM (
    'PRIMARY', 'SECONDARY'
);

CREATE TYPE verdict AS ENUM (
    'STRONG_HIRE', 'HIRE', 'NO_HIRE', 'STRONG_NO_HIRE'
);

CREATE TYPE offer_status AS ENUM (
    'DRAFT', 'PENDING_APPROVAL', 'APPROVED', 'SIGNED_BY_COMPANY',
    'ACCEPTED', 'DECLINED', 'NEGOTIATING', 'EXPIRED', 'REJECTED_INTERNALLY'
);

CREATE TYPE approval_decision AS ENUM (
    'PENDING', 'APPROVED', 'REJECTED', 'REQUEST_CHANGE'
);

-- ---------------------------------------------------------------------
-- 2. CORE ORG TABLES
-- ---------------------------------------------------------------------

CREATE TABLE departments (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(150) NOT NULL,
    parent_id   BIGINT REFERENCES departments(id) ON DELETE SET NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT now(),
    updated_at  TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_departments_name UNIQUE (name)
);

CREATE INDEX idx_departments_parent_id ON departments (parent_id);

CREATE TABLE users (
    id              BIGSERIAL PRIMARY KEY,
    email           VARCHAR(255) NOT NULL,
    name            VARCHAR(150) NOT NULL,
    role            user_role NOT NULL,
    department_id   BIGINT NOT NULL REFERENCES departments(id) ON DELETE RESTRICT,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMP NOT NULL DEFAULT now(),
    updated_at      TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_users_email UNIQUE (email)
);

CREATE INDEX idx_users_department_id ON users (department_id);

-- ---------------------------------------------------------------------
-- 3. JD & INTERVIEW PROCESS CONFIG
-- ---------------------------------------------------------------------

CREATE TABLE job_descriptions (
    id                  BIGSERIAL PRIMARY KEY,
    title               VARCHAR(200) NOT NULL,
    department_id       BIGINT NOT NULL REFERENCES departments(id) ON DELETE RESTRICT,
    level               VARCHAR(50),
    salary_band_min     DECIMAL(12, 2) NOT NULL,
    salary_band_max     DECIMAL(12, 2) NOT NULL,
    hiring_manager_id   BIGINT NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    recruiter_id        BIGINT NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    status              jd_status NOT NULL DEFAULT 'DRAFT',
    headcount           INT NOT NULL DEFAULT 1,
    opened_at           TIMESTAMP,
    closed_at           TIMESTAMP,
    created_at          TIMESTAMP NOT NULL DEFAULT now(),
    updated_at          TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT chk_jd_salary_band CHECK (salary_band_max >= salary_band_min),
    CONSTRAINT chk_jd_salary_min_positive CHECK (salary_band_min >= 0),
    CONSTRAINT chk_jd_headcount_positive CHECK (headcount > 0)
);

CREATE INDEX idx_jd_department_id ON job_descriptions (department_id);
CREATE INDEX idx_jd_hiring_manager_id ON job_descriptions (hiring_manager_id);
CREATE INDEX idx_jd_recruiter_id ON job_descriptions (recruiter_id);
CREATE INDEX idx_jd_status ON job_descriptions (status);

CREATE TABLE scorecard_templates (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(150) NOT NULL,
    criteria    JSONB NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT now(),
    updated_at  TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE interview_processes (
    id                      BIGSERIAL PRIMARY KEY,
    jd_id                   BIGINT NOT NULL REFERENCES job_descriptions(id) ON DELETE CASCADE,
    round_order             INT NOT NULL,
    round_name              VARCHAR(100) NOT NULL,
    required_interviewers   INT NOT NULL DEFAULT 1,
    scorecard_template_id   BIGINT NOT NULL REFERENCES scorecard_templates(id) ON DELETE RESTRICT,
    created_at              TIMESTAMP NOT NULL DEFAULT now(),
    updated_at              TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_interview_process_jd_round UNIQUE (jd_id, round_order),
    CONSTRAINT chk_ip_round_order_positive CHECK (round_order > 0),
    CONSTRAINT chk_ip_required_interviewers_positive CHECK (required_interviewers > 0)
);

CREATE INDEX idx_ip_jd_id ON interview_processes (jd_id);
CREATE INDEX idx_ip_scorecard_template_id ON interview_processes (scorecard_template_id);

-- ---------------------------------------------------------------------
-- 4. CANDIDATE & APPLICATION
-- ---------------------------------------------------------------------

CREATE TABLE candidates (
    id                      BIGSERIAL PRIMARY KEY,
    full_name               VARCHAR(150) NOT NULL,
    email                   VARCHAR(255) NOT NULL,
    phone                   VARCHAR(30),
    current_company         VARCHAR(150),
    years_of_experience     INT,
    experience_summary      TEXT,
    source                  candidate_source NOT NULL DEFAULT 'OTHER',
    parsed_profile          JSONB,
    created_at              TIMESTAMP NOT NULL DEFAULT now(),
    updated_at              TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_candidates_email UNIQUE (email),
    CONSTRAINT chk_candidates_years_exp_nonneg CHECK (years_of_experience >= 0)
);

CREATE TABLE attachments (
    id              BIGSERIAL PRIMARY KEY,
    candidate_id    BIGINT NOT NULL REFERENCES candidates(id) ON DELETE CASCADE,
    file_url        VARCHAR(500) NOT NULL,
    file_name       VARCHAR(255) NOT NULL,
    version         INT NOT NULL DEFAULT 1,
    uploaded_at     TIMESTAMP NOT NULL DEFAULT now(),
    created_at      TIMESTAMP NOT NULL DEFAULT now(),
    updated_at      TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT chk_attachments_version_positive CHECK (version > 0)
);

CREATE INDEX idx_attachments_candidate_id ON attachments (candidate_id);

CREATE TABLE applications (
    id                  BIGSERIAL PRIMARY KEY,
    candidate_id        BIGINT NOT NULL REFERENCES candidates(id) ON DELETE RESTRICT,
    jd_id               BIGINT NOT NULL REFERENCES job_descriptions(id) ON DELETE RESTRICT,
    status              application_status NOT NULL DEFAULT 'NEW',
    applied_at          TIMESTAMP NOT NULL DEFAULT now(),
    current_round       INT,                    -- [DENORM] cache MAX(interviews.round_order)
    rejection_reason    VARCHAR(255),
    created_at          TIMESTAMP NOT NULL DEFAULT now(),
    updated_at          TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX idx_applications_candidate_id ON applications (candidate_id);
CREATE INDEX idx_applications_jd_id ON applications (jd_id);
CREATE INDEX idx_applications_status ON applications (status);
-- Hỗ trợ BR-04 (không cho apply lại cùng JD trong 6 tháng kể từ lần reject gần nhất) ở tầng service
CREATE INDEX idx_applications_candidate_jd_applied ON applications (candidate_id, jd_id, applied_at);

-- ---------------------------------------------------------------------
-- 5. INTERVIEW & FEEDBACK
-- ---------------------------------------------------------------------

CREATE TABLE interviews (
    id                  BIGSERIAL PRIMARY KEY,
    application_id      BIGINT NOT NULL REFERENCES applications(id) ON DELETE CASCADE,
    round_order         INT NOT NULL,
    scheduled_at        TIMESTAMP NOT NULL,
    duration_min        INT NOT NULL DEFAULT 60,
    meeting_link        VARCHAR(500),
    status              interview_status NOT NULL DEFAULT 'SCHEDULED',
    created_at          TIMESTAMP NOT NULL DEFAULT now(),
    updated_at          TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT chk_interviews_duration_positive CHECK (duration_min > 0)
);

CREATE INDEX idx_interviews_application_id ON interviews (application_id);
-- Hỗ trợ kiểm tra xung đột lịch (BR-03) kết hợp với interview_participants.interviewer_id
CREATE INDEX idx_interviews_scheduled_at ON interviews (scheduled_at);

CREATE TABLE interview_participants (
    id              BIGSERIAL PRIMARY KEY,
    interview_id    BIGINT NOT NULL REFERENCES interviews(id) ON DELETE CASCADE,
    interviewer_id  BIGINT NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    role            participant_role NOT NULL DEFAULT 'SECONDARY',
    created_at      TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_interview_participant UNIQUE (interview_id, interviewer_id)
);

CREATE INDEX idx_ipart_interview_id ON interview_participants (interview_id);
CREATE INDEX idx_ipart_interviewer_id ON interview_participants (interviewer_id);

CREATE TABLE feedbacks (
    id              BIGSERIAL PRIMARY KEY,
    interview_id    BIGINT NOT NULL REFERENCES interviews(id) ON DELETE CASCADE,
    interviewer_id  BIGINT NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    verdict         verdict NOT NULL,
    total_score     DECIMAL(4, 2),          -- [DENORM] cache AVG(feedback_criteria.score)
    submitted_at    TIMESTAMP NOT NULL DEFAULT now(),
    is_locked       BOOLEAN NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMP NOT NULL DEFAULT now(),
    updated_at      TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_feedback_interview_interviewer UNIQUE (interview_id, interviewer_id)
);

CREATE INDEX idx_feedbacks_interview_id ON feedbacks (interview_id);
CREATE INDEX idx_feedbacks_interviewer_id ON feedbacks (interviewer_id);

CREATE TABLE feedback_criteria (
    id              BIGSERIAL PRIMARY KEY,
    feedback_id     BIGINT NOT NULL REFERENCES feedbacks(id) ON DELETE CASCADE,
    criterion_name  VARCHAR(50) NOT NULL,
    score           INT NOT NULL,
    comment         TEXT,
    created_at      TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_feedback_criterion_name UNIQUE (feedback_id, criterion_name),
    CONSTRAINT chk_feedback_criteria_score_range CHECK (score BETWEEN 1 AND 5)
);

CREATE INDEX idx_feedback_criteria_feedback_id ON feedback_criteria (feedback_id);

-- ---------------------------------------------------------------------
-- 6. OFFER & APPROVAL
-- ---------------------------------------------------------------------

CREATE TABLE offers (
    id                          BIGSERIAL PRIMARY KEY,
    application_id              BIGINT NOT NULL REFERENCES applications(id) ON DELETE RESTRICT,
    salary                      DECIMAL(12, 2) NOT NULL,
    start_date                  DATE NOT NULL,
    benefits                    JSONB,
    deadline                    DATE NOT NULL,
    status                      offer_status NOT NULL DEFAULT 'DRAFT',
    current_approval_level      INT NOT NULL DEFAULT 0,
    created_at                  TIMESTAMP NOT NULL DEFAULT now(),
    updated_at                  TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_offers_application_id UNIQUE (application_id),
    CONSTRAINT chk_offers_salary_positive CHECK (salary > 0),
    CONSTRAINT chk_offers_approval_level_nonneg CHECK (current_approval_level >= 0)
);

CREATE INDEX idx_offers_application_id ON offers (application_id);
CREATE INDEX idx_offers_status ON offers (status);
CREATE INDEX idx_offers_deadline ON offers (deadline);

CREATE TABLE offer_approvals (
    id              BIGSERIAL PRIMARY KEY,
    offer_id        BIGINT NOT NULL REFERENCES offers(id) ON DELETE CASCADE,
    approver_id     BIGINT NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    level           INT NOT NULL,
    decision        approval_decision NOT NULL DEFAULT 'PENDING',
    comment         TEXT,
    decided_at      TIMESTAMP,
    created_at      TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_offer_approval_level UNIQUE (offer_id, level),
    CONSTRAINT chk_offer_approval_level_range CHECK (level BETWEEN 1 AND 3)
);

CREATE INDEX idx_offer_approvals_offer_id ON offer_approvals (offer_id);
CREATE INDEX idx_offer_approvals_approver_id ON offer_approvals (approver_id);

-- ---------------------------------------------------------------------
-- 7. INFRASTRUCTURE TABLES
-- ---------------------------------------------------------------------

CREATE TABLE email_templates (
    id              BIGSERIAL PRIMARY KEY,
    template_key    VARCHAR(100) NOT NULL,
    subject         VARCHAR(255) NOT NULL,
    body            TEXT NOT NULL,
    variables       JSONB,
    created_at      TIMESTAMP NOT NULL DEFAULT now(),
    updated_at      TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT uq_email_templates_key UNIQUE (template_key)
);

CREATE TABLE audit_logs (
    id              BIGSERIAL PRIMARY KEY,
    actor_id        BIGINT REFERENCES users(id) ON DELETE SET NULL,
    action          VARCHAR(100) NOT NULL,
    entity_type     VARCHAR(50) NOT NULL,
    entity_id       BIGINT NOT NULL,
    payload         JSONB,
    created_at      TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX idx_audit_logs_actor_id ON audit_logs (actor_id);
CREATE INDEX idx_audit_logs_entity ON audit_logs (entity_type, entity_id);

CREATE TABLE notifications (
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type        VARCHAR(50) NOT NULL,
    payload     JSONB,
    is_read     BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX idx_notifications_user_id ON notifications (user_id);
CREATE INDEX idx_notifications_is_read ON notifications (is_read);

COMMIT;

-- =====================================================================
-- Ghi chú triển khai
-- =====================================================================
-- 1. BR-03 (không trùng lịch interviewer) và BR-04 (không apply lại JD
--    trong 6 tháng) là ràng buộc liên-dòng/theo thời gian, KHÔNG thể
--    biểu diễn bằng CHECK constraint của PostgreSQL — phải enforce ở
--    tầng application/service (kết hợp Redis lock cho BR-03, xem
--    SEQ-01 trong Chương 3 của B).
-- 2. total_score (feedbacks) và current_round (applications) là cột
--    denormalize/cache — xem giải thích đầy đủ trong
--    report/chapter_4_data.md, mục "Normalization Analysis".
-- 3. Toàn bộ FK dùng ON DELETE RESTRICT cho dữ liệu nghiệp vụ cốt lõi
--    (không cho xoá nhầm làm mất lịch sử tuyển dụng), CASCADE cho dữ
--    liệu con phụ thuộc chặt (feedback_criteria, interview_participants,
--    attachments...), SET NULL cho self-reference (departments.parent_id)
--    và audit_logs.actor_id (giữ log dù user bị xoá).
