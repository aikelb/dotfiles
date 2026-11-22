---
name: Sandbox Session
description: >
  Filesystem sandbox boundary for agent sessions. Use when starting, continuing, or
  reviewing non-orchestrator agent sessions in the user's own projects, and when subagents are
  spawned: keeps the agent inside the project root unless the user grants task-scoped access,
  never allows secret paths without explicit per-path user approval, gates destructive
  actions, and escalates when a grant is missing.
---

> **If you are an agent reading this in a session covered by this skill:** you are inside a
> sandboxed session. Follow these rules strictly.

## The boundary (hard line)

- **Default boundary:** the project root of the current working project (for example
  `/Users/aike/git/shmup`).
- **Inside the boundary:** reading and writing are allowed, except secret paths (see
  **Grants** → **Secret paths**).
- **Outside the boundary:** forbidden unless the user granted task-scoped access (see
  **Grants**).

## Grants

- Grants are **task-scoped** (a session-scoped grant may be introduced later).
- A grant must include:
  - **exact paths** (no `~`, no globs reaching outside the boundary, no parent dirs like
    `/Users/aike` or `~/git`);
  - **read-only vs read-write** stated explicitly.
- The agent may **ask the user for permission** to operate outside the boundary or to obtain a
  grant. The agent must not grant itself scope.

### Secret paths (never by default)

- Secret and credential paths are **never** covered by a grant by default, and are off limits
  even inside the boundary.
- Only an **explicit user approval naming the exact path** unlocks one. It is required every
  time, is never implied by a broader grant, and is never reused for later tasks.
- Canonical list: `~/.ssh`, `~/.gnupg`, `~/.aws`, `~/.kube`, `~/.docker`, `~/.netrc`,
  `~/.config/**`, `~/.claude/**`, `~/Library/**`, shell history/rc files, password stores, any
  `.env*`, `*.pem`/`*.key`, `/etc`, other users' dirs, the home dir itself, and any other
  secret-looking file inside the project (tokens, credentials).
- The agent may ask for this approval but must not grant it to itself.

## Subagents

- Subagents spawned within a sandboxed session **inherit** the boundary.
- Spawning a subagent does not widen the boundary unless the user grants more.

## Gates

- **Destructive actions** (deletes, overwrites, pushes, installs, …) inside the boundary still
  require user confirmation.
- Before any file operation, the agent should state the target path and confirm it falls within
  the granted scope.

## Escalation

- If the user requests something outside the boundary and no grant exists, stop, explain what
  is needed, and ask for a grant (the user names the exact path(s), read-only vs read-write, and
  purpose).

## Relation to Herdr Fleet

- Fleet workers get their filesystem scope through task-prompt allowlists, which are the grants
  described here; see the **Herdr Fleet** skill for orchestration and verification.
- This skill governs non-orchestrator agent sessions in the user's own projects.
- The Claude orchestrator is **not** under this boundary: it keeps its normal access under
  Claude Code's permission mode and is the one that issues grants to workers.
