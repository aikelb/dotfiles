# Global instructions

## pin — publishing pages for the user to view on any device

`pin` is the user's self-hosted artifact server (server on their Raspberry Pi,
reachable over their VPN). To publish an HTML/Markdown page the user can open
from any device:

- `pin add <file.html|file.md|dir> --title "…" --tags a,b` → prints the URL; report it.
- To update an existing pin: `pin edit <slug> [<path>] [--title …]` (same URL);
  `pin add` again would create a `-2` duplicate. Check `pin ls` first.
- `pin ls [--tag t] [--json]` · `pin url <slug>`.
- Self-contained HTML (inline CSS/JS), mobile-friendly, works best.

Rules when you are a herdr fleet worker (a task dispatched by Claude):

- Only run `pin add` when your task explicitly says to, and only on files you
  created for that task or paths you were granted. Never publish anything else.
- Never run `pin rm` or `pin update`.
- Never read, print or copy `~/.config/pin/config.json` or any file under `~/.config`.
