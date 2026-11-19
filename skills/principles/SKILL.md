---
name: principles
description: "Trigger: engineering principles, coding standards, SOLID, circuit breaker, resilience, standing rules. Bootstrap the per-repo engineering principles doc."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load when a product repo needs its engineering principles defined (bootstrap or principles questioned), when an RFC needs the deviation baseline, or when code review needs the standing rules to enforce. Do NOT load for a single significant choice (that is `adr`) or for API contract rules (already owned by `api-design`).

## Hard Rules

- One `docs/principles.md` per product repo, ratified by a founding ADR; everything else links to it.
- Principles are defaults with exception paths, never dogma: each states when it does NOT apply and what a deviation requires.
- Brownfield: document the CURRENT reality first, then improve — aspirational principles that do not match the code are dead docs.
- Every remote call gets a timeout; retries require idempotency; circuit breakers on calls whose failure cascades.
- RFCs declare deviations from these principles (`rfc` enforces); a deviation without a linked ADR fails review.

## Decision Gates

| Repo state | Approach |
|---|---|
| Greenfield | full template + founding ADR |
| Brownfield, undocumented | inventory actual patterns → document reality → gaps become proposals, not lies |
| Single-stack (API only, no UI) | skip UI layering; keep resilience + idempotency + error sections |

## Execution Steps

1. Inventory: stack, external calls, async flows, current error handling.
2. Pick layering (clean architecture vs MVC) justified per repo per `references/layering-and-resilience.md` — not by fashion.
3. Fill `assets/principles-template.md`; every principle gets an exception path.
4. Ratify via `adr` as a founding record; reference the doc from the repo's `AGENTS.md`.
5. Wire enforcement: RFC deviations section + code-review checklist.

## Output Contract

Write `docs/principles.md` from the template plus a founding ADR in `decisions/`. Done when: the layering choice is justified per repo, every remote call appears in the resilience table with timeout/retry/breaker decisions, every principle carries an exception path, and the doc is linked from `AGENTS.md`.

## References

- `references/layering-and-resilience.md` — SOLID tests, layering decision table, resilience patterns with defaults.

## Assets

- `assets/principles-template.md` — output skeleton with ratification checklist.
