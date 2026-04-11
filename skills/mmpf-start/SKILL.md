---
name: mmpf-start
description: >
  Start a new MMPF project and enter freeform research mode. Use when beginning
  a new initiative, feature, or investigation. Creates the .mmpf/ directory and
  STATE.md, then opens an unstructured research session where you explore,
  experiment, and accumulate findings. Trigger: "let's start a new project",
  "I want to research", "new mmpf project", "/mmpf-start".
---

# /mmpf-start — Start a New Project

Start a new MMPF project and enter freeform research mode.

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
├── RESEARCH.md
├── experiments/
└── phases/
```

Write `STATE.md` with:
- `project`: the short name
- `stage`: `research`
- `started`: today's date
- `updated`: today's date
- Current Focus: the project description
- Context: empty (nothing decided yet)
- Next Step: "Begin research — explore the problem space"

See `references/artifact-formats.md` for the full STATE.md format.

Write `RESEARCH.md` with the project name as the title and empty sections for Findings, Experiments, Open Questions, and Decisions.

### 4. Enter research mode

Tell the user: the project is set up and we're in research mode. Explain what this means:
- This is freeform — direct the research however you want
- Ask me to look things up, read docs, explore the codebase, or try experiments
- Findings accumulate in `.mmpf/RESEARCH.md`
- Experiments (scripts, pseudocode, prototypes) go in `.mmpf/experiments/`
- When you feel you understand the problem well enough, run `/mmpf-plan`

Then ask: "Where do you want to start?"

## Research Mode Behavior

While in research mode (STATE.md stage is `research`), follow these principles:

**Be freeform.** Do not impose structure on the research process. No "are you ready for the next area?" gates. No mandatory sections to fill out. The user directs.

**Use subagents.** Spawn Sonnet or Haiku subagents for:
- Deep dives into documentation or codebases
- Web searches for prior art, libraries, patterns
- Reading and summarizing long documents
- Exploring multiple approaches in parallel

This keeps the main conversation context clean and focused.

**Accumulate findings.** After each research activity, update `.mmpf/RESEARCH.md`:
- Add findings under relevant topic headings
- Tag confidence: [VERIFIED], [CITED], or [ASSUMED]
- Record experiment results with goal/approach/result/takeaway
- Capture decisions as they're made
- Note open questions

**Support experiments.** When the user wants to try something:
- Write scripts, pseudocode, or prototypes to `.mmpf/experiments/`
- These are throwaway — they exist to learn, not to ship
- Record what was learned in RESEARCH.md

**Check for existing solutions.** Before building anything from scratch, check:
- Does a library or tool already solve this?
- Is there a well-established pattern?
- What are others doing in this space?

**Keep STATE.md current.** Update the Current Focus and Context sections as the research evolves. A fresh session should be able to pick up where we left off.
