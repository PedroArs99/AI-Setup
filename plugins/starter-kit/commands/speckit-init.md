---
description: Set up GitHub Spec Kit (Spec-Driven Development) in the current project for Claude Code
argument-hint: "[--preset <id>]"
disable-model-invocation: true
allowed-tools: Bash(specify version), Bash(specify init:*), Bash(git status:*), Bash(git diff:*), Bash(ls:*)
---

Initialize GitHub Spec Kit in the current project so the `/speckit-*` skills
are available in Claude Code. Extra arguments for `specify init`: `$ARGUMENTS`

1. Run `specify version`. If `specify` is not found, stop. Tell the user to
   install it with `plugins/starter-kit/scripts/install-spec-kit.sh` from the
   `pedro-ai-setup` marketplace repo (needs `uv`). **Never install Spec Kit
   yourself.**
2. If `.specify/` already exists, say Spec Kit is already set up here and stop.
   Upgrades are done with `specify integration upgrade claude`, which the user
   runs themselves.
3. Run `git status --porcelain`. If there are uncommitted changes, stop and ask
   the user to commit or stash first, so the generated files can be reviewed
   on their own.
4. From the repository root, run:
   - empty directory: `specify init --here --integration claude --script sh $ARGUMENTS`
   - non-empty directory: the same plus `--force`. It merges into existing
     files and may replace files at Spec Kit's managed paths, which is why
     step 3 needs a clean tree.
5. Show `git status --short` and summarize what was added (`.specify/`,
   `.claude/skills/speckit-*`). Don't commit.
6. Finish with the next steps:
   - `/speckit-constitution` with principles the project already follows
     (from its README, contributing guide and CI), not made-up ones.
   - Per feature: `/speckit-specify` → `/speckit-plan` → `/speckit-tasks` →
     `/speckit-implement` → `/speckit-converge`. Add `/speckit-clarify` and
     `/speckit-analyze` as quality gates when needed.
   - Optional extensions: `specify extension add git` (feature branches),
     `bug` (bug fixing) and `assess` (idea assessment).
