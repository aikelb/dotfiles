# Shared shell setup, sourced by zsh (macOS) and bash (Omarchy).

export EDITOR=nvim
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac

alias vim='nvim'
alias v='nvim'
alias lg='lazygit'
alias rpi='ssh rpi'

if [ "$(uname)" = "Darwin" ]; then
  alias brew-upgrade='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
fi
