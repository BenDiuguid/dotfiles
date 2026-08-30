#!/usr/bin/env bash

# Linux Setup Coordinator
set -e

LINUX_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "==> Configuring Linux environment..."

# 1. Install packages via distro package manager or Linuxbrew
if [ -f "$LINUX_DIR/packages.sh" ]; then
  echo "--> Running Linux packages installation..."
  source "$LINUX_DIR/packages.sh"
fi

# 2. Configure default shells
if [ -f "$LINUX_DIR/shells.sh" ]; then
  echo "--> Configuring default shells for Linux..."
  source "$LINUX_DIR/shells.sh"
fi

# 3. Configure Git credential helper for Linux
if command -v git >/dev/null 2>&1; then
  echo "--> Setting git credential helper to cache..."
  git config --global credential.helper "cache --timeout=3600"
fi

echo "==> Linux environment configured successfully."
