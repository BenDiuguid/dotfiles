# Ensure uv is available in current subshell PATH
if ! command -v uv >/dev/null 2>&1; then
  if [[ -x "/opt/homebrew/bin/uv" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
  elif [[ -x "/usr/local/bin/uv" ]]; then
    export PATH="/usr/local/bin:$PATH"
  elif [[ -x "$HOME/.local/bin/uv" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
  else
    # Fallback standalone installer if Homebrew binary is not yet in place
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
  fi
fi

# Install latest Python
if command -v uv >/dev/null 2>&1; then
  uv python install
fi