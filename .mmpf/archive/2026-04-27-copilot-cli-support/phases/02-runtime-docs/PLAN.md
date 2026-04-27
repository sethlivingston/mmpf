---
phase: 2
name: runtime docs
requirements: [DOC-01, DOC-02, DOC-03]
depends_on: [1]
---

# Phase 2: runtime docs

## Goal

The repository documentation tells users exactly how to install and invoke MMPF in Claude and Copilot without overstating Copilot command parity.

## Truths

- [ ] README shows manual install commands for Claude, Copilot, and both runtimes.
- [ ] README explains that Claude uses `/mmpf-*` commands while Copilot uses installed skills via `/skills` and skill-name prompts.
- [ ] README includes enough Copilot guidance for a user to verify that MMPF skills loaded successfully and refresh them inside an active CLI session.

## Tasks

### Task 1: Rewrite the install section around runtimes
Update `README.md` so installation is framed around Claude, Copilot, and both runtimes instead of a single Claude-only destination.

### Task 2: Document runtime-specific invocation
Add a concise usage section that distinguishes Claude slash commands from Copilot skill-driven usage, including the supported `/skills` workflow and a prompt example using a named skill.

### Task 3: Add troubleshooting and verification guidance
Document how to confirm skills are available after install, including reload behavior for Copilot and any equivalent Claude guidance that reduces confusion after switching runtimes.
