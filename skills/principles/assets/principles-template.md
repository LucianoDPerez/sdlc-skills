# Engineering Principles: <repo>

Status: draft | ratified
Date: YYYY-MM-DD
Founding ADR: link to `decisions/…`
Referenced from AGENTS.md: yes/no

## 1. Layering

Choice: clean architecture | MVC | hexagonal-lite — justification (2–3 sentences, per repo):

Dependency rule: dependencies point <inward toward the domain>.

Module map: one line per module → its layer.

Exception path: a module may deviate with a linked ADR (see §7).

## 2. SOLID conventions

Enforced strictly in: (domain modules). Enforced pragmatically in: (adapters, UI).
Exception path: …

## 3. Resilience

Every remote call — no exceptions without an ADR:

| Call | Timeout | Retry (max/backoff) | Breaker | Fallback |
|---|---|---|---|---|
| (DB, external APIs, queues, email, PSP — all of them) | | | | |

Exception path: a call may skip a control only with a linked ADR.

## 4. Idempotency & dedup

| Operation class | Mechanism |
|---|---|
| external writes | Idempotency-Key (contract) |
| event/queue handlers | event id + dedup store / natural-key upsert |
| last line of defense | unique constraint in schema (ERD) |

## 5. Error handling

- Catch policy: no silent catch; wrap with correlation id.
- Retryable vs terminal taxonomy:
- Boundary errors map to RFC 7807.

## 6. Concurrency

- Locking default: optimistic (version column); pessimistic requires evidence.
- Transaction boundaries: short; never across remote calls.

## 7. Deviations log

| Principle | Deviation | ADR |
|---|---|---|
| (empty at ratification — every row must link an ADR) | | |

---

## Ratification checklist

- [ ] Every remote call appears in the resilience table
- [ ] Every principle has an exception path
- [ ] Brownfield: matches current code reality — gaps listed as proposals, not as existing practice
- [ ] Founding ADR accepted
- [ ] Linked from the repo's AGENTS.md
