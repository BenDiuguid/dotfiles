# ==============================================================================
# Ben Diuguid's .zshrc
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. ENVIRONMENT & SHELL OPTIONS
# ------------------------------------------------------------------------------
# History configuration
export HISTFILE="$HOME/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000

# Color and Localization
export CLICOLOR=1
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Default Editor
export EDITOR="code"

# Tooling environment flags
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
command -v chromium >/dev/null 2>&1 && export PUPPETEER_EXECUTABLE_PATH="$(command -v chromium)"

# Shell Options (http://zsh.sourceforge.net/Doc/Release/Options.html)
setopt \
  AUTO_LIST \
  PROMPT_SUBST \
  SHARE_HISTORY \
  EXTENDED_HISTORY \
  EXTENDED_GLOB \
  HIST_IGNORE_DUPS \
  HIST_REDUCE_BLANKS

unsetopt \
  LIST_AMBIGUOUS \
  CASE_GLOB

# ------------------------------------------------------------------------------
# 2. PLATFORM & PACKAGE MANAGER DETECTION
# ------------------------------------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
  IS_MACOS=true
  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  IS_MACOS=false
  if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# ------------------------------------------------------------------------------
# 3. PATH CONFIGURATION
# ------------------------------------------------------------------------------
# Ensure unique PATH and fpath entries in Zsh (automatic deduplication)
typeset -U path PATH fpath FPATH

# Additional completion and function directories before compinit
if [[ -n "${HOMEBREW_PREFIX}" ]]; then
  [[ -d "${HOMEBREW_PREFIX}/share/zsh/site-functions" ]] && fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)
  [[ -d "${HOMEBREW_PREFIX}/share/zsh-completions" ]] && fpath=("${HOMEBREW_PREFIX}/share/zsh-completions" $fpath)
fi

# Assemble standard & custom user paths in order of preference
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.antigravity/antigravity/bin"
  "$HOME/.antigravity-ide/antigravity-ide/bin"
  /usr/local/sbin
  /usr/local/bin
  /usr/sbin
  /usr/bin
  /sbin
  /bin
  $path
)
export PATH

# PNPM setup (dynamic path for macOS vs Linux)
if [[ "$IS_MACOS" == true ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi
[[ -d "$PNPM_HOME" ]] && path=("$PNPM_HOME" $path)

# Source local bin env if provided
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# FNM (Fast Node Manager) initialization
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi

# Bun setup
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && path=("$BUN_INSTALL/bin" $path)

# ------------------------------------------------------------------------------
# 4. COMPLETIONS & PROMPT
# ------------------------------------------------------------------------------
autoload -Uz compinit promptinit colors
compinit
promptinit
colors

# Completion match styling (case-insensitive autocomplete)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# Shell completions for uv & uvx
if command -v uv >/dev/null 2>&1; then
  eval "$(uv generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
fi

# Shell completions for Bun
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# Pure prompt (if available)
prompt pure 2>/dev/null || true

# ------------------------------------------------------------------------------
# 5. ALIASES & CUSTOM FUNCTIONS
# ------------------------------------------------------------------------------
# Quick reload
alias reSource='source ~/.zshrc && echo "Sourced ~/.zshrc!"'

# Navigation
alias ..='cd ../'
alias ...='cd ../../'

# Directory Listing
alias ls='ls -GF'
alias la='ls -A'
alias ld='ls -d */'

# Utilities
command -v trash >/dev/null 2>&1 && alias rm='trash'

alias colorTest='for x in 0 1 4 5 7 8; do for i in $(seq 30 37); do for a in $(seq 40 47); do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'

# macOS-specific aliases & utilities
if [[ "$IS_MACOS" == true ]]; then
  alias cpwd='pwd | tr -d "\n" | pbcopy'
  alias ipaddr='ipconfig getifaddr en0'

  # Finder defaults
  alias hiddenFilesShow='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
  alias hiddenFilesHide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
  alias fileExtensionsShow='defaults write NSGlobalDomain AppleShowAllExtensions -bool true && killall Finder'
  alias fileExtensionsHide='defaults write NSGlobalDomain AppleShowAllExtensions -bool false && killall Finder'
fi

# ------------------------------------------------------------------------------
# 6. PLUGINS & KEYBINDINGS
# ------------------------------------------------------------------------------
# Plugin directory search (Homebrew prefix or Linux standard)
PLUGIN_DIR="${HOMEBREW_PREFIX:-/opt/homebrew}/share"

if [[ -d "$PLUGIN_DIR/zsh-syntax-highlighting/highlighters" ]]; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$PLUGIN_DIR/zsh-syntax-highlighting/highlighters"
fi

for plugin in \
  "zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "zsh-history-substring-search/zsh-history-substring-search.zsh"; do
  [[ -f "$PLUGIN_DIR/$plugin" ]] && source "$PLUGIN_DIR/$plugin"
done

# Keybindings for history substring search (if plugin is loaded)
if (( $+functions[history-substring-search-up] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# ------------------------------------------------------------------------------
# 7. LOCAL OVERRIDES
# ------------------------------------------------------------------------------
# Machine-specific, private, or work configurations (ignored by git)
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

