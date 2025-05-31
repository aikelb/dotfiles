#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
    echo "Adding FiraCode Nerd Font"
    brew tap homebrew/cask-fonts
    brew install font-fira-code-nerd-font
    echo "Installing starship.rs, neovim and dependencies..."
    brew install starship ripgrep neovim fzf zoxide lf silicon

elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    echo "Updating sources and installing apps..."
		yay -S ghostty zen-browser-bin gopass openresolv wireguard-tools defold-bin lazygit aseprite bat tree ncdu
    echo "Linux: Installing nvim and dependencies"
		yay -S neovim ripgrep fd zip luarocks wget lua rust npm tar gzip git curl fzf zoxide
else
    echo "Sistema operativo no compatible"
    exit 1
fi

echo "Done! Do chezmoi apply --force to overwrite config."
echo "Then run nvim to finish installing modules and run :MasonInstallAll."

