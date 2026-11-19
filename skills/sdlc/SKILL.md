---
name: sdlc
description: "Trigger: SDLC, what stage, full lifecycle, new feature, new project, discovery to release. Route work to the right stage skill and enforce stage gates."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.3"
---

## Activation Contract

Load when the user starts new work with no clear stage ("build X", "we want Y"), asks what stage they are in, or wants to run the lifecycle end to end. Do NOT load for a single-stage request whose stage skill already triggers (e.g. "write an ADR" → `adr` directly).

## Hard Rules

- Never skip a gate: a stage starts only when the previous artifact exists and passes its Output Contract.
- One stage per request unless the user explicitly asks to continue.
- Every artifact lands in the product repo at the path defined in `references/pipeline.md`.
- If a gate fails, report the gap and stop — do not fabricate the missing artifact silently.
- Rework is routing: when a later stage invalidates an earlier artifact, route back to that stage, fix it, and re-verify every downstream Output Contract that cited it.
- Stage skills own their methodology; never inline their templates here.

## Decision Gates

| Current state | Load | Produces |
|---|---|---|
| Idea only, no evidence | `product-discovery` | discovery brief |
| Approved discovery brief | `prd` | PRD |
| Approved PRD, user-facing UI | `ux-ui` | UX spec |
| UX approved, or PRD approved with no UI | `rfc` | technical design |
| A significant choice arises at any stage | `adr` | decision record |
| RFC approved, data involved | `erd` | data model + migrations |
| RFC approved, external contract | `api-design` | OpenAPI spec |
| Design done, before implementation | `security` | threat model |
| Threat model done / pre-merge | `qa` | test plan |
| Tests green, pre-production | `release` | release plan + runbook |
| Small change in existing system, no feature semantics | your review skills directly; `adr` only if a significant choice appears | fix shipped |

A feature may need BOTH `erd` and `api-design`: run each that applies, in either order, before moving to `security`.

## Execution Steps

1. Identify the feature-slug in scope; if several features are in flight, ask which one before scanning.
2. Scan `docs/` and `decisions/` for its artifacts. An artifact counts only if it exists, names a human approver, and every downstream citation `path @ <sha>` matches current content (`git diff <sha> -- <file>` empty). Drift returns the artifact to review.
3. Map current state to the table above; state which stage is next and why.
4. Load that stage's `SKILL.md` and execute its steps verbatim.
5. Verify the stage's Output Contract checklist passes.
6. Report: stage completed, artifact path, gate status, and the next stage.

## Output Contract

Return the stage verdict: current stage, gate status (pass/blocked + missing artifact), the skill executed, artifact paths created, and the recommended next stage with its entry condition.

## References

- `references/pipeline.md` — stage gates, artifact path conventions, gate checklists.
