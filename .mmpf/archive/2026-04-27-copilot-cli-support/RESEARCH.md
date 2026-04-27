# Research: copilot-cli support

## Summary

GitHub Copilot CLI does **not** document a way to register custom slash commands like `/mmpf-start`. Its slash command surface is built-in, while custom capability is exposed through **skills**, **agents**, **plugins**, and instruction files. That means MMPF should not promise Claude-style `/mmpf-*` parity in Copilot. Instead, Copilot usage should rely on `/skills`, natural-language references to skill names, and possibly agents later if they add value. [VERIFIED]

The biggest surprise is that Copilot does **not** require a plugin wrapper just to load personal skills. Official docs say personal skills can live directly in `~/.copilot/skills`, and project skills can live in `.github/skills`, `.claude/skills`, or `.agents/skills`. A local plugin with `plugin.json` is still a supported manual-install path, but it is optional for MMPF v1 unless we want bundled agents, hooks, MCP, or other plugin-only components. [VERIFIED]

The current MMPF repo is mostly reusable as-is. The core `.mmpf/` artifact model, reference docs, and most skill logic are runtime-agnostic. The main Claude-specific pieces are the installer destinations, the universal `/mmpf-*` wording, and a few Claude-flavored references in skill text. The plan should therefore bias toward a shared `skills/` source tree, dual install targets (`~/.claude/skills` and `~/.copilot/skills`), cleanup-first installers, and README guidance that clearly distinguishes Claude command usage from Copilot skill usage. [VERIFIED]

## Findings

### API and interface research: official Copilot surfaces

- [VERIFIED] Copilot CLI exposes a fixed built-in slash-command set such as `/skills`, `/agent`, `/plugin`, `/instructions`, `/env`, and `/help`. The official command reference does not document any mechanism for third-party skills or plugins to add custom slash commands like `/mmpf-start`.  
  Source: `https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-command-reference`

- [VERIFIED] Copilot skills can be used by naming the skill in a prompt with a leading slash, for example `Use the /frontend-design skill ...`, but this is documented as **prompting Copilot to use a named skill**, not as registering a new slash command.  
  Source: `https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-skills`

- [VERIFIED] Copilot provides skill management commands including `/skills list`, `/skills info`, `/skills reload`, `/skills add`, and `/skills remove`. This is the documented discovery and management surface for skills.  
  Source: `https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-skills`

- [VERIFIED] Copilot supports custom agents and local plugins, but those are surfaced through `/agent`, `/plugin`, and command-line flags like `copilot --agent=...`, not as custom slash commands.  
  Sources: `https://docs.github.com/en/copilot/how-tos/use-copilot-agents/use-copilot-cli`, `https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-plugin-reference`

### API and interface research: skills versus plugins

- [VERIFIED] Personal Copilot skills can live directly in `~/.copilot/skills` or `~/.agents/skills`. Project-specific skills can live in `.github/skills`, `.claude/skills`, or `.agents/skills` inside a repository. This means MMPF can support Copilot by copying skills directly into a documented personal skill location.  
  Source: `https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-skills`

- [VERIFIED] Plugins are also a supported manual-install path. `copilot plugin install` accepts a local directory, GitHub repo, Git URL, or marketplace reference. A plugin must contain a `plugin.json` manifest at its root.  
  Source: `https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-plugin-reference`

- [VERIFIED] `plugin.json` supports `skills`, `agents`, `commands`, `hooks`, `mcpServers`, and `lspServers` component fields. However, the plugin reference documents the existence of a `commands` path field without documenting a way for plugin commands to appear as new interactive slash commands.  
  Source: `https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-plugin-reference`

- [CITED] Because Copilot already supports direct skill directories, a plugin wrapper is best treated as an **optional packaging layer** for MMPF rather than a hard requirement for the first Copilot-compatible release. It becomes more attractive if MMPF later wants bundled agents, hooks, or MCP integration.  
  Sources: official skill and plugin docs above

### Codebase analysis: current MMPF assumptions

- [VERIFIED] The current installers are Claude-only. `install.sh` copies skills to `~/.claude/skills`, and `install.ps1` uses the equivalent `.claude\\skills` destination on Windows.  
  Sources: `install.sh`, `install.ps1`

- [VERIFIED] README install docs currently state that installation copies all skills to `~/.claude/skills/`, which is now incomplete for a dual-runtime design.  
  Source: `README.md`

- [VERIFIED] The `.mmpf/` artifact formats are runtime-agnostic. `STATE.md`, `RESEARCH.md`, `REQUIREMENTS.md`, per-phase `PLAN.md`, and `DONE.md` are all plain Markdown/YAML artifacts and do not depend on Claude-specific features.  
  Source: `references/artifact-formats.md`

- [VERIFIED] The current skill content is mostly reusable for Copilot. The main repo-level changes needed are wording and invocation assumptions: the skills commonly describe `/mmpf-*` commands as if they were universal, and at least one skill refers to a "fresh Claude session" rather than a generic new session.  
  Sources: `skills/mmpf-*/SKILL.md`

### Risk and pitfalls

- [VERIFIED] MMPF should not promise literal `/mmpf-*` command support in Copilot. The official docs support skill invocation and management, but not third-party slash-command registration. README guidance should explicitly distinguish:
  - **Claude**: `/mmpf-start`, `/mmpf-plan`, etc.
  - **Copilot**: install skills, use `/skills list`, `/skills info`, `/skills reload`, or mention skill names in prompts
  Sources: official command and skills docs above

- [VERIFIED] Cleanup-first installation is compatible with both runtimes. For Claude, it means removing existing `mmpf-*` skill directories from `~/.claude/skills`; for Copilot, removing existing `mmpf-*` directories from `~/.copilot/skills` before copying the new versions.  
  Sources: current installer behavior plus official personal skill directory docs

- [ASSUMED] A shared `skills/` tree remains the right source of truth, but some skill descriptions may need light edits so Copilot users are not told to use unsupported literal slash commands. The most likely pattern is to keep skill names like `mmpf-start` while changing text from "run `/mmpf-start`" to "use the `mmpf-start` skill" where universal phrasing is needed.  
  Basis: current MMPF skill wording plus Copilot skill docs

## Open Questions

- Should MMPF v1 for Copilot stop at direct skill installation into `~/.copilot/skills`, or should it also ship an optional `plugin.json` wrapper now for future extensibility?
- Do any MMPF workflows benefit enough from Copilot custom agents to justify adding `~/.copilot/agents` or plugin-provided agents in the first pass?
- Should MMPF keep Claude-first wording inside the skill bodies where the commands are genuinely Claude-specific, or normalize all skill text to cross-runtime language?

## Decisions

- Use the official Copilot skill surface as the minimum supported integration path. [VERIFIED]
- Do not promise custom Copilot slash commands such as `/mmpf-start`. [VERIFIED]
- Keep `skills/` as the shared source of truth and adapt installer/docs around it. [VERIFIED]
- Treat `plugin.json` as optional for v1, not mandatory. [CITED]
