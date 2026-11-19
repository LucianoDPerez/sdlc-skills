# Roadmap

## Now (next minor release)

- **Solo/lean profile**: implemented (sdlc 1.4) — `docs/lean/<feature-slug>.md` collapses discovery+PRD+RFC; risk stages (security, qa, release) still run. Open follow-up: one real lean run in a solo repo to validate friction level.
- **Routing examples**: a short conversation transcript showing how `sdlc` routes an ambiguous request to the right stage skill — discoverability for new users.

## Review cadence (standing)

Methodology-dependent references get a quarterly sweep (first week of Jan/Apr/Jul/Oct): `ux-ui` (WCAG 2.2), `security` (OWASP Top 10), `api-design` (OpenAPI spec version), `erd` (SQL/migration practices). Findings land as skill version bumps in CHANGELOG.md.

## Conventions

- Skill versions bump per CHANGELOG entry; plugin version bumps per release.
- After every release: re-sync installed copies (`.opencode/skills/`) in consuming repos — drift is silent otherwise.
