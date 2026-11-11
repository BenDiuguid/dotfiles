#!/usr/bin/env bash

# Linux Setup Coordinator
set -e

LINUX_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "==> Configuring Linux environment..."

# 1. Install base distro packages
if [ -f "$LINUX_DIR/packages.sh" ]; then
  echo "--> Running Linux distro packages installation..."
  source "$LINUX_DIR/packages.sh"
fi

# 2. Install and configure Linuxbrew (Homebrew on Linux)
if [ -f "$LINUX_DIR/brew.sh" ]; then
  echo "--> Running Linuxbrew installation & packages..."
  source "$LINUX_DIR/brew.sh"
fi

# 3. Configure default shells
if [ -f "$LINUX_DIR/shells.sh" ]; then
  echo "--> Configuring default shells for Linux..."
  source "$LINUX_DIR/shells.sh"
fi

echo "==> Linux environment configured successfully."
