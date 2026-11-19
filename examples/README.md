# Examples: every pipeline path, exercised

Each directory is a committed run against a fictional product; every sha is real. Run the gate on every passing chain from the repo root:

```bash
for root in examples/vela examples/atlas examples/lean-solo; do
  bash skills/sdlc/assets/verify-gate.sh --root "$root" $(cd "$root" && find docs -type f | sort)
done
```

| Case | Product type | Pipeline path it exercises |
|---|---|---|
| [vela/](vela/) | e-commerce (user-facing) | full chain: discovery → PRD → UX → RFC → ADR → ERD → OpenAPI → threat model → test plan → release |
| [atlas/](atlas/) | B2B API platform | conditional skips DECLARED in the RFC: `ux` (no user-facing surface), `erd` (no schema change); `api-design` as the center of gravity |
| [bypass-webhook-timeout/](bypass-webhook-timeout/) | brownfield SaaS | the bypass: no stage artifacts BY DESIGN + an ADR spawned from the bypass path (transversal rule) |
| [lean-solo/](lean-solo/) | solo-built SaaS | lean profile: one doc collapsing discovery+PRD+UX; risk stages still run (queued) |
| [gate-fixture/](gate-fixture/) | — | the failure path: a stale citation the gate MUST reject (CI asserts it) |

The bypass case intentionally has no `docs/` artifacts — `verify-gate.sh` has nothing to check there, and that is the point.
