# Layering, SOLID, resilience

## SOLID — the test, not the sermon

| Principle | Test that fails it |
|---|---|
| **S**ingle responsibility | you cannot describe the unit without saying "and" |
| **O**pen/closed | new behavior requires editing a switch/if-chain instead of adding a module |
| **L**iskov | sibling types checked with `instanceof` / type switches |
| **I**nterface segregation | a consumer is forced to stub methods it ignores |
| **D**ependency inversion | swapping the database touches domain code |

Enforcement level: domain modules strictly; adapters and UI pragmatically — the exception path is stated, not implied.

## Layering decision (per repo, justified)

| Situation | Default | Why |
|---|---|---|
| Domain-heavy, business rules live long | clean architecture (entities → use cases → adapters) | domain survives framework churn |
| CRUD-centered, thin rules | framework MVC convention | layering ceremony exceeds value |
| Mixed | hexagonal-lite: isolated domain module, conventional rest | pragmatic middle |

Non-negotiable in all three — the dependency rule: dependencies point toward the domain; domain code imports nothing external (no framework, no DB types at the boundary).

## Resilience — every remote call answers this

| Control | Default | Exception path |
|---|---|---|
| **Timeout** | 1–5s user-facing, 30s batch jobs; NEVER unbounded | linked ADR |
| **Retry** | max 3, exponential backoff + jitter; ONLY on idempotent operations | linked ADR + risk analysis |
| **Circuit breaker** | on calls whose failure cascades; open at 5 consecutive failures or >50% error over a 10s window; half-open probe after 30s | call is non-cascading (documented) |
| **Bulkhead** | separate pools/connections for critical vs slow call classes | single-class system |
| **Fallback** | degrade (cache, default, queue for later); never block the caller's core flow on a non-critical dependency | dependency IS the core flow |

Queues: every consumer has a DLQ with replay; poison messages parked, never retried forever.

Idempotency requirement for retries: external writes carry `Idempotency-Key` (contract side: `api-design`); internal side: natural-key upsert or event id + dedup store. The unique constraint in the schema (`erd`) is the last line of defense.

## Error handling

- No silent catch: every `catch` adds context (correlation id, input fingerprint) or rethrows wrapped.
- Taxonomy: retryable (timeout, 429, 5xx) vs terminal (4xx validation, business rule) — the retry table above only fires on retryable.
- Cross-service errors map to RFC 7807 problem+json at the boundary (contract owned by `api-design`).

## Concurrency

- Optimistic locking (version column) by default; pessimistic locks only for hot spots with evidence.
- Transactions stay short: never hold one across a remote call or user think-time.
- Queue consumers process one message at a time unless ordering is proven irrelevant.
