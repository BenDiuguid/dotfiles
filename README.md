# Ben Diuguid's dotfiles

For more information on dotfiles checkout [dotfiles.github.io](http://dotfiles.github.io/)

Follow me on Twitter: [@BenDiuguid](https://twitter.com/BenDiuguid)

Follow me on Medium: [@BenDiuguid](https://medium.com/@BenDiuguid)

## Overview

### Why dotfiles?
* dotfiles provide an easy solution for setting up your dev environment with one command across macOS and Linux.
* Backup, restore, and sync the prefs and settings for your toolbox. Your dotfiles might be the most important files on your machine.
* Learn from the community. Discover new tools for your toolbox and new tricks for the ones you already use.
* Share what you've learned with the rest of us.


### Setup
To setup these dotfiles, simply clone this repo then cd into it and execute `./setup.sh`. You can also simply paste the following command into terminal, which will switch to the home directory, clone the repo into `~/.dotfiles/`, make the setup script executable, and then run the setup script with bash.


Copy and Paste into terminal: `cd ~/ && git clone https://github.com/bendiuguid/dotfiles .dotfiles && cd .dotfiles && chmod +x setup.sh && ./setup.sh`

### Health Check & Validation (Doctor)
To verify that all symlinks, shell syntax, pure prompt, plugins, CLI tools, and runtime managers are correctly installed and functioning on macOS or Linux:

```bash
./validate.sh
# or after sourcing ~/.zshrc:
doctor
```

## File System

    ├── setup.sh                    - Master cross-platform setup coordinator (symlinks, OS dispatch, shared tools)
    ├── validate.sh                 - Dotfiles health doctor & test suite (run directly or via 'doctor' alias)
    │
    ├── macOS
    │   ├── setup.sh                - macOS setup orchestrator
    │   ├── brew.sh                 - Installs Homebrew & CLI formulae
    │   ├── shells.sh               - Registers & configures Homebrew shells in /private/etc/shells
    │   ├── defaults.sh             - macOS system defaults configuration
    │   └── defaults.dock.sh        - Sets the Dock layout up
    │
    ├── linux
    │   ├── setup.sh                - Linux setup orchestrator
    │   ├── packages.sh             - Installs packages via apt, dnf, pacman, or linuxbrew
    │   └── shells.sh               - Registers & configures default shell in /etc/shells
    │
    ├── install
    │   ├── agy.sh                  - Installs the AntiGravity CLI
    │   ├── bun.sh                  - Installs Bun runtime & package manager
    │   ├── node.sh                 - Configures FNM & Node.js environment
    │   ├── pnpm.sh                 - Installs pnpm package manager
    │   └── python.sh               - Installs Python runtime & uv manager
    │
    └── symlink
        ├── .gitconfig              - Global git config with local override include
        ├── .gitignore_global       - Global gitignore patterns
        ├── .tmux.conf              - tmux configuration & keybindings
        └── .zshrc                  - Unified cross-platform Zsh config (env, paths, aliases, plugins)

### Screenshots
![Hyper Screenshot](docs/HyperScreenShot.png)

# Happy Hacking!
