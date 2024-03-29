Write-Host "Adding FiraCode Nerd Font"
scoop bucket add nerd-fonts
scoop install FiraCode-NF

Write-Host "Installing starship.rs kickstart.nvim dependencies"
scoop install starship ripgrep neovim git ripgrep wget fd unzip gzip mingw make sed gsudo

$delNvChad = Read-Host "Delete previous nvim setup? (yN)"
if ($delNvChad -eq "y" -or $delNvChad -eq "Y") {
    Write-Host "Cleaning AppData\Local\nvim..."
    rm -Force ~\AppData\Local\nvim
    rm -Force ~\AppData\Local\nvim-data
}

Write-Host "Creating links..."

$symLinkPath = Join-Path $(Resolve-Path ~/AppData/Local).Path "nvim"
$actualNvimConfigPath = $(Resolve-Path ~/.config/nvim).Path
if (!$(Test-Path $symLinkPath) -and $(Test-Path $actualNvimConfigPath))
{
    gsudo cmd /c mklink /d $symLinkPath $actualNvimConfigPath
}

# To list all appx packages:
# Get-AppxPackage | Format-Table -Property Name,Version,PackageFullName
Write-Header "Removing UWP Apps..."
$uwpApps = @(
    "Microsoft.OutlookForWindows",
    "Microsoft.BingSearch",
    "Microsoft.BingWeather",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.YourPhone",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.People",
    "Microsoft.GetHelp")

$delW11Packages = Read-Host "Delete W11 preinstalled pacakges? (yN)"
if ($delW11Packages -eq "y" -or $delW11Packages -eq "Y") {
	foreach ($uwp in $uwpApps)
	{
    		gsudo Get-AppxPackage -Name $uwp | Remove-AppxPackage
	}
}

Write-Host "Done! Run nvim to finish installing modules and run :MasonInstallAll"
