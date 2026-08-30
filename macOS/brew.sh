#!/usr/bin/env bash

# Install Homebrew if not already installed
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
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

  # Node, Python & JS Runtime Managers
  fnm
  pnpm
  uv
  bun

  # Other CLI tools
  bat
  dockutil
  eza
  git
  tmux
  vim
  xsv
  diff-so-fancy
)

echo "Installing Homebrew packages..."
brew install "${binaries[@]}"

brew cleanup
