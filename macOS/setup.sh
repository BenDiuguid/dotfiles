#!/usr/bin/env bash

# macOS Setup Coordinator
set -e

MACOS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "==> Configuring macOS environment..."

# 1. Install Homebrew and CLI binaries
if [ -f "$MACOS_DIR/brew.sh" ]; then
  echo "--> Running macOS Homebrew packages installation..."
  source "$MACOS_DIR/brew.sh"
fi

# 2. Configure default shells
if [ -f "$MACOS_DIR/shells.sh" ]; then
  echo "--> Configuring default shells for macOS..."
  source "$MACOS_DIR/shells.sh"
fi

# 3. macOS System Defaults
if [ -f "$MACOS_DIR/defaults.sh" ]; then
  echo "--> Applying macOS system defaults..."
  source "$MACOS_DIR/defaults.sh"
fi

echo "==> macOS environment configured successfully."
