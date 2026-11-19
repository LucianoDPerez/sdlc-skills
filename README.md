# SDLC Skills

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Skills: 11](https://img.shields.io/badge/skills-11-5C4FC7)](#skills)
[![Agent Skills Standard](https://img.shields.io/badge/Agent_Skills-Standard-8A2BE2)](https://agentskills.io)

One perfect, self-contained skill per stage of the software development lifecycle — from discovery to production. Built for OpenCode, Claude Code, and Codex (any Agent Skills Standard runtime).

## The pipeline

```
discovery ──▶ prd ──▶ ux-ui ──▶ rfc ──▶ erd ──▶ api-design ──▶ security ──▶ qa ──▶ release
                │
                └── implementation & code review (covered by your existing review skills)

adr: transversal — spawned whenever a significant choice is made, at any stage.
```

Each stage produces a versioned artifact inside the product repo, and each stage has an entry gate: the previous artifact must exist and pass its checklist before the next stage starts.

## Skills

| Stage | Skill | Trigger words | Artifact |
|---|---|---|---|
| Orchestration | `sdlc` | SDLC, what stage, full lifecycle | routes to the right stage skill |
| Discovery | `product-discovery` | discovery, user research, validate problem | `docs/discovery/<feature>.md` |
| Product spec | `prd` | PRD, product requirements, user stories | `docs/prd/<feature>.md` |
| UX/UI | `ux-ui` | UX, UI, wireframe, screens, views, user flow, design system | `docs/ux/<feature>.md` |
| Technical design | `rfc` | RFC, technical design, architecture doc | `docs/rfc/NNNN-<slug>.md` |
| Decisions | `adr` | ADR, decision record, why did we choose | `decisions/YYYY-MM-DD-<slug>.md` |
| Data | `erd` | ERD, data model, database schema, migration | `docs/data-model/<feature>-erd.md` |
| Contracts | `api-design` | API design, endpoints, OpenAPI | `docs/api/<service>-openapi.yaml` |
| Security | `security` | threat model, STRIDE, security review | `docs/security/<feature>-threat-model.md` |
| Quality | `qa` | test strategy, test plan, coverage | `docs/qa/<feature>-test-plan.md` |
| Ship | `release` | release plan, go/no-go, runbook, rollback | `docs/releases/<version>.md` |

## Install

Skills are plain folders with a `SKILL.md`; every Agent Skills Standard runtime reads them as-is.

**OpenCode** (project-level):
```bash
mkdir -p .opencode/skills
cp -R skills/* .opencode/skills/
```

**OpenCode** (global): copy `skills/*` to `~/.config/opencode/skills/`.

**Claude Code** (plugin — one command):
```text
/plugin marketplace add LucianoDPerez/sdlc-skills
```

**Claude Code** (manual):
```bash
mkdir -p ~/.claude/skills
cp -R skills/* ~/.claude/skills/
```

**Codex** (verified path: project-level shared folder + AGENTS.md reference):
```bash
mkdir -p .agents/skills
cp -R skills/* .agents/skills/
# then list the skills you use in the project's AGENTS.md
```

**Tip**: OpenCode also reads `~/.claude/skills` and `~/.agents/skills` (project: `.claude/skills`, `.agents/skills`). One copy in `~/.claude/skills` serves both OpenCode and Claude Code; when the same skill exists in several places, project scope beats global.

**As a plugin** — this repo is conformant to the open [Agent Plugins v1.0.0 specification](https://agent-plugins.org) (root `plugin.json`, skills discovered at `skills/`):

```text
# Claude Code
/plugin marketplace add LucianoDPerez/sdlc-skills

# Codex (marketplace manifest at .agents/plugins/marketplace.json, following the official google/skills pattern)
codex plugin marketplace add LucianoDPerez/sdlc-skills
```

Skills remain the portable cargo: any skills-only client consumes `skills/` directly, with no plugin support required.

## Principles

1. **One artifact per stage, committed to the repo.** Documents live next to the code they describe; no external wiki.
2. **Evidence before solution.** No PRD without discovery evidence, no RFC without an approved problem statement.
3. **Decisions are immutable.** ADRs are superseded, never rewritten — the "why" survives team turnover.
4. **Every stage ends in a verifiable checklist.** A stage is done when its Output Contract passes, not when the doc "looks done".
5. **Lean runtime, deep references.** Each `SKILL.md` is a small instruction contract; methodology lives in `references/`, templates in `assets/`.

## Stack lanes

Stage skills are stack-agnostic; implementation lanes live inside `ux-ui` and `qa`:

- **Frontend (React | Angular)**: `skills/ux-ui/references/framework-handoff.md` maps every UX component to shadcn/Radix (React) and Material/CDK (Angular); same UX spec drives both. Visual generation tools (e.g. Google Stitch) seed from the spec — generated HTML is a draft, never the deliverable.
- **QA**: `skills/qa/references/pyramid-risk-gates.md` has the per-stack framework table (Vitest/RTL vs TestBed; Playwright + axe-core shared).
- **Google Cloud projects**: install official `google/skills` (24.4k★, Apache-2.0) as technology-specific complement — it covers GCP services, not lifecycle stages.

## Maintenance

- Normative format rules: `docs/skill-style-guide.md`.
- Audit and refactor skills with `skill-improver`; register new skills in `AGENTS.md`.

## License

Apache-2.0 (individual skills may carry their own license in frontmatter).
