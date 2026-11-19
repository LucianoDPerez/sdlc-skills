# AGENTS.md — SDLC Skills

## Repo purpose

This repo hosts one skill per SDLC stage. A skill is a runtime instruction contract for an LLM, not human documentation. Follow `docs/skill-style-guide.md` before creating or editing any skill.

## Skill registry

| Skill | Path | Triggers |
|---|---|---|
| `sdlc` | `skills/sdlc/SKILL.md` | SDLC, what stage, new feature lifecycle, discovery to release |
| `product-discovery` | `skills/product-discovery/SKILL.md` | discovery, user research, customer interviews, validate problem |
| `prd` | `skills/prd/SKILL.md` | PRD, product requirements, user stories, success metrics |
| `ux-ui` | `skills/ux-ui/SKILL.md` | UX, UI, wireframe, screens, views, user flow, design system, prototype, accessibility |
| `rfc` | `skills/rfc/SKILL.md` | RFC, technical design, architecture doc, system design |
| `adr` | `skills/adr/SKILL.md` | ADR, decision record, why did we choose, decision log |
| `erd` | `skills/erd/SKILL.md` | ERD, data model, database schema, entity design, migration |
| `api-design` | `skills/api-design/SKILL.md` | API design, endpoints, OpenAPI, REST contract, webhooks |
| `security` | `skills/security/SKILL.md` | threat model, STRIDE, security review, attack surface, OWASP |
| `qa` | `skills/qa/SKILL.md` | test strategy, test plan, QA, coverage, quality gates |
| `release` | `skills/release/SKILL.md` | release plan, deploy, go/no-go, runbook, rollback |

## Rules for agents working in this repo

1. Read `docs/skill-style-guide.md` before any skill edit; it is normative.
2. Every `SKILL.md` keeps frontmatter (`name`, `description`, `license`, `metadata.author`, `metadata.version`) and sections in order: Activation Contract, Hard Rules, Decision Gates, Execution Steps, Output Contract, References.
3. Body budget: 180–450 tokens. Depth goes in `references/`, templates in `assets/`.
4. New skills must be registered in the table above.
5. Artifact conventions (paths, gates) are defined in `skills/sdlc/references/pipeline.md`; change them there, not per-skill.
