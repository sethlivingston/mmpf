---
phase: 3
name: skill language
requirements: [SKILL-01, SKILL-02, SKILL-03]
depends_on: [1, 2]
---

# Phase 3: skill language

## Goal

The shared skill files remain a single source of truth while their wording accurately reflects cross-runtime support and any Claude-only affordances.

## Truths

- [ ] Shared skill files still live in the existing `skills/mmpf-*` directories with no duplicated Copilot-specific copies.
- [ ] Skill frontmatter descriptions and trigger text no longer imply that Copilot supports literal `/mmpf-*` commands.
- [ ] Any remaining command-specific wording in the skill bodies is either generalized to "use the skill" language or explicitly labeled as Claude-specific.
- [ ] Skill content that refers to session behavior uses runtime-neutral language unless a Claude-only distinction is intentional.

## Tasks

### Task 1: Audit and normalize skill frontmatter
Review all `skills/mmpf-*/SKILL.md` files and update descriptions, trigger text, and other high-signal wording that currently assumes universal slash-command support.

### Task 2: Normalize runtime references in skill bodies
Replace vague Claude-only phrasing with runtime-neutral language where possible, and make any intentionally Claude-specific instructions explicit.

### Task 3: Run a final consistency sweep
Check README, installers, and skill text together so naming, runtime labels, and invocation guidance all match the supported behavior.
