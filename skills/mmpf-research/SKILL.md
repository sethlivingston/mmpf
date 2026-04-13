---
name: mmpf-research
description: >
  Investigate unknowns identified during discussion. Selects research strategies
  based on discussion context, runs parallel subagents, and produces RESEARCH.md
  with a summary and detailed findings. Trigger: "let's research", "investigate",
  "I need to learn more", "/mmpf-research".
---

# /mmpf-research — Investigate Unknowns

Run focused research using parallel subagents, then compile findings into RESEARCH.md.

## Prerequisites

- `.mmpf/STATE.md` must exist

## Steps

### 1. Identify what we need to learn

Read `.mmpf/STATE.md` and the current conversation context from the discussion.

List the open questions — things we don't know that would change the plan. Be specific: "How does the existing auth middleware handle sessions?" not "Research auth."

Present the questions to the user: "Here's what I think we need to investigate. What would you add or change?"

### 2. Select research strategies

Choose 2-4 strategies from the menu below based on the open questions. Each strategy becomes a parallel subagent with a focused mandate. Not every project needs every strategy — pick only what the questions demand.

**Strategy menu:**

- **Domain exploration** — Survey the problem space: prior art, existing solutions, established patterns, community conventions. Use when entering unfamiliar territory or when "has someone solved this already?" is an open question.

- **Codebase analysis** — Examine existing code in the areas we'll touch: current patterns, dependencies, test coverage, module boundaries, potential friction points. Use when modifying or extending an existing system.

- **Technology evaluation** — Assess candidate tools, libraries, or approaches: capabilities, trade-offs, version compatibility, maintenance health, community adoption. Use when there's a "which tool?" decision to make.

- **Architecture survey** — Explore structural options: component boundaries, data flow, integration points, scaling characteristics. Use when the shape of the solution is unclear.

- **Risk and pitfalls** — Identify what commonly goes wrong with this kind of work: migration hazards, breaking changes, performance traps, security concerns, "looks done but isn't" patterns. Use when the project involves integration, migration, or unfamiliar infrastructure.

- **API and interface research** — Read the actual docs for external APIs, protocols, file formats, or services we'll integrate with: endpoints, authentication, rate limits, data shapes, error handling. Use when the project depends on external contracts.

Tell the user which strategies you've selected and why. Map each open question to the strategy that will answer it. Adjust if the user disagrees.

### 3. Run research subagents

For each selected strategy, spawn a subagent (Sonnet by default; Haiku is fine for straightforward lookups like reading API docs). Run all subagents in parallel.

Each subagent receives:
- The strategy name and description
- The specific questions it should answer
- Relevant context (project description, file paths, prior decisions from STATE.md)
- Instructions to be prescriptive ("Use X because Y" not "Consider X or Y")
- Instructions to tag confidence: [VERIFIED] (confirmed by docs/tests/code), [CITED] (from credible source, not independently verified), [ASSUMED] (reasonable belief, not yet confirmed)

Each subagent returns its findings as structured text — not a file write. The orchestrator (this skill) compiles the results.

### 4. Compile RESEARCH.md

After all subagents complete, write `.mmpf/RESEARCH.md` with this structure:

```markdown
# Research: <project name>

## Summary

<2-3 paragraphs synthesizing the key findings across all strategies. What did we learn? What's the recommended approach? What risks should the plan account for?>

## Findings

### <Strategy: Topic>
<Findings from this strategy, organized by subtopic>
<Each finding tagged [VERIFIED], [CITED], or [ASSUMED]>

### <Strategy: Topic>
...

## Open Questions

- <Things still unknown after research, if any>

## Decisions

- <Choices made or recommended based on findings>
```

See `references/artifact-formats.md` for the full RESEARCH.md format.

Present a brief summary of findings to the user. Highlight anything surprising or anything that changes the shape of the project from what was discussed.

### 5. Update state

Update `.mmpf/STATE.md`:
- `stage`: `research`
- `updated`: today's date
- Current Focus: summary of what was learned
- Next Step: "Run `/mmpf-plan` to create a plan from these findings"

## Principles

- **Questions drive research.** Every subagent should be answering specific questions from the discussion, not exploring aimlessly.
- **Parallel by default.** Strategies are independent — run them concurrently.
- **Prescriptive, not exploratory.** Researchers should recommend, not enumerate options. "Use X because Y" beats "you could use X, Y, or Z."
- **Confidence matters.** Tag everything. Unverified assumptions that slip into the plan are where projects go wrong.
- **Don't over-research.** If a question can be answered in 30 seconds by reading a file, it doesn't need a research strategy. The discussion may have already resolved some questions — only research what's genuinely unknown.
