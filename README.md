# Ben Diuguid's dotfiles

For more information on dotfiles [visit this](http://dotfiles.github.io/)

Follow me on Twitter: [@BenDiuguid](https://twitter.com/BenDiuguid)

## Overview

### Why dotfiles?
* dotfiles provide an easy solution for setting up your dev environment with one command.
* Backup, restore, and sync the prefs and settings for your toolbox. Your dotfiles might be the most important files on your machine.
* Learn from the community. Discover new tools for your toolbox and new tricks for the ones you already use.
* Share what you've learned with the rest of us.


### Installation
To install these dotfiles, simply clone this repo then cd into it and execute install.sh. You can also simply paste the following command into terminal, which switch the the home directory, clone the repo into .dotfiles/ and then run the install script with bash.


Copy and Paste into terminal: `cd ~/ && git clone https://github.com/bendiuguid/dotfiles .dotfiles && cd .dotfiles && bash install.sh`

## File System

    ├── bin
    │   └── dotfiles                - Executable placed on path to provide update/sourcing
    │
    ├── git
    │   ├── .gitconfig              - Global git config, where user info and git alias's live
    │   └── .gitignore_global       - Global git ignore
    │
    └── install
    │   ├── atom.sh                 - Uses apm to install atom packages/themes
    │   ├── bash.sh                 - Gets bash/completions from brew and makes it default shell
    │   ├── brew-cask.sh            - Installs GUI apps
    │   ├── brew.sh                 - Installs command line apps
    │   ├── gem.sh                  - Installs useful gems
    │   ├── meteor.sh               - Installs meteor
    │   └── npm.sh                  - Globally installs useful npm packages
    │
    ├── osx
    │   ├── defaults.dock.sh        - Sets the Dock up
    │   └── defaults.sh             - Skinned down version of mathiasbynens/dotfiles/.osx
    │
    ├── symlink
    │   ├── .bash_profile           - Symlinked into ~/ controls the sourcing of everything
    │   ├── .tmux.                  - Symlinked into ~/ configures tmux
    │   └── .inputrc                - Symlinked into ~/ sets input info
    │
    ├── system
    │   ├── .alias                  - Shell Alias's
    │   ├── .completion             - Bash/brew and other completions
    │   ├── .env                    - Environmental variables
    │   ├── .function               - General useful bash functions
    │   ├── .function_fs            - File System specific functions
    │   ├── .nvm                    - Properly sources nvm
    │   ├── .path                   - Defines the path
    │   └── .prompt                 - Bash logic for coloring / git status of prompt
    │
    └── themes
        ├── .Material.itermcolors   - Material color theme for iTerm
        └── .Material.terminal      - Material color theme for Terminal.app

## Themes
I have created a Material theme for both Mac Terminal & [iTerm2](https://www.iterm2.com/)
The themes are located in the `themes/` folder.

### Installing themes
To install a theme, simply navigate to the preferences/settings of the terminal or iTerm, and import the desired theme.

### Screenshots
![Terminal Theme](https://github.com/bendiuguid/dotfiles/raw/master/docs/imgs/terminalThemeAt2016-05-08.png)

![iTerm Theme](https://github.com/bendiuguid/dotfiles/raw/master/docs/imgs/itermThemeAt2016-05-08.png)

## Caveats
Currently I have not tested this on anything other than OS X, and I know all of the `brew` stuff will not work on Linux or Windows systems.

# Happy Hacking!
