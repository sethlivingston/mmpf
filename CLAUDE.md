# CSD — Custom Software Development

A Claude Code skill framework for structured software development that follows a natural workflow: research freely, plan from knowledge, execute with discipline.

## Project Structure

```
skills/           # One folder per slash command, installed to ~/.claude/skills/
  csd-start/      # Start a new project, enter research mode
  csd-plan/       # Derive requirements from research, create phased plan
  csd-execute/    # Run a phase with traceability and atomic commits
  csd-status/     # Show current state and what's next
  csd-backlog/    # Capture ideas for later
  csd-complete/   # Archive project, reset for next
docs/             # Project documentation
install.sh        # Copies skills to ~/.claude/skills/
```

## Skill Format

Each skill follows the agentskills.io standard:
- `SKILL.md` with YAML frontmatter (`name`, `description`) + markdown body
- `references/` for supplementary docs loaded on demand
- `scripts/` for deterministic operations
- Folder name must match the `name` field in frontmatter (kebab-case)

## Runtime Artifacts

Skills read/write artifacts in `.csd/` within the target project:
- `STATE.md` — current project position and resumption info
- `RESEARCH.md` — accumulated findings from research phase
- `REQUIREMENTS.md` — requirements derived from research
- `BACKLOG.md` — ideas captured for future work
- `experiments/` — throwaway scripts and prototypes
- `phases/NN-name/PLAN.md` — tasks and verifiable truths per phase
- `phases/NN-name/DONE.md` — results and verification per phase

## Conventions

- Use conventional commits: `type[(scope)]: description`
- Skills are independent of GSD and any other framework
- Subagents use Sonnet or Haiku for research, review, and execution
- Unit tests are expected for code deliverables (TDD when the test-first heuristic applies)
- CLAUDE.md and /docs updates are a natural output of execution when appropriate
