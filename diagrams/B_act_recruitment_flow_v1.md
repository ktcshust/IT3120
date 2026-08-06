# B_act_recruitment_flow_v1 — ACT-01 Toàn bộ quy trình tuyển 1 ứng viên

**Người vẽ:** B (Behavior / Process Analyst)
**Phiên bản:** v1
**Nguồn:** UC-01 → UC-04, state machine mục 7 (`spec_ats (1).md`), BR-02/05/07/09/10/11
**Swimlane:** Candidate, Recruiter, Hiring Manager, Interviewer, System

Tiêu chí Done (`02_person_B_behavior.md` mục 6):
- Start / end node rõ ràng
- ≥2 decision node (sàng lọc, pass vòng PV, phản hồi offer, onboard)
- Swimlane cho mỗi actor
- Có fork/join: gửi email mời song song tới Candidate + Interviewer

---

## Diagram

```mermaid
flowchart TB
    Start([Start]) --> CandSubmit[Nộp CV qua portal]

    subgraph Candidate["Swimlane: Candidate"]
        CandSubmit
        CandConfirm{Xác nhận lịch trong 24h?}
        CandAttend[Tham dự phỏng vấn]
        CandOfferResp{Phản hồi offer?}
        CandAccept[Accept offer]
        CandDecline[Decline offer]
        CandCounter[Counter-offer / đàm phán]
        CandOnboard[Onboard đúng ngày]
    end

    subgraph Recruiter["Swimlane: Recruiter"]
        RecScreen[Mở danh sách CV mới / SCREENING]
        RecDecide{Shortlist hay Reject?}
        RecRejectReason[Chọn lý do reject]
        RecTalent{Thêm talent pool?}
        RecSchedule[Chọn interviewer + khung giờ]
        RecOverride{Override lịch trùng?}
        RecOfferDraft[Tạo Offer draft]
        RecReschedule[Xếp lịch lại]
    end

    subgraph HiringManager["Swimlane: Hiring Manager"]
        HMReviewOffer[Duyệt offer theo cấp BR-08]
        HMDecideOffer{Approve / Reject / Request Change?}
    end

    subgraph Interviewer["Swimlane: Interviewer"]
        IntAttend[Tham dự phỏng vấn]
        IntFeedback[Chấm scorecard + verdict]
        IntSubmitFB[Submit feedback]
    end

    subgraph System["Swimlane: System"]
        SysCreateApp[Tạo Application status=NEW]
        SysConflict{Xung đột lịch?}
        SysSuggest[Gợi ý 3 slot trống]
        SysCreateIV[Tạo Interview SCHEDULED]
        SysNotifyParallel[[Fork: gửi email mời]]
        SysEmailCand[Email mời Candidate]
        SysEmailInt[Email mời Interviewer]
        SysJoinNotify[[Join]]
        SysSetSLA[Đặt SLA xác nhận 24h]
        SysNeedResched[Chuyển NEED_RESCHEDULE]
        SysMarkCompleted[Đánh dấu Interview COMPLETED]
        SysCheckBR07{≥50% HIRE nếu ≥2 interviewer?}
        SysPassRound[Pass vòng / sang vòng tiếp]
        SysRejectAfterIV[Cập nhật REJECTED]
        SysAllRoundsDone{Hết vòng?}
        SysNotifyOffer[Gửi offer + đặt deadline 7 ngày]
        SysExpireOffer[Offer EXPIRED]
        SysOnHold[Các Application khác → ON_HOLD]
        SysGhosted[ACCEPTED → GHOSTED, reopen JD]
        SysHired[Cập nhật HIRED]
        SysTalentPool[Ghi TALENT_POOL]
        SysRejectEmail[Gửi email reject]
    end

    CandSubmit --> SysCreateApp
    SysCreateApp --> RecScreen
    RecScreen --> RecDecide

    RecDecide -->|Reject| RecRejectReason
    RecRejectReason --> RecTalent
    RecTalent -->|Có| SysTalentPool
    RecTalent -->|Không| SysRejectEmail
    SysTalentPool --> EndReject([End: Rejected / Talent Pool])
    SysRejectEmail --> EndReject

    RecDecide -->|Shortlist| RecSchedule
    RecSchedule --> SysConflict

    SysConflict -->|Có xung đột| SysSuggest
    SysSuggest --> RecOverride
    RecOverride -->|Không, chọn lại| RecSchedule
    RecOverride -->|Có, ghi audit| SysCreateIV
    SysConflict -->|Không xung đột| SysCreateIV

    SysCreateIV --> SysNotifyParallel
    SysNotifyParallel --> SysEmailCand
    SysNotifyParallel --> SysEmailInt
    SysEmailCand --> SysJoinNotify
    SysEmailInt --> SysJoinNotify
    SysJoinNotify --> SysSetSLA
    SysSetSLA --> CandConfirm

    CandConfirm -->|Không / quá 24h| SysNeedResched
    SysNeedResched --> RecReschedule
    RecReschedule --> RecSchedule

    CandConfirm -->|Có| CandAttend
    CandAttend --> IntAttend
    IntAttend --> SysMarkCompleted
    SysMarkCompleted --> IntFeedback
    IntFeedback --> IntSubmitFB
    IntSubmitFB --> SysCheckBR07

    SysCheckBR07 -->|Không đạt BR-07| SysRejectAfterIV
    SysRejectAfterIV --> EndReject

    SysCheckBR07 -->|Đạt| SysPassRound
    SysPassRound --> SysAllRoundsDone
    SysAllRoundsDone -->|Còn vòng| RecSchedule
    SysAllRoundsDone -->|Hết vòng| RecOfferDraft

    RecOfferDraft --> HMReviewOffer
    HMReviewOffer --> HMDecideOffer
    HMDecideOffer -->|Request Change| RecOfferDraft
    HMDecideOffer -->|Reject nội bộ| RecScreen
    HMDecideOffer -->|Approve đủ cấp| SysNotifyOffer

    SysNotifyOffer --> CandOfferResp
    CandOfferResp -->|Không phản hồi / hết hạn| SysExpireOffer
    SysExpireOffer --> EndExpired([End: Offer Expired])

    CandOfferResp -->|Decline| CandDecline
    CandDecline --> EndDeclined([End: Declined])

    CandOfferResp -->|Counter| CandCounter
    CandCounter --> RecOfferDraft

    CandOfferResp -->|Accept| CandAccept
    CandAccept --> SysOnHold
    SysOnHold --> CandOnboard
    CandOnboard -->|Đúng ngày| SysHired
    SysHired --> EndHired([End: Hired])
    CandOnboard -->|Không onboard| SysGhosted
    SysGhosted --> EndGhosted([End: Ghosted])
```

---

## Ghi chú

| Điểm | Giải thích |
|---|---|
| Decision sàng lọc | Recruiter Shortlist / Reject (UC-02); Reject có nhánh talent pool (A4.1). |
| Decision lịch | System kiểm tra xung đột (BR-03); override ghi audit (UC-01 A5.2). |
| Decision vòng PV | BR-07: ≥2 interviewer → ≥50% verdict HIRE trở lên mới pass. |
| Decision offer | ACT-02 chi tiết hơn; ở đây rút gọn thành 1 swimlane Hiring Manager đại diện chuỗi duyệt. |
| Fork/Join | Gửi email mời Candidate và Interviewer song song sau khi tạo Interview. |
| NEED_RESCHEDULE | BR-05: Candidate không xác nhận trong 24h → System chuyển trạng thái, Recruiter xếp lại. |
| ON_HOLD / GHOSTED | BR-10 / BR-11 — khớp enum `application_status` của C. |
