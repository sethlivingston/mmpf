---
project: copilot-cli support
stage: executing
phase: 1
started: 2026-04-27
updated: 2026-04-27
---

## Current Focus

Executing Phase 1: Add runtime selection to both `install.sh` and `install.ps1`. The installers will accept a runtime selector (claude, copilot, or both), resolve appropriate destinations, clean existing mmpf-* directories for the selected runtime(s), and copy the current skill tree with shared references.

## Context

The plan intentionally omits a Copilot `plugin.json` wrapper, marketplace publishing, and Copilot-specific agents. Claude keeps literal `/mmpf-*` command guidance, while Copilot support is documented through `~/.copilot/skills`, `/skills`, and skill-name prompts.

## Next Step

Task 1: Update install.sh with runtime selection and dual-destination support
