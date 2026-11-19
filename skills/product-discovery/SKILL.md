---
name: product-discovery
description: "Trigger: discovery, user research, customer interviews, validate problem, opportunity. Frame the real problem and gather evidence before anything is built."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load at the start of any feature, product, or initiative — before a PRD exists — or when validating a problem/solution idea. Do NOT load when a discovery brief already exists and passes its checklist (go to `prd`).

## Hard Rules

- Treat any proposed solution as a hypothesis, never as the problem. Reframe first.
- Every insight must cite evidence: interview quote, analytics number, ticket, or observation — no "we believe".
- Interviews ask about past behavior, not opinions or predictions (Mom Test rules in `references/interviews.md`).
- Output ranks assumptions by risk; the riskiest assumption is named explicitly.
- Never write requirements or solution specs here — that is `prd`'s job.

## Decision Gates

| Situation | Approach |
|---|---|
| Greenfield product | problem framing + JTBD + 5–8 interviews |
| Existing product, new feature | analytics + support tickets + 3–5 interviews |
| No user access yet | data-first: analytics, tickets, competitor reviews, docs |
| Competing problem candidates | rank by evidence strength, pick one, note others |

## Execution Steps

1. Frame the problem: who, what, why painful, and what is NOT the problem.
2. List the assumptions the idea rests on; score each by impact × uncertainty.
3. Gather evidence per `references/interviews.md` and `references/synthesis.md`.
4. Synthesize into insights with citations; map them on an opportunity tree.
5. Produce the brief from `assets/discovery-brief-template.md`.

## Output Contract

Write `docs/discovery/<feature-slug>.md`: problem statement, evidence section with citations, personas/JTBD, ranked assumptions (riskiest first), opportunity map, and explicit recommendation: proceed to PRD, kill, or run one more experiment. Every claim without evidence must be labeled 🔶 assumption or 🔵 open question.

## References

- `references/interviews.md` — Mom Test rules, question bank, anti-patterns.
- `references/synthesis.md` — evidence handling, assumption ranking, opportunity trees.

## Assets

- `assets/discovery-brief-template.md` — output skeleton.
- `assets/interview-script.md` — copy-paste interview guide.
