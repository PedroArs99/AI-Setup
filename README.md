# AI-Setup

Personal [Claude Code plugin marketplace](https://docs.claude.com/en/docs/claude-code/plugin-marketplaces)
for my AI tooling: slash commands, skills, subagents, hooks and MCP servers.

## Install

```sh
# from a local clone
/plugin marketplace add ~/repos/AI-Setup
# or from GitHub, once pushed
/plugin marketplace add <github-user>/AI-Setup

/plugin install starter-kit@pedro-ai-setup
```

## Layout

```
.claude-plugin/
  marketplace.json          # marketplace catalog: lists every plugin
plugins/
  <plugin-name>/
    .claude-plugin/
      plugin.json           # plugin manifest (name, version, author…)
    commands/*.md           # slash commands  → /<plugin-name>:<command>
    skills/<skill>/SKILL.md # model-invoked skills
    agents/*.md             # subagents
    hooks/hooks.json        # optional: event hooks
    .mcp.json               # optional: MCP servers
```

## Adding a plugin

1. `cp -r plugins/starter-kit plugins/<new-plugin>`
2. Update `plugins/<new-plugin>/.claude-plugin/plugin.json`.
3. Add an entry to `plugins` in `.claude-plugin/marketplace.json`.
4. Validate: `claude plugin validate .`
5. Refresh locally: `/plugin marketplace update pedro-ai-setup`

Bump `version` in both `plugin.json` and `marketplace.json` when releasing changes.
