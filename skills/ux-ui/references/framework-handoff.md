# Framework handoff: React and Angular lanes

One UX spec serves both stacks. Screens, states, flows, and accessibility do NOT change per framework — only the implementation lane does.

## Token handoff (single source of truth)

Token names defined in the UX spec are identical in both lanes.

| Concern | React lane | Angular lane |
|---|---|---|
| Token storage | CSS custom properties via Tailwind theme (`:root` vars) | CSS custom properties + Material theming (M3 tokens, v18+) |
| Component theming | shadcn/ui + Tailwind classes reading the vars | Angular Material + CDK reading the vars |

If a token value changes, it changes ONCE in the spec → propagates via vars in both lanes.

## Component mapping

UX spec inventory → concrete component per lane. A spec row with no match in either lane goes to the new-components table (still shared).

| UX inventory | React | Angular |
|---|---|---|
| Button | shadcn Button | MatButton / MatAnchor (Material) |
| Input / Select | shadcn + React Hook Form | MatFormField + MatInput/MatSelect + Reactive Forms |
| Checkbox / Radio | shadcn | MatCheckbox / MatRadio |
| Table (sort/paginate) | TanStack Table + shadcn | MatTable + MatTableDataSource |
| Modal | Radix Dialog (shadcn) | MatDialog |
| Drawer | Radix Sheet | MatDrawer (CDK) |
| Toast / alerts | Sonner / Radix Toast | MatSnackBar |
| Tabs | Radix Tabs | MatTabs |
| Skeleton loaders | shadcn Skeleton | MatProgressSpinner + CSS skeleton |
| Empty state | shared slot component | shared slot component (identical copy) |

## Patterns per lane

| Pattern | React | Angular |
|---|---|---|
| Forms + validation | React Hook Form + zod; errors via `aria-describedby` | Reactive Forms (`Validators`, cross-field via `FormGroup`); `ErrorStateMatcher` |
| Focus trap / live announce | Radix primitives handle it; verify | CDK A11y (`FocusTrap`, `LiveAnnouncer`) — REQUIRED for modals |
| Router → flows | file-based routes mirror spec flows | Angular Router config mirrors spec flows |
| Data / server state | TanStack Query | RxJS + HTTP interceptors (or TanStack Query Angular) |
| State (screen-local) | component state / Zustand | component signals / services |

## Shared rules (both lanes)

- **Selectors for tests are part of the contract**: stable `data-testid` (kebab, one per interactive element) or role-based selectors — Playwright suites written once run against both lanes.
- **States are implemented, not optional**: a lane implementation missing empty/loading/error/success fails review against the spec checklist.
- **Accessibility parity**: axe-core (Playwright) in CI for both; keyboard + screen-reader smoke per release. Radix (React) and CDK A11y (Angular) do the heavy lifting — custom widgets must match their behavior.
- **No one-off values**: any hex/px inline in a lane component is a review violation; it must trace to a spec token.

## Handoff procedure

1. UX spec approved (flows, states, tokens, inventory).
2. Pick the lane; generate the initial screens with the visual tool of choice (e.g. Stitch) seeded from the spec, then implement against the mapping table — generated HTML is a draft, never the deliverable.
3. Run the a11y checklist before handoff review.
4. Playwright suite + axe run green in CI; attach results to the release gate.
