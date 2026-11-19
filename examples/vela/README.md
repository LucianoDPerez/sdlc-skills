# Vela Store: greenfield feature, the full pipeline

Vela is a fictional candle store. This directory is a complete run of the sdlc pipeline for `order-emails`: discovery → PRD → UX spec → RFC → ADR (spawned at the RFC) → ERD → OpenAPI → threat model → test plan → release plan.

- Every downstream artifact cites its upstream as `path @ <approval sha>` — the commit where the upstream reached approved status.
- Every artifact names its human approver; the ADR is status-ratified (accepted) instead.
- The git history of this directory shows each stage landing as its own commit.

## Verify it yourself

From the repo root:

```bash
bash skills/sdlc/assets/verify-gate.sh --root examples/vela $(cd examples/vela && find docs -type f | sort)
```

Every artifact prints OK: the approver is named, and every cited sha still matches the current content.

## What this case exercises

Greenfield + user-facing surface → the FULL chain applies: ux (user-facing), erd (new tables), api-design (new endpoint), plus an `adr` spawn at the RFC's significant choice (outbox vs synchronous send).

Vela's people are fictional; the shas and the git history are real.
