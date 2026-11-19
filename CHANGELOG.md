# Changelog

All notable changes to this project are documented here. Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning follows [SemVer](https://semver.org/). Policy details in `CONTRIBUTING.md`.

## [Unreleased]

## [1.2.0] - 2026-11-19

### Changed

- `sdlc` (1.3 → 1.4): enforcement is now deterministic — new `assets/verify-gate.sh` checks artifact existence, the `Approved by: <name> (<role>), <date>` line, and every `path @ <sha>` citation with a real `git diff`; the orchestrator runs it instead of trusting prose. All stage templates standardized on the `Approved by:` line. Sha-citation guidance for squash-merge/rebase flows. Lean profile for solo/small-team substantial features: one feature doc collapsing discovery+PRD+RFC (risk stages still run).
- `ux-ui` (1.0 → 1.1): accessibility split into spec-time (verified on the document) and implementation-time (handed to `qa` as the accessibility test procedure) — the spec no longer claims checks that require a rendered UI.
- docs: style guide aligned with the CI section-order check (only Assets is optional) — guide and validator no longer contradict.
- `sdlc` (1.2 → 1.3): approval integrity — approvals bind to the approved content via commit sha: downstream artifacts cite inputs as `path @ <sha>`, the orchestrator verifies `git diff <sha>` before opening a stage, and drift returns the artifact to review. Rework now requires a new approval. Templates updated to the citation format. Reported by Mike Dabydeen (community review of the public release).

### Added

- Behavioral regression in CI: `verify-gate.sh` runs against every example chain (must pass) and a stale-citation fixture (must fail) — editing a `SKILL.md` can no longer break gate enforcement silently.
- `examples/` suite covering every pipeline path: `vela` (greenfield, full 10-stage chain with an ADR spawned at RFC), `atlas` (B2B API-only — `ux` and `erd` skipped with declared reasons), `bypass-webhook-timeout` (brownfield bypass + ADR spawn on a significant choice), `lean-solo` (solo-dev lean profile), `gate-fixture` (a stale citation the gate must reject). Real approval shas; each stage lands as its own commit.
- `ROADMAP.md`: quarterly review cadence for methodology-dependent references (WCAG, OWASP, OpenAPI, SQL practices).
- `principles` (new, 1.0): per-repo engineering principles — layering decision justified per repo, SOLID conventions, resilience table (timeout/retry/breaker per remote call), idempotency/dedup, error handling, concurrency. Ratified by a founding ADR; enforced via RFC deviations and code review.
- `rfc` (1.0 → 1.1): hard rule — deviations from `docs/principles.md` are declared in the design; a deviation without a linked ADR fails review. Template gains a Principles deviations section.
- `sdlc` (1.1 → 1.2): explicit brownfield bypass — small changes with no feature semantics go straight to implementation/review; `adr` spawns only on significant choices. Documented in `pipeline.md` as a designed bypass, not gate evasion.

## [1.1.0] — 2026-11-19

### Changed

- `sdlc` (1.0 → 1.1): orchestrator execution now verifies a named human approver, not just artifact existence; rework is an explicit routing rule (later stage invalidates → route back, fix, re-verify downstream contracts); `erd` and `api-design` may both apply after an RFC, in either order, before `security`; `adr` shown as transversal in the pipeline diagram and its routing generalized to any stage.
- `skills/sdlc/references/pipeline.md`: gate enforcement documents the rework path and its recording rule ("reworked from \<stage\> on \<date\>").

## [1.0.0] — 2026-11-19

## [1.0.0] — 2026-11-19

### Added

- 11 stage skills: `sdlc` (orchestrator), `product-discovery`, `prd`, `ux-ui`, `rfc`, `adr`, `erd`, `api-design`, `security`, `qa`, `release`.
- Stage gates with human approval and cross-referenced artifacts (`skills/sdlc/references/pipeline.md`).
- Frontend lanes: one UX spec drives React (shadcn/Radix) and Angular (Material/CDK) implementations (`skills/ux-ui/references/framework-handoff.md`).
- Packaging: Agent Plugins v1.0.0 conformant root `plugin.json`; Claude Code marketplace (`.claude-plugin/`); Codex marketplace (`.agents/plugins/marketplace.json`); plain skills for any Agent Skills runtime.
- CI validation: JSON manifests, frontmatter, section order, token budget, local references, registry sync.
- Community health: CONTRIBUTING, SECURITY, CODE_OF_CONDUCT, issue templates, PR template, 27 triage labels.
- Apache-2.0 license.
