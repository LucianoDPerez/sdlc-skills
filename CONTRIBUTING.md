# Contributing to SDLC Skills

Thanks for contributing. This repo is a set of **runtime instruction contracts for LLMs**, not human documentation — read `docs/skill-style-guide.md` first; it is normative.

## Adding a new skill

1. **Check it doesn't exist.** One skill per stage; improvements to an existing stage belong in that stage's `references/`, not a new skill.
2. **Follow the required structure:**

```
skills/<skill-name>/
├── SKILL.md            # lean runtime contract (180–450 token body)
├── references/         # methodology, deep detail
└── assets/             # templates, checklists, schemas
```

3. **Frontmatter rules:** `name`, one-line quoted `description` starting with `Trigger: ...` (≤250 chars), `license`, `metadata.author`, `metadata.version`.
4. **Sections in order:** Activation Contract, Hard Rules, Decision Gates, Execution Steps, Output Contract, References.
5. **Register the skill** in `AGENTS.md` and the README skills table.
6. **If the new skill changes the pipeline** (adds a stage, an artifact path, or a gate), update `skills/sdlc/references/pipeline.md` — that file is the single source for gates and artifact conventions.

## Improving an existing skill

- Methodology depth → `references/`. Templates and checklists → `assets/`. Never bloat `SKILL.md`.
- Artifacts produced by skills live in the *product repo*, not here — issue reports should quote the skill file and line, not a generated document.
- Run `skill-improver` on the skill you touched before opening the PR.

## Issues and PRs

- Label issues with the stage: `stage:prd`, `stage:qa`, etc. New skills use `new-skill`.
- PRs: keep one skill per PR when possible; cross-cutting pipeline changes are their own PR.
- Every PR states which `SKILL.md` or reference changed and why, in one paragraph.

## Ground rules

- Apache-2.0; by contributing you license your contribution under it.
- English for all artifacts (skills, docs, commit messages — conventional commits).
- No AI attribution lines in commits.
