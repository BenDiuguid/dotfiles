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

# 3. Configure Git credential helper for macOS Keychain
if command -v git >/dev/null 2>&1; then
  echo "--> Setting git credential helper to osxkeychain..."
  git config --global credential.helper osxkeychain
fi

# 4. Optional GUI Casks and macOS System Defaults
# [ -f "$MACOS_DIR/brew-cask.sh" ] && source "$MACOS_DIR/brew-cask.sh"
# [ -f "$MACOS_DIR/defaults.sh" ] && source "$MACOS_DIR/defaults.sh"
# [ -f "$MACOS_DIR/defaults.dock.sh" ] && source "$MACOS_DIR/defaults.dock.sh"

echo "==> macOS environment configured successfully."
