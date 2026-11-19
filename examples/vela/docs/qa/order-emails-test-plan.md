# Test Plan: order-emails

Status: approved
Date: 2026-11-21
PRD: `docs/prd/order-emails.md @ 78a3574`
RFC: `docs/rfc/0001-order-emails.md @ cecbd11`
Threat model: `docs/security/order-emails-threat-model.md @ 4d37a2f`
Approved by: Sam Okafor (tech lead), 2026-11-21

## 1. Risk matrix

| Feature area | Impact | Likelihood | Score | Band | Depth |
|---|---|---|---|---|---|
| email send path | 4 | 3 | 12 | HIGH | full automation + exploratory + load |
| preferences authz | 5 | 2 | 10 | HIGH | full automation |
| outbox retry/park | 3 | 3 | 9 | MEDIUM | automation |
| email content | 2 | 3 | 6 | LOW | snapshot automation |

## 2. Coverage matrix (from PRD acceptance criteria)

| PRD criterion | Test | Level | Type |
|---|---|---|---|
| US-1 happy | confirmation queued + sent on payment.ok | integration | happy |
| US-1 failure | provider error → backoff ×3 → parked; checkout untouched | integration | failure |
| US-1 latency | event→send p99 <60s at 10× order spike | load | boundary |
| US-2 happy | toggle shipping notices off → next ship skips email | E2E | happy |
| US-2 failure | logged-out PUT → 401 problem+json, no state change | integration | failure |
| US-3 happy | ship event → email with tracking link | E2E | happy |
| US-3 boundary | prefs off → no email, event logged | integration | boundary |
| guardrail | checkout completion unaffected with worker down | load | boundary |

No criterion without a row. "Not covered" is allowed; silence is not.

## 3. Level assignment

| Level | Count target | Framework | CI stage |
|---|---|---|---|
| unit | ~70% (payload render, prefs logic) | vitest | PR |
| integration | ~20% (outbox worker, endpoints) | testcontainers-postgres | PR |
| E2E | ~10% (US-2, US-3 journeys) | Playwright | merge + deploy |

## 4. Quality gates

| Gate | Checks | Threshold | Enforced |
|---|---|---|---|
| PR | unit + integration + lint + SAST | coverage ↓ = fail | CI |
| merge | E2E smoke incl. accessibility procedure | 100% pass | CI |
| deploy | full E2E + load (send path) | p99 <60s | CI |
| nightly | outbox backlog soak + Mailhaus sandbox flake | reviewed AM | CI |

## 5. Test data & environments

- Factories per environment; Mailhaus sandbox for E2E; no shared mutable fixtures; prefs seeded via the backfill script.

## 6. Threat-model blockers coverage

| Threat-model finding | Verifying test | Level |
|---|---|---|
| F1 DMARC | DNS assertion in the deploy gate | deploy |
| T5 IDOR | PUT with A's session → 401, B's prefs untouched | integration |
| T6 retry storm | provider 500s injected → attempts ≤3 then parked; alert fires | integration |

## 7. Accessibility test procedure (from UX spec §6 — implementation-time, owned here)

axe-core on the preferences screen × 4 states; keyboard-only toggle + retry flow; screen-reader smoke (labels, aria-live error announcement); contrast spot-check incl. disabled/locked toggle state.

## 8. Flaky policy

Classify before quarantine; provider sandbox flakes → time-boxed quarantine; quarantine budget <5% of suite, owner Sam Okafor.

## 9. Exploratory charters

| Charter | Target | Duration |
|---|---|---|
| email content edge cases (100-item orders, unicode names) | templates | 2h |
