#!/usr/bin/env bash
# Installs the Impeccable frontend-design skill (https://github.com/pbakaus/impeccable)
# for Claude Code with its official npm installer (`npx impeccable install`).
# Installation goes only through the pinned npm package; nothing is cloned,
# downloaded or built by hand. The package fetches its own engine binary into
# ~/.impeccable/bin/ on first run.
#
# Agents must NOT run this script unless the user has explicitly allowed it.
#
# Usage: install-impeccable.sh [--scope global|project] [--no-hooks] [--force]
#   --scope     global: ~/.claude/skills (default); project: run from the project root
#   --no-hooks  skip Impeccable's design-detector hook for the current project
#   --force     replace an existing Impeccable installation
set -euo pipefail

PACKAGE="impeccable@4.1.0"
SCOPE="global"
extra=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --scope) SCOPE="$2"; shift 2 ;;
    --no-hooks|--force) extra+=("$1"); shift ;;
    -h|--help) sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

[[ "$SCOPE" == "global" || "$SCOPE" == "project" ]] || { echo "--scope must be global or project." >&2; exit 1; }
command -v npx >/dev/null || { echo "npx not found; install Node.js 18+ first." >&2; exit 1; }

echo "Installing ${PACKAGE} for Claude Code (${SCOPE} scope)..."
npx -y "$PACKAGE" install --providers=claude --scope="$SCOPE" --yes ${extra[@]+"${extra[@]}"}
echo "Done. Reload Claude Code, then run '/impeccable init' in your project."
