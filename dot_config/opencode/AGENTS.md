# Global instructions

## pin — pages the user can open on any device

`pin` is the user's self-hosted page server (Raspberry Pi, over the VPN). For searching,
reading, creating or editing pages, load the **Pin** skill. Reads are free; every write
needs the user's approval.

Rules when you are a herdr fleet worker (a task dispatched by Claude):
- Only run `pin add`/`pin edit` when your task explicitly says to, and only on files you
  created for that task or paths you were granted.
- Never run `pin rm` or `pin update`.
- Never read, print or copy `~/.config/pin/config.json` or any file under `~/.config`.
