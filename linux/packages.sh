#!/usr/bin/env bash

# Linux Package Installation
#
# The distro package manager installs the BASE system only (compilers, zsh,
# git, tmux, vim, clipboard helpers, and Linuxbrew's prerequisites). Modern CLI
# tools, zsh plugins, the Pure prompt, and runtimes come from the shared
# Brewfile via Linuxbrew (see linux/brew.sh), so nothing is installed twice.
#
# Core packages are installed in a single strict transaction: if one fails, the
# error is shown and setup stops. Optional packages are installed one at a time
# so a missing one only produces a warning.

install_optional() {
  local installer="$1"; shift
  local pkg
  for pkg in "$@"; do
    if ! $installer "$pkg"; then
      echo "Warning: optional package '$pkg' could not be installed; skipping."
    fi
  done
}

apt_install() { sudo apt-get install -y "$@"; }
dnf_install() { sudo dnf install -y "$@"; }
pacman_install() { sudo pacman -S --noconfirm --needed "$@"; }

install_debian() {
  echo "Detected Debian/Ubuntu-based system."
  sudo apt-get update
  apt_install \
    build-essential \
    procps \
    curl \
    file \
    git \
    zsh \
    tmux \
    vim \
    unzip \
    ca-certificates

  install_optional apt_install xclip wl-clipboard

  # Docker CLI and Compose plugins (official repo or distro fallback)
  apt_install docker-ce-cli docker-buildx-plugin docker-compose-plugin || \
    apt_install docker.io docker-compose-v2 || \
    apt_install docker.io docker-compose || \
    echo "Warning: Docker packages could not be installed; skipping."
}

install_fedora() {
  echo "Detected Fedora/RHEL-based system."
  sudo dnf check-update || true  # exits 100 when updates are available
  dnf_install \
    @development-tools \
    procps-ng \
    curl \
    file \
    git \
    zsh \
    tmux \
    vim \
    unzip \
    ca-certificates

  install_optional dnf_install xclip wl-clipboard

  # Docker CLI and Compose
  dnf_install docker-ce-cli docker-compose-plugin docker-buildx-plugin || \
    dnf_install moby-engine docker-compose || \
    echo "Warning: Docker packages could not be installed; skipping."
}

install_arch() {
  echo "Detected Arch Linux-based system."
  sudo pacman -Sy
  pacman_install \
    base-devel \
    procps-ng \
    curl \
    file \
    git \
    zsh \
    tmux \
    vim \
    unzip \
    ca-certificates

  install_optional pacman_install xclip wl-clipboard docker docker-compose docker-buildx
}


# Distro native package manager
if command -v apt-get >/dev/null 2>&1; then
  install_debian
elif command -v dnf >/dev/null 2>&1; then
  install_fedora
elif command -v pacman >/dev/null 2>&1; then
  install_arch
else
  echo "Warning: Unrecognized Linux package manager. Skipping native package installation."
fi
