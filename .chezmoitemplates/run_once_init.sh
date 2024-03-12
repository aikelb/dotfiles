#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
    echo "Adding FiraCode Nerd Font"
    brew tap homebrew/cask-fonts
    brew install font-fira-code-nerd-font
    echo "Installing starship.rs and ripgrep"
    brew install starship ripgrep neovim

elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    echo "Updating sources and installing dependencies..."
    sudo apt update && sudo apt install unzip 
    echo "Linux: Installing font and nvim"

    echo "Downloading FiraCode"
    tar_file="FiraCode.tar.xz"
    curl --fail --location --show-error "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${tar_file}" --output "${tar_file}"

    fonts_dir="${HOME}/.local/share/fonts"
    if [[ ! -d "$fonts_dir" ]]; then
      mkdir -p "$fonts_dir"
    fi
    tar -xJf "${tar_file}" -C "${fonts_dir}"
    rm "${tar_file}"
    fc-cache -fv

    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
    ./nvim.appimage

    echo "Installing starship.rs"
    curl -sS https://starship.rs/install.sh | sh

    sudo apt install ripgrep
else
    echo "Sistema operativo no compatible"
    exit 1
fi

echo "Delete previous NvChad setup? (yN)"
read delNvChad
if [[ "$delNvChad" == "y" || "$delNvChad" == "Y" ]]; then
  echo "Cleaning NvChad..."
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
fi

echo "Installing NvChad..."
git clone https://github.com/NvChad/starter ~/.config/nvim

chezmoi apply --force

echo "Done. Run nvim to finish installing modules"
