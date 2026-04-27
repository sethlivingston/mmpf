# Copilot Instructions

## Commands

- Install skills on macOS/Linux: `./install.sh claude|copilot|both`
- Install skills on Windows PowerShell: `./install.ps1 claude|copilot|both`
- After changing skills for Copilot, refresh and inspect them from the CLI with `/skills reload`, `/skills list`, and `/skills info mmpf-start`
- This repository does not define a build, lint, or automated test suite, so there is no full-suite or single-test command to run

## High-level architecture

- `skills/mmpf-*` is the source of truth. Each skill is a self-contained package with a `SKILL.md` file, and some skills add skill-local `references/`.
- Top-level `references/` holds shared markdown that the installers copy into every installed skill's `references/` directory.
- `install.sh` and `install.ps1` are parallel implementations of the same install flow: validate the runtime selector, remove existing `mmpf-*` directories only from the selected destination, copy current skills, then copy shared references into each installed skill.
- The framework's behavior is distributed across the skill docs rather than a single program entrypoint:
  - `mmpf-start` initializes `.mmpf/STATE.md` and discussion mode
  - `mmpf-research` writes `.mmpf/RESEARCH.md`
  - `mmpf-plan` writes `.mmpf/REQUIREMENTS.md` and `.mmpf/phases/NN-name/PLAN.md`
  - `mmpf-execute` consumes those artifacts and writes `.mmpf/phases/NN-name/DONE.md`
  - `mmpf-status`, `mmpf-backlog`, and `mmpf-complete` inspect or update the same artifact set
- Runtime behavior intentionally differs by target: Claude uses `/mmpf-*` slash commands after install, while Copilot uses the installed skill names from `~/.copilot/skills`.

## Key conventions

- Skill directory names must match the `name:` field in `SKILL.md` frontmatter and remain `mmpf-*`; the installers discover skills by directory name, not by scanning arbitrary folders.
- Keep `install.sh` and `install.ps1` behaviorally aligned. If installation semantics change in one, make the equivalent change in the other.
- Keep shared reference material in top-level `references/` when it should ship with every skill. Reserve `skills/<skill>/references/` for skill-specific material only.
- Artifact formats in `references/artifact-formats.md` are part of the framework contract. Future edits should preserve:
  - category-based requirement IDs like `AUTH-01`
  - per-phase plans under `.mmpf/phases/NN-name/PLAN.md`
  - optional `## Threats` sections only for security-relevant phases
  - `DONE.md` as the place where truths and threats are independently verified
- The skills are intentionally conversational rather than form-driven. Multiple skill docs explicitly say to avoid rigid questionnaires and instead work through discussion in freeform prose.
- The workflow is evidence-oriented across files: research findings are tagged `[VERIFIED]`, `[CITED]`, or `[ASSUMED]`; plans define verifiable "truths"; execution and completion verify those truths and any threat mitigations.
- `README.md` and `CLAUDE.md` both document the runtime model. If you change how skills are installed, discovered, or invoked, update those docs alongside the affected skill files.
- Treat `.mmpf/archive/` as historical artifacts and examples, not the source of truth for current framework behavior.
