# Pair Mode

> Build with AI without losing the plot.

Pair Mode is a skill that makes working with a coding agent feel more like pair programming. It keeps you in the loop as the agent works in small steps, so you can understand the decisions and steer when necessary.

Read the [Pair Mode skill](SKILL.md).

## Why pair mode?

Agentic development is great, but delegating large tasks can create *[cognitive debt](https://margaretstorey.com/blog/2026/02/09/cognitive-debt/)*: the code changes faster than your understanding of it. Even with up-front planning and careful code review, it can be hard to piece together how the solution took shape.

An agent can also make a bad decision because it is missing context or focusing too narrowly on the immediate goal. That can be hard to spot once the decision is buried in a large change.

Pair Mode avoids both problems by keeping the steps small. You can follow how the code takes shape and step in before the agent gets too far.

Pair Mode slows the development process down and can use more tokens than full delegation of big tasks. However, you might reach for it when changing particularly important code, learning an unfamiliar part of the stack, exploring a new feature or simply wanting to take part in the reasoning.

An example exchange:

```text
Agent: The basic animation loop is now in place in ui.ts, and I've started the
       development server on http://localhost:1234. You should see the grid
       updating in the browser. Does that look right?

You:   Yes

Agent: Good. I noticed `requestAnimationFrame` in ui.ts line 89
       is firing at 120 Hz on this display. Because we advance the
       simulation on every frame, its speed depends on the monitor's
       refresh rate.

       I propose keeping `requestAnimationFrame` for rendering, but
       advancing the simulation at a fixed rate of 10 generations per
       second. Sound good?

You:   Yes. Put the rate into a named default so we can add a speed slider
       later.
```

## Quick start

### Claude Code

```sh
mkdir -p ~/.claude/skills
git clone https://github.com/martinpllu/pair-mode.git ~/.claude/skills/pair-mode
```

Restart Claude Code and invoke the skill with `/pair-mode`.

### Codex

```sh
mkdir -p ~/.agents/skills
git clone https://github.com/martinpllu/pair-mode.git ~/.agents/skills/pair-mode
```

Restart Codex and invoke the skill with `$pair-mode`.

## How it works

In Pair Mode, the agent:

1. Explains one small proposed step and the problem it will solve
2. Presents meaningful alternatives and trade-offs
3. Waits for you to approve or redirect the step
4. Performs only the agreed work
5. Reports what changed, then repeats

The agent still uses the tools and writes the code. You guide the work, with regular chances to ask questions or change direction.

In a Git repository, each approved step is staged before the next one begins. The current step remains unstaged. This makes the Git index a shared checkpoint: the staged diff holds the work agreed so far, while the unstaged diff shows only the current step. Pair Mode never commits.

When the work has a visible result, such as a web page or GUI, the running app becomes another shared screen. The agent starts the development server and keeps the app up to date. After each visible change, it tells you what to look for, so you can see the new behaviour for yourself.

## Why staying involved matters

Rules, skills and documentation can guide an agent, but they can't make every decision in advance. The agent still has to interpret them and make choices as it works. Pair Mode lets you give the agent more context or change direction before it gets too far.

A detailed plan can help you agree on an approach before implementation. But a plan can't include everything you will discover by writing the code. *Shape Up* describes this difference as [imagined tasks and discovered tasks](https://basecamp.com/shapeup/3.1-chapter-10#imagined-vs-discovered-tasks): the work you expect and the work that only becomes clear once you begin. Pair Mode keeps you involved as the real constraints, trade-offs and shape of the solution emerge.

Code review lets you inspect the result afterwards. But even a careful review may not tell you why the code took its final shape. The alternatives, constraints and assumptions can be hard to reconstruct once the work is done.

### Cognitive debt

When an agent works faster than you can follow its decisions, your understanding can fall behind the code. Margaret-Anne Storey calls this gap [cognitive debt](https://margaretstorey.com/blog/2026/02/09/cognitive-debt/). Technical debt lives in the code. Cognitive debt lives in the understanding of the people responsible for changing it. It grows when a system changes faster than the team can understand what it does, why it works that way and how to change it safely.

Pair Mode aims to prevent that debt from building up by keeping you involved while the code changes.

### Programming as theory building

This idea goes deeper than code review. In his 1985 paper [*Programming as Theory Building*](https://pages.cs.wisc.edu/~remzi/Naur.pdf), Peter Naur argues that programming is mainly about “building up knowledge of a certain kind”. The source code and documentation matter, but they are products of a theory held by the people who built the system.

That theory is more than knowing what the code says. It means being able to explain the system, justify its design, connect it to the problem it solves and extend it when circumstances change. Designing and building the software is how that understanding is formed.

If an agent delivers the result while the human skips the process, the software may work without the human gaining the understanding needed to change it. Pair Mode treats that understanding as part of the deliverable. The goal is not only code you have reviewed, but code you understand well enough to keep building.

## Further reading

- Margaret-Anne Storey, [*How Generative and Agentic AI Shift Concern from Technical Debt to Cognitive Debt*](https://margaretstorey.com/blog/2026/02/09/cognitive-debt/)
- Peter Naur, [*Programming as Theory Building*](https://pages.cs.wisc.edu/~remzi/Naur.pdf) (1985)
- Nataliya Kosmyna et al., [*Your Brain on ChatGPT: Accumulation of Cognitive Debt when Using an AI Assistant for Essay Writing Task*](https://arxiv.org/abs/2506.08872) (2025 preprint)
