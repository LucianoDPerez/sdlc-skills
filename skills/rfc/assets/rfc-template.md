# RFC NNNN: <slug>

Status: draft | review | accepted | rejected | superseded
Author:
Reviewers:
PRD: `docs/prd/<feature-slug>.md @ <approval sha>`
UX spec: `docs/ux/<feature-slug>.md @ <approval sha>` (if user-facing)
Date: YYYY-MM-DD
Approved by: <name> (<role>), <date>

## 1. Context

The problem, constraints, and why now. Written for an engineer with zero meeting background.

## 2. Goals

- …

## 3. Non-goals

- Explicitly out of scope; changes here require re-review.

## 4. Alternatives considered

| Criterion (weight) | Option A | Option B | Do nothing |
|---|---|---|---|
| | score + one-line why | | |
| **Weighted total** | | | |

## 5. Proposed design

Decision + justification. Significant choices → link ADR(s) from `decisions/`.

### C4 context

```mermaid
flowchart LR
```

### C4 container

```mermaid
flowchart LR
```

### Critical sequences

One mermaid sequenceDiagram per critical PRD story, error branches included.

### Principles deviations

Against the repo's `docs/principles.md` — every row links an ADR; "none" is a valid entry:

| Principle | Deviation | ADR |
|---|---|---|

## 6. Data

Entities touched or created (detail lives in the ERD via `erd`); storage implications one level deep.

## 7. API surface

Endpoints/events added or changed (detail via `api-design`); auth and rate-limit implications.

## 8. Security considerations

Threats considered at design time (detail via `security`): trust boundaries, auth changes, data exposure.

## 9. Observability

New metrics, logs, traces; alert thresholds and owners.

## 10. Rollout

| Phase | Change | Rollback |
|---|---|---|
| 1 | | how to undo, tested? |

Coexistence with the old path during rollout; feature flags used.

## 11. Open questions

- 🔵 …

---

## Reviewer checklist

Run `references/design-review.md` checklist; all boxes pass before status → accepted.
