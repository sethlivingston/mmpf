# Requirements: copilot-cli support

## Requirements

### Installation

- **INSTALL-01**: MMPF can be installed manually for Claude CLI, GitHub Copilot CLI, or both from the provided platform installers.
- **INSTALL-02**: Each installer removes previously installed MMPF-managed skill directories for the selected runtime before copying new files, without deleting unrelated user skills.
- **INSTALL-03**: Claude installation continues to target `~/.claude/skills`, and Copilot installation targets the documented personal skill location `~/.copilot/skills`.
- **INSTALL-04**: Shared reference markdown is copied into each installed skill for every selected runtime.

### Documentation

- **DOC-01**: README documents manual installation for Claude, Copilot, and both runtimes on supported platforms.
- **DOC-02**: README clearly distinguishes Claude slash-command usage from Copilot skill-based usage and does not imply unsupported Copilot `/mmpf-*` slash commands.
- **DOC-03**: Documentation explains how Copilot users discover and reload installed MMPF skills.

### Skill Content

- **SKILL-01**: Shared MMPF skill content remains the single source of truth for both runtimes.
- **SKILL-02**: Skill descriptions and instructions use runtime-appropriate language, avoiding claims of universal Claude-style slash-command support.
- **SKILL-03**: Runtime-specific wording that remains in skill content is explicit about being Claude-only rather than implied to apply everywhere.

## Out of Scope

- Adding a Copilot `plugin.json` wrapper
- Publishing to any Copilot plugin marketplace
- Adding Copilot-specific custom agents, hooks, MCP servers, or instruction files
- Achieving literal custom `/mmpf-*` slash-command support in Copilot CLI
- Changing the `.mmpf/` artifact model or project workflow semantics
