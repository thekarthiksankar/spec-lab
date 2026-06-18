#!/usr/bin/env bash
#
# link-skills.sh — make this repo's skills/ discoverable by Claude Code via
# symlink, so edits to the skills apply live (no copying/syncing).
#
# Usage:
#   ./link-skills.sh                  # whole-dir symlink: ~/.claude/skills -> ./skills
#   ./link-skills.sh --per-skill      # symlink each skill individually (coexist with other personal skills)
#   ./link-skills.sh --project        # target <repo>/.claude/skills instead of ~/.claude/skills
#   ./link-skills.sh --per-skill --project
#
# Repo-relative: resolves its own location, so it works on any fresh clone.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR/skills"

MODE="whole"
SCOPE_DIR="$HOME/.claude/skills"
for arg in "$@"; do
  case "$arg" in
    --per-skill) MODE="per" ;;
    --project)   SCOPE_DIR="$SCRIPT_DIR/.claude/skills" ;;
    -h|--help)   sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "unknown arg: $arg (try --help)" >&2; exit 1 ;;
  esac
done

if [[ ! -d "$SRC_DIR" ]]; then
  echo "ABORT: no skills dir at $SRC_DIR" >&2; exit 1
fi

# link <target_path> <source_path>
link() {
  local tgt="$1" src="$2"
  if [[ -e "$tgt" && ! -L "$tgt" ]]; then
    echo "ABORT: a real file/dir already exists at $tgt — remove it first." >&2
    exit 1
  fi
  ln -sfn "$src" "$tgt"
  echo "linked: $tgt -> $src"
}

if [[ "$MODE" == "whole" ]]; then
  mkdir -p "$(dirname "$SCOPE_DIR")"
  link "$SCOPE_DIR" "$SRC_DIR"
else
  mkdir -p "$SCOPE_DIR"
  for skill in "$SRC_DIR"/*/; do
    [[ -f "${skill}SKILL.md" ]] || continue
    link "$SCOPE_DIR/$(basename "$skill")" "${skill%/}"
  done
fi

echo "Done. Restart Claude Code / start a new session to load the skills."
