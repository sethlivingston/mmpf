---
name: csd-backlog
description: >
  Manage the CSD backlog — capture ideas for future work, list pending items,
  or promote an item to a new project. Use when you have an idea worth
  remembering but don't want to act on it now. Trigger: "add to backlog",
  "backlog", "save this idea", "what's in the backlog", "/csd-backlog".
---

# /csd-backlog — Capture Ideas for Later

Manage the backlog of future ideas and tasks.

## Usage

`/csd-backlog` with no arguments lists the current backlog.
`/csd-backlog <idea>` adds a new item.

## Steps

### 1. Determine action

Based on user input:
- **No argument or "list"** — show the backlog
- **Text provided** — add it as a new item
- **"promote <item>"** — suggest starting a new project from that item

### 2. Adding an item

Ensure `.csd/BACKLOG.md` exists. If not, create it with the header `# Backlog`.

Append the new item:
```markdown
- **<short title>**: <description and context>
```

Derive a short title from the user's input. Include enough context that the idea makes sense weeks later. If the user gave a terse description, ask one clarifying question to capture the "why" — but only one.

Confirm: "Added to backlog: <title>"

### 3. Listing items

Read `.csd/BACKLOG.md` and display the items. If the backlog is empty, say so and suggest the user can add items anytime with `/csd-backlog <idea>`.

### 4. Promoting an item

When the user wants to act on a backlog item:
- Confirm which item they mean
- Suggest running `/csd-start` to begin a project for it
- Do NOT automatically remove it from the backlog — remove it only after `/csd-start` creates the project

## Notes

- The backlog persists across projects. It is not cleared by `/csd-complete`.
- Items are simple — no priority, no categories, no IDs. Just ideas with context.
- If there's no `.csd/` directory at all, create it and BACKLOG.md.
