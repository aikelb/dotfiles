---
name: Herdr Fleet
description: >
  Dispatch and verify work on herdr-managed agents (OpenCode workers on the
  Command Code subscription, zero data retention on every request). Use when the user asks to offload, dispatch,
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
| Non-sensitive mechanics, code, docs, research | **Default: Command Code** (`commandcode/zai-org/GLM-5.3`, set as `model` in `~/.config/opencode/opencode.jsonc`). Every request carries `x-cmd-zdr: 1` |
| Hard task the user asked to give to a stronger worker | `commandcode/moonshotai/Kimi-K3.1-Pro` |
| Worker runs out of one **model's** monthly allowance (a limit error that names the model or its allowance, not the plan) | Pre-authorized by the user, no need to ask: Claude switches that worker to the next `commandcode/` model with allowance left, in this order: `zai-org/GLM-5.3` → `deepseek/deepseek-v4.1-flash` → `z-ai/glm-5.3-flash` → `inclusionai/ling-3.1-flash` → `MiniMaxAI/MiniMax-M3` (`/models` in the pane; opencode v2.3+ has no `-m` flag), re-dispatches the task and tells the user which model it moved to and why. |
| Command Code **plan** window hit: `429 RATE_LIMITED`, "You've reached your 5-hour/weekly usage limit for your plan … resets at <time>" | The whole plan is paused and every `commandcode/` model will fail the same way, so don't switch models. Stop dispatching to Command Code workers, report the reset time (convert to Atlantic/Canary) and keep the work with Claude. No local/ornith or other provider unless the user asks for it. |
| Command Code **free** models (`commandcode-free/…`: Glyph Cluster, Flint, Inkling 2 Small) | Not zero-retention: prompts may be retained or used for training. Never a default, never a fallback (not for allowance-out, not when the plan window is hit). Only when the user explicitly allows them in this session or for this launch, and only for non-sensitive content (public code, generic questions, docs with no private data). Say in the dispatch report that a free model was used. |
| Always, with Command Code | Never buy credits, turn on auto reload or remove the ZDR header. A `422 cmd_zdr_no_providers` means that model has no ZDR route: pick another, don't work around it. Any other model switch still follows the Dialog gate. |
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

Notes (opencode v2.3.0):
- `opencode` lives in `~/.opencode/bin` (on PATH via `~/.config/shell/env.sh`,
  sourced by `~/.zshrc`). A pane opened before that needs
  `herdr pane run <pane> "source ~/.zshrc"`.
- There is no `-m` flag: start plain (opens on the default tier), then pick the
  model with `herdr pane send-text <pane> "/models"` + `herdr agent send-keys
  <name> enter`, type the model name, `enter`, and `enter` again for the
  `Default` variant. Check the status line shows it before dispatching.
- For read-only work (reviews, research) switch to the **Plan** agent
  (`herdr agent send-keys <name> shift+tab`): it cannot edit files. Plan keeps
  its own model setting, so pick the model again after switching.
- Worker tool calls are in `~/.local/share/opencode/opencode.db`
  (`session_message`, parts with `"type":"tool"`); audit them read-only
  with `sqlite3 -readonly` against the grant.

### 2. Dispatch
**One task, one OpenCode session.** Context is re-sent on every step and is what
burns the Command Code plan (one long session re-sent 200-400K tokens per step
and used the weekly window in a day). Before each new task on an existing
worker: `herdr pane send-text <pane> "/new"` + `herdr agent send-keys <name>
enter`, then check the status line still shows the intended model (pick it
again with `/models` if not). Only follow-ups to the same task stay in the
same session.
```
herdr agent prompt <name> "<single, concrete task + path allowlist>" --wait --timeout 120000
```
`--timeout` requires `--wait`; without `--wait`, omit it (the call returns at
once). For long tasks, prompt without `--wait` and run
`herdr agent wait <name> --timeout <ms>` in the background.
Every prompt that involves files must end with the allowlist from rule 2.
No allowlist → the worker gets a pure text task (no file access).

### 3. Collect + verify (evidence, not vibes)
```
herdr agent wait <name> --timeout 60000
herdr agent read <name> --source recent-unwrapped --lines 120
```
On `agent_not_idle` → wait and retry once, then fall back to `--source visible`.
Verify: (a) the status line shows the expected tier (`glm-5.3`, or the
model it was switched to), (b) the answer actually addresses the
task — read the code/diff yourself; worker summaries have claimed work that
was never done. Report what you saw, quoting the agent.

### 4. Codex notes
If a codex pane shows a usage/credit limit banner, do not touch it: report the
reset time shown and stop. (Current standing: ChatGPT Go is exhausted until
Nov 26th, 2026 ~12:03 PM.)

### 5. Escalate & stop
On `blocked`, `unknown`, repeated `timeout`, or cryptic pane output: capture
`herdr agent get <name>` + last 20 lines, show them, stop.
