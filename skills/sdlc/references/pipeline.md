# Pipeline: gates, artifacts, conventions

Normative for all stage skills. Change conventions here, not per-skill.

## Artifact paths (inside the product repo)

```
docs/
├── discovery/<feature-slug>.md          # discovery brief
├── prd/<feature-slug>.md                # PRD
├── ux/<feature-slug>.md                 # UX spec (flows, screens, states)
├── rfc/NNNN-<slug>.md                    # technical design (NNNN sequential)
├── data-model/<feature-slug>-erd.md     # ERD + migration plan
├── api/<service>-openapi.yaml            # API contracts
├── security/<feature-slug>-threat-model.md
├── qa/<feature-slug>-test-plan.md
├── releases/YYYY-MM-DD-<version>.md     # release plan + runbook link
decisions/
├── index.md                             # decision log index
└── YYYY-MM-DD-<slug>.md                 # immutable decision records
```

`<feature-slug>`: kebab-case, stable across stages so artifacts trace to each other.

## Stage gates

| Gate | Entry condition | Exit condition (Output Contract of the stage) |
|---|---|---|
| → discovery | an idea exists | brief with problem statement + ranked assumptions + evidence |
| → prd | discovery brief approved | PRD with evidence-backed problem, metrics (baseline→target), Gherkin stories, out-of-scope |
| → ux | PRD approved, user-facing surface | flows with failure paths, screens with all 4 states, WCAG 2.2 AA pass |
| → rfc | UX approved (user-facing) or PRD approved (no UI) | design with ≥2 real alternatives, C4 views, rollout + security sections |
| → erd / api-design | RFC approved | per-skill contract; each cites the RFC |
| → security | design done | STRIDE model with mitigations mapped, OWASP checklist pass |
| → qa | threat model done | risk-ranked test plan; every acceptance criterion maps to a test or an explicit "not covered" |
| → release | tests green | go/no-go checklist, tested rollback, runbook |
| implementation | after qa | owned by code-review/PR skills, not this set |

## Gate enforcement

- A stage skill asked to start without its entry artifact MUST report the blocked gate and name the missing file.
- "Approved" means a human named in the doc accepted it (PR review, comment, or meeting) — do not self-approve.
- Cross-references are mandatory: PRD links its discovery brief; RFC links the PRD; threat model and test plan link the RFC; release links the test plan.
