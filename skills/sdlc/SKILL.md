---
name: sdlc
description: "Trigger: SDLC, what stage, full lifecycle, new feature, new project, discovery to release. Route work to the right stage skill and enforce stage gates."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load when the user starts new work with no clear stage ("build X", "we want Y"), asks what stage they are in, or wants to run the lifecycle end to end. Do NOT load for a single-stage request whose stage skill already triggers (e.g. "write an ADR" → `adr` directly).

## Hard Rules

- Never skip a gate: a stage starts only when the previous artifact exists and passes its Output Contract.
- One stage per request unless the user explicitly asks to continue.
- Every artifact lands in the product repo at the path defined in `references/pipeline.md`.
- If a gate fails, report the gap and stop — do not fabricate the missing artifact silently.
- Stage skills own their methodology; never inline their templates here.

## Decision Gates

| Current state | Load | Produces |
|---|---|---|
| Idea only, no evidence | `product-discovery` | discovery brief |
| Approved discovery brief | `prd` | PRD |
| Approved PRD, user-facing UI | `ux-ui` | UX spec |
| UX approved, or PRD approved with no UI | `rfc` | technical design |
| RFC needs a significant choice | `adr` | decision record |
| RFC approved, data involved | `erd` | data model + migrations |
| RFC approved, external contract | `api-design` | OpenAPI spec |
| Design done, before implementation | `security` | threat model |
| Threat model done / pre-merge | `qa` | test plan |
| Tests green, pre-production | `release` | release plan + runbook |

## Execution Steps

1. Scan the product repo (`docs/`, `decisions/`) for existing stage artifacts.
2. Map current state to the table above; state which stage is next and why.
3. Load that stage's `SKILL.md` and execute its steps verbatim.
4. Verify the stage's Output Contract checklist passes.
5. Report: stage completed, artifact path, gate status, and the next stage.

## Output Contract

Return the stage verdict: current stage, gate status (pass/blocked + missing artifact), the skill executed, artifact paths created, and the recommended next stage with its entry condition.

## References

- `references/pipeline.md` — stage gates, artifact path conventions, gate checklists.
