# ADR 0007: Fail closed when webhook signature verification is slow

Number: 0007
Date: 2026-11-20
Status: accepted
Deciders: Riley Quinn (owner), flagged to the ops channel
Supersedes: —
Spawned from: brownfield bypass (webhook signature timeout fix) — not from a pipeline stage

## Context

Signature verification against PayForge was unbounded; during their degraded periods our webhook worker hung. The fix adds a 10s timeout. The choice: what happens when verification exceeds it.

## Options considered

| Option | Trade-off |
|---|---|
| Fail closed — reject, PayForge retries (chosen) | we may briefly drop a payment confirmation until recovery; but no unverified payload is ever processed |
| Fail open — accept, verify asynchronously | availability over integrity; an attacker who can slow the verification path injects unverified events |
| Do nothing (unbounded) | already caused the incident |

## Decision

Fail closed: reject with 503 so PayForge's retry delivers the event after recovery; alert on the reject rate.

## Consequences

- Integrity-first posture: no unverified payment event is ever processed.
- Availability now depends on PayForge retry behavior — monitored via the reject-rate alert.
- The 10s budget and alert threshold live in config; revisited after 30 days of data.

## Related

- Bypass record: `README.md` (this directory)
