# Discovery Brief: order-emails

Status: approved
Date: 2026-11-10
Author: Alex Vega (PO)
Approved by: Alex Vega (PO), 2026-11-10

## 1. Problem statement

- **Who:** buyers at Vela Store (candles e-commerce, mobile-heavy, mostly guest checkout).
- **What:** "I never know if my order went through" — checkout ends on a spinner; confirmation arrives hours later or never.
- **Why it's painful:** 1 in 6 support tickets is "did my order work?"; buyers call the shop; some place duplicate orders and eat the refund cost.
- **NOT the problem:** shipping carrier delays; marketing email strategy; SMS.

## 2. Evidence

| Insight | Citation | Strength |
|---|---|---|
| 18% of Oct support tickets ask for order status | Zendesk export, Oct 2026 | strong |
| Confirmation opens: 71% when it arrives <2 min, 9% after 1h | email provider analytics, Sep–Oct 2026 | medium |
| 3 of 5 interviewees re-checked email within 5 min of paying | Interviews #1–#5, Nov 3–7 | medium |

> "I refreshed my inbox for ten minutes and then just ordered again." — Interview #3, buyer, Nov 5

## 3. Personas / Jobs-to-be-done

- Primary persona: casual buyer — mobile, ~1 order/month, guest checkout, checks email immediately after paying.
- Job-to-be-done: "When I pay online, I want immediate proof the order exists, so I can stop worrying and close the tab."

## 4. Assumptions (ranked by risk)

| # | Assumption | Impact | Uncertainty | Evidence |
|---|---|---|---|---|
| 1 | Buyers accept email-only confirmation (no in-app status) | 3 | 4 | weak |
| 2 | Duplicate-order tickets drop when confirmation <5 min | 4 | 2 | medium |
| 3 | Mailhaus delivers >99% within 2 min | 4 | 2 | strong (SLA) |

**Riskiest assumption:** #1 — the PRD's guardrail metric tests it (in-app status page is the fallback).

## 5. Opportunity map

```
Outcome: buyer trusts the purchase
└── Opportunity: instant proof of purchase
    └── Solution candidates: order confirmation email, SMS receipt, in-app status page
```

## 6. Recommendation

- [x] Proceed to PRD
- [ ] Run one more experiment
- [ ] Kill

## 7. Open questions

- 🔵 Reply-to on transactional emails: support inbox vs no-reply — owner: Alex Vega
