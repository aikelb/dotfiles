# Install [chezmoi](https://www.chezmoi.io/)

## Linux
```bash
$ sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

## Windows
```bash
scoop install chezmoi
chezmoi init git@github.com:$GITHUB_USERNAME/dotfiles.git
```

## macOS
```bash
brew install chezmoi
chezmoi init git@github.com:$GITHUB_USERNAME/dotfiles.git
```

https://www.chezmoi.io/quick-start/#start-using-chezmoi-on-your-current-machine
