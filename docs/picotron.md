# Picotron

Picotron itself isn't managed here, only the bits around it.

## Install / update (macOS)

`~/.local/bin/picotron-update` (source of truth: `~/git/shmup/tools/picotron-update.sh`).

```sh
picotron-update setup     # once per machine: paste your personal Lexaloffle download link
picotron-update           # install or update to the latest version
picotron-update check | rollback | install 0.3.0d
```

The link (email/token) is stored in `~/.config/picotron-update/config` and never enters this repo.
On Arch/Omarchy use the AUR package instead: `yay -S picotron`.

## Config

`run_after_picotron-config.sh` appends missing `mount` lines to `picotron_config.txt`
(macOS: `~/Library/Application Support/Picotron/`, Linux: `~/.lexaloffle/Picotron/`).
Picotron rewrites that file itself, so it isn't tracked as a whole.

## Carts I like

Reinstall from inside Picotron's terminal. The ids come from the downloaded file names
(`name-version.p64.png`), so double-check the hexpop ones on the BBS if `load` fails.

| Cart | Command |
|---|---|
| Minebrusher | `load #minebrusher` |
| Pomodoro | `load #pomodoro` |
| Solitaire Suite | `load #solitaire_suite` |
| Task Monitor | `load #task_monitor` |
| Hexpop wallpaper | `load #hexpop` |
| Hexpop theme | `load #hexpop_theme` |
| SLATE editor | installer cart from https://github.com/scrapSavage/SLATE |

The old copies are in git history (tag `kickstart-final`) if a BBS id ever disappears.
