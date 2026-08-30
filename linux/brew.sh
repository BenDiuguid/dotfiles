#!/usr/bin/env bash

# Install Linuxbrew (Homebrew on Linux) if not already installed
if ! command -v brew >/dev/null 2>&1 && [[ ! -x "/home/linuxbrew/.linuxbrew/bin/brew" ]] && [[ ! -x "/var/home/linuxbrew/.linuxbrew/bin/brew" ]] && [[ ! -x "$HOME/.linuxbrew/bin/brew" ]]; then
  echo "Linuxbrew not found. Installing Homebrew for Linux..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Load Linuxbrew environment into the current shell session
if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x "/var/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/var/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
  eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
elif command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

# Export PATH explicitly to ensure subshells and script steps locate brew
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
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

  # Ensure Linuxbrew is also loaded in bash profiles if present
  for profile_file in "$HOME/.bashrc" "$HOME/.profile" "$HOME/.bash_profile"; do
    if [ -f "$profile_file" ] && ! grep -q "linuxbrew" "$profile_file" 2>/dev/null; then
      echo "Adding Linuxbrew shellenv to $profile_file..."
      echo -e '\n# Homebrew / Linuxbrew PATH configuration\nif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then\n  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"\nelif [[ -x "/var/home/linuxbrew/.linuxbrew/bin/brew" ]]; then\n  eval "$(/var/home/linuxbrew/.linuxbrew/bin/brew shellenv)"\nelif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then\n  eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"\nfi' >> "$profile_file"
    fi
  done
else
  echo "Warning: Linuxbrew installation could not be verified in current session."
fi
