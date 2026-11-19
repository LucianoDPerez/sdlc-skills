# Lean Feature Doc: <feature-slug>

Status: draft | approved
Date: YYYY-MM-DD
Owner:
Approved by: <name> (<role>), <date> — in solo mode the owner signs; sha-binding applies
Mode: solo | small team
Replaces: discovery brief + PRD + (UX spec if user-facing) + RFC — lean profile, `skills/sdlc/references/pipeline.md`

## 1. Problem + evidence

Who, what, why painful. Every claim cites evidence (analytics, tickets, interviews) or is tagged 🔶/🔵 inline.

## 2. Success metric

| Type | Metric | Baseline | Target | Measured |
|---|---|---|---|---|
| Primary (ONE) | | | | <date> |
| Guardrail | | must not go below/above | | |

## 3. Stories

Gherkin happy + failure per story. Out of scope: ≥1 entry with reason.

## 4. UI (only if user-facing)

Screen inventory + states (empty/loading/error/success per screen), spec-time accessibility results. Skip this section if no UI.

## 5. Alternatives considered

≥2 real options + do nothing, one-line trade-off each. A significant choice → spawn `adr`; do not bury it here.

## 6. Data / API touchpoints

Tables/columns touched (run `erd` if the schema changes); endpoints/contracts (run `api-design` if there is an external contract).

## 7. Security considerations

Trust boundaries crossed, top threats. The `security` stage still runs before implementation — this section feeds it.

## 8. Rollout + rollback

Flag/stages; rollback trigger stated numerically ("5xx >2× baseline for 5 min → roll back").

## 9. Deviations from docs/principles.md

| Principle | Deviation | ADR |
|---|---|---|

## 10. Open questions

🔵 each with owner and needed-by date.

---

Downstream gates STILL RUN: `security`, `qa`, `release` — lean collapses knowledge stages, not risk stages.
