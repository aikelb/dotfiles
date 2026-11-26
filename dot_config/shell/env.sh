# Shared environment (variables and PATH), sourced by zsh (macOS) and bash (Omarchy).

export EDITOR=nvim
# pin server over the VPN. Not a secret: the write token stays in ~/.config/pin/config.json
export PIN_REMOTE="http://pin.dot.home.arpa"
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
# Bun (official installer): `bun link` puts pin there, and ovis-pair needs bun
case ":$PATH:" in *":$HOME/.bun/bin:"*) ;; *) export PATH="$HOME/.bun/bin:$PATH" ;; esac
# OpenCode, installed with its official script (https://opencode.ai/v2/install), not Homebrew
case ":$PATH:" in *":$HOME/.opencode/bin:"*) ;; *) export PATH="$HOME/.opencode/bin:$PATH" ;; esac
