---
name: mmpf-complete
description: >
  Complete the current MMPF project. Archives artifacts for reference, resets
  state for the next project. Can be used to finish a successful project or
  to close one early. Trigger: "we're done", "complete the project", "wrap up",
  "close this project", "mmpf-complete". Claude users can also invoke
  `/mmpf-complete`.
---

# mmpf-complete — Finish and Reset

Complete the current project and archive its artifacts.

## Steps

### 1. Check for active project

Read `.mmpf/STATE.md`. If it doesn't exist or `stage` is `complete`:
- Tell the user there's no active project to complete
- Stop here

### 2. Assess completion

Determine the project's state:
- How many phases have DONE.md files vs total phases planned?
- Are there unverified truths in any DONE.md?
- Are there requirements in REQUIREMENTS.md that no phase covered?

Present a summary:

```
Project: <name>
Phases completed: N / M
Requirements covered: X / Y
```

If the project is incomplete (not all phases done), note this without judgment. The user may be intentionally closing early — that's fine. Ask: "Ready to archive and close, or is there more to do?"

### 3. Archive

Create `.mmpf/archive/<YYYY-MM-DD>-<project-name>/` and move into it:
- `STATE.md`
- `RESEARCH.md`
- `REQUIREMENTS.md`
- `phases/` (entire directory with all PLAN.md and DONE.md files)
- `experiments/` (if it exists and has content)

Do NOT archive `BACKLOG.md` — it persists across projects.

### 4. Reset state

Write a fresh `.mmpf/STATE.md`:

```markdown
---
project: none
stage: complete
started:
updated: <today's date>
---

## Current Focus

No active project.

## Context

Last project "<name>" completed on <date>.

## Next Step

Use `mmpf-start` to begin a new project, or `mmpf-backlog` to review ideas.
```

### 5. Summary

Tell the user:
- The project has been archived to `.mmpf/archive/<dir>/`
- Mention any backlog items if they exist
- Suggest `mmpf-start` or `mmpf-backlog` as next steps

## Notes

- Archives are kept for reference but are not meant to be actively used. They're there so you can look back at what was decided and why.
- The backlog survives project completion. Ideas captured during one project carry forward.
- Completing a project does not touch the actual codebase, CLAUDE.md, or /docs — those were updated during execution as appropriate.
