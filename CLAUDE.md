# AI-Setup Plugin Marketplace

## Repo layout

This is a personal Claude Code plugin marketplace (name: `pedro-ai-setup`).

- `.claude-plugin/marketplace.json` — lists all plugins with metadata
- `plugins/<name>/` — each plugin directory contains:
  - `.claude-plugin/plugin.json` — plugin metadata and version
  - `commands/` — slash commands (optional)
  - `skills/<skill>/SKILL.md` — reusable skills (optional)
  - `agents/` — custom agents (optional)
  - `hooks/hooks.json` — lifecycle hooks (optional)
  - `.mcp.json` — MCP servers (optional)

## Adding a plugin

`starter-kit` is the baseline plugin installed in every project. Put shared behavior (agents, skills, commands) there.

For a separate plugin:
1. Create `plugins/<name>/.claude-plugin/plugin.json` with the plugin's metadata
2. Add its commands/skills/agents folders
3. Add an entry to `.claude-plugin/marketplace.json`
4. Run `claude plugin validate .` to verify
5. Never bump `version` (in `plugin.json` or `marketplace.json`) unless the user explicitly asks

## Guarded scripts

- `plugins/starter-kit/scripts/install-codebase-memory-mcp.sh` installs an npm package globally and changes the user's Claude Code MCP config. Run it only after the user explicitly allows it in the current conversation. `.claude/settings.json` has an `ask` rule so every run needs approval.
- `plugins/starter-kit/scripts/install-archify.sh` installs the Archify skill into `~/.claude/skills/` with the npm `skills` CLI (via npx). The same rule applies: run it only after the user explicitly allows it in the current conversation. It is also covered by an `ask` rule.
- Install scripts install only through Node tooling (npm / npx packages). Never clone, download or build tools from source.
