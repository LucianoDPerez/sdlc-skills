# PRD: <feature-slug>

Status: draft | approved
Date: YYYY-MM-DD
Author:
Discovery brief: `docs/discovery/<feature-slug>.md @ <approval sha>`
Approver:

## 1. Executive summary

One sentence: "We're building <solution> for <persona> to solve <problem>, which will move <primary metric> from <baseline> to <target>."

## 2. Problem statement

- Who, what, why painful.
- Evidence (cite the discovery brief: quotes, analytics, tickets). Every claim without evidence → tag 🔶 or 🔵 inline.

## 3. Target users

- Primary persona (role, goals, pains, current behavior).
- Secondary personas, or "none — deliberately".

## 4. Strategic context

- Business goal / OKR this ladders to.
- Why now.

## 5. Solution overview

High-level description and key user flows. No architecture, no schemas.

## 6. Success metrics

| Type | Metric | Baseline | Target | Measured |
|---|---|---|---|---|
| Primary | (ONE) | | | <date> |
| Input | | | | |
| Guardrail | | must not go below/above | | |
| Counter | | | | |

## 7. User stories & acceptance criteria

Per story: Gherkin happy + failure scenarios (see `references/stories-and-metrics.md`).

### Story 1: <action phrase>
As a …, I want …, so that ….
- Scenario: happy path — Given / When / Then
- Scenario: failure or boundary — Given / When / Then

## 8. Out of scope

| Excluded | Why |
|---|---|
| (≥1 mandatory) | |

## 9. Dependencies & risks

- Dependencies (technical, external, teams).
- Risks: trigger → mitigation, with an owner each.

## 10. Open questions

- 🔵 question — owner — needed-by date. Unanswered questions block `ux`/`rfc`.

---

## Completeness checklist (must pass before approval)

- [ ] Every claim cites evidence or is tagged 🔶/🔵
- [ ] Primary metric has baseline → target → date
- [ ] Every story has happy + failure criteria, testable as written
- [ ] Out of scope has ≥1 entry
- [ ] Open questions have owners
- [ ] Discovery brief linked
