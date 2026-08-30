#!/usr/bin/env bash

# Configure macOS shells
BREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null || echo '/opt/homebrew')}"

# Register Homebrew Bash
if [[ -x "$BREW_PREFIX/bin/bash" ]]; then
  grep -q "$BREW_PREFIX/bin/bash" /private/etc/shells 2>/dev/null || \
    sudo bash -c "echo $BREW_PREFIX/bin/bash >> /private/etc/shells"
fi

# Register Homebrew Zsh
if [[ -x "$BREW_PREFIX/bin/zsh" ]]; then
  grep -q "$BREW_PREFIX/bin/zsh" /private/etc/shells 2>/dev/null || \
    sudo bash -c "echo $BREW_PREFIX/bin/zsh >> /private/etc/shells"
  
  # Change default shell to Homebrew Zsh if not already set
  if [[ "$SHELL" != "$BREW_PREFIX/bin/zsh" ]]; then
    echo "Changing default shell to $BREW_PREFIX/bin/zsh..."
    chsh -s "$BREW_PREFIX/bin/zsh" 2>/dev/null || true
  fi
fi
