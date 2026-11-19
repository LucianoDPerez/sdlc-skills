# Lean-solo: substantial feature, one implementer, one collapsed doc

Nimbus is a fictional solo-built helpdesk. `docs/lean/saved-replies.md` is ONE approved doc carrying the gates of discovery (evidence, tagged assumptions), PRD (metric, Gherkin stories, out-of-scope), and UX (screen states, spec-time accessibility) — the lean profile from `skills/sdlc/references/pipeline.md`.

What it deliberately shows:

- Self-approval in solo mode, acknowledged as the weaker signal; sha-binding still applies.
- The significance check run on its alternatives — none is hard to reverse, so no ADR is spawned.
- The queued stages named at the bottom: the schema change sends this run through `erd`, and `security`/`qa`/`release` still run as stages (omitted here for brevity — see `examples/vela/` for full downstream runs).

## Verify it yourself

```bash
bash skills/sdlc/assets/verify-gate.sh --root examples/lean-solo docs/lean/saved-replies.md
```
