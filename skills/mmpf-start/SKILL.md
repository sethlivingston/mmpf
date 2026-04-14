---
name: mmpf-start
description: >
  Start a new MMPF project and enter a freeform discussion. Use when beginning
  a new initiative, feature, or investigation. Creates the .mmpf/ directory and
  STATE.md, then opens a conversation to explore the problem space and narrow
  scope. Trigger: "let's start a new project", "new mmpf project", "/mmpf-start".
---

# /mmpf-start — Start a New Project

Start a new MMPF project and open a freeform discussion.

## Steps

### 1. Check for existing project

Read `.mmpf/STATE.md`. If it exists and `stage` is not `complete`:
- Tell the user there's an active project and show its name and stage
- Ask if they want to `/mmpf-complete` it first or abandon it
- Do not proceed until resolved

### 2. Get project name

Ask the user: "What are we working on?" Accept a short name and a brief description. Keep it conversational — one question, not a form.

### 3. Initialize .mmpf/ directory

Create the directory structure:

```
.mmpf/
├── STATE.md
└── phases/
```

Write `STATE.md` with:
- `project`: the short name
- `stage`: `discussion`
- `started`: today's date
- `updated`: today's date
- Current Focus: the project description
- Context: empty (nothing decided yet)
- Next Step: "Discuss the problem space and decide on approach"

See `references/artifact-formats.md` for the full STATE.md format.

### 4. Enter discussion mode

Tell the user: the project is set up and we're in discussion mode. Explain what this means:
- This is freeform — talk through the problem, explore ideas, surface assumptions
- The goal is to get clear enough on the problem that we can decide what's next
- When ready, the next step is either:
  - `/mmpf-research` — if there are unknowns to investigate (new domain, unfamiliar codebase, multiple viable approaches)
  - `/mmpf-plan` — if we already know enough to plan (familiar territory, clear requirements)

Then ask: "What are you thinking?"

## Discussion Mode Behavior

While in discussion mode (STATE.md stage is `discussion`), follow these principles:

**Be conversational.** This is a thinking-together session. Ask clarifying questions, push back on assumptions, suggest angles the user may not have considered. No forms, no checklists, no gates.

**Help narrow scope.** The discussion should trend toward clarity:
- What problem are we solving and for whom?
- What does "done" look like?
- What do we already know vs. what do we need to learn?
- Are there constraints (time, tech, compatibility) that shape the approach?

**Don't record obsessively.** STATE.md should have enough context that a fresh session isn't totally lost, but the conversation itself is the primary artifact here. Update STATE.md's Current Focus and Context sections when something significant crystallizes — not after every exchange.

**Surface gray areas before moving on.** When the discussion feels like it's converging, pause and identify what's still ambiguous — decisions that could go multiple ways and would change the shape of the work. These aren't generic categories ("UI? UX?") but concrete choices that emerged from the conversation: "We talked about auth but didn't settle on session tokens vs JWTs", "The import feature could be sync or async — that affects the whole architecture."

To find gray areas:
- Review the conversation for decisions that were discussed but not resolved
- Check if the codebase has existing patterns that constrain or inform those decisions (if applicable)
- Skip anything the user already locked down during discussion

If there are unresolved gray areas, surface them conversationally: "Before we move on, I think there are a few things still open: ..." Then resolve them through continued discussion. Don't present a numbered form — just talk through them. If there are none, move on.

**Recognize the decision point.** When the discussion has narrowed enough and gray areas are resolved, surface the choice explicitly: "It sounds like we're ready to plan — or is there research you want to do first?" Help the user distinguish between:
- Things we need to *learn* (→ `/mmpf-research`) — unknowns that would change the plan
- Things we need to *decide* (→ keep discussing) — choices between known options
- Things we already know (→ `/mmpf-plan`) — ready to commit to requirements and phases
