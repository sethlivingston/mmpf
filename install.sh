#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"
SKILLS_DST="$HOME/.claude/skills"

if [ ! -d "$SKILLS_SRC" ]; then
  echo "Error: skills/ directory not found at $SKILLS_SRC"
  exit 1
fi

mkdir -p "$SKILLS_DST"

installed=0
for skill_dir in "$SKILLS_SRC"/csd-*; do
  skill_name="$(basename "$skill_dir")"
  target="$SKILLS_DST/$skill_name"

  rm -rf "$target"
  cp -r "$skill_dir" "$target"
  echo "  Installed $skill_name"
  installed=$((installed + 1))
done

echo ""
echo "Done. $installed CSD skills installed to $SKILLS_DST"
