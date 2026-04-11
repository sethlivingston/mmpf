---
name: mmpf-plan
description: >
  Derive requirements from research and create a phased execution plan. Use
  after research is complete (or sufficient) to crystallize what we learned
  into actionable work. Creates REQUIREMENTS.md and per-phase PLAN.md files
  with verifiable truths. Trigger: "let's plan", "ready to plan", "create a
  plan", "/mmpf-plan".
---

# /mmpf-plan — Plan from Knowledge

Derive requirements from research findings and create a phased plan.

## Prerequisites

- `.mmpf/STATE.md` must exist
- `.mmpf/RESEARCH.md` should exist with findings (warn if empty, but allow planning without it)

## Steps

### 1. Review research

Read `.mmpf/RESEARCH.md` and `.mmpf/STATE.md`.

Summarize what we know:
- Key findings and decisions made during research
- Open questions that might affect planning
- Any experiments and their takeaways

Present this summary to the user. Ask if there's anything else to research before we plan, but don't push — if they say "let's plan", plan.

### 2. Derive requirements collaboratively

This is a conversation, not a form. Work with the user to identify what the project needs to deliver.

Start by proposing requirements based on the research findings. Present them as a draft:

```
Based on our research, here's what I think we need:

AUTH-01: Users can sign in with email/password
AUTH-02: Session tokens expire after 24 hours
DATA-01: Import supports CSV and JSON formats
...

What would you add, remove, or change?
```

Iterate until the user is satisfied. Then:
- Write `.mmpf/REQUIREMENTS.md` with categorized requirement IDs
- Include an Out of Scope section for things explicitly excluded
- Include a Traceability table (phases filled in during step 3)

See `references/artifact-formats.md` for the full format.

### 3. Create phased plan

Break the requirements into phases using goal-backward thinking: "What must be true when this phase is complete?"

For each phase, determine:
- **Goal** — one sentence describing the end state
- **Dependencies** — which phases must complete first
- **Requirements** — which requirement IDs this phase covers
- **Success criteria** — 2-5 observable, verifiable truths

Present the phase breakdown to the user for feedback. Iterate if needed.

Then for each phase, create `.mmpf/phases/NN-name/PLAN.md` with:
- Frontmatter: phase number, name, requirements, dependencies
- Goal
- Truths (verifiable assertions — these drive verification in DONE.md)
- Tasks with descriptions and acceptance criteria

See `references/artifact-formats.md` for the full PLAN.md format.

### 4. Verify coverage

Spawn a subagent to check:
- Every requirement ID appears in at least one phase
- Every phase has at least one verifiable truth
- Dependencies don't form cycles
- The traceability table in REQUIREMENTS.md is complete

Report any gaps to the user.

### 5. Update state

Update `.mmpf/STATE.md`:
- `stage`: `planning` (or `executing` if plan is approved and user wants to start)
- `updated`: today's date
- Current Focus: summary of the plan
- Next Step: "Run `/mmpf-execute` to begin phase 1" (or whichever phase is first)

## Principles

- **Requirements come from research.** Don't invent requirements that aren't grounded in what we learned. If something feels missing, ask the user.
- **Phases are small.** Each phase should be completable in one or two sessions. If a phase feels too big, split it.
- **Truths are testable.** Every truth should be verifiable by running a test, checking a file, or observing a behavior. "Code is clean" is not a truth. "All public functions have typed parameters" is.
- **Plans are living documents.** It's fine to update a PLAN.md during execution if we learn something new. The plan serves us, not the other way around.
