# Runbook: <service>

Owner: <team>
On-call escalation: <path/channel>
Last verified: YYYY-MM-DD  ← stale >6 months = audit

## Service in one paragraph

What it does, who uses it, criticality, and where it runs.

## Health & observability

- Dashboards: <links>
- Key alerts: <name → what it means → first action>
- SLOs and current error budget: <link>

## Common alerts

| Alert | Likely cause | First action | If not resolved |
|---|---|---|---|
| HighErrorRate | bad deploy | check recent deploys; consider rollback per release plan criteria | escalate |
| QueueBacklog | consumer down | restart consumer, check DLQ | page owner |
| DiskFull | log explosion | rotate/purge per retention policy | escalate |

## Operational procedures

### Roll back a deploy
1. <exact command/steps>
2. Verify guardrails recover.

### Force a feature flag off
1. <panel/CLI steps> — when in doubt, roll back, then investigate.

### Rotate credentials / invalidate sessions
1. <steps>

### Replay a stuck queue / DLQ
1. <steps>; verify idempotency before replay.

## Dependencies

| Dependency | What breaks if it's down | Mitigation |
|---|---|---|

## When in doubt

Roll back. Investigating a healthy rollback is cheap; investigating an outage is not.
