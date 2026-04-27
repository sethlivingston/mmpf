---
phase: 1
name: runtime installers
requirements: [INSTALL-01, INSTALL-02, INSTALL-03, INSTALL-04]
depends_on: []
---

# Phase 1: runtime installers

## Goal

The MMPF installers can install skills for Claude, Copilot, or both, while safely replacing only previously installed MMPF skill directories for the selected runtime.

## Truths

- [ ] `install.sh` accepts a runtime selector for `claude`, `copilot`, or `both`.
- [ ] `install.ps1` accepts the same runtime selector and installs to the same runtime-specific destinations as `install.sh`.
- [ ] Running either installer removes previously installed `mmpf-*` directories only from the selected destination(s) before copying the current skills.
- [ ] Both installers copy shared reference markdown into each installed skill in every selected destination.

## Threats

- **T1**: An installer could delete unrelated user skills in the destination directory → limit cleanup to `mmpf-*` directories only.
- **T2**: Claude and Copilot destinations could drift between shell and PowerShell installers → keep destination mappings and runtime names aligned across both scripts.

## Tasks

### Task 1: Add runtime selection to the POSIX installer
Update `install.sh` so it accepts a runtime selector, resolves Claude and Copilot destinations, cleans existing installed `mmpf-*` directories for the selected runtime(s), and copies the current skill tree plus shared references.

### Task 2: Add runtime selection to the PowerShell installer
Update `install.ps1` with the same runtime selector behavior, cleanup rules, destination mappings, and reference-copy logic used in `install.sh`.

### Task 3: Keep install behavior explicit and readable
Add any small shared helper logic needed inside each installer so the runtime choices, cleanup scope, and completion output stay obvious to future maintainers.
