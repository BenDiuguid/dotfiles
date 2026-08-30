#!/usr/bin/env bash

# Configure Linux shells

ZSH_PATH="$(command -v zsh 2>/dev/null || true)"

if [[ -n "$ZSH_PATH" && -x "$ZSH_PATH" ]]; then
  # Register zsh in /etc/shells if not already present
  if ! grep -q "^$ZSH_PATH$" /etc/shells 2>/dev/null; then
    echo "Adding $ZSH_PATH to /etc/shells..."
    sudo bash -c "echo $ZSH_PATH >> /etc/shells" 2>/dev/null || true
  fi

  # Change default shell to zsh if not already set
  if [[ "$SHELL" != "$ZSH_PATH" ]]; then
    echo "Changing default shell to $ZSH_PATH..."
    chsh -s "$ZSH_PATH" "$USER" 2>/dev/null || chsh -s "$ZSH_PATH" 2>/dev/null || true
  fi
fi
