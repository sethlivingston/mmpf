# MMPF Artifact Formats

All artifacts live in `.mmpf/` at the project root.

## STATE.md

Tracks current project position for session resumption.

```markdown
---
project: <short project name>
stage: research | planning | executing | complete
phase: <current phase number, if executing>
started: <ISO date>
updated: <ISO date>
---

## Current Focus

<1-2 sentences: what we're working on right now>

## Context

<Key decisions made, important constraints, anything a fresh session needs to know>

## Next Step

<Specific next action to take>
```

## RESEARCH.md

Accumulated findings from freeform research and experimentation.

```markdown
# Research: <project name>

## Findings

### <Topic>
<What we learned. Tag confidence:>
- [VERIFIED] — confirmed by docs, tests, or code
- [CITED] — from a credible source, not independently verified
- [ASSUMED] — reasonable belief, not yet confirmed

### <Topic>
...

## Experiments

### <Experiment name>
- **Goal:** <what we wanted to learn>
- **Approach:** <what we did>
- **Result:** <what happened>
- **Takeaway:** <what this means for the project>

## Open Questions

- <Things we still don't know>

## Decisions

- <Choices made during research that should carry forward>
```

## REQUIREMENTS.md

Requirements derived collaboratively from research findings.

```markdown
# Requirements: <project name>

## Requirements

### <Category>

- **<ID>**: <requirement description>
- **<ID>**: <requirement description>

### <Category>

- **<ID>**: <requirement description>

## Out of Scope

- <Explicitly excluded items>

## Traceability

| Requirement | Phase | Status |
|---|---|---|
| <ID> | <phase number> | pending / done |
```

Requirement IDs use category prefix + number: `AUTH-01`, `UI-03`, `PERF-02`, etc.

## PLAN.md (per phase)

Lives in `.mmpf/phases/NN-name/PLAN.md`.

```markdown
---
phase: <number>
name: <phase name>
requirements: [<list of requirement IDs this phase covers>]
depends_on: [<list of phase numbers>]
---

# Phase <N>: <name>

## Goal

<What must be true when this phase is complete>

## Truths

Verifiable assertions that prove the goal is met:

- [ ] <truth 1 — a testable/observable statement>
- [ ] <truth 2>
- ...

## Tasks

### Task 1: <description>
<What to do, key files, acceptance criteria>

### Task 2: <description>
...
```

## DONE.md (per phase)

Lives in `.mmpf/phases/NN-name/DONE.md`.

```markdown
---
phase: <number>
completed: <ISO date>
commits: [<list of commit SHAs>]
---

# Phase <N>: Done

## What Was Built

<Summary of what was implemented>

## Truths Verified

- [x] <truth 1> — <how verified>
- [x] <truth 2> — <how verified>
- [ ] <truth N> — <why not verified, if applicable>

## Tests

<Test files created/modified, what they cover>

## Notes

<Anything notable: deviations from plan, surprises, follow-up items>
```

## BACKLOG.md

Simple list of ideas for future work.

```markdown
# Backlog

- **<short title>**: <description and context>
- **<short title>**: <description and context>
```
