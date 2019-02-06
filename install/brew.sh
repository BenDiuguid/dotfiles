# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Installs with special flags
brew install vim --with-override-system-vi

binaries=(
  # BASH + plugins
  bash
  bash-completion2

  # ZSH + plugins
  zsh
  zsh-history-substring-search
  zsh-syntax-highlighting
  zsh-completions
  zsh-autosuggestions

  # Install ruby stuff
  rbenv
  ruby-build

  # Install python stuff
  python

  # Other
  autojump
  bat
  diff-so-fancy
  dockutil
  fx
  git
  guetzli
  haskell-stack
  hub
  jpeg-turbo
  tmux
  watchman
  webp
)

brew install "${binaries[@]}"

brew cleanup
