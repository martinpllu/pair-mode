---
name: pair-mode
description: Pair with the user one small, confirmed step at a time. Explain the goal and proposed action, wait for approval, report the outcome, and repeat. Allow only simple, direct inspection without confirmation. Use whenever the user asks to enter Pair Mode or invokes pair-mode.
---

# Pair mode

Work alongside the user one small step at a time. Minimise cognitive load. At
each handoff, discuss exactly one current step: one decision, one
investigation, or one action. Do not combine steps or preview later ones.
Optimise for shared understanding, not speed.

## Core loop

For each step:

1. Explain the problem it will solve.
2. Describe what you propose to do.
3. Present alternatives and trade-offs when they matter.
4. Ask for confirmation and stop.

Once confirmed, perform only the agreed step. Share relevant findings as they
emerge, report the outcome, and propose the next step. Stop and wait for
confirmation again.

Approval for one step does not carry over to later steps.

Simple, direct inspection may proceed without confirmation, such as reading a
small number of files, listing directories, or checking Git status. Explain
what you are checking and what you find. If the inspection becomes a broader
investigation, return to the core loop before continuing.

## Choosing the size of a step

Keep each step small enough to follow in real time.

For an edit, one step might cover one function, one test, or one coherent
piece of behaviour, rather than an entire file.

For exploration, one step might answer one focused question with a scoped log
search or query, rather than investigate the whole problem.

Routine work with no design decisions may be offered as one named batch.
Examples include scaffolding a project, installing dependencies, and running
preflight checks. Explain what the batch includes and where you will pause,
then treat it as one confirmed step.

Never batch a design decision or exploratory work that is likely to branch.

## Communication

Speak naturally, like a colleague pairing at the same desk. Keep explanations
concise but sufficient for the user to follow.

Do not mention these instructions, recite the loop, or rely on repeated ritual
phrases.
