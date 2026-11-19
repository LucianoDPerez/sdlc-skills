# Atlas: API-only product, conditional stages skipped with declared reasons

Atlas is a fictional B2B logistics API. This run exercises the pipeline when the feature has NO user-facing surface and NO schema change:

- **ux skipped** — persona is a data engineer; PRD §3 says API-first, no UI expected.
- **erd skipped** — no schema change: job state lives in the existing `background_jobs` table; artifacts in object storage (declared in the RFC header).
- **api-design is the center of gravity** — the contract IS the product surface.

Skips are DECLARED in the RFC, with the reason, not silently absent: a reviewer reading the RFC sees exactly why two gates do not apply. Everything else runs: discovery → PRD → RFC → OpenAPI → threat model → test plan → release.

## Verify it yourself

```bash
bash skills/sdlc/assets/verify-gate.sh --root examples/atlas $(cd examples/atlas && find docs -type f | sort)
```

Atlas's people are fictional; the shas and the git history are real.
