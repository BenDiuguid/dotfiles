#!/usr/bin/env bash

# Install the AntiGravity CLI only if it isn't already present.
# NOTE: the upstream installer appends a PATH line to ~/.zshrc, which is a
# symlink into this repo. $HOME/.local/bin is already on PATH in .zshrc, so
# running it repeatedly would just dirty the tracked file.
if ! command -v agy >/dev/null 2>&1 && [[ ! -x "$HOME/.local/bin/agy" ]]; then
  echo "Installing AntiGravity CLI..."
  curl -fsSL https://antigravity.google/cli/install.sh | bash
else
  echo "AntiGravity CLI already installed; skipping."
fi
