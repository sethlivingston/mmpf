# MMPF — My Meta-Prompting Framework

A meta-prompting framework that fits my mental model and workflow: research freely, plan from knowledge, execute with discipline. Other meta-prompting frameworks don't give the research portion as much freedom and attention as I prefer.

## Commands

| Command | Description |
|---|---|
| `/mmpf-start` | Start a new project and enter freeform research mode |
| `/mmpf-plan` | Derive requirements from research and create a phased plan |
| `/mmpf-execute` | Execute a phase with atomic commits and TDD |
| `/mmpf-status` | Show current state and what to do next |
| `/mmpf-backlog` | Capture ideas for future work |
| `/mmpf-complete` | Archive the project and reset for the next one |

## Lifecycle

```
/mmpf-start → research & experiment freely
           → /mmpf-plan → derive requirements, create phases
           → /mmpf-execute → build phase by phase
           → /mmpf-complete → archive and reset

/mmpf-status  — where are we? (anytime, especially new sessions)
/mmpf-backlog — save an idea for later (anytime)
```

## Install

```bash
# macOS / Linux
./install.sh

# Windows (PowerShell)
.\install.ps1
```

Copies all skills to `~/.claude/skills/`.

## License

MIT
