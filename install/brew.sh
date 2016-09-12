# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install some CTF tools; see https://github.com/ctfs/write-ups.

# BASH + plugins
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# ZSH + plugins
brew install zsh
brew install zsh-syntax-highlighting
brew install zsh-completions
brew install zsh-autosuggestions

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
# brew install homebrew/dupes/openssh

# Install other useful binaries.
# brew install bats
brew install diff-so-fancy
brew install dockutil
brew install git
brew install heroku-toolbelt
brew install mongodb
brew install rethinkdb
brew install tmux

# Install ruby stuff
brew install rbenv
brew install ruby-build

# Install python stuff
brew install python # python v2.7

# Remove outdated versions from the cellar.
brew cleanup
