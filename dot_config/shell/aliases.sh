# Shared aliases, sourced by zsh (macOS) and bash (Omarchy). Variables and PATH go in env.sh.

alias vim='nvim'
alias v='nvim'
alias lg='lazygit'
alias rpi='ssh rpi'

if [ "$(uname)" = "Darwin" ]; then
  alias brew-upgrade='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
fi
