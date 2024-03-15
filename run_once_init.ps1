Write-Host "Adding FiraCode Nerd Font"
scoop bucket add nerd-fonts
scoop install FiraCode-NF

Write-Host "Installing starship.rs kickstart.nvim dependencies"
scoop install starship ripgrep neovim git ripgrep wget fd unzip gzip mingw make

$delNvChad = Read-Host "Delete previous NvChad setup? (yN)"
if ($delNvChad -eq "y" -or $delNvChad -eq "Y") {
    Write-Host "Cleaning NvChad..."
    rm -Force ~\AppData\Local\nvim
    rm -Force ~\AppData\Local\nvim-data
}

Write-Host "Installing NvChad..."
git clone https://github.com/nvim-lua/kickstart.nvim.git $env:USERPROFILE\AppData\Local\nvim\

Write-Host "Done. chezmoi apply --force to overwrite config and then run nvim to finish installing modules and run :MasonInstallAll"
