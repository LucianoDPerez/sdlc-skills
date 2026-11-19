# Design system: tokens, components, patterns

## Tokens

Define once, reference everywhere. A spec may only add tokens; it may not inline raw values.

| Token family | Contents | Convention |
|---|---|---|
| Color | semantic roles (primary, success, warning, danger, neutral scale 50–900) | semantic names, never `blue-500` in specs |
| Spacing | 4px base scale: 4/8/12/16/24/32/48/64 | no off-scale gaps |
| Typography | scale (display, h1–h4, body, caption, mono), line heights | sizes in rem, scale jumps ≥1.25 |
| Radius | sm/md/lg/full + circle | — |
| Elevation | 0–3 shadows + purpose per level | — |
| Motion | durations (fast 150ms, base 250ms, slow 400ms), easings | respect `prefers-reduced-motion` |

## Component inventory

List each component with its variants and states. A component not in the inventory does not exist; a spec needing a new component adds it here with: name, variants, states, props sketch, and which screens use it.

Minimum starter inventory: Button (primary/secondary/ghost/destructive × idle/hover/focus/active/disabled/loading), Input (+validation states), Select, Checkbox/Radio, Toast/Alert, Modal, Drawer, Table (sorting, pagination, selection, sticky header), Tabs, Breadcrumb, Empty-state illustration slot, Skeleton loaders.

## Patterns

**Forms** — label above field; inline validation on blur, never on keystroke; error summary at top linking to fields for long forms; required marked, optional assumed; autocomplete attributes on identity/payment fields; submit disabled only while pending, not before first attempt.

**Tables** (admin) — column sort where meaningful; pagination over virtual scroll under ~10k rows; row actions behind a menu beyond 2; bulk selection with visible count and clear action bar; loading = skeleton rows, not spinner.

**Navigation** — global nav ≤7 items; breadcrumb on any page 3+ levels deep; destructive actions behind confirm with typed input for irreversible ones; back always returns to previous state, not reset.

**Mobile** — 44×44px minimum targets (iOS HIG) / 48dp (Material); primary action in thumb reach; system back must work; input types trigger the right keyboard (`inputmode`); respect safe areas/notches.

**Admin vs consumer** — admin optimizes density and keyboard throughput (shortcuts, filters that persist); consumer optimizes clarity over density; never mix the two conventions in one surface.

## Existing-system rule

If the project has a design system (tokens file, component library), the spec MUST consume it and may only propose deltas. Greenfield: ship a tokens section in the first UX spec and treat it as the system's seed.
