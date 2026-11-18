# dotfiles

Personal config for macOS and Omarchy (Arch), managed with [chezmoi](https://www.chezmoi.io).

## New machine

**macOS** — install [Homebrew](https://brew.sh), then:

```sh
brew install chezmoi
chezmoi init --apply --ssh aikelb/dotfiles
```

**Omarchy** — Omarchy already ships most tools, so this only adds the personal layer:

```sh
sudo pacman -S chezmoi
chezmoi init --apply --ssh aikelb/dotfiles
```

The first apply installs the package list for that OS, then writes the configs.

OpenCode is not in the package lists: install it with its official script (`curl -fsSL https://opencode.ai/v2/install | bash`), which also keeps it updated.

llama.cpp (used by `ia`, macOS on Apple Silicon) isn't either: install it with the official llama.app script (`curl -LsSf https://llama.app/install.sh | sh`). It puts a single `llama` binary in `~/.local/bin` (`llama serve` replaces `llama-server`), tracks the latest nightly build and updates with `llama update`.

## What's here

| Path | What |
|---|---|
| `packages/Brewfile`, `packages/arch.txt` | Apps per OS. Edit, then `chezmoi apply` installs what's new |
| `dot_config/shell/env.sh`, `dot_config/shell/aliases.sh` | Env/PATH and aliases shared by zsh (Mac) and bash (Omarchy) |
| `dot_config/nvim` | LazyVim + personal layer (Defold filetypes, tabs, keymaps) |
| `dot_config/zed`, `dot_config/starship.toml`, `dot_config/git` | App configs |
| `dot_gitconfig.tmpl` | Git identity and settings |
| `dot_config/herdr`, `dot_config/opencode` | herdr + OpenCode: config, plugin y hooks de estado, skill `herdr-fleet`. Plugin Ovis: `herdr plugin install devswha.ovis` |
| `private_dot_codex` | Codex: config y hook de estado para herdr (macOS) |
| `dot_config/pin/create_private_config.json.tmpl` | Cliente de pin; el token sale de gopass (`dot/pin-token`). Solo se crea si falta: para regenerarlo, borra `~/.config/pin/config.json` y `chezmoi apply` |
| `dot_local/bin` | macOS scripts: `ia` + `ia-bench` (local models), `picotron-update`, `xcode-clear`. Both OSes: `ovis-pair` |
| `docs/` | Notes, e.g. [Picotron setup and carts](docs/picotron.md) |
| `content/` | Wallpapers (kept in the repo, not deployed) |
| `archive/windows` | Old PowerShell setup, not deployed |

## On Omarchy

Omarchy owns most of `~/.config` (Hyprland, Waybar, terminal, themes) and updates it, so those aren't tracked here.
Personal Hyprland tweaks belong in the override files Omarchy sources after its defaults; add them with `chezmoi add` when there are some.
`~/.bashrc` stays Omarchy's: a script only appends the lines that load `env.sh` and `aliases.sh`.
The Neovim config is applied on top of Omarchy's LazyVim, so its theme files keep following `omarchy theme set`.

## Day to day

```sh
chezmoi re-add          # pull live edits back into the repo (auto-commits)
chezmoi edit ~/.zshrc   # or edit through chezmoi
chezmoi diff            # see what apply would change
chezmoi update          # pull + apply on another machine
chezmoi cd && git push
```
