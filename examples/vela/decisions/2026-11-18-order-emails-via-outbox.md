# ADR 0001: Send order emails via outbox, not in the checkout request path

Number: 0001
Date: 2026-11-18
Status: accepted
Deciders: Sam Okafor (tech lead), Alex Vega (PO)
Supersedes: —

## Context

Order emails must never slow or destabilize checkout (PRD guardrail: completion ≥60%). Mailhaus has a 99% SLA but transient failures are routine. RFC 0001 scored three options on problem fit, checkout latency risk, delivery reliability, and operational complexity: synchronous send 44, outbox + worker 63, do nothing 38.

## Options considered

| Option | Trade-off |
|---|---|
| Send synchronously in the checkout request | simplest; couples the money path to a 3rd-party call — provider latency becomes checkout latency |
| Outbox table + background worker (chosen) | one more moving part to monitor; checkout only does a local DB insert in the same transaction |
| Mailhaus-native automation (trigger on their webhook) | zero code; couples product logic to the vendor; no preferences gate, no retry control |

## Decision

Write emails to an `email_outbox` row inside the order's transaction; a background worker drains it with a 10s timeout and bounded idempotent retry (max 3, exponential backoff), parking failures for human replay. Per-account `notification_preferences` gate every send.

## Consequences

- Checkout is decoupled: email failure cannot fail checkout — the guardrail holds by construction.
- Delivery reliability becomes an operational duty: outbox backlog + parked alerts join the runbook.
- Replay after park requires idempotency: the send operation keys on outbox row id; Mailhaus dedups on our message id.

## Related

- `docs/rfc/0001-order-emails.md`
- `docs/data-model/order-emails-erd.md`
