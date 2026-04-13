---
name: mmpf-plan
description: >
  Derive requirements and create a phased execution plan. Use after discussion
  or research to crystallize what we know into actionable work. Creates
  REQUIREMENTS.md and per-phase PLAN.md files with verifiable truths. Trigger:
  "let's plan", "ready to plan", "create a plan", "/mmpf-plan".
---

# /mmpf-plan — Plan from Knowledge

Derive requirements and create a phased plan.

## Prerequisites

- `.mmpf/STATE.md` must exist

## Steps

### 1. Review what we know

Read `.mmpf/STATE.md` and `.mmpf/RESEARCH.md` (if it exists).

If RESEARCH.md exists, summarize:
- Key findings and decisions made during research
- Open questions that might affect planning
- Any experiments and their takeaways

If no RESEARCH.md, work from the discussion context — STATE.md and the current conversation.

Present this summary to the user. Ask if there's anything else to figure out before we plan, but don't push — if they say "let's plan", plan.

### 2. Derive requirements collaboratively

This is a conversation, not a form. Work with the user to identify what the project needs to deliver.

Start by proposing requirements based on what we know (from research, discussion, or both). Present them as a draft:

```
Based on what we've discussed, here's what I think we need:

AUTH-01: Users can sign in with email/password
AUTH-02: Session tokens expire after 24 hours
DATA-01: Import supports CSV and JSON formats
...

What would you add, remove, or change?
```

Iterate until the user is satisfied. Then:
- Write `.mmpf/REQUIREMENTS.md` with categorized requirement IDs
- Include an Out of Scope section for things explicitly excluded

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
- Every requirement ID appears in at least one phase's PLAN.md frontmatter
- Every phase has at least one verifiable truth
- Dependencies don't form cycles

**Handling partial coverage:** If a requirement is large enough that one phase only covers part of it, split the requirement into sub-IDs (e.g., `AUTH-01a`, `AUTH-01b`) so each phase's frontmatter accurately reflects what it delivers. Every sub-ID should be independently verifiable. Don't leave a requirement listed in a phase that only partially implements it — that creates false confidence during verification.

Report any gaps or recommended splits to the user.

### 5. Update state

Update `.mmpf/STATE.md`:
- `stage`: `planning` (or `executing` if plan is approved and user wants to start)
- `updated`: today's date
- Current Focus: summary of the plan
- Next Step: "Run `/mmpf-execute` to begin phase 1" (or whichever phase is first)

## Principles

- **Requirements come from what we know.** Don't invent requirements that aren't grounded in the discussion or research. If something feels missing, ask the user.
- **Phases are small.** Each phase should be completable in one or two sessions. If a phase feels too big, split it.
- **Truths are testable.** Every truth should be verifiable by running a test, checking a file, or observing a behavior. "Code is clean" is not a truth. "All public functions have typed parameters" is.
- **Plans are living documents.** It's fine to update a PLAN.md during execution if we learn something new. The plan serves us, not the other way around.
