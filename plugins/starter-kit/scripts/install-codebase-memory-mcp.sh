#!/usr/bin/env bash
# Installs codebase-memory-mcp globally with npm and registers it with Claude
# Code at user scope under the name the code-explorer agent expects.
# The npm package's postinstall downloads the release binary from GitHub and
# verifies its SHA-256 checksum.
#
# Agents must NOT run this script unless the user has explicitly allowed it.
#
# Usage: install-codebase-memory-mcp.sh [--version X.Y.Z] [--no-register] [--force]
#   --version      npm version to install (default: latest)
#   --no-register  skip `claude mcp add`
#   --force        replace an existing 'codebase-memory-mcp' MCP registration
set -euo pipefail

NAME="codebase-memory-mcp"
VERSION="latest"
REGISTER=1
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version) VERSION="$2"; shift 2 ;;
    --no-register) REGISTER=0; shift ;;
    --force) FORCE=1; shift ;;
    -h|--help) sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

command -v npm >/dev/null || { echo "npm not found; install Node.js first." >&2; exit 1; }

echo "Installing ${NAME}@${VERSION} globally with npm..."
npm install -g "${NAME}@${VERSION}"

bin_path="$(npm prefix -g)/bin/${NAME}"
[[ -x "$bin_path" ]] || { echo "Expected binary not found at ${bin_path}" >&2; exit 1; }
echo "Installed ${bin_path} ($("$bin_path" --version 2>/dev/null || echo 'version unknown'))"

[[ "$REGISTER" -eq 1 ]] || exit 0

if ! command -v claude >/dev/null; then
  echo "claude CLI not found; skipping MCP registration." >&2
  exit 0
fi

if claude mcp get "$NAME" >/dev/null 2>&1; then
  if [[ "$FORCE" -eq 0 ]]; then
    echo "MCP server '${NAME}' is already registered; leaving it unchanged (use --force to replace)."
    exit 0
  fi
  claude mcp remove --scope user "$NAME"
fi

# Register the absolute path: the global npm bin dir (e.g. under nvm) may not be
# on the PATH Claude Code starts MCP servers with. After switching Node
# versions, re-run this script with --force.
claude mcp add --scope user "$NAME" -- "$bin_path"
echo "Registered '${NAME}' with Claude Code (user scope)."
