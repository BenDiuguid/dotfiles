#!/usr/bin/env bash

# ==============================================================================
# Dotfiles Environment Doctor & Validation Suite
# ==============================================================================
# Audits symlinks, shell syntax, prompt setup, plugins, CLI tools, runtimes,
# and git configuration across macOS and Linux.
# ==============================================================================

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Output colors
RESET="\033[0m"
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
CYAN="\033[36m"

# Tally counters
TOTAL_CHECKS=0
PASSED_CHECKS=0
WARNED_CHECKS=0
FAILED_CHECKS=0

# OS Detection
OS_TYPE="$(uname -s)"
if [[ "$OSTYPE" == darwin* ]] || [[ "$OS_TYPE" == "Darwin" ]]; then
  IS_MACOS=true
else
  IS_MACOS=false
fi

print_header() {
  echo -e "\n${BOLD}${BLUE}=== $1 ===${RESET}"
}

pass() {
  ((TOTAL_CHECKS++))
  ((PASSED_CHECKS++))
  echo -e "  [${GREEN}PASS${RESET}] $1"
}

warn() {
  ((TOTAL_CHECKS++))
  ((WARNED_CHECKS++))
  echo -e "  [${YELLOW}WARN${RESET}] $1"
  if [ -n "$2" ]; then
    echo -e "         ${CYAN}↳ Recommendation:${RESET} $2"
  fi
}

fail() {
  ((TOTAL_CHECKS++))
  ((FAILED_CHECKS++))
  echo -e "  [${RED}FAIL${RESET}] $1"
  if [ -n "$2" ]; then
    echo -e "         ${CYAN}↳ Fix:${RESET} $2"
  fi
}

