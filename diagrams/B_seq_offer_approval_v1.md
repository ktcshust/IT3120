# B_seq_offer_approval_v1 — SEQ-02 Duyệt offer multi-level

**Người vẽ:** B (Behavior / Process Analyst)
**Phiên bản:** v1
**Nguồn:** UC-04, BR-08, BR-09, BR-10
**Lifelines:** Recruiter, OfferService, ApprovalWorkflow, HiringManager, HeadOfHR, Finance, CandidatePortal

Đây là sequence phức tạp nhất — focus khi bảo vệ.

Tiêu chí Done:
- ≥4 lifeline (7)
- Message return trên Approve/Reject
- Fragment `alt` cho 3 mức band; `loop`/`alt` cho từng cấp duyệt; `opt` cho Request Change / counter

---

## Diagram

```mermaid
sequenceDiagram
    actor Recruiter
    participant OfferService
    participant ApprovalWorkflow
    actor HiringManager
    actor HeadOfHR
    actor Finance
    participant CandidatePortal

    Recruiter->>OfferService: 1. createOfferDraft(appId, salary, startDate, benefits, deadline)
    OfferService->>OfferService: 2. validatePrecondition(allRoundsPassed)
    OfferService->>ApprovalWorkflow: 3. determineLevels(salary, salaryBandMin, salaryBandMax)

    alt salary trong band (BR-08 → 1 cấp)
        ApprovalWorkflow-->>OfferService: 4a. levels=1 [HM]
    else vượt band ≤10% (BR-08 → 2 cấp)
        ApprovalWorkflow-->>OfferService: 4b. levels=2 [HM, HeadOfHR]
    else vượt band >10% (BR-08 → 3 cấp)
        ApprovalWorkflow-->>OfferService: 4c. levels=3 [HM, HeadOfHR, Finance]
    end

    OfferService->>ApprovalWorkflow: 5. startApproval(offerId, levels)
    ApprovalWorkflow-->>OfferService: 6. status=PENDING_APPROVAL, currentLevel=1
    OfferService-->>Recruiter: 7. OfferPending

    loop Mỗi cấp duyệt từ 1 → levels
        alt currentLevel == 1
            ApprovalWorkflow->>HiringManager: 8. requestDecision(offerId, level=1)
            HiringManager-->>ApprovalWorkflow: 9. decision (APPROVED / REJECTED / REQUEST_CHANGE)
        else currentLevel == 2
            ApprovalWorkflow->>HeadOfHR: 10. requestDecision(offerId, level=2)
            HeadOfHR-->>ApprovalWorkflow: 11. decision
        else currentLevel == 3
            ApprovalWorkflow->>Finance: 12. requestDecision(offerId, level=3)
            Finance-->>ApprovalWorkflow: 13. decision
        end

        alt decision == REQUEST_CHANGE (UC-04 A4.1)
            ApprovalWorkflow->>OfferService: 14. returnForEdit(offerId, comment)
            OfferService-->>Recruiter: 15. RequestChange
            Note over Recruiter,ApprovalWorkflow: Recruiter sửa → createOfferDraft lại → duyệt từ cấp 1
        else decision == REJECTED
            ApprovalWorkflow->>OfferService: 16. markRejectedInternally(offerId)
            OfferService-->>Recruiter: 17. OFFER_REJECTED_INTERNALLY
            Note over OfferService: Application → SCREENING (STATE-01)
        else decision == APPROVED
            ApprovalWorkflow->>ApprovalWorkflow: 18. advanceLevel() / record OfferApproval
        end
    end

    ApprovalWorkflow->>OfferService: 19. allLevelsApproved(offerId)
    OfferService->>OfferService: 20. status=SIGNED_BY_COMPANY
    OfferService->>CandidatePortal: 21. sendOffer(offerId, deadline=7WD)
    CandidatePortal-->>OfferService: 22. delivered
    OfferService-->>Recruiter: 23. OfferSent

    alt Candidate Accept
        CandidatePortal->>OfferService: 24a. accept(offerId)
        OfferService->>OfferService: 25a. Application=ACCEPTED; other apps=ON_HOLD (BR-10)
        OfferService-->>CandidatePortal: 26a. AcceptedAck
    else Candidate Decline
        CandidatePortal->>OfferService: 24b. decline(offerId)
        OfferService-->>CandidatePortal: 25b. DeclinedAck
    else Candidate Counter-offer
        CandidatePortal->>OfferService: 24c. counter(offerId, newTerms)
        OfferService-->>Recruiter: 25c. NEGOTIATING → chỉnh draft → duyệt lại
    else Không phản hồi / hết hạn (BR-09)
        OfferService->>OfferService: 24d. expire(offerId)
        Note over OfferService: status=EXPIRED
    end
```

---

## Ghi chú — câu hỏi bảo vệ thường gặp

| Câu hỏi | Trả lời ngắn |
|---|---|
| Vì sao `ApprovalWorkflow` tách khỏi `OfferService`? | OfferService quản lý vòng đời Offer (CRUD, gửi candidate). ApprovalWorkflow đóng gói quy tắc cấp duyệt (BR-08) và có thể tái dùng cho JD approve (`Approvable` trong Class Diagram của C). |
| Sao chọn SEQ này? | Nhiều actor, 3 nhánh band, loop cấp duyệt, alt phản hồi candidate — phức tạp nhất trong hệ thống. |
| Khớp ACT-02? | Cùng BR-08/09/10; ACT-02 nhìn swimlane nghiệp vụ, SEQ-02 nhìn tương tác service. |
