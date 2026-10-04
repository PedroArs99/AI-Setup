#!/usr/bin/env bash
# Installs the GitHub Spec Kit CLI (`specify`, https://github.com/github/spec-kit)
# from PyPI as a uv tool. Installation goes only through the published
# `specify-cli` package; nothing is cloned, downloaded or built by hand.
# The /starter-kit:speckit-init command uses this CLI.
#
# Agents must NOT run this script unless the user has explicitly allowed it.
#
# Usage: install-spec-kit.sh [--version X.Y.Z] [--force]
#   --version  PyPI version of specify-cli to install (default: pinned below)
#   --force    reinstall even if specify-cli is already installed
set -euo pipefail

PACKAGE="specify-cli"
VERSION="1.0.13"
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version) VERSION="$2"; shift 2 ;;
    --force) FORCE=1; shift ;;
    -h|--help) sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

command -v uv >/dev/null || { echo "uv not found; install it first: https://docs.astral.sh/uv/" >&2; exit 1; }

args=(tool install --python ">=3.11")
[[ "$FORCE" -eq 1 ]] && args+=(--force)

echo "Installing ${PACKAGE}==${VERSION} from PyPI with uv..."
uv "${args[@]}" "${PACKAGE}==${VERSION}"

command -v specify >/dev/null || { echo "Installed, but 'specify' is not on PATH. Run 'uv tool update-shell'." >&2; exit 1; }
specify version
