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
    diff-so-fancy 2>/dev/null || true

  # Try installing modern CLI utilities if available in repos
  sudo apt-get install -y eza 2>/dev/null || true
  sudo apt-get install -y bat 2>/dev/null || true
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
    diff-so-fancy 2>/dev/null || true
}

install_linuxbrew() {
  if command -v brew >/dev/null 2>&1; then
    echo "Using Linuxbrew to install command-line utilities..."
    brew update
    brew install \
      zsh \
      tmux \
      git \
      bat \
      eza \
      diff-so-fancy \
      zsh-autosuggestions \
      zsh-syntax-highlighting \
      zsh-completions \
      zsh-history-substring-search 2>/dev/null || true
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

# 2. Linuxbrew support if installed
if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]] || command -v brew >/dev/null 2>&1; then
  [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  install_linuxbrew
fi
