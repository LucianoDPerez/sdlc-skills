# STRIDE reference

## Trust boundaries

A boundary is any line where trust level changes: internet↔load balancer, client↔API, API↔database, service↔service, admin plane↔user plane. For each crossing state: what data crosses, in what direction, authenticated how, encrypted how. Undocumented crossings are findings.

## The matrix

| Element type | S | T | R | I | D | E |
|---|---|---|---|---|---|---|
| External actor | — | ✔ impersonation via credential theft | ✔ claims more rights | — | ✔ denies service to others | ✔ trojan account creation |
| API endpoint | ✔ input validation | ✔ JWT/session forgery | ✔ privilege escalation via IDOR | ✔ log tampering | ✔ flood | ✔ malicious handler |
| Service/process | ✔ config injection | ✔ service-to-service spoofing | ✔ missing tenant check | ✔ unlogged state change | ✔ crash loop | ✔ dependency backdoor |
| Data store | ✔ SQL/NoSQL injection | ✔ weak tenant isolation | ✔ missing row-level authz | ✔ silent mutation | ✔ lock/drop exhaustion | ✔ stored XSS |
| Data flow | ✔ MITM without TLS | ✔ replay without nonce | — | ✔ truncation undetected | ✔ cut cable | ✔ proxy injection |

Answer all six per element. "N/A" costs one line of justification.

## Risk rating

severity (1–5: data exposure breadth, blast radius, money) × likelihood (1–5: exposure, attacker value, skill needed).

| Score | Class | Action |
|---|---|---|
| 15–25 | blocker | fix before implementation merges |
| 10–14 | high | fix before release; temporary mitigation named |
| 5–9 | medium | tracked with owner + deadline |
| ≤4 | accepted risk | named accepter, revisit date |

## Mitigation quality bar

- State the control TYPE: prevent (validation, authz), detect (alert, audit), respond (rollback, revoke).
- "We'll be careful" / "the framework handles it" are not mitigations — name the mechanism and where it is enforced (edge, service, store).
- Each threat ends mitigated, or explicitly accepted by a named person.

## Data classification (drives everything)

| Class | Examples | Rules |
|---|---|---|
| PII | email, phone, address, gov id | minimal collection, encrypted at rest, access logged, deletion path defined |
| Financial | cards, balances | PSP tokenization; raw PAN never stored (PCI scope) |
| Credentials/keys | passwords, tokens | hashed (argon2/bcrypt), never logged, rotate on exposure |
| Internal | non-user business data | tenant isolation, no public exposure |
