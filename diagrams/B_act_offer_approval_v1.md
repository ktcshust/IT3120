# B_act_offer_approval_v1 — ACT-02 Quy trình duyệt offer multi-level

**Người vẽ:** B (Behavior / Process Analyst)
**Phiên bản:** v1
**Nguồn:** UC-04, BR-08, BR-09, BR-10
**Swimlane:** Recruiter, Hiring Manager, Head of HR, Finance, Candidate, System

Tiêu chí Done:
- Start / end rõ
- Decision theo mức lương so với band (3 nhánh: trong band / vượt ≤10% / vượt >10%)
- Loop: Request Change / Reject nội bộ → Recruiter sửa → duyệt lại từ cấp 1
- Swimlane đủ actor liên quan

---

## Diagram

```mermaid
flowchart TB
    Start([Start: Ứng viên pass hết vòng]) --> RecCreate[Tạo Offer draft: lương, start date, benefits, deadline]

    subgraph Recruiter["Swimlane: Recruiter"]
        RecCreate
        RecEdit[Chỉnh Offer theo Request Change]
        RecResubmit[Gửi lại từ cấp 1]
    end

    subgraph System["Swimlane: System"]
        SysCalcLevel{So sánh salary với salary_band?}
        SysRoute1[Cần 1 cấp: Hiring Manager]
        SysRoute2[Cần 2 cấp: HM + Head of HR]
        SysRoute3[Cần 3 cấp: HM + Head of HR + Finance]
        SysSetPending[status = PENDING_APPROVAL, level = 1]
        SysNextLevel{Còn cấp duyệt tiếp?}
        SysApproved[status = APPROVED → SIGNED_BY_COMPANY]
        SysSendOffer[Gửi offer tới CandidatePortal, đặt deadline 7 ngày LV]
        SysRejectInt[status = REJECTED_INTERNALLY]
        SysBackScreen[Application → SCREENING để chỉnh lại]
        SysExpired[status = EXPIRED]
        SysAccepted[Application → ACCEPTED]
        SysOnHold[Các Application khác của candidate → ON_HOLD]
        SysDeclined[Application → DECLINED]
        SysNegotiating[Application → NEGOTIATING]
    end

    subgraph HiringManager["Swimlane: Hiring Manager"]
        HMReview[Xem Offer cấp 1]
        HMDecide{Approve / Reject / Request Change?}
    end

    subgraph HeadOfHR["Swimlane: Head of HR"]
        HRReview[Xem Offer cấp 2]
        HRDecide{Approve / Reject / Request Change?}
    end

    subgraph Finance["Swimlane: Finance"]
        FinReview[Xem Offer cấp 3]
        FinDecide{Approve / Reject / Request Change?}
    end

    subgraph Candidate["Swimlane: Candidate"]
        CandResp{Phản hồi trong deadline?}
        CandAccept[Accept]
        CandDecline[Decline]
        CandCounter[Counter-offer]
    end

    RecCreate --> SysCalcLevel
    RecEdit --> RecResubmit
    RecResubmit --> SysCalcLevel

    SysCalcLevel -->|Trong band| SysRoute1
    SysCalcLevel -->|Vượt ≤10%| SysRoute2
    SysCalcLevel -->|Vượt >10%| SysRoute3

    SysRoute1 --> SysSetPending
    SysRoute2 --> SysSetPending
    SysRoute3 --> SysSetPending

    SysSetPending --> HMReview
    HMReview --> HMDecide

    HMDecide -->|Request Change| RecEdit
    HMDecide -->|Reject| SysRejectInt
    HMDecide -->|Approve| SysNextLevel

    SysNextLevel -->|Cần cấp 2| HRReview
    SysNextLevel -->|Cần cấp 3 sau HM| HRReview
    SysNextLevel -->|Chỉ 1 cấp / đủ cấp| SysApproved

    HRReview --> HRDecide
    HRDecide -->|Request Change| RecEdit
    HRDecide -->|Reject| SysRejectInt
    HRDecide -->|Approve| NeedFin{Cần cấp Finance?}

    NeedFin -->|Có - vượt band hơn 10%| FinReview
    NeedFin -->|Không| SysApproved

    FinReview --> FinDecide
    FinDecide -->|Request Change| RecEdit
    FinDecide -->|Reject| SysRejectInt
    FinDecide -->|Approve| SysApproved

    SysRejectInt --> SysBackScreen
    SysBackScreen --> EndReject([End: Offer rejected internally])

    SysApproved --> SysSendOffer
    SysSendOffer --> CandResp

    CandResp -->|Hết hạn| SysExpired
    SysExpired --> EndExpired([End: Expired])

    CandResp -->|Accept| CandAccept
    CandAccept --> SysAccepted
    SysAccepted --> SysOnHold
    SysOnHold --> EndAccepted([End: Accepted / chờ onboard])

    CandResp -->|Decline| CandDecline
    CandDecline --> SysDeclined
    SysDeclined --> EndDeclined([End: Declined])

    CandResp -->|Counter| CandCounter
    CandCounter --> SysNegotiating
    SysNegotiating --> RecEdit
```

---

## Ghi chú

| Điểm | Giải thích |
|---|---|
| 3 nhánh band | BR-08: trong band → 1 cấp; vượt ≤10% → 2 cấp; vượt >10% → 3 cấp. |
| Loop Request Change | UC-04 A4.1: trả về Recruiter, duyệt lại từ cấp 1 (không tiếp tục từ cấp đang dang dở). |
| Reject nội bộ | `OFFER_REJECTED_INTERNALLY` → Application quay `SCREENING` (spec mục 7). |
| Candidate counter | `NEGOTIATING` → Recruiter chỉnh offer → vòng duyệt mới (loop về `OFFER_PENDING`). |
| BR-09 / BR-10 | Deadline 7 ngày làm việc; Accept → các Application khác `ON_HOLD`. |
| Khớp SEQ-02 | Cùng logic, góc nhìn object interaction thay vì swimlane nghiệp vụ. |
