---
name: mmpf-backlog
description: >
  Manage the MMPF backlog — capture ideas for future work, list pending items,
  or promote an item to a new project. Use when you have an idea worth
  remembering but don't want to act on it now. Trigger: "add to backlog",
  "backlog", "save this idea", "what's in the backlog", "mmpf-backlog". Claude
  users can also invoke `/mmpf-backlog`.
---

# mmpf-backlog — Capture Ideas for Later

Manage the backlog of future ideas and tasks.

## Steps

### 1. Determine action

Interpret the user's request naturally:
- **They ask to see the backlog or just invoke the skill without a new idea** — show the backlog
- **They provide a new idea to remember** — add it as a new item
- **They ask to promote an existing item** — suggest starting a new project from that item

### 2. Adding an item

Ensure `.mmpf/BACKLOG.md` exists. If not, create it with the header `# Backlog`.

Append the new item:
```markdown
- **<short title>**: <description and context>
```

Derive a short title from the user's input. Include enough context that the idea makes sense weeks later. If the user gave a terse description, ask one clarifying question to capture the "why" — but only one.

Confirm: "Added to backlog: <title>"

### 3. Listing items

Read `.mmpf/BACKLOG.md` and display the items. If the backlog is empty, say so and suggest the user can add items anytime by asking `mmpf-backlog` to save an idea.

### 4. Promoting an item

When the user wants to act on a backlog item:
- Confirm which item they mean
- Suggest using `mmpf-start` and present the backlog item's title and description so the user can use it as a starting point — but don't auto-invoke or skip the discussion step
- Remove the item from BACKLOG.md only after `mmpf-start` creates the project

## Notes

- The backlog persists across projects. It is not cleared by `mmpf-complete`.
- Items are simple — no priority, no categories, no IDs. Just ideas with context.
- If there's no `.mmpf/` directory at all, create it and BACKLOG.md.
