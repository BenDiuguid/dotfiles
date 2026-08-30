#!/usr/bin/env bash

# Install Linuxbrew (Homebrew on Linux) if not already installed
if ! command -v brew >/dev/null 2>&1 && [[ ! -x "/home/linuxbrew/.linuxbrew/bin/brew" ]] && [[ ! -x "$HOME/.linuxbrew/bin/brew" ]]; then
  echo "Linuxbrew not found. Installing Homebrew for Linux..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Load Linuxbrew environment into the current shell
if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
  eval "$("$HOME/.linuxbrew/bin/brew shellenv")"
elif command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

if command -v brew >/dev/null 2>&1; then
  echo "Updating Linuxbrew..."
  brew update
  brew upgrade

  binaries=(
    # ZSH + prompt + plugins
    zsh
    pure
    zsh-history-substring-search
    zsh-syntax-highlighting
    zsh-completions
    zsh-autosuggestions

    # CLI tools
    bat
    eza
    git
    tmux
    vim
    diff-so-fancy
  )

  echo "Installing Linuxbrew packages..."
  brew install "${binaries[@]}"

  brew cleanup
else
  echo "Warning: Linuxbrew installation could not be verified in current session."
fi
