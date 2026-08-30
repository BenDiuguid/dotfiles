# Ensure fnm is available if not yet in current subshell PATH
if ! command -v fnm >/dev/null 2>&1; then
  if [[ -x "/opt/homebrew/bin/fnm" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
  elif [[ -x "/usr/local/bin/fnm" ]]; then
    export PATH="/usr/local/bin:$PATH"
  elif [[ -x "$HOME/.local/share/fnm" ]]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
  fi
fi

# Initialize fnm in this shell session
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env)"
  # Install latest LTS Node version and set as default
  fnm install --lts
  fnm default lts-latest
  fnm use lts-latest
fi

# npm completion installation
if command -v npm >/dev/null 2>&1; then
  if [[ -d "/usr/local/etc/bash_completion.d" ]]; then
    npm completion > /usr/local/etc/bash_completion.d/npm 2>/dev/null || true
  fi

  # Globally install with npm
  packages=(
    npm
    trash-cli
  )

  npm install --global "${packages[@]}"
fi

curl -fsSL https://get.pnpm.io/install.sh | sh -