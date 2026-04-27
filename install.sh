#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"
SHARED_REFS="$SCRIPT_DIR/references"

RUNTIME="${1:-both}"
case "$RUNTIME" in
  claude|copilot|both)
    ;;
  *)
    echo "Usage: $0 [claude|copilot|both]"
    echo ""
    echo "  claude   Install to ~/.claude/skills only"
    echo "  copilot  Install to ~/.copilot/skills only"
    echo "  both     Install to both ~/.claude/skills and ~/.copilot/skills (default)"
    exit 1
    ;;
esac

if [ ! -d "$SKILLS_SRC" ]; then
  echo "Error: skills/ directory not found at $SKILLS_SRC"
  exit 1
fi

install_to_destination() {
  local dest_name="$1"
  local skills_dst="$2"

  mkdir -p "$skills_dst"

  # Clean up existing mmpf-* directories for this runtime only
  for existing_skill in "$skills_dst"/mmpf-*; do
    [ -d "$existing_skill" ] && rm -rf "$existing_skill"
  done

  local installed=0
  for skill_dir in "$SKILLS_SRC"/mmpf-*; do
    skill_name="$(basename "$skill_dir")"
    target="$skills_dst/$skill_name"

    cp -r "$skill_dir" "$target"

    # Copy shared references into each installed skill
    if [ -d "$SHARED_REFS" ]; then
      mkdir -p "$target/references"
      cp "$SHARED_REFS"/*.md "$target/references/"
    fi

    echo "  Installed $skill_name to $dest_name"
    installed=$((installed + 1))
  done

  echo "Done. $installed MMPF skills installed to $skills_dst"
}

echo "Installing MMPF skills to runtime: $RUNTIME"
echo ""

case "$RUNTIME" in
  claude)
    install_to_destination "Claude" "$HOME/.claude/skills"
    ;;
  copilot)
    install_to_destination "Copilot" "$HOME/.copilot/skills"
    ;;
  both)
    install_to_destination "Claude" "$HOME/.claude/skills"
    echo ""
    install_to_destination "Copilot" "$HOME/.copilot/skills"
    ;;
esac
