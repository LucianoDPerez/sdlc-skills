---
name: prd
description: "Trigger: PRD, product requirements, user stories, success metrics, feature spec. Turn an approved discovery brief into an engineering-ready product requirements document."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load when a discovery brief is approved and requirements must be written, or when an existing PRD is being revised. Do NOT load without a discovery brief (blocked gate → `product-discovery`), and do not design the technical solution here — that is `rfc`'s job.

## Hard Rules

- Problem statement must cite discovery evidence; no evidence, no PRD.
- Success metrics must state baseline → target with a measurement date.
- Every user story carries Gherkin acceptance criteria covering happy path and failure.
- Out of scope is mandatory; unlisted scope is the #1 PRD failure.
- Every unsupported claim is tagged 🔶 assumption or 🔵 open question inline.
- Requirements describe WHAT and WHY, never HOW (no stacks, no schemas here).

## Decision Gates

| Input depth | PRD size |
|---|---|
| Single feature, clear evidence | lean: sections 1–8 of the template, one pass |
| Initiative with unknowns | full template + explicit experiments for open questions |
| Existing PRD revision | diff-based: change log entry, re-approve affected sections only |

## Execution Steps

1. Load the discovery brief; carry over problem, personas, evidence, and ranked assumptions.
2. Write the executive summary sentence: "We're building X for Y to solve Z, resulting in M."
3. Define metrics: primary (one), secondary, guardrails — each with baseline → target.
4. Break the solution into stories with Gherkin criteria per `references/stories-and-metrics.md`.
5. Fill out-of-scope, dependencies, risks, open questions.
6. Self-review against the template's completeness checklist; fix gaps before delivering.

## Output Contract

Write `docs/prd/<feature-slug>.md` from `assets/prd-template.md`. Done when: every story has criteria, every metric has baseline→target, out-of-scope lists ≥1 item, open questions have owners, and the doc links its discovery brief.

## References

- `references/stories-and-metrics.md` — story format, Gherkin patterns, epic splitting, metric types.

## Assets

- `assets/prd-template.md` — output skeleton with per-section instructions.
