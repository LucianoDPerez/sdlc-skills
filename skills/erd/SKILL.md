---
name: erd
description: "Trigger: ERD, data model, database schema, entity design, migration plan. Design normalized entities, relationships, and safe migrations for an approved RFC."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load when the approved RFC touches stored data: new entities, relationship changes, new columns with constraints, or migrations. Do NOT load without an approved RFC for greenfield schemas (blocked gate).

## Hard Rules

- Model to 3NF; every denormalization must justify itself with the query it serves.
- Every table: explicit PK; every FK indexed and named `<table>_<column>_idx`.
- Cardinality is explicit (1:1, 1:N, M:N) — M:N via a join table, never dual FKs.
- Diagrams are mermaid `erDiagram`; types are concrete (the target DB's types).
- Every migration ships with a rollback path and states whether it locks writes (`references/migration-safety.md`).
- Naming: `snake_case` tables plural, columns singular; no abbreviations.

## Decision Gates

| Situation | Approach |
|---|---|
| New domain | full ERD from template, then DDL review |
| Add column/table, no rewrite | delta spec: entities touched + migration only |
| Data type/key change on live data | expand-contract migration, dual-write plan |

## Execution Steps

1. Extract entities, attributes, and relationships from the RFC (and UX spec state models).
2. Draw the mermaid ERD; walk every relationship with cardinality.
3. Apply the checklist in `references/data-design-rules.md` (keys, types, constraints, indexes).
4. Design the migration with rollback per `references/migration-safety.md`.
5. Fill `assets/erd-template.md`; cite the RFC.

## Output Contract

Write `docs/data-model/<feature-slug>-erd.md`: mermaid ERD with cardinalities, table-by-table definitions (PK, FKs, constraints, indexes), query-driven index rationale, and the migration plan with rollback + lock assessment. DDL without a rollback path fails review.

## References

- `references/data-design-rules.md` — normalization, keys, types, indexing.
- `references/migration-safety.md` — expand-contract, zero-downtime, rollback patterns.

## Assets

- `assets/erd-template.md` — output skeleton.
