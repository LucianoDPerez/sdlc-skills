# PRD: order-emails

Status: approved
Date: 2026-11-12
Author: Alex Vega (PO)
Discovery brief: `docs/discovery/order-emails.md @ b16f8bb`
Approved by: Dana Ríos (CEO), 2026-11-12

## 1. Executive summary

We're building transactional order emails (confirmation + shipping) with per-account notification preferences for casual buyers to solve the "did my order go through?" anxiety, which will move duplicate-order tickets from 2.1 to under 0.8 per 100 orders within 30 days.

## 2. Problem statement

- Buyers finish checkout with no proof of purchase; confirmation arrives late or never.
- Evidence: 18% of Oct tickets are order-status asks (discovery §2, strong); "I refreshed my inbox for ten minutes and then just ordered again" (discovery §2, 🔶 single interview).

## 3. Target users

- Primary: casual buyer — mobile, ~1 order/month, guest checkout, no account habit.
- Secondary: none — deliberately; wholesale buyers get a later iteration.

## 4. Strategic context

- Ladders to Q4 OKR: reduce support cost per order 20%.
- Why now: highest-volume support category; email provider already contracted; no new vendor needed.

## 5. Solution overview

Two transactional emails — order confirmation (payment OK) and shipping notice (fulfillment) — plus a notification-preferences screen in the account. No new navigation surfaces; emails link to support.

## 6. Success metrics

| Type | Metric | Baseline | Target | Measured |
|---|---|---|---|---|
| Primary | duplicate-order tickets / 100 orders | 2.1 | <0.8 | 2026-12-15 |
| Input | confirmations delivered <5 min | ~40% | 99% | dashboard |
| Guardrail | checkout completion rate | 62% | must not drop below 60% | dashboard |
| Counter | prefs opt-out (shipping notices) | n/a | <1% of accounts | dashboard |

## 7. User stories & acceptance criteria

### Story 1: receive confirmation
As a buyer, I want a confirmation email within 5 minutes of paying, so I can trust the purchase is real.
- Scenario: happy — Given payment succeeded, When the payment event lands, Then a confirmation email with order number, items, total and support link is sent, with delivery attempted within 60s.
- Scenario: failure — Given the email provider errors, When sending fails, Then the email is retried with backoff up to 3 times, And nothing in the checkout flow blocks or errors.

### Story 2: notification preferences
As a buyer with an account, I want to choose which transactional emails I receive, so I control my inbox.
- Scenario: happy — Given I am logged in, When I toggle Shipping notices off in Preferences, Then the setting persists and future shipping emails are skipped.
- Scenario: failure — Given I am logged out, When I call the preferences endpoint, Then I get 401 and no state changes.

### Story 3: shipping notice
As a buyer, I want an email when my order ships, so I know when to expect it.
- Scenario: happy — Given my order is marked shipped and shipping notices are on, When fulfillment completes, Then a shipping email with carrier and tracking link is sent.
- Scenario: boundary — Given shipping notices are off, When the order ships, Then no email is sent and a preferences-respected event is logged.

## 8. Out of scope

| Excluded | Why |
|---|---|
| SMS receipts | new vendor + phone validation; separate RFC |
| In-app order status page | discovery riskiest assumption #1 — email-first test |
| Marketing emails | different consent regime |

## 9. Dependencies & risks

- Dependencies: Mailhaus contract (99% SLA); PayForge payment webhook events.
- Risks: provider outage → outbox retry + parked alert (owner: Sam Okafor); prefs endpoint abuse → rate limit + authz (owner: Sam Okafor).

## 10. Open questions

- 🔵 Reply-to on transactional emails — owner Alex Vega — needed by RFC 2026-11-17.

---

## Completeness checklist (must pass before approval)

- [x] Every claim cites evidence or is tagged 🔶/🔵
- [x] Primary metric has baseline → target → date
- [x] Every story has happy + failure criteria
- [x] Out of scope has ≥1 entry
- [x] Open questions have owners
- [x] Discovery brief linked
