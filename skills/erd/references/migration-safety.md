# Migration safety

## Expand-contract (zero-downtime default)

Two releases minimum, never one big-bang:

1. **Expand** — add new columns/tables/indexes; old code ignores them; dual-write where data moves. Deployable any time; never locks beyond DDL.
2. **Backfill** — migrate existing data in bounded batches (size + sleep to avoid replica lag); resumable from a checkpoint.
3. **Switch reads** — behind a flag; verify parity (row counts, checksums) before full cutover.
4. **Contract** — only after the old path is fully retired: drop old columns/constraints in a LATER release, never the same one.

## Rollback

Every migration states its rollback BEFORE it runs:

| Migration | Rollback | Reversible? |
|---|---|---|
| additive (new table/column/index) | drop it | yes, safe |
| data backfill | restore from checkpoint/backup snapshot | yes, if snapshot taken pre-run |
| rename/type change | expand-contract in reverse | only via the paired contract step |
| destructive drop | restore from PITR backup, dated | NO — gate on human sign-off |

Rules: destructive steps (drops, type narrowing, deletes) require an explicit human approval line in the release; take the backup/snapshot in the plan, not as an afterthought; a migration without a written rollback is not mergeable.

## Locks

- State the lock profile of every DDL: `ALTER TABLE ADD COLUMN` is cheap on modern PG (11+); changing a column TYPE, adding NOT NULL without default, and some index builds rewrite/lock the table.
- Long lock risks: `lock_timeout` set; run against production-shaped data volumes in staging first; batch anything touching >1% of rows.
- Concurrent index creation where the engine supports it (`CREATE INDEX CONCURRENTLY`).

## Verification gates

- [ ] Ran against a production-sized dataset copy; measured duration
- [ ] Batch size and sleep documented; replica lag alarm threshold set
- [ ] Rollback rehearsed (or snapshot restore path verified) in staging
- [ ] Contract step scheduled in a future release, with an owner
