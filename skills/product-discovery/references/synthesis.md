# Synthesis, assumptions, opportunity mapping

## From notes to insights

1. Tag every raw note with its source and date.
2. Group notes into themes (affinity mapping).
3. Promote a theme to an **insight** only when ≥3 independent sources agree, or 1 source with quantified impact.
4. Every insight keeps its citations inline: `(Interview #3, 2026-11-12)`, `(Amplitude funnel, Oct 2026)`, `(Zendesk: 214 tickets/qtr)`.

## Assumption ranking

An idea rests on assumptions (desirability, viability, feasibility, usability). Score each:

- **Impact** (1–5): if false, how much does the idea collapse?
- **Uncertainty** (1–5): how much evidence do we actually have?
- **Evidence** (none / weak / strong): what backs it today.

Risk = Impact × Uncertainty. Sort descending. The top assumption is the one the next experiment must test. If the riskiest assumption is already backed by strong evidence, discovery is done — write the brief.

## Opportunity solution tree

```
Outcome (metric we move)
└── Opportunity 1 (pain, phrased as user need)
    ├── Solution A  → experiment: <cheapest test>
    └── Solution B
└── Opportunity 2
    └── Solution C
```

Rules: opportunities come from evidence (interviews/tickets/analytics), never from brainstorming; solutions hang below opportunities so swapping a solution never loses the problem; pick the experiment that tests the riskiest assumption at the lowest cost.

## Recommendation formats

- **Proceed to PRD** — riskiest assumptions have strong evidence.
- **Run one more experiment** — name the experiment, its assumption, cost, and kill criteria.
- **Kill** — evidence contradicts the problem's importance; state which evidence.
