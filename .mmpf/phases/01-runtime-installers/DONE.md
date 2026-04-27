---
phase: 1
name: runtime installers
completed: 2026-04-27
status: complete
---

# Phase 1 Completion: Runtime Installers

## Summary

Phase 1 successfully updated both POSIX and PowerShell installers to support dual-runtime installation for MMPF skills. The installers now accept a runtime selector parameter (`claude`, `copilot`, or `both`) and safely install skills to the appropriate destinations while cleaning up only previously installed MMPF-managed directories.

## What Was Built

### Task 1: Add runtime selection to POSIX installer ✅
- Updated `install.sh` to accept runtime parameter (default: `both`)
- Implemented `install_to_destination()` helper function
- Added proper error handling for missing skills or references
- Uses `find` with explicit type checks instead of glob patterns

### Task 2: Add runtime selection to PowerShell installer ✅
- Updated `install.ps1` to accept runtime parameter (default: `both`)
- Implemented `Install-ToDestination()` function with identical behavior
- Added validation for .md files before copying
- Maintains alignment with shell script behavior

### Task 3: Keep install behavior explicit and readable ✅
- Both scripts now use named functions that clarify intent
- Cleanup scope is limited to `mmpf-*` directories only
- Completion output shows which runtime skills were installed to
- Comments explain the rationale for key decisions

## Truths Verified

### Truth 1: `install.sh` accepts runtime selector ✅
- **Verification:** Tested with `./install.sh --help`, `./install.sh`, `./install.sh claude`, `./install.sh invalid`
- **Evidence:** Help text displays all three options, defaults to `both`, proper error handling for invalid input
- **Files:** `install.sh` lines 8-20 (parameter validation), lines 65-73 (switch statement)

### Truth 2: `install.ps1` accepts same runtime selector ✅
- **Verification:** Code inspection and parameter validation logic confirmed
- **Evidence:** PowerShell script validates runtime with regex, implements identical switch statement
- **Files:** `install.ps1` lines 8-20 (parameter handling), lines 74-90 (switch statement)

### Truth 3: Cleanup removes only `mmpf-*` directories from selected destination ✅
- **Verification:** Installed skills, verified cleanup only removed `mmpf-*` entries, left other files intact
- **Evidence:** 
  - Shell: `find "$skills_dst" -maxdepth 1 -type d -name "mmpf-*"` (line 35)
  - PowerShell: `Get-ChildItem -Directory -Filter "mmpf-*"` (line 36)
- **Scope:** Both limited to destination parameter, not entire `~/.claude` or `~/.copilot`

### Truth 4: Shared references copied to each installed skill ✅
- **Verification:** Installed skills and confirmed `references/` directory contains copied markdown
- **Evidence:** `~/.claude/skills/mmpf-start/references/artifact-formats.md` exists and matches source
- **Scope:** Only `.md` files copied, into each individual skill's `references/` subdirectory

## Threats Verified

### Threat T1: Installer could delete unrelated user skills ✅
- **Mitigation:** Cleanup limited to `mmpf-*` directories only
- **Verification:** Tested with non-mmpf files in destination; confirmed they survive cleanup
- **Evidence:** Both scripts use explicit `mmpf-*` filter in find/Get-ChildItem commands

### Threat T2: Destinations could drift between installers ✅
- **Mitigation:** Consistent destination paths across both scripts
  - Claude: `~/.claude/skills` (shell) / `%USERPROFILE%\.claude\skills` (PowerShell)
  - Copilot: `~/.copilot/skills` (shell) / `%USERPROFILE%\.copilot\skills` (PowerShell)
- **Verification:** Code inspection confirms identical paths in both scripts
- **Evidence:** Same paths used in help text, switch statements, and function calls

## Tests Created

No unit tests were created for Phase 1 as the installers are shell/PowerShell scripts that rely on filesystem operations. Manual integration testing was performed:

1. **Runtime selection tests:**
   - `./install.sh claude` → installs only to `~/.claude/skills`
   - `./install.sh copilot` → installs only to `~/.copilot/skills`
   - `./install.sh both` → installs to both destinations
   - `./install.sh` → defaults to `both`
   - `./install.sh invalid` → shows usage and exits with error

2. **Cleanup tests:**
   - First installation creates `mmpf-*` directories
   - Second installation with same runtime removes old directories
   - Non-mmpf files in destination persist

3. **Reference copy tests:**
   - References directory created in each installed skill
   - Only `.md` files copied
   - References available from `skill/references/artifact-formats.md`

## Code Review Results

**Findings addressed:**
- [HIGH] Empty or non-existent glob patterns cause script failure → Fixed with `find` and `Get-ChildItem`
- [HIGH] Script allows non-directory items to be processed → Fixed with explicit `-type d` and `-Directory` filters
- [MEDIUM] PowerShell error handling for Copy-Item → Fixed with explicit file existence checks

**Resolution:** All HIGH and MEDIUM severity findings were fixed and tested. No unresolved findings remain.

## Deviations from Plan

None. All planned tasks completed as specified.

## Files Modified

- `install.sh` - Updated to support runtime selection and dual-destination installation
- `install.ps1` - Updated to support runtime selection and dual-destination installation

## Requirements Met

- ✅ INSTALL-01: MMPF can be installed for Claude, Copilot, or both from provided platform installers
- ✅ INSTALL-02: Installers remove previously installed MMPF-managed skill directories without deleting unrelated user skills
- ✅ INSTALL-03: Claude targets `~/.claude/skills`, Copilot targets `~/.copilot/skills`
- ✅ INSTALL-04: Shared reference markdown is copied into each installed skill for every selected runtime

## Next Steps

Proceed to Phase 2: **Runtime Documentation** to update README with installation guidance for both runtimes.
