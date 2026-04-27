---
name: mmpf-status
description: >
  Show current MMPF project state and what to do next. Use at the start of a
  new session to resume work, or anytime to check progress. Reads .mmpf/STATE.md
  and project artifacts to give a complete picture. Trigger: "what's next",
  "where are we", "mmpf status", "resume", "mmpf-status". Claude users can also
  invoke `/mmpf-status`.
---

# mmpf-status — Where Are We, What's Next

Show the current project state and recommend the next action.

## Steps

### 1. Check for active project

Read `.mmpf/STATE.md`. If it doesn't exist:
- Tell the user there's no active MMPF project
- Check if `.mmpf/archive/` exists and list past projects (see step 6)
- Check if `.mmpf/BACKLOG.md` exists and mention pending backlog items
- Suggest `mmpf-start` to begin a new project
- Stop here

### 2. Display current state

Show a concise status block:

```
Project: <name>
Stage: <discussion | research | planning | executing | complete>
Started: <date>
Updated: <date>
```

If executing, also show:
```
Phase: <N> — <name>
Progress: <completed tasks> / <total tasks>
```

### 3. Show context

Display the **Current Focus** and **Context** sections from STATE.md. These tell the user (and a fresh session) what's happening and why.

### 4. Recommend next action

Based on the current stage:

**discussion:**
- Show the Current Focus and any Context from STATE.md
- Say: "You're in discussion mode. Keep talking it through, then use `mmpf-research` if there are unknowns to investigate or `mmpf-plan` if you're ready to plan."

**research:**
- Summarize what's been found so far (scan RESEARCH.md headings and decision count)
- Show open questions if any
- Say: "You're in research mode. Keep exploring, or use `mmpf-plan` when you're ready to plan."

**planning:**
- Show how many requirements exist and how many phases are planned
- If REQUIREMENTS.md exists but no phases yet, say planning is in progress
- Say: "Use `mmpf-plan` to continue planning, or `mmpf-execute` if the plan is ready."

**executing:**
- Read the current phase's PLAN.md
- Show which tasks are done vs remaining
- If all tasks are done, suggest running verification or moving to the next phase
- Say: "Use `mmpf-execute` to continue, or `mmpf-complete` if you're done."

**complete:**
- Say the project is complete and suggest `mmpf-start` for a new one
- List past archived projects if any exist (see step 6)
- Mention backlog items if they exist

### 5. Surface blockers

If STATE.md mentions blockers, decisions needed, or open questions that could affect progress, highlight them prominently before the recommendation.

### 6. Show archive history

If `.mmpf/archive/` exists, list past projects. For each subdirectory (named `<YYYY-MM-DD>-<project-name>`):

- Read its `STATE.md` frontmatter for the project name and dates
- Read its `REQUIREMENTS.md` to count requirements (if it exists)
- Count phases with DONE.md vs total phases

Show a compact summary:

```
Past projects:
  2026-03-15  widget-api       3/3 phases, 12 requirements
  2026-02-01  auth-refactor    2/4 phases, 8 requirements (closed early)
```

Mark projects "closed early" if not all phases have a DONE.md. Keep this brief — it's context, not the focus. If the user wants to inspect a specific archive, read and summarize its artifacts on request.

## Session Resumption

This skill is designed for the "fresh session" use case. When a user starts a new chat and uses `mmpf-status`, they should get everything they need to continue working without reading multiple files themselves. Be thorough but concise — give them the full picture in one response.
