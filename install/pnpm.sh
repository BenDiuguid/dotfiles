# Ensure pnpm is available in current subshell PATH
if ! command -v pnpm >/dev/null 2>&1; then
  if [[ -x "/opt/homebrew/bin/pnpm" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
  elif [[ -x "/usr/local/bin/pnpm" ]]; then
    export PATH="/usr/local/bin:$PATH"
  elif [[ -n "$PNPM_HOME" && -x "$PNPM_HOME/pnpm" ]]; then
    export PATH="$PNPM_HOME:$PATH"
  else
    # Fallback standalone installer if Homebrew binary is not yet in place
    curl -fsSL https://get.pnpm.io/install.sh | sh -
  fi
fi
