---
name: mmpf-execute
description: >
  Execute a phase from the MMPF plan. Implements tasks with atomic commits,
  TDD when appropriate, and subagent delegation. Writes DONE.md with
  verification results on completion. Updates CLAUDE.md and /docs when
  appropriate. Trigger: "let's execute", "start phase", "build it",
  "/mmpf-execute".
---

# /mmpf-execute — Execute with Discipline

Run a phase from the plan with traceability and best practices.

## Prerequisites

- `.mmpf/STATE.md` must exist with `stage: executing` or `planning`
- At least one phase must have a PLAN.md in `.mmpf/phases/`

## Steps

### 1. Determine which phase to execute

If the user specifies a phase number, use that. Otherwise:
- Read STATE.md for the current phase
- If no current phase, find the first phase whose PLAN.md exists and has no DONE.md
- Check that dependencies (from PLAN.md frontmatter) have DONE.md files
- If dependencies are unmet, tell the user and suggest the right phase

### 2. Load phase context

Read the phase's PLAN.md. Also read:
- `.mmpf/REQUIREMENTS.md` for the requirements this phase covers
- `.mmpf/RESEARCH.md` for relevant context and decisions
- DONE.md files from dependency phases for what's already built
- The project's CLAUDE.md for project conventions

Present a brief summary: "Executing Phase N: <name>. <goal>. <task count> tasks."

### 3. Update state

Update `.mmpf/STATE.md`:
- `stage`: `executing`
- `phase`: the phase number
- `updated`: today's date
- Current Focus: the phase goal
- Next Step: first task description

### 4. Execute tasks

For each task in the PLAN.md:

**Before starting the task:**
- Announce what you're about to do
- Determine if TDD applies (see `references/testing-heuristic.md`)

**Implement the task:**
- Use subagents for discrete, well-defined pieces of work
- Make atomic commits — each commit should be a coherent unit of work
- Use conventional commit messages: `type[(scope)]: description`
- If using TDD: commit the failing test first, then commit the implementation

**After completing the task:**
- Verify the task's acceptance criteria are met
- Run existing tests to check for regressions
- Update STATE.md with progress

**If something goes wrong:**
- If a task is blocked, note it and move to the next independent task
- If the plan needs to change, update PLAN.md and tell the user what changed and why
- Do not silently deviate from the plan

### 5. Write DONE.md

When all tasks are complete (or the phase is being closed), create `.mmpf/phases/NN-name/DONE.md`:

- List what was built
- Check each truth from PLAN.md — verified or not, and how
- List tests created
- Note any deviations from the plan

See `references/artifact-formats.md` for the full format.

### 6. Verify truths

Spawn a subagent to independently verify each truth from the PLAN.md:
- Run the tests
- Check that files exist and contain expected content
- Verify observable behaviors

If any truth fails verification, report it. Do not mark the phase as done until truths pass or the user explicitly accepts the gap.

### 7. Update project artifacts

After successful execution, consider whether updates are needed to:
- **CLAUDE.md** — if the phase established conventions, patterns, or architectural decisions that future work should follow
- **/docs** — if the phase created user-facing features, APIs, or configuration that should be documented

Only update these when genuinely appropriate. Do not add temporal entries ("we changed X on this date"). Document the current state, not the history.

### 8. Advance state

Update `.mmpf/STATE.md`:
- If more phases remain: set Next Step to the next phase
- If all phases are done: set `stage: executing` with Next Step suggesting `/mmpf-complete`
- Update the Context section with key decisions or outcomes from this phase

## Principles

- **Atomic commits.** Each commit is a coherent, working unit. No "WIP" commits unless pausing mid-task (in which case, update STATE.md too).
- **Test by default.** Code deliverables get unit tests. Use the testing heuristic to decide TDD vs test-after. See `references/testing-heuristic.md`.
- **Traceability.** Every commit relates to a task. Every task relates to a truth. Every truth relates to a requirement. This chain doesn't need to be explicit in commit messages, but it should be reconstructable.
- **Subagents for focus.** Delegate discrete implementation tasks to subagents. This keeps the main context clean and provides a fresh perspective on each task.
- **Plans are guides, not shackles.** If execution reveals the plan is wrong, update the plan. Document the deviation in DONE.md.
