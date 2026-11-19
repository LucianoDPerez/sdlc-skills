# Stories, splitting, metrics

## Story format

```markdown
**Story N: <action phrase>**
As a <persona>, I want <capability>, so that <outcome>.

**Acceptance criteria (Gherkin):**
Scenario: happy path
  Given <state>
  When <action>
  Then <observable result>

Scenario: <failure/boundary>
  Given <state>
  When <action or invalid input>
  Then <recovery behavior, message, side effects>
```

Rules: each story ≥1 happy + ≥1 failure scenario; criteria are testable (a QA can derive tests from them — that is `qa`'s coverage matrix input); no story mixes two capabilities; "and engineering will…" is a smell — stories describe user-visible behavior.

## Splitting epics (Lawrence's 9 patterns, in order of preference)

1. **Workflow steps** — split by steps of the flow.
2. **Business rules / variations** — one rule per story.
3. **CRUD operations** — create, read, update, delete.
4. **Data variance** — simple data first, complex later.
5. **Defer effort** — thin slice first, hardening later.
6. **Simple/complex** — simplest version, then edge cases.
7. **Operations** — list, then add/sort/edit one at a time.
8. **Breakout tool/spike** — unknown tech → timeboxed spike story.
9. **Data entry method** — single entry first, bulk/import later.

Stop splitting when a story fits in one iteration and one PR.

## Metric types

| Type | Role | Example |
|---|---|---|
| **Primary** | the ONE number this feature must move | activation rate 40%→60% by <date> |
| **Input** | leading indicators you can act on weekly | checklist completion rate ≥80% |
| **Guardrail** | must NOT regress | signup conversion stays ≥10% |
| **Counter-metric** | prevents gaming the primary | dismiss rate ≤40% alongside activation |

Baseline rule: no metric without a current measured value; "we don't know the baseline" becomes an open question with an owner and a measurement date, not a blank.

## Anti-patterns

- Solution-shaped stories ("implement Redis cache") — reframe as user-visible outcomes.
- Criteria that name UI implementation ("button turns green") — the UX spec owns that.
- 20 stories in one PRD — that is an initiative; split the epic first.
- Success metric with no baseline — you will not be able to prove it worked.
