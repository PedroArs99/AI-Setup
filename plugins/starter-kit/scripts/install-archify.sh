#!/usr/bin/env bash
# Installs the Archify diagram skill (https://github.com/tt-a1i/archify) for
# Claude Code at user scope (~/.claude/skills/archify). Installation goes only
# through Node tooling: the pinned `skills` CLI from npm, run with npx. Nothing
# is cloned, downloaded or built by hand.
# The archify-documenter agent preloads this skill.
#
# Agents must NOT run this script unless the user has explicitly allowed it.
#
# Usage: install-archify.sh
set -euo pipefail

SOURCE="tt-a1i/archify"
SKILLS_CLI="skills@1.7.0"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

command -v npx >/dev/null || { echo "npx not found; install Node.js 18+ first." >&2; exit 1; }
node_major="$(node -p 'process.versions.node.split(".")[0]')"
[[ "$node_major" -ge 18 ]] || { echo "Archify needs Node.js 18+, found $(node -v)." >&2; exit 1; }

echo "Installing the archify skill from ${SOURCE} for Claude Code (user scope)..."
npx -y "$SKILLS_CLI" add "$SOURCE" --skill archify --agent claude-code --global --copy --yes

cli="${HOME}/.claude/skills/archify/bin/archify.mjs"
[[ -f "$cli" ]] || { echo "Install finished but ${cli} was not found." >&2; exit 1; }
echo "Installed: ${cli}"
