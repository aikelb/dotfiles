<div align="center">

### ~/. my dotfiles ~/. :house:&nbsp;

#### \> Managed with chezmoi
</div>


📖  Overview

This repository contains all my dotfiles managed by [chezmoi](https://www.chezmoi.io). Please note that this is my own personal dotfiles. 
Thanks to [mimikun](https://github.com/mimikun/dotfiles/tree/master) and [budimanjojo](https://github.com/budimanjojo/dotfiles)!

📥  Installation

Install chezmoi chezmoi and use the repo:

## Linux
```bash
$ sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

## Windows
```bash
scoop install chezmoi
chezmoi init --apply $GITHUB_USERNAME
```

## macOS

Start by installing [kitty](https://sw.kovidgoyal.net/kitty/binary/) or just run:
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

We also need [homebrew](https://brew.sh):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then we are ready to install chezmoi!
```bash
brew install chezmoi
chezmoi init --apply $GITHUB_USERNAME --ssh
```

https://www.chezmoi.io/quick-start/#start-using-chezmoi-on-your-current-machine
