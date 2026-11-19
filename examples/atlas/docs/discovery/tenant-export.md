# Discovery Brief: tenant-export

Status: approved
Date: 2026-11-17
Author: Maya Chen (CTO)
Approved by: Maya Chen (CTO), 2026-11-17

## 1. Problem statement

- **Who:** enterprise prospects evaluating Atlas (B2B logistics API) — compliance and data teams.
- **What:** "if we adopt you, can we ever get our data out?" — no export path exists; data feels locked in.
- **Why it's painful:** procurement now requires a data-portability clause; deals stall in legal review.
- **NOT the problem:** self-serve analytics dashboards; data quality; import (already solved).

## 2. Evidence

| Insight | Citation | Strength |
|---|---|---|
| 3 enterprise deals lost in 2026-Q3 with lock-in cited in the post-mortem notes | sales CRM deal records | medium |
| data-portability clause requested in 5 of 6 active enterprise negotiations | procurement email threads, Oct–Nov 2026 | strong |
| 2 mid-market customers built ad-hoc scrape scripts (support tickets #4102, #4419) | support tickets | medium |

> "We can't sign without an exit story for our data." — procurement lead, deal #2119, Nov 2

## 3. Personas / Jobs-to-be-done

- Primary persona: enterprise data engineer — wants a documented, rate-limited export API, not a UI.
- Job-to-be-done: "When compliance asks where our data lives, I want a supported export path, so I can answer and keep the deal moving."

## 4. Assumptions (ranked by risk)

| # | Assumption | Impact | Uncertainty | Evidence |
|---|---|---|---|---|
| 1 | An async API export (no UI) satisfies procurement clauses | 4 | 3 | medium — clause language says "documented export capability" |
| 2 | Exports stay rare (<1% of tenants/quarter) | 3 | 2 | medium — no usage data yet |
| 3 | Large tenants export <50 GB | 3 | 2 | weak |

**Riskiest assumption:** #1 — legal review of the clause language validates it before build.

## 5. Opportunity map

```
Outcome: enterprise deals close without data-lock-in objections
└── Opportunity: credible data exit path
    └── Solution candidates: async export API, nightly S3 drop, database dump tool access
```

## 6. Recommendation

- [x] Proceed to PRD
- [ ] Run one more experiment
- [ ] Kill

## 7. Open questions

- 🔵 Does the export need to include soft-deleted records for compliance? — owner: Maya Chen
