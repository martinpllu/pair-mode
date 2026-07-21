# Pair Mode

A portable agent skill for collaborative pair programming. The agent works as the driver, explains one small step at a time, waits for approval, implements only that step, and hands control back for review.

## Quick start

### Claude Code

Install the skill for your user account:

```sh
mkdir -p ~/.claude/skills
git clone https://github.com/martinpllu/pair-mode.git ~/.claude/skills/pair-mode
```

Start Claude Code and invoke the skill with `/pair-mode`. Restart Claude Code if the skill directory did not already exist when your session started.

### Codex

Install the skill for your user account:

```sh
mkdir -p ~/.agents/skills
git clone https://github.com/martinpllu/pair-mode.git ~/.agents/skills/pair-mode
```

Start Codex and invoke the skill with `$pair-mode`. Restart Codex if the skill does not appear immediately.
