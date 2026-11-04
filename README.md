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

## What's here

| Path | What |
|---|---|
| `packages/Brewfile`, `packages/arch.txt` | Apps per OS. Edit, then `chezmoi apply` installs what's new |
| `dot_config/shell/aliases.sh` | Aliases and env shared by zsh (Mac) and bash (Omarchy) |
| `dot_config/nvim` | LazyVim + personal layer (Defold filetypes, tabs, keymaps) |
| `dot_config/zed`, `dot_config/starship.toml`, `dot_config/git` | App configs |
| `dot_gitconfig.tmpl` | Git identity and settings |
| `dot_local/bin` | Scripts (`picotron-update`, macOS only) |
| `docs/` | Notes, e.g. [Picotron setup and carts](docs/picotron.md) |
| `content/` | Wallpapers (kept in the repo, not deployed) |
| `archive/windows` | Old PowerShell setup, not deployed |

## On Omarchy

Omarchy owns most of `~/.config` (Hyprland, Waybar, terminal, themes) and updates it, so those aren't tracked here.
Personal Hyprland tweaks belong in the override files Omarchy sources after its defaults; add them with `chezmoi add` when there are some.
`~/.bashrc` stays Omarchy's: a script only appends one line that loads `aliases.sh`.
The Neovim config is applied on top of Omarchy's LazyVim, so its theme files keep following `omarchy theme set`.

## Day to day

```sh
chezmoi re-add          # pull live edits back into the repo (auto-commits)
chezmoi edit ~/.zshrc   # or edit through chezmoi
chezmoi diff            # see what apply would change
chezmoi update          # pull + apply on another machine
chezmoi cd && git push
```
