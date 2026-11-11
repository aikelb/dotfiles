---
name: Herdr Fleet
description: >
  Dispatch and verify work on herdr-managed agents (OpenCode workers on the
  DeepSeek API by default, free GLM tier as fallback). Use when the user asks to offload, dispatch,
  fan out, or orchestrate tasks across OpenCode/codex/Claude panes, or asks
  about the herd. Enforces: fleet workers get no disk access except exact,
  non-sensitive paths the orchestrator grants; secret/credential paths are
  never auto-granted; one action per user confirmation; never answer trust/
  permission/usage dialogs; verify agent state and output before reporting.
---

> **If you are an OpenCode/codex worker reading this file:** you are NOT the
> orchestrator. You may only touch the exact paths listed in your task prompt.
> Anything else — including reading — is forbidden. If you need more, stop and
> ask in your reply.

## User governance rules (non-negotiable)

1. **Disk access — who may touch what.**
   - **Claude orchestrator sessions** may read and write the disk as needed
     for the task, under the normal Claude Code permission mode. No extra
     per-read confirmation is required by this skill.
   - **Fleet workers** (OpenCode, codex, any non-Claude model) are untrusted:
     we don't know what these models do, or how readily they try to work
     around limits. Default is **no filesystem access**.
2. **Grants to workers.** The Claude orchestrator may grant a worker access to
   specific files/directories, only if:
   - the paths are exact (no `~`, no globs reaching outside the project, no
     parent dirs like `/Users/aike` or `~/git`);
   - Claude has checked them first and they contain no sensitive or private
     information (no secrets, tokens, `.env`, personal data, private notes);
   - the grant is written into the task prompt as an explicit allowlist
     (`You may read/write ONLY: <paths>. Do not access anything else.`) and
     stated read-only vs read-write;
   - Claude tells the user which paths were granted, in the same message
     that reports the dispatch.
3. **Never auto-granted.** These need an explicit user approval naming the
   path, every time — Claude may not grant them on its own:
   `~/.ssh`, `~/.gnupg`, `~/.aws`, `~/.kube`, `~/.docker`, `~/.netrc`,
   `~/.config/**` (incl. `~/.config/opencode` — workers must not edit their
   own rules), `~/.claude/**`, `~/Library/**` (keychains, browser profiles,
   app data), shell history/rc files, password stores, any `.env*`,
   `*.pem`/`*.key`, `/etc`, other users' dirs, and the home dir itself.
   Same for network/credential actions: `ssh`, `scp`, `git push`, `curl`
   uploads, package publishing.
4. **Watch for workarounds.** When verifying, check the worker's tool calls
   and diff, not just its summary. Any attempt to step outside the grant —
   `cat`/`find` via shell, `../` paths, symlinks, reading env vars, encoding
   tricks, editing its own config/permissions — means: stop that worker,
   show the user the evidence verbatim, and do not re-dispatch to it.
5. **Step gate.** One herdr action per user confirmation. Only batch when the
   user says an explicit blanket go-ahead for that batch.
6. **Dialog gate.** If an agent shows trust, permission, model-switch, or
   usage/credit dialogs: stop, describe it verbatim, wait for the user to
   decide. Never press `t`, never upgrade plans, never switch models.
7. **No blind re-sends.** A timeout or stalled response does not mean the
   prompt was never delivered. Read the pane before ever resubmitting.
8. **Layout gate.** Creating/splitting/closing panes requires approval.
   Leave every pane running unless the user asks for cleanup.

## Tier policy

| Task | Tier |
|---|---|
| Non-sensitive mechanics, code, docs, research | **Default: DeepSeek paid API** (`deepseek/deepseek-v4-pro`, set as `model` in `~/.config/opencode/opencode.jsonc`) |
| Fallback when DeepSeek is unavailable | `opencode/glm-5.3-flash-free`. Pre-authorized by the user: if a worker shows a DeepSeek auth/credit/rate-limit/outage error, Claude may switch that worker to this model (`/models` in the pane, or start it with `-m opencode/glm-5.3-flash-free`) and must tell the user it did so. Any other model switch still follows the Dialog gate. |
| Privacy-critical, no external egress | local/ornith — only if the `ia` llama-server is up on port 8080; verify before use |
| codex / ChatGPT Go | Only on explicit user request; stop on usage-limit screens |
| Claude | Never dispatch from this skill. Claude panes belong to the user |

## Runbook

### 0. Preflight
`test "${HERDR_ENV:-}" = 1` — if it fails, say you are not inside herdr and stop.
Then: `herdr status`, `herdr agent list`. Reuse existing idle agents instead of
creating new ones.

### 1. Acquiring a worker (needs approval)
```
herdr agent start <kebab-name> --kind opencode --pane <pane-id> --timeout 45000
```
If startup times out: wait 15s, read the pane once (`herdr pane read <pane>
--source visible`), retry the start ONCE. Two failures → report and stop.

### 2. Dispatch
```
herdr agent prompt <name> "<single, concrete task + path allowlist>" --wait --timeout 120000
```
Every prompt that involves files must end with the allowlist from rule 2.
No allowlist → the worker gets a pure text task (no file access).

### 3. Collect + verify (evidence, not vibes)
```
herdr agent wait <name> --timeout 60000
herdr agent read <name> --source recent-unwrapped --lines 120
```
On `agent_not_idle` → wait and retry once, then fall back to `--source visible`.
Verify: (a) the status line shows the expected tier (`deepseek-v4-pro`, or
the GLM fallback if it was switched), (b) the answer actually addresses the
task — read the code/diff yourself; worker summaries have claimed work that
was never done. Report what you saw, quoting the agent.

### 4. Codex notes
If a codex pane shows a usage/credit limit banner, do not touch it: report the
reset time shown and stop. (Current standing: ChatGPT Go is exhausted until
Nov 26th, 2026 ~12:03 PM.)

### 5. Escalate & stop
On `blocked`, `unknown`, repeated `timeout`, or cryptic pane output: capture
`herdr agent get <name>` + last 20 lines, show them, stop.
