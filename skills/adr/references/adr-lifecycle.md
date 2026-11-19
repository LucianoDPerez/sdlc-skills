# ADR lifecycle and governance

## Statuses

```
proposed ──▶ accepted ──▶ deprecated ──▶ superseded by ADR-N
    │            │
    └── rejected └─ (accepted records are never edited; changes spawn a new record)
```

- `proposed` — open for comments with a deadline ("comments by Friday, then default-accept").
- `accepted` / `rejected` — a NAMED human decided; record who and when.
- `deprecated` — still true historically, no longer followed.
- `superseded` — replaced by a specific record; both directions linked.

## Writing rules

- **Context**: the situation and constraints, not the debate transcript. A reader with zero meeting background must follow it.
- **Options**: facts and trade-offs per option, not opinions; include "do nothing" when plausible.
- **Decision**: plain active voice — "We will X", never "X was considered optimal".
- **Consequences**: what changes, including the negatives you accepted. No pros/cons rehash.

## Supersede flow

1. Write the new record with full context (do not require reading the old one).
2. In the new record: `Supersedes: <link>`.
3. In the old record: change ONLY the status line to `superseded by <link>` — content stays frozen.
4. Update the index.

## Index format — `decisions/index.md`

```markdown
| # | Date | Title | Status | Superseded by |
|---|---|---|---|---|
| 001 | 2026-11-19 | Switch payments to PSP B | accepted | — |
```

Index is append-only; review quarterly: any `proposed` older than its deadline gets resolved or rejected.

## Governance questions to answer per team (once)

- Who can propose? (default: anyone who read the guide)
- What justifies a record? (hard to reverse + affects others)
- Lifecycle criteria: who accepts, who owns the periodic review.

## Anti-patterns

- The zombie log: records accepted but never enforced — link decisions to RFCs so they're load-bearing.
- Retroactive ADRs written to justify a fait accompli — allowed once, label honestly: context includes "already implemented; documenting why".
- Editing history — the diff IS the history; if the reasoning changed, that's a new record.
