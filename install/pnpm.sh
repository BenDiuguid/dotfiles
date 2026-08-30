#!/usr/bin/env bash

# Ensure pnpm is available in current subshell PATH
if ! command -v pnpm >/dev/null 2>&1; then
  if [[ -x "/opt/homebrew/bin/pnpm" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
  elif [[ -x "/usr/local/bin/pnpm" ]]; then
    export PATH="/usr/local/bin:$PATH"
  elif [[ -x "/home/linuxbrew/.linuxbrew/bin/pnpm" ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  elif [[ -n "$PNPM_HOME" && -x "$PNPM_HOME/pnpm" ]]; then
    export PATH="$PNPM_HOME:$PATH"
  elif [[ -x "$HOME/Library/pnpm/pnpm" ]]; then
    export PATH="$HOME/Library/pnpm:$PATH"
  elif [[ -x "$HOME/.local/share/pnpm/pnpm" ]]; then
    export PATH="$HOME/.local/share/pnpm:$PATH"
  else
    # Fallback standalone installer if binary is not yet in place
    curl -fsSL https://get.pnpm.io/install.sh | sh -
  fi
fi
