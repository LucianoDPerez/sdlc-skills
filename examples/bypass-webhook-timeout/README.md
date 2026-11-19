# Brownfield bypass: webhook signature timeout

The change: the PayForge webhook signature-verification call gets a 10s timeout (it was unbounded — that caused the incident) and slow verification now fails closed.

## Why this bypasses the pipeline (bypass rule, `skills/sdlc/references/pipeline.md`)

Three tests, all fail → no feature semantics → straight to implementation + code review:

- Adds user-visible behavior? No — internal reliability fix.
- Adds a contract? No — no endpoint, payload, or documented limit changes.
- Adds data? No — no schema or migration.

No discovery, no PRD, no RFC. This record exists so the bypass itself is documented — a bypass is a designed path, not silent gate evasion.

## Why an ADR still spawned

The fail-closed choice affects people outside the implementing room (ops, fraud posture) and WILL be questioned the first time a legitimate slow webhook is rejected ("why did we drop a payment confirmation?"). Per the significance rule, `adr` spawned — even though the change itself never entered the pipeline.

ADR: `decisions/2026-11-20-fail-closed-on-slow-webhook-signature.md`

## What this case demonstrates

- The bypass, with its three-test qualification written out.
- `adr` is transversal: it spawns from ANY path — including bypasses.
- No stage artifacts exist here BY DESIGN: `verify-gate.sh` has nothing to check in this directory, and that is correct.
