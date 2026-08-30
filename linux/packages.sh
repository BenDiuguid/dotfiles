#!/usr/bin/env bash

# Linux Package Installation

install_debian() {
  echo "Detected Debian/Ubuntu-based system."
  sudo apt-get update
  sudo apt-get install -y \
    build-essential \
    curl \
    git \
    zsh \
    tmux \
    vim \
    unzip \
    procps \
    ca-certificates \
    xclip \
    wl-clipboard \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    diff-so-fancy 2>/dev/null || true

  # Try installing modern CLI utilities if available in repos
  sudo apt-get install -y eza 2>/dev/null || true
  sudo apt-get install -y bat 2>/dev/null || true
  sudo apt-get install -y zsh-history-substring-search 2>/dev/null || true
}

install_fedora() {
  echo "Detected Fedora/RHEL-based system."
  sudo dnf check-update || true
  sudo dnf install -y \
    @development-tools \
    curl \
    git \
    zsh \
    tmux \
    vim \
    unzip \
    procps-ng \
    ca-certificates \
    xclip \
    wl-clipboard \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    eza \
    bat 2>/dev/null || true
}

install_arch() {
  echo "Detected Arch Linux-based system."
  sudo pacman -Sy --noconfirm --needed \
    base-devel \
    curl \
    git \
    zsh \
    tmux \
    vim \
    unzip \
    procps-ng \
    ca-certificates \
    xclip \
    wl-clipboard \
    eza \
    bat \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zsh-completions \
    zsh-history-substring-search \
    zsh-pure-prompt \
    diff-so-fancy 2>/dev/null || true
}

install_pure() {
  local pure_dir="$HOME/.zsh/pure"
  if [ ! -d "$pure_dir" ]; then
    echo "Installing Pure prompt to $pure_dir..."
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$pure_dir"
  else
    echo "Updating Pure prompt in $pure_dir..."
    git -C "$pure_dir" pull origin main || true
  fi
  # Ensure standard symlinks exist for fpath discovery
  if [ -d "$pure_dir" ]; then
    [ -f "$pure_dir/pure.zsh" ] && ln -sfn "$pure_dir/pure.zsh" "$pure_dir/prompt_pure_setup"
    [ -f "$pure_dir/async.zsh" ] && ln -sfn "$pure_dir/async.zsh" "$pure_dir/async"
  fi
}


# 1. Distro native package manager
if command -v apt-get >/dev/null 2>&1; then
  install_debian
elif command -v dnf >/dev/null 2>&1; then
  install_fedora
elif command -v pacman >/dev/null 2>&1; then
  install_arch
else
  echo "Warning: Unrecognized Linux package manager. Skipping native package installation."
fi

# 2. Pure prompt installation fallback
install_pure


