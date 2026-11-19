---
name: adr
description: "Trigger: ADR, decision record, why did we choose, decision log, supersede. Capture one significant choice, its options, and consequences."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load whenever a significant choice is made or requested — in RFCs, planning, reviews, or "why did we…?" questions. Also load to supersede an existing record. Do NOT load for trivial, reversible, or single-person decisions (gate below).

## Hard Rules

- One decision per record; a sprawling record is two records.
- Records are immutable: reversing a decision means a NEW record that supersedes, never an edit.
- Title is an active sentence ("Switch payments to PSP B"), not a topic ("Payments").
- Options are real, including "do nothing" where relevant; strawmen fail review.
- Status transitions require a named human accepting or rejecting — silence is not acceptance.
- Every record lands in `decisions/` and updates `decisions/index.md`.

## Decision Gates

| Check | Record needed? |
|---|---|
| Costly to reverse, affects other teams, will be questioned in a year, sets precedent | YES |
| Cheap, local, temporary, or already covered by policy | NO — decide and move on |
| High-stakes, multi-stakeholder | comprehensive template |
| Everything else | lightweight template (default) |

## Execution Steps

1. Run the gate above; if NO, say so and decide inline.
2. Pick the template: `assets/adr-lightweight.md` (default) or `assets/adr-comprehensive.md`.
3. Draft per the template fields; context written for a reader with zero meeting background.
4. Set status `proposed` with a comment deadline; route to the decision-maker(s).
5. On acceptance: update status + date; if superseding, link forward and back.
6. Append to `decisions/index.md`.

## Output Contract

`decisions/YYYY-MM-DD-<slug>.md` from a template, plus an index row: title, status, date, one-line summary. Done when a stranger can read it and understand both the decision and the why.

## References

- `references/adr-lifecycle.md` — statuses, governance, supersede flow, index format.

## Assets

- `assets/adr-lightweight.md` — default six-field record.
- `assets/adr-comprehensive.md` — high-stakes variant.
