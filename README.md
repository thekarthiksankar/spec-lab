# spec-lab

A personal library of rules and principles for AI agents.

## Structure

```
rules/
  coding/       ← principles for software development tasks
  email/        ← principles for email writing
  files/        ← principles for file organisation
AGENTS.md       ← index of all rules
```

## Usage

In any project, create a `CLAUDE.md` and `@include` only the rules relevant to that context:

```
@~/.config/ai/rules/coding/spec-first-third-party-integration.md
```

Universal rules that apply across all sessions are maintained separately in `~/.config/ai/AGENTS.md`, wired via `~/.claude/CLAUDE.md`.
