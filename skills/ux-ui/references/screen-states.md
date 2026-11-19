# Screen states, flows, fidelity

## The state matrix

Every screen spec answers all of these. "Happy path only" is a rejected spec.

| State | Must define | Rules |
|---|---|---|
| **Empty** | first-use vs no-data vs filtered-to-empty copy, call-to-action | three distinct cases — never one "Nothing here" for all |
| **Loading** | skeleton vs spinner vs progress; what remains interactive | skeletons for content areas, spinners only for <300ms unknowns; block or allow navigation, stated explicitly |
| **Error** | recoverable (retry works) vs validation (field-level) vs fatal (support/escape) | error copy says what happened + what to do next; never just "Error" |
| **Success** | confirmation, what unlocks next, undo where destructive | transient toasts for reversible actions; persistent confirmation for irreversible ones |

Optional states when applicable: partial data (stale-cache banner), offline, permission-denied, concurrent-modification.

## Flow notation

- Mermaid `flowchart TD` inside the spec; one flowchart per user journey, named after the story (`US-3: checkout`).
- Every decision diamond lists its branches: success, validation failure, timeout, cancel.
- Error recovery paths return to the last valid step — never to a dead end.
- Annotate cross-screen transitions with the trigger (button, redirect, system event).

## Fidelity levels

| Level | What it is | When to stop here |
|---|---|---|
| Low | grey boxes, arrows, real labels only | choosing between flow options |
| Mid | real copy, layout regions, real navigation | PRD approved, flow agreed |
| High | tokens, components, all states, a11y annotations | handoff to implementation |
| Prototype | clickable, real timing | interaction risk: drag, gestures, multi-step timing |

## Rules

- One screen can serve multiple flows; spec states once per screen, reference them from flows.
- Inventory first, detail second: a screen missing from the inventory is a bug found at QA time — the inventory is the contract.
- Copy is part of design: button labels, empty states, and error messages are deliverables, not leftovers.
