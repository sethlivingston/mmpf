---
name: mmpf-execute
description: >
  Execute a phase from the MMPF plan. Implements tasks with atomic commits,
  TDD when appropriate, and subagent delegation. Writes DONE.md with
  verification results on completion. Updates CLAUDE.md and /docs when
  appropriate. Use --chain to run all remaining phases without pausing.
  Trigger: "let's execute", "start phase", "build it", "execute all",
  "mmpf-execute". Claude users can also invoke `/mmpf-execute`.
---

# mmpf-execute — Execute with Discipline

Run a phase from the plan with traceability and best practices.

Use `--chain` to execute all remaining phases without pausing between them. Each phase still gets full review and verification — chaining skips the pause, not the discipline.

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

### 5. Review code

Spawn a Sonnet subagent to review the code changed during this phase. The subagent receives:
- The list of files modified (from git diff against the pre-phase baseline)
- The phase's PLAN.md (for intent context)

The subagent reviews for:
- **Bugs** — logic errors, off-by-ones, null dereferences, race conditions
- **Security** — injection, auth bypasses, secrets in code, unsafe input handling
- **Quality** — dead code, duplicated logic, missing error handling at system boundaries

It classifies each finding by severity: `high` (likely bug or vulnerability), `medium` (potential issue), `low` (style or minor concern).

**Handling findings:**
- **No findings:** Record "No issues found" in DONE.md's Code Review section and continue.
- **Findings exist:** Fix them one at a time, highest severity first. Run tests after each fix — if any test fails, stop and report to the user before continuing. This fail-fast discipline prevents cascading breakage.

### 6. Write DONE.md

When all tasks are complete (or the phase is being closed), create `.mmpf/phases/NN-name/DONE.md`:

- List what was built
- Check each truth from PLAN.md — verified or not, and how
- List tests created
- Record code review results (findings and fixes, or "No issues found")
- Note any deviations from the plan

See `references/artifact-formats.md` for the full format.

### 7. Verify truths and threats

Spawn a Sonnet subagent to independently verify each truth from the PLAN.md. The subagent receives:
- The list of truths from PLAN.md (the verifiable assertions)
- The threats from PLAN.md, if any (with their stated mitigations)
- The DONE.md just written (what was built and how)
- The project's test commands and file paths
- Access to read the codebase and run tests

The subagent's job is to verify each truth through direct observation, not by trusting what DONE.md claims. For each truth, it should:
- **Run relevant tests** and confirm they pass
- **Read files** to confirm expected content, exports, or structure exist
- **Run commands** (build, lint, type-check) if the truth implies they should succeed
- **Check staleness** — before verifying a truth, confirm the referenced component still exists (hasn't been renamed or removed during the phase)
- **Report pass/fail** for each truth with evidence (test output, file contents, command results)

For each threat in the PLAN.md, the subagent verifies the mitigation is actually present:
- **Read the relevant code** to confirm the mitigation was implemented, not just planned
- **Report pass/fail** for each threat with evidence

The subagent returns its findings. Update DONE.md's "Truths Verified" and "Threats Verified" sections with the subagent's results.

If any truth or threat fails verification, report it to the user. Do not mark the phase as done until all pass or the user explicitly accepts the gap.

### 8. Update project artifacts

After successful execution, consider whether updates are needed to:
- **CLAUDE.md** — if the phase established conventions, patterns, or architectural decisions that future work should follow
- **/docs** — if the phase created user-facing features, APIs, or configuration that should be documented

Only update these when genuinely appropriate. Do not add temporal entries ("we changed X on this date"). Document the current state, not the history.

### 9. Advance state

Update `.mmpf/STATE.md`:
- If more phases remain: set Next Step to the next phase
- If all phases are done: set `stage: executing` with Next Step suggesting `mmpf-complete`
- Update the Context section with key decisions or outcomes from this phase

### 10. Chain to next phase (optional)

If `--chain` was specified and more phases remain, go back to step 1 with the next phase. Do not pause to ask the user — proceed directly.

Stop chaining if:
- All phases are complete
- A verification truth or threat fails (the user needs to weigh in)
- A code review finding of `high` severity couldn't be auto-fixed

## Principles

- **Atomic commits.** Each commit is a coherent, working unit. No "WIP" commits unless pausing mid-task (in which case, update STATE.md too).
- **Test by default.** Code deliverables get unit tests. Use the testing heuristic to decide TDD vs test-after. See `references/testing-heuristic.md`.
- **Traceability.** Every commit relates to a task. Every task relates to a truth. Every truth relates to a requirement. This chain doesn't need to be explicit in commit messages, but it should be reconstructable.
- **Subagents for focus.** Delegate discrete implementation tasks to subagents. This keeps the main context clean and provides a fresh perspective on each task.
- **Fail fast when fixing.** When addressing review findings or failed truths, fix one at a time and run tests after each. First failure stops the sequence — diagnose before continuing. Don't batch fixes and hope they compose.
- **Deviations need mechanisms, not acknowledgment.** If the plan had to change, document what changed, why, and what structural step prevents the same surprise next time. "We'll be more careful" is not a mechanism.
- **Plans are guides, not shackles.** If execution reveals the plan is wrong, update the plan. Document the deviation in DONE.md.
