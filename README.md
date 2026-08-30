# Ben Diuguid's dotfiles

For more information on dotfiles checkout [dotfiles.github.io](http://dotfiles.github.io/)

Follow me on Twitter: [@BenDiuguid](https://twitter.com/BenDiuguid)

Follow me on Medium: [@BenDiuguid](https://medium.com/@BenDiuguid)

## Overview

### Why dotfiles?
* dotfiles provide an easy solution for setting up your dev environment with one command.
* Backup, restore, and sync the prefs and settings for your toolbox. Your dotfiles might be the most important files on your machine.
* Learn from the community. Discover new tools for your toolbox and new tricks for the ones you already use.
* Share what you've learned with the rest of us.


### Setup
To setup these dotfiles, simply clone this repo then cd into it and execute `./setup.sh`. You can also simply paste the following command into terminal, which will switch to the home directory, clone the repo into `~/.dotfiles/`, make the setup script executable, and then run the setup script with bash.


Copy and Paste into terminal: `cd ~/ && git clone https://github.com/bendiuguid/dotfiles .dotfiles && cd .dotfiles && chmod +x setup.sh && ./setup.sh`

## File System

    ├── install
    │   ├── agy.sh                  - Installs the AntiGravity CLI
    │   ├── bash.sh                 - Gets bash/completions from brew and makes it default shell
    │   ├── brew-cask.sh            - Installs GUI apps
    │   ├── brew.sh                 - Installs command line apps
    │   ├── bun.sh                  - Installs Bun runtime & package manager
    │   ├── gem.sh                  - Installs useful ruby gems
    │   ├── npm.sh                  - Globally installs useful npm packages
    │   ├── python.sh               - Installs useful python packages
    │   └── zsh.sh                  - Gets zsh/completions from brew and makes it default shell
    │
    ├── macOS
    │   ├── defaults.dock.sh        - Sets the Dock up
    │   └── defaults.sh             - Skinned down version of mathiasbynens/dotfiles/.macOS
    │
    └── symlink
        ├── .gitconfig              - Global git config, where user info and git aliases live
        ├── .gitignore_global       - Global gitignore
        ├── .hyper.js               - hyper.app config
        ├── .tmux.conf              - tmux config
        ├── .zprofile               - Sources Homebrew environment variables
        ├── .zshenv                 - Configures basic environment variables
        └── .zshrc                  - Unified Zsh config (env, path, aliases, completions, plugins, and local overrides)

### Screenshots
![Hyper Screenshot](docs/HyperScreenShot.png)

# Happy Hacking!

