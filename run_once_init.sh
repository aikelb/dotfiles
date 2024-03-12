#!/bin/bash

version='3.1.1'
echo "Downloading FiraCode version $version..."
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v$version/FiraCode.zip"

if [[ "$(uname)" == "Darwin" ]]; then
    echo "macOS: Installing font and neovim"
    sudo -v
    unzip FiraCode.zip -d ./font -x "*.txt/*" -x "*.md/*"
    sudo mv ./font/*.ttf /Library/Fonts/
    rm -rf ./font
    
    echo "Installing starship.rs and ripgrep"
    brew install neovim starship ripgrep
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    echo "Linux: Installing font and nvim"

    fonts_dir="${HOME}/.local/share/fonts"
    if [[ ! -d "$fonts_dir" ]]; then
      mkdir -p "$fonts_dir"
    fi

    unzip FiraCode.zip -d "$fonts_dir" -x "*.txt/*" -x "*.md/*"
    rm FiraCode.zip
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

echo "Delete previous NvChad setup? (Y/n)"
read delNvChad
if [[ ! "$delNvChad" == "n" && ! "$delNvChad" == "N" ]]; then
  echo "Cleaning NvChad..."
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
fi

echo "Installing NvChad..."
git clone https://github.com/NvChad/starter ~/.config/nvim

echo "Done. Run nvim to finish installing modules"
