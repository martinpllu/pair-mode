# Pair Mode

A portable agent skill for collaborative work. Pair Mode begins with the smallest useful shared plan, then works one approved step at a time across coding, investigation, and documentation.

The agent acts as the driver, keeps the plan current, explains each small step, waits for approval, and hands control back for review. Plan detail is adapted to the size, uncertainty, and risk of the task.

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
