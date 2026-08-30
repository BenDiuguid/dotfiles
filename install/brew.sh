# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

binaries=(
  # BASH + plugins
  bash
  bash-completion2

  # ZSH + plugins
  zsh
  pure
  zsh-history-substring-search
  zsh-syntax-highlighting
  zsh-completions
  zsh-autosuggestions

  # Node & Python Runtime Managers
  fnm
  uv

  # Other
  dockutil
  git
  tmux
  vim
  xsv
  diff-so-fancy
)

brew install "${binaries[@]}"

brew cleanup
