# dotfiles

This repository contains my personal configuration for macOS and Omarchy (Arch Linux), managed with [chezmoi](https://www.chezmoi.io).
It is shared as a reference for people curious about how I set up my machines, not as a framework to install as-is.
Review the files and adapt anything you borrow to your own setup.

## New machine

On **macOS**, install [Homebrew](https://brew.sh), then run:

```sh
brew install chezmoi
chezmoi init --apply --ssh aikelb/dotfiles
```

On **Omarchy**, most of the tools are already included; this adds my personal layer:

```sh
sudo pacman -S chezmoi
chezmoi init --apply --ssh aikelb/dotfiles
```

The first apply installs the package list for the current OS, then writes the configurations.

OpenCode is not in the package lists. Install it with its official script, which also keeps it updated:

```sh
curl -fsSL https://opencode.ai/v2/install | bash
```

`llama.cpp`, used by `ia` on Apple Silicon Macs, is not in the package lists either. Install it with the official llama.app script:

```sh
curl -LsSf https://llama.app/install.sh | sh
```

It installs a single `llama` binary in `~/.local/bin`; use `llama serve` instead of `llama-server`.
It tracks the latest nightly build and can be updated with `llama update`.

## What's here

| Path | What |
|---|---|
| `packages/Brewfile`, `packages/arch.txt` | Apps for each OS. Edit the lists, then run `chezmoi apply` to install additions. |
| `dot_config/shell/env.sh`, `dot_config/shell/aliases.sh` | Shared environment, PATH and aliases for macOS zsh and Omarchy bash. |
| `dot_config/nvim` | LazyVim personal layer, including Defold filetypes, tabs and keymaps. |
| `dot_config/zed`, `dot_config/starship.toml`, `dot_config/git` | Application configurations. |
| `dot_gitconfig.tmpl` | Git identity and settings, populated from local data at apply time. |
| `dot_config/herdr`, `dot_config/opencode` | herdr and OpenCode configuration, status hooks and the `herdr-fleet` skill. Ovis can be added with `herdr plugin install devswha.ovis`. |
| `private_dot_codex` | Codex configuration and a herdr status hook (macOS). |
| `dot_config/pin/create_private_config.json.tmpl` | pin client configuration. Created only if missing; see the Secrets section. |
| `dot_local/bin` | macOS scripts: `ia` and `ia-bench` for local models, `picotron-update` and `xcode-clear`; `ovis-pair` works on both OSes. |
| `docs/` | Notes, including [Picotron setup and carts](docs/picotron.md). |
| `content/` | Wallpapers kept in the repository, not deployed. |
| `archive/windows` | Previous PowerShell setup, not deployed. |

## On Omarchy

Omarchy manages most of `~/.config`, including Hyprland, Waybar, the terminal and themes, and updates those files. They are therefore not tracked here.
Personal Hyprland tweaks belong in the override files Omarchy sources after its defaults; add those files with `chezmoi add` when needed.

Omarchy's `~/.bashrc` remains in place. A script only appends the lines that load `env.sh` and `aliases.sh`.
The Neovim configuration is applied on top of Omarchy's LazyVim, so its theme files continue to follow `omarchy theme set`.

## Day to day

```sh
chezmoi re-add          # pull live edits back into the repo (auto-commits)
chezmoi edit ~/.zshrc   # or edit through chezmoi
chezmoi diff            # see what apply would change
chezmoi update          # pull + apply on another machine
chezmoi cd && git push
```

## Borrowing from this repo

Chezmoi filenames encode how a file is treated when deployed:

| Name part | Meaning |
|---|---|
| `dot_` | A leading dot in the destination filename, such as `.zshrc`. |
| `private_` | Deploy with private permissions. |
| `executable_` | Deploy as an executable file. |
| `.tmpl` | Process the file as a template before deployment. |
| `run_onchange_` | Run a script when its contents change. |
| `run_after_` | Run a script after applying files. |
| `create_` | Create the destination only if it does not already exist. |
| `modify_` | Modify an existing destination rather than replacing it. |

These name parts can be combined. For example, `dot_config/pin/create_private_config.json.tmpl` describes a private JSON config that is templated and created only when absent.
Templates obtain secrets from gopass or environment variables at apply time; secret values are not stored in this repository.

## Secrets

No secrets are committed here. Tokens are read from gopass or environment variables when needed.
A few configs point at services on my private network (reachable only over my VPN); those addresses are not usable from the internet.
