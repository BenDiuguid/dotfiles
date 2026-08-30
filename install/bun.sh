#!/usr/bin/env bash

# Ensure bun is available in current subshell PATH
if ! command -v bun >/dev/null 2>&1; then
  if [[ -x "/opt/homebrew/bin/bun" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
  elif [[ -x "/usr/local/bin/bun" ]]; then
    export PATH="/usr/local/bin:$PATH"
  elif [[ -x "/home/linuxbrew/.linuxbrew/bin/bun" ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  elif [[ -x "$HOME/.bun/bin/bun" ]]; then
    export PATH="$HOME/.bun/bin:$PATH"
  else
    # Fallback standalone installer
    curl -fsSL https://bun.sh/install | bash
    export PATH="$HOME/.bun/bin:$PATH"
  fi
fi
