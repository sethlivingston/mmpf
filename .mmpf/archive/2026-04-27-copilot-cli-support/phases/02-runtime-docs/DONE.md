---
phase: 2
completed: 2026-04-27
commits: [1ee84de]
---

# Phase 2: Done

## What Was Built

`README.md` now documents MMPF as a dual-runtime skill set for Claude CLI and GitHub Copilot CLI. The install section covers runtime-specific commands for `claude`, `copilot`, and `both` on POSIX and PowerShell, the usage section separates Claude slash commands from Copilot skill-based prompting, and the verification section explains how to reload and inspect skills in an active Copilot session.

The README now also documents the full skill set, including `mmpf-research`, so the documented workflow matches what the installers actually copy.

## Truths Verified

- [x] README shows manual install commands for Claude, Copilot, and both runtimes — verified by direct inspection of `README.md` install examples for `./install.sh` and `.\install.ps1` covering all three runtime selectors.
- [x] README explains that Claude uses `/mmpf-*` commands while Copilot uses installed skills via `/skills` and skill-name prompts — verified by the runtime model and usage sections that explicitly separate Claude slash commands from Copilot `/skills` discovery and skill-name prompting.
- [x] README includes enough Copilot guidance for a user to verify that MMPF skills loaded successfully and refresh them inside an active CLI session — verified by the Copilot verification section documenting `~/.copilot/skills`, `/skills reload`, `/skills list`, and `/skills info mmpf-start`.

## Tests

No automated tests were added or changed because this phase only modified repository documentation.

Verification for this phase was done by:

- reading the updated README directly
- checking the documented install commands against the actual installer interfaces
- independently verifying the phase truths through a separate verification pass

## Code Review

- **High:** `mmpf-research` was missing from the README skill inventory even though it exists in `skills/` and is installed by the scripts. Fixed by adding it to the skills table and both lifecycle flows.
- **Medium:** the Copilot prompt example used `/mmpf-start`, which contradicted the rest of the README's skill-name guidance. Fixed by changing the example to `mmpf-start` without implying a Copilot slash command.

## Notes

No phase threats were defined in `02-runtime-docs/PLAN.md`, so there was no Threats Verified section for this phase.

Phase 3 is now unblocked and can normalize the remaining runtime-specific wording inside the shared skill files.
