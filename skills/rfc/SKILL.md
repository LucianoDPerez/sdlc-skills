---
name: rfc
description: "Trigger: RFC, technical design, architecture doc, system design, how to build it. Produce a reviewable technical design with real alternatives and a rollout plan."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load when a PRD (and UX spec, if user-facing) is approved and the technical approach must be designed, or when revising an existing RFC. Do NOT load without an approved PRD — report the blocked gate. Significant choices made here spawn `adr`, not inline prose.

## Hard Rules

- Alternatives table with ≥2 real options plus "do nothing"; strawman options fail review.
- Context section explains the problem for an engineer with zero meeting background.
- Non-goals are explicit; scope creep is the #1 RFC killer.
- Architecture views follow C4 (context + container minimum) as mermaid, per `references/design-review.md`.
- Rollout and security-considerations sections are mandatory, not optional appendices.
- Cite the PRD/UX artifacts; every requirement traced to a design element or explicitly deferred.

## Decision Gates

| Design scope | Depth |
|---|---|
| Single feature in existing system | container + sequence diagram, no new C4 context |
| New service / major component | full C4 context + container + 1–2 sequences |
| Cross-cutting change (auth, events, data) | above + explicit migration/coexistence plan |

## Execution Steps

1. Restate the problem and constraints from the PRD; list non-goals.
2. Enumerate candidate approaches; fill the tradeoff table honestly (include "do nothing").
3. Pick one and justify; if the choice is significant (hard to reverse, affects other teams), stop and write an ADR via `adr`, then reference it.
4. Draw C4 views and key sequence diagrams (mermaid).
5. Write data, API surface, observability, security-considerations, and rollout sections.
6. Self-review against `references/design-review.md` before requesting comments.

## Output Contract

Write `docs/rfc/NNNN-<slug>.md` (NNNN = next sequential) from `assets/rfc-template.md`. Done when: alternatives table has ≥3 rows, decision is justified and ADR-linked when significant, rollout has phases with rollback, and the reviewer checklist passes.

## References

- `references/design-review.md` — C4 in mermaid, tradeoff table format, review checklist.

## Assets

- `assets/rfc-template.md` — output skeleton.
