# Data design rules

## Normalization and denormalization

- Default 3NF: no repeating groups, no partial-key dependencies, no transitive dependencies.
- Denormalize ONLY with a written justification naming the exact query and its measured/estimated cost — "fewer joins" is not a justification.
- Calculated/redundant fields carry a refresh strategy (trigger, view, job) or they rot.

## Keys

- PKs: prefer surrogate (`id` bigserial/uuid) + unique constraints on the natural key. UUIDs when records leave the system or are created client-side; bigserial otherwise.
- Every FK: `ON DELETE` behavior chosen explicitly (restrict default; cascade only with a written reason — cascades are where referential surprises live).
- Natural unique keys (email, slug, external id) get a `UNIQUE` constraint, never just app logic.

## Types and constraints

- Use the target DB's concrete types (`timestamptz`, not "datetime").
- Timestamps: `timestamptz` UTC everywhere; `created_at` + `updated_at` on every table.
- Money: integer minor units or `numeric` — NEVER float.
- Enums: DB CHECK constraint or lookup table; document allowed values in the spec.
- Status/state columns mirror the UX spec's state machine — states must match 1:1.
- NULL means "unknown", not "empty string" or "false"; NOT NULL by default, NULL needs a reason.

## Indexes (query-driven, not fear-driven)

1. Start from the queries the RFC/UX states: list each with its filters and joins.
2. Index to serve them: FK columns always; composite index where a filter pair repeats; leading column = most selective.
3. Every index names the query it serves in the spec; indexes without a named query get deleted.
4. Write-heavy tables: justify each index against write amplification.

## Naming

Tables plural `snake_case` (`orders`, `order_items`); columns singular; join tables `left_right` in declaration order; booleans `is_`/`has_`; no abbreviations except `id`.

## Anti-patterns

- The god table (one table, 60 columns, nulls everywhere) — split by lifecycle.
- Polymorphic FKs (`entity_type` + `entity_id`) — when unavoidable, document the integrity gap and enforce in app layer explicitly.
- Storing JSON blobs for queryable data — JSONB only for genuinely schemaless payloads.
- Dual-FK M:N — always a join table.
