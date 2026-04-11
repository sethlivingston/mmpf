# CSD — Custom Software Development

A meta-prompting framework that fits my mental model and workflow: research freely, plan from knowledge, execute with discipline. Other meta-prompting frameworks don't give the research portion as much freedom and attention as I prefer.

## Commands

| Command | Description |
|---|---|
| `/csd-start` | Start a new project and enter freeform research mode |
| `/csd-plan` | Derive requirements from research and create a phased plan |
| `/csd-execute` | Execute a phase with atomic commits and TDD |
| `/csd-status` | Show current state and what to do next |
| `/csd-backlog` | Capture ideas for future work |
| `/csd-complete` | Archive the project and reset for the next one |

## Lifecycle

```
/csd-start → research & experiment freely
           → /csd-plan → derive requirements, create phases
           → /csd-execute → build phase by phase
           → /csd-complete → archive and reset

/csd-status  — where are we? (anytime, especially new sessions)
/csd-backlog — save an idea for later (anytime)
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
