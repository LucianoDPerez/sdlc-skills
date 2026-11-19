# REST conventions

## Naming and structure

- Paths: `/api/v1/<plural-resources>`; sub-resources max 2 levels (`/orders/{id}/items`).
- Actions that don't fit CRUD: controller sub-resource (`POST /orders/{id}/cancellation`) — verbs allowed only there, documented as exceptions.
- `GET` is safe and cacheable: no side effects ever.
- Operations on collections: `GET` (list) and `POST` (create) only. Bulk operations get their own resource, not collection verbs.
- Field names in payloads: `camelCase` or `snake_case` — pick one per API and write it in the spec; timestamps ISO 8601 UTC.

## Pagination, filtering, sorting

- Cursor pagination by default: `?cursor=<token>&limit=50` (limit ≤100); response carries `next_cursor`. Offset pagination only for small, admin-facing sets.
- Filtering: `?status=active&created_after=<iso>` — documented per endpoint, unknown params are ignored (never errors).
- Sorting: `?sort=-created_at,name` (leading `-` = desc).

## Errors — RFC 7807

```json
{ "type": "https://api.example.com/errors/order-not-found",
  "title": "Order not found", "status": 404,
  "detail": "Order o_123 was deleted on 2026-11-01.",
  "instance": "/api/v1/orders/o_123" }
```

- `type` is a stable, documented URL — clients switch on `type`, never on `title`.
- 422 for validation with a field-level `errors` extension.
- 409 for state conflicts (already shipped, already cancelled).

## Status codes (the working set)

200/201(+`Location`)/204 success; 400 malformed; 401 unauthenticated; 403 forbidden; 404 (also for cross-tenant objects — don't leak existence); 409 conflict; 410 gone; 422 validation; 423 locked; 429 rate limit (+`Retry-After`); 5xx server.

## Auth and authorization

- Bearer JWT short-lived + refresh token; scopes named per endpoint in the spec.
- Authorization is resource-level: every operation documents its required scope AND the tenancy check (404, not 403, cross-tenant).
- Secrets never in payloads; webhooks sign with HMAC + timestamp (+replay window).

## Idempotency

- `Idempotency-Key` header on POST/PATCH for payment-class operations; server stores first response for 24h; same key returns the stored response.

## Versioning and breaking changes

- Additive changes (new optional field, new endpoint) are NOT breaking — ship freely.
- Breaking (removing/renaming fields, changing semantics, new required param) requires: new version path or a dated deprecation window (min 90 days) + `Deprecation`/`Sunset` headers — the decision is an ADR.

## Webhooks / events

- Contract per event: name, schema, delivery (at-least-once), retry policy (exp. backoff, then DLQ), signature scheme, replay source.
- Consumers must be idempotent — document event ids and dedup guidance.
