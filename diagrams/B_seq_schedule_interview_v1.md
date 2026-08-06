# B_seq_schedule_interview_v1 — SEQ-01 Xếp lịch phỏng vấn có kiểm tra xung đột

**Người vẽ:** B (Behavior / Process Analyst)
**Phiên bản:** v1
**Nguồn:** UC-01, BR-03, BR-05
**Lifelines:** Recruiter, UI, SchedulingService, CalendarRepo, NotificationService, EmailGateway

Tiêu chí Done:
- ≥4 lifeline (thực tế 6)
- Có message return (đường đứt nét)
- Fragment `alt` (xung đột / không xung đột) và `opt` (override)
- Khớp service naming với kiến trúc D (SchedulingService, NotificationService...)

---

## Diagram

```mermaid
sequenceDiagram
    actor Recruiter
    participant UI
    participant SchedulingService
    participant CalendarRepo
    participant NotificationService
    participant EmailGateway

    Recruiter->>UI: 1. Chọn Application + click "Xếp lịch"
    UI->>SchedulingService: 2. getNextRound(applicationId)
    SchedulingService-->>UI: 3. roundInfo (roundOrder, roundName)
    UI-->>Recruiter: 4. Hiển thị vòng kế tiếp + form

    Recruiter->>UI: 5. Chọn 1..3 interviewer + timeSlot
    UI->>SchedulingService: 6. scheduleInterview(appId, interviewers, timeSlot)

    SchedulingService->>CalendarRepo: 7. findConflicts(interviewerIds, timeSlot)
    CalendarRepo-->>SchedulingService: 8. conflictList

    alt Có xung đột lịch (UC-01 A5.1, BR-03)
        SchedulingService->>CalendarRepo: 9a. suggestFreeSlots(interviewerIds, count=3)
        CalendarRepo-->>SchedulingService: 10a. freeSlots[3]
        SchedulingService-->>UI: 11a. ConflictResult + freeSlots
        UI-->>Recruiter: 12a. Hiển thị interviewer trùng + 3 slot gợi ý

        opt Override khi không chấp nhận slot gợi ý (UC-01 A5.2)
            Recruiter->>UI: 13a. override(timeSlot, reason)
            UI->>SchedulingService: 14a. scheduleInterview(..., force=true, reason)
            SchedulingService->>CalendarRepo: 15a. writeAuditLog(OVERRIDE_SCHEDULE)
            CalendarRepo-->>SchedulingService: 16a. ok
        end
    else Không xung đột
        Note over SchedulingService: Tiếp tục tạo lịch
    end

    SchedulingService->>CalendarRepo: 17. createInterview(SCHEDULED) + addParticipants
    CalendarRepo-->>SchedulingService: 18. interviewId
    SchedulingService->>CalendarRepo: 19. addCalendarEvents(interviewers)
    CalendarRepo-->>SchedulingService: 20. ok

    SchedulingService->>NotificationService: 21. notifyInvite(interviewId)
    NotificationService->>EmailGateway: 22. send(template=interview_invite, candidate)
    EmailGateway-->>NotificationService: 23. sent
    NotificationService->>EmailGateway: 24. send(template=interview_invite, interviewers)
    EmailGateway-->>NotificationService: 25. sent
    NotificationService-->>SchedulingService: 26. notified

    SchedulingService->>CalendarRepo: 27. setConfirmSLA(deadline=now+24h)
    CalendarRepo-->>SchedulingService: 28. ok
    SchedulingService-->>UI: 29. InterviewCreated
    UI-->>Recruiter: 30. Thông báo xếp lịch thành công

    Note over SchedulingService,EmailGateway: Sau 24h nếu Candidate chưa xác nhận → Cron chuyển NEED_RESCHEDULE (BR-05, xem SEQ-03 pattern)
```

---

## Ghi chú

| Điểm | Giải thích |
|---|---|
| Vì sao tách `CalendarRepo` | Persistence lịch + kiểm tra conflict; Redis lock (BR-03 race) nằm ở tầng SchedulingService trước khi gọi Repo — D sẽ phản ánh trong Component Diagram. |
| `alt` / `opt` | Đúng alt flow UC-01 A5.1 và A5.2; không gộp thành 1 nhánh. |
| Message return | Mọi gọi service đều có `-->>` trả kết quả. |
| BR-12 | Email dùng template đã duyệt (`interview_invite`). |
| Khớp C | Persist `interviews`, `interview_participants`; status `SCHEDULED`. |