# ------------------------------------------------------------------------------
# 1. SYMLINKS AUDIT
# ------------------------------------------------------------------------------
audit_symlinks() {
  print_header "1. Symlink & Configuration Integrity"

  # Check root dotfiles in symlink/
  for src_file in "$DOTFILES_DIR"/symlink/{*,.*}; do
    [ -e "$src_file" ] || continue
    basename="$(basename "$src_file")"
    if [[ "$basename" == "." || "$basename" == ".." || "$basename" == ".git" || "$basename" == "*" || "$basename" == ".*" ]]; then
      continue
    fi

    if [[ "$basename" == ".config" && -d "$src_file" ]]; then
      for app_dir in "$src_file"/*; do
        [ -e "$app_dir" ] || continue
        app_name="$(basename "$app_dir")"
        target="$HOME/.config/$app_name"

        if [ -L "$target" ]; then
          resolved="$(readlink "$target" 2>/dev/null || true)"
          if [ -e "$target" ]; then
            pass "Symlink ~/.config/$app_name -> $resolved"
          else
            fail "Broken symlink ~/.config/$app_name points to missing target: $resolved" "Re-run ./setup.sh to restore symlinks."
          fi
        elif [ -e "$target" ]; then
          warn "~/.config/$app_name exists but is NOT a symlink (manual directory/file)." "Delete or back up ~/.config/$app_name and run ./setup.sh."
        else
          warn "Symlink ~/.config/$app_name not found in \$HOME." "Run ./setup.sh to link ~/.config/$app_name."
        fi
      done
    else
      target="$HOME/$basename"
      if [ -L "$target" ]; then
        resolved="$(readlink "$target" 2>/dev/null || true)"
        if [ -e "$target" ]; then
          pass "Symlink ~/$basename -> $resolved"
        else
          fail "Broken symlink ~/$basename points to missing target: $resolved" "Re-run ./setup.sh to restore symlinks."
        fi
      elif [ -e "$target" ]; then
        warn "~/$basename exists in \$HOME but is NOT a symlink." "Run ./setup.sh to link repo dotfiles."
      else
        warn "Symlink ~/$basename not found in \$HOME." "Run ./setup.sh to create symlink."
      fi
    fi
  done
}

# ------------------------------------------------------------------------------
# 2. SHELL SYNTAX & STARTUP
# ------------------------------------------------------------------------------
audit_shell_startup() {
  print_header "2. Zsh Shell & Startup Lifecycle"

  if ! command -v zsh >/dev/null 2>&1; then
    fail "Zsh shell is not installed or not in PATH." "Install zsh via package manager."
    return
  fi

  pass "Zsh binary found ($(zsh --version))"

  # Validate repository .zshrc syntax
  local repo_zshrc="$DOTFILES_DIR/symlink/.zshrc"
  if [ -f "$repo_zshrc" ]; then
    if zsh -n "$repo_zshrc" 2>/dev/null; then
      pass "Repository symlink/.zshrc syntax is valid."
    else
      fail "Repository symlink/.zshrc has syntax errors!" "Inspect symlink/.zshrc for syntax mistakes."
    fi
  fi

  # Validate $HOME/.zshrc if present and readable
  if [ -f "$HOME/.zshrc" ]; then
    if zsh -n "$HOME/.zshrc" 2>/dev/null; then
      pass "~/.zshrc syntax is valid."
    fi

    startup_errors="$(zsh -f -c "source $HOME/.zshrc" 2>&1 || true)"
    if [ -z "$startup_errors" ]; then
      pass "Zsh evaluated ~/.zshrc cleanly with 0 startup errors."
    else
      warn "Zsh emitted output when evaluating ~/.zshrc:" "$startup_errors"
    fi
  fi
}

# ------------------------------------------------------------------------------
# 3. PURE PROMPT & ZSH PLUGINS
# ------------------------------------------------------------------------------
audit_prompt_and_plugins() {
  print_header "3. Pure Prompt & Zsh Plugins"

  pure_found=false
  if [ -d "$HOME/.zsh/pure" ]; then
    pure_found=true
  fi

  if command -v brew >/dev/null 2>&1; then
    brew_prefix="$(brew --prefix 2>/dev/null || true)"
    if [[ -n "$brew_prefix" && -f "$brew_prefix/share/zsh/site-functions/prompt_pure_setup" ]]; then
      pure_found=true
    fi
  fi

  if [[ -f "/usr/share/zsh/functions/Prompts/prompt_pure_setup" || -f "/usr/share/zsh/site-functions/prompt_pure_setup" || -f "/usr/local/share/zsh/site-functions/prompt_pure_setup" ]]; then
    pure_found=true
  fi

  # Test Pure initialization in zsh
  pure_init_test="$(zsh -f -c "
    if [[ -x '/opt/homebrew/bin/brew' ]]; then eval \"\$(/opt/homebrew/bin/brew shellenv)\"; fi
    if [[ -x '/usr/local/bin/brew' ]]; then eval \"\$(/usr/local/bin/brew shellenv)\"; fi
    if [[ -x '/home/linuxbrew/.linuxbrew/bin/brew' ]]; then eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"; fi
    if [[ -n \"\$HOMEBREW_PREFIX\" ]]; then fpath=(\"\$HOMEBREW_PREFIX/share/zsh/site-functions\" \$fpath); fi
    [[ -d \"\$HOME/.zsh/pure\" ]] && fpath=(\"\$HOME/.zsh/pure\" \$fpath)
    fpath=(/usr/local/share/zsh/site-functions /usr/share/zsh/site-functions \$fpath)
    autoload -Uz promptinit && promptinit && prompt pure 2>&1
  " 2>&1 || true)"

  if [ -z "$pure_init_test" ]; then
    pass "Pure prompt is installed and initializes cleanly in Zsh."
  else
    if [ "$pure_found" = true ]; then
      warn "Pure prompt files exist, but initialization returned an error:" "$pure_init_test"
    else
      if [ "$IS_MACOS" = true ]; then
        fail "Pure prompt is not installed." "Run 'brew install pure' or ./setup.sh."
      else
        fail "Pure prompt is not installed." "Run 'git clone https://github.com/sindresorhus/pure.git ~/.zsh/pure' or ./setup.sh."
      fi
    fi
  fi

  # Check Zsh plugins
  plugins=(
    "zsh-autosuggestions:zsh-autosuggestions/zsh-autosuggestions.zsh:brew install zsh-autosuggestions / apt install zsh-autosuggestions"
    "zsh-syntax-highlighting:zsh-syntax-highlighting/zsh-syntax-highlighting.zsh:brew install zsh-syntax-highlighting / apt install zsh-syntax-highlighting"
    "zsh-history-substring-search:zsh-history-substring-search/zsh-history-substring-search.zsh:brew install zsh-history-substring-search / apt install zsh-history-substring-search"
  )

  search_dirs=(
    "/opt/homebrew/share"
    "/usr/local/share"
    "/home/linuxbrew/.linuxbrew/share"
    "$HOME/.linuxbrew/share"
    "/usr/share"
    "$HOME/.zsh"
  )
  if command -v brew >/dev/null 2>&1; then
    bprefix="$(brew --prefix 2>/dev/null || true)"
    [[ -n "$bprefix" ]] && search_dirs=("$bprefix/share" "${search_dirs[@]}")
  fi

  for item in "${plugins[@]}"; do
    IFS=":" read -r name relpath install_tip <<< "$item"
    plugin_found=false

    for dir in "${search_dirs[@]}"; do
      if [[ -f "$dir/$relpath" ]]; then
        plugin_found=true
        pass "Plugin '$name' found at $dir/$relpath"
        break
      fi
    done

    if [ "$plugin_found" = false ]; then
      warn "Plugin '$name' is not installed in standard search paths." "$install_tip"
    fi
  done
}

# ------------------------------------------------------------------------------
# 4. CLI TOOLS & UTILITIES
# ------------------------------------------------------------------------------
audit_cli_tools() {
  print_header "4. Core CLI Tools & Utilities"

  core_tools=(
    "git:brew install git / apt install git"
    "tmux:brew install tmux / apt install tmux"
    "vim:brew install vim / apt install vim"
  )

  for item in "${core_tools[@]}"; do
    IFS=":" read -r tool fix <<< "$item"
    if command -v "$tool" >/dev/null 2>&1; then
      pass "Core tool '$tool' is available ($(command -v "$tool"))"
    else
      fail "Core tool '$tool' is missing!" "$fix"
    fi
  done

  # Modern CLI replacements
  if command -v eza >/dev/null 2>&1; then
    pass "Modern ls replacement 'eza' is available."
  else
    warn "'eza' (modern ls replacement) is not installed." "Install via brew install eza / cargo / distro repo."
  fi

  if command -v bat >/dev/null 2>&1 || command -v batcat >/dev/null 2>&1; then
    pass "Syntax pager 'bat' is available."
  else
    warn "'bat' (cat clone with syntax highlighting) is not installed." "Install via brew install bat / apt install bat."
  fi

  if command -v diff-so-fancy >/dev/null 2>&1; then
    pass "Git pager 'diff-so-fancy' is available."
  else
    warn "'diff-so-fancy' is not installed." "Install via brew install diff-so-fancy / npm install -g diff-so-fancy."
  fi

  # Docker CLI & Plugins
  if command -v docker >/dev/null 2>&1; then
    pass "Docker CLI is available ($(command -v docker))"

    if docker compose version >/dev/null 2>&1; then
      compose_ver="$(docker compose version 2>/dev/null | head -n 1)"
      pass "Docker Compose is available ($compose_ver)"
    elif command -v docker-compose >/dev/null 2>&1; then
      pass "Docker Compose (standalone) is available ($(command -v docker-compose))"
    else
      warn "Docker Compose is not available." "Install docker-compose-plugin or docker-compose."
    fi

    if docker buildx version >/dev/null 2>&1; then
      buildx_ver="$(docker buildx version 2>/dev/null | head -n 1)"
      pass "Docker Buildx is available ($buildx_ver)"
    else
      warn "Docker Buildx plugin is not installed." "Install docker-buildx-plugin."
    fi
  else
    echo -e "  [${CYAN}SKIP${RESET}] Docker CLI not installed (optional; add to ~/.Brewfile.local on machines that need it)."
  fi

  # Clipboard integration
  if [ "$IS_MACOS" = true ]; then
    if command -v pbcopy >/dev/null 2>&1 && command -v pbpaste >/dev/null 2>&1; then
      pass "macOS clipboard (pbcopy/pbpaste) is available."
    else
      fail "macOS pbcopy/pbpaste not found."
    fi
  else
    if command -v wl-copy >/dev/null 2>&1; then
      pass "Wayland clipboard (wl-copy) is available."
    elif command -v xclip >/dev/null 2>&1; then
      pass "X11 clipboard (xclip) is available."
    else
      warn "No Linux clipboard helper (wl-clipboard or xclip) detected." "Install via 'sudo apt install wl-clipboard xclip' or distro equivalent."
    fi
  fi
}

# ------------------------------------------------------------------------------
# 5. RUNTIMES & PACKAGE MANAGERS
# ------------------------------------------------------------------------------
audit_runtimes() {
  print_header "5. Language Runtimes & Package Managers"

  # FNM / Node
  if command -v fnm >/dev/null 2>&1 || [[ -x "$HOME/.local/share/fnm/fnm" ]] || [[ -x "$HOME/.fnm/fnm" ]]; then
    pass "FNM (Fast Node Manager) is installed."
    if ! command -v node >/dev/null 2>&1; then
      if command -v fnm >/dev/null 2>&1; then
        eval "$(fnm env 2>/dev/null)" || true
      elif [[ -x "$HOME/.local/share/fnm/fnm" ]]; then
        eval "$("$HOME/.local/share/fnm/fnm" env 2>/dev/null)" || true
      fi
    fi
    node_ver="$(node --version 2>/dev/null || true)"
    if [ -n "$node_ver" ]; then
      pass "Node is available ($node_ver)."
    else
      warn "Node binary not currently available or failed to execute." "Run 'fnm use --lts' or ensure fnm env is evaluated."
    fi
  else
    fail "FNM is not installed." "Run ./setup.sh or source install/node.sh."
  fi

  # PNPM
  if command -v pnpm >/dev/null 2>&1 || [[ -d "$HOME/Library/pnpm" ]] || [[ -d "$HOME/.local/share/pnpm" ]]; then
    pass "pnpm is installed."
  else
    fail "pnpm is not installed." "Run ./setup.sh or source install/pnpm.sh."
  fi

  # Bun
  if command -v bun >/dev/null 2>&1 || [[ -x "$HOME/.bun/bin/bun" ]]; then
    pass "Bun runtime is installed."
  else
    warn "Bun runtime is not installed." "Run ./setup.sh or source install/bun.sh."
  fi

  # uv / Python
  if command -v uv >/dev/null 2>&1 || [[ -x "$HOME/.local/bin/uv" ]] || [[ -x "$HOME/.cargo/bin/uv" ]]; then
    pass "uv (Python package manager) is installed."
  else
    warn "uv is not installed." "Run ./setup.sh or source install/python.sh."
  fi

  if command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1; then
    py_ver="$(python3 --version 2>/dev/null || python --version 2>/dev/null)"
    pass "Python is available ($py_ver)."
  else
    warn "Python runtime not detected." "Run 'uv python install' or ./setup.sh."
  fi

  # AntiGravity CLI
  if command -v agy >/dev/null 2>&1 || [[ -x "$HOME/.local/bin/agy" ]] || [[ -x "$HOME/.antigravity/antigravity/bin/agy" ]]; then
    pass "AntiGravity CLI (agy) is installed."
  else
    warn "AntiGravity CLI (agy) is not installed." "Run ./setup.sh or curl -fsSL https://antigravity.google/cli/install.sh | bash"
  fi
}

# ------------------------------------------------------------------------------
# 6. GIT & GLOBAL CONFIGURATION
# ------------------------------------------------------------------------------
audit_git_config() {
  print_header "6. Git Global Configuration"

  if command -v git >/dev/null 2>&1; then
    # Global ignore
    core_excludes="$(git config --global core.excludesfile 2>/dev/null || true)"
    if [[ -n "$core_excludes" ]]; then
      pass "Git core.excludesfile configured: $core_excludes"
    else
      warn "Git core.excludesfile is not set." "Run 'git config --global core.excludesfile ~/.gitignore_global'."
    fi
  else
    fail "Git is not installed."
  fi
}

# ------------------------------------------------------------------------------
# MAIN EXECUTION
# ------------------------------------------------------------------------------
echo "================================================================="
echo -e "${BOLD} Dotfiles Doctor & Validation Suite${RESET}"
echo " Host OS: $OS_TYPE (macOS: $IS_MACOS)"
echo " Dotfiles Root: $DOTFILES_DIR"
echo "================================================================="

audit_symlinks
audit_shell_startup
audit_prompt_and_plugins
audit_cli_tools
audit_runtimes
audit_git_config

echo -e "\n================================================================="
echo -e "${BOLD} Validation Summary${RESET}"
echo "================================================================="
echo -e " Total Checks: $TOTAL_CHECKS"
echo -e "   ${GREEN}Passed:${RESET}   $PASSED_CHECKS"
echo -e "   ${YELLOW}Warnings:${RESET} $WARNED_CHECKS"
echo -e "   ${RED}Failed:${RESET}   $FAILED_CHECKS"

if [ "$FAILED_CHECKS" -eq 0 ]; then
  if [ "$WARNED_CHECKS" -eq 0 ]; then
    echo -e "\n${BOLD}${GREEN}🎉 All dotfiles configurations and dependencies are healthy!${RESET}\n"
  else
    echo -e "\n${BOLD}${YELLOW}⚠️  Dotfiles setup is functional, but with $WARNED_CHECKS warning(s) above.${RESET}\n"
  fi
  exit 0
else
  echo -e "\n${BOLD}${RED}❌ Found $FAILED_CHECKS configuration failure(s). Please review fixes above.${RESET}\n"
  exit 1
fi
