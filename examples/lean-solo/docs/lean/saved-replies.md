# Lean Feature Doc: saved-replies

Status: approved
Date: 2026-11-21
Owner: Jo Alvarez (solo)
Approved by: Jo Alvarez (solo — lean mode: the owner signs; sha-binding applies), 2026-11-21
Mode: solo
Replaces: discovery brief + PRD + UX spec — lean profile, `skills/sdlc/references/pipeline.md`

## 1. Problem + evidence

Who: Nimbus users (solo-built helpdesk, 340 paying users). What: agents retype the same answers. Evidence: 🔶 my own support inbox — ~30% of my last 50 replies are near-duplicates (sampled Nov 15–19). Why painful: 2–4 minutes per duplicate reply. 🔵 Real-user duplicate rate: unmeasured — the guardrail question below tests it.

## 2. Success metric

| Type | Metric | Baseline | Target | Measured |
|---|---|---|---|---|
| Primary | median reply composition time | 6 min | 4 min | 2026-12-20 |
| Guardrail | replies per active hour | 9 | must not drop below 8 | dashboard |

## 3. Stories

US-1: save a reply — Given I am on a conversation, When I select text and click "Save as reply", Then it is stored under a name I choose.
- failure: name already taken → inline "Name taken. Overwrite?" with a keep-both option.
US-2: use a saved reply — Given saved replies exist, When I open the picker and select one, Then the text inserts at the cursor.
- failure: none saved yet → empty state "No saved replies yet — select text in any reply to save it."

Out of scope: team-shared replies — no evidence of team demand (no teams in the product yet).

## 4. UI (user-facing)

Screen: saved-replies picker (modal over the composer). States: empty (copy above), loading (skeleton list), error (recoverable → "Couldn't load replies. Retry."), success (searchable list). Spec-time accessibility: focus order search → list → items; Esc closes and returns focus to the composer; items are buttons with the reply name as accessible name; insert confirmation announced via aria-live="polite".

## 5. Alternatives considered

- Snippet shortcuts (type `:greeting` to expand) — power-user only; 🔶 casual users dominate the sample.
- Markdown template library import — overkill; zero import demand evidence.
- Do nothing — ~30% near-duplicate replies keep burning time.
Significance check: none of these is hard to reverse → no ADR spawned.

## 6. Data / API touchpoints

New table `saved_replies` (id, account_id, name, body, created_at, updated_at) → schema change: the `erd` stage runs before implementation. No external contract.

## 7. Security considerations

New table is account-scoped → row-level authz on every query (same pattern as existing tables); no new trust boundary. The `security` stage still runs before implementation per lean rules.

## 8. Rollout + rollback

Behind `saved_replies` flag, default off; rollback = flag off (additive table, no migration rollback needed). Rollback trigger: composer error rate >2× baseline for 15 min → flag off.

## 9. Deviations from docs/principles.md

| Principle | Deviation | ADR |
|---|---|---|
| none — flag rollout and account-scoped queries follow the repo's standing rules | — | — |

## 10. Open questions

🔵 measure the real-user duplicate-reply rate before considering team sharing — owner: Jo Alvarez — 2026-12-01.

---

Downstream gates STILL RUN: `erd` (schema change), `security`, `qa`, `release` — lean collapses knowledge stages, not risk stages.
