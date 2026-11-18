# Shared environment (variables and PATH), sourced by zsh (macOS) and bash (Omarchy).

export EDITOR=nvim
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
# OpenCode, installed with its official script (https://opencode.ai/v2/install), not Homebrew
case ":$PATH:" in *":$HOME/.opencode/bin:"*) ;; *) export PATH="$HOME/.opencode/bin:$PATH" ;; esac
