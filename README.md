# MMPF — My Meta-Prompting Framework

A meta-prompting framework that fits my mental model and workflow: research freely, plan from knowledge, execute with discipline. Other meta-prompting frameworks do not give the research portion as much freedom and attention as I prefer.

## Runtime model

MMPF ships as a shared `skills/` tree that can be installed into:

- `~/.claude/skills` for Claude CLI
- `~/.copilot/skills` for GitHub Copilot CLI
- both runtimes at the same time

Claude and Copilot do **not** expose MMPF the same way:

- **Claude** uses literal `/mmpf-*` slash commands.
- **Copilot** uses installed skills. Use `/skills` commands to discover or refresh them, then invoke a skill by name in a prompt.

## MMPF skills

| Skill | Claude | Copilot |
| --- | --- | --- |
| `mmpf-start` | `/mmpf-start` | Use the `mmpf-start` skill in a prompt |
| `mmpf-research` | `/mmpf-research` | Use the `mmpf-research` skill in a prompt |
| `mmpf-plan` | `/mmpf-plan` | Use the `mmpf-plan` skill in a prompt |
| `mmpf-execute` | `/mmpf-execute` | Use the `mmpf-execute` skill in a prompt |
| `mmpf-status` | `/mmpf-status` | Use the `mmpf-status` skill in a prompt |
| `mmpf-backlog` | `/mmpf-backlog` | Use the `mmpf-backlog` skill in a prompt |
| `mmpf-complete` | `/mmpf-complete` | Use the `mmpf-complete` skill in a prompt |

## Lifecycle

### Claude

```text
/mmpf-start → research & experiment freely
           → /mmpf-research → investigate unknowns in parallel
           → /mmpf-plan → derive requirements, create phases
           → /mmpf-execute → build phase by phase
           → /mmpf-complete → archive and reset

/mmpf-status  — where are we? (anytime, especially new sessions)
/mmpf-backlog — save an idea for later (anytime)
```

### Copilot

Use the same workflow through skill names rather than custom slash commands:

```text
mmpf-start → research & experiment freely
           → mmpf-research → investigate unknowns in parallel
           → mmpf-plan → derive requirements, create phases
           → mmpf-execute → build phase by phase
           → mmpf-complete → archive and reset

mmpf-status  — where are we? (anytime, especially new sessions)
mmpf-backlog — save an idea for later (anytime)
```

## Install

### macOS / Linux

```bash
# Claude only
./install.sh claude

# Copilot only
./install.sh copilot

# Both runtimes
./install.sh both
```

If you omit the runtime argument, `install.sh` defaults to `both`.

### Windows (PowerShell)

```powershell
# Claude only
.\install.ps1 claude

# Copilot only
.\install.ps1 copilot

# Both runtimes
.\install.ps1 both
```

If you omit the runtime argument, `install.ps1` defaults to `both`.

### Install destinations

| Runtime | Destination |
| --- | --- |
| Claude CLI | `~/.claude/skills` |
| GitHub Copilot CLI | `~/.copilot/skills` |

The installers remove previously installed `mmpf-*` skill directories only from the selected destination, then copy the current skills and shared reference markdown into each installed skill.

## Usage

### Claude

Claude uses the installed slash commands directly:

```text
/mmpf-start
/mmpf-plan
/mmpf-execute
```

### Copilot

Copilot does not add custom `/mmpf-*` slash commands. Instead:

1. Use `/skills list` to confirm the MMPF skills are available.
2. Use `/skills info mmpf-start` to inspect a specific skill.
3. Use a named skill in a prompt.

Example:

```text
Use the mmpf-start skill to begin a new project and keep the discussion freeform.
```

## Verify and refresh an install

### Claude

- Confirm the skills were copied into `~/.claude/skills`.
- If Claude CLI was already running during install, start a new session before trying `/mmpf-start`.

### Copilot

- Confirm the skills were copied into `~/.copilot/skills`.
- In an active Copilot CLI session, run `/skills reload` after installing or updating skills.
- Run `/skills list` to verify the MMPF skills appear.
- Run `/skills info mmpf-start` if you want to inspect one skill in detail before using it.

## License

MIT
