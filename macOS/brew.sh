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

# Install everything in the shared Brewfile, plus machine-specific extras
BREWFILE_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
echo "Installing Homebrew packages from $BREWFILE_DIR/Brewfile..."
brew bundle --file="$BREWFILE_DIR/Brewfile"

if [ -f "$HOME/.Brewfile.local" ]; then
  echo "Installing machine-specific packages from ~/.Brewfile.local..."
  brew bundle --file="$HOME/.Brewfile.local"
fi

brew cleanup
