Write-Host "Adding FiraCode Nerd Font"
scoop bucket add nerd-fonts
scoop install FiraCode-NF

Write-Host "Installing starship.rs and ripgrep, make and mingw"
scoop install starship ripgrep make mingw

$delNvChad = Read-Host "Delete previous NvChad setup? (yN)"
if ($delNvChad -eq "y" -or $delNvChad -eq "Y") {
    Write-Host "Cleaning NvChad..."
    rm -Force ~\AppData\Local\nvim
    rm -Force ~\AppData\Local\nvim-data
}

Write-Host "Installing NvChad..."
git clone https://github.com/NvChad/starter $ENV:USERPROFILE\AppData\Local\nvim

chezmoi apply --force

Write-Host "Done. Run nvim to finish installing modules"
