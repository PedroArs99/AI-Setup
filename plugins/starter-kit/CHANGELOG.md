# Changelog

All notable changes to the `starter-kit` plugin. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions follow
[Semantic Versioning](https://semver.org/). Releases are tagged
`starter-kit--v<version>`.

## [0.4.0] - 2026-10-04

### Added

- Impeccable (frontend design skill, commands and anti-pattern hooks) is now a
  plugin dependency. Installing `starter-kit` installs it too, so no per-project
  setup is needed. It's re-listed in the `pedro-ai-setup` marketplace from
  `pbakaus/impeccable`, pinned to release 4.5.0.

### Removed

- `scripts/install-impeccable.sh`, replaced by the dependency above.

## [0.3.0] - 2026-10-04

### Added

- `scripts/install-spec-kit.sh`: installs the GitHub Spec Kit CLI (`specify-cli`
  1.0.13) from PyPI with `uv`.
- `/starter-kit:speckit-init`: initializes Spec Kit with the Claude Code
  integration in the current project, on a clean git tree.
- `scripts/install-impeccable.sh`: installs Impeccable with its npm installer.

## [0.2.0] - 2026-10-01

### Added

- `code-explorer` agent: read-only Haiku subagent that prefers
  codebase-memory-mcp for structural queries and falls back to grep/glob.
- `scripts/install-codebase-memory-mcp.sh`: npm-based installer for
  codebase-memory-mcp.
- `archify-documenter` agent: writes documentation built around Archify
  diagrams.
- `scripts/install-archify.sh`: installs the Archify skill with the npm
  `skills` CLI.

### Changed

- `starter-kit` is now the baseline plugin installed in every project.

### Removed

- Placeholder `example-agent` agent and `hello` command.

## [0.1.0] - 2026-09-30

### Added

- Initial plugin scaffold with example agent, command and skill.

[0.4.0]: https://github.com/PedroArs99/AI-Setup/compare/starter-kit-v0.3.0...starter-kit--v0.4.0
[0.3.0]: https://github.com/PedroArs99/AI-Setup/compare/16be105...starter-kit-v0.3.0
[0.2.0]: https://github.com/PedroArs99/AI-Setup/compare/b5c9e7b...16be105
[0.1.0]: https://github.com/PedroArs99/AI-Setup/commit/b5c9e7b
