# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install Bash + completions
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install grep --with-default-names
brew install gnu-sed --with-default-names
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# Install some CTF tools; see https://github.com/ctfs/write-ups.

# Install other useful binaries.
brew install bats
brew install diff-so-fancy
brew install dockutil
brew install git
brew install heroku-toolbelt
brew install mongodb

# Remove outdated versions from the cellar.
brew cleanup
