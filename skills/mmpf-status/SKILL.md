---
name: mmpf-status
description: >
  Show current MMPF project state and what to do next. Use at the start of a
  new session to resume work, or anytime to check progress. Reads .mmpf/STATE.md
  and project artifacts to give a complete picture. Trigger: "what's next",
  "where are we", "mmpf status", "resume", "/mmpf-status".
---

# /mmpf-status — Where Are We, What's Next

Show the current project state and recommend the next action.

## Steps

### 1. Check for active project

Read `.mmpf/STATE.md`. If it doesn't exist:
- Tell the user there's no active MMPF project
- Check if `.mmpf/BACKLOG.md` exists and mention pending backlog items
- Suggest `/mmpf-start` to begin a new project
- Stop here

### 2. Display current state

Show a concise status block:

```
Project: <name>
Stage: <research | planning | executing | complete>
Started: <date>
Updated: <date>
```

If executing, also show:
```
Phase: <N> — <name>
Progress: <completed tasks> / <total tasks>
```

### 3. Show context

Display the **Current Focus** and **Context** sections from STATE.md. These tell the user (and a fresh Claude session) what's happening and why.

### 4. Recommend next action

Based on the current stage:

**research:**
- Summarize what's been found so far (scan RESEARCH.md headings and decision count)
- Show open questions if any
- Say: "You're in research mode. Keep exploring, or run `/mmpf-plan` when you're ready to plan."

**planning:**
- Show how many requirements exist and how many phases are planned
- If REQUIREMENTS.md exists but no phases yet, say planning is in progress
- Say: "Run `/mmpf-plan` to continue planning, or `/mmpf-execute` if the plan is ready."

**executing:**
- Read the current phase's PLAN.md
- Show which tasks are done vs remaining
- If all tasks are done, suggest running verification or moving to the next phase
- Say: "Run `/mmpf-execute` to continue, or `/mmpf-complete` if you're done."

**complete:**
- Say the project is complete and suggest `/mmpf-start` for a new one
- Mention backlog items if they exist

### 5. Surface blockers

If STATE.md mentions blockers, decisions needed, or open questions that could affect progress, highlight them prominently before the recommendation.

## Session Resumption

This command is designed for the "fresh session" use case. When a user starts a new chat and runs `/mmpf-status`, they should get everything they need to continue working without reading multiple files themselves. Be thorough but concise — give them the full picture in one response.
