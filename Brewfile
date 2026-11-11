# ==============================================================================
# Ben Diuguid's Brewfile (shared by macOS Homebrew and Linuxbrew)
# ==============================================================================
# Installed by `brew bundle --file=~/.dotfiles/Brewfile` (see macOS/brew.sh and
# linux/brew.sh). Check drift with `brew bundle check --file=~/.dotfiles/Brewfile`.
#
# Machine-specific extras belong in ~/.Brewfile.local, which setup installs
# automatically if present.
# ==============================================================================

# ------------------------------------------------------------------------------
# Zsh prompt + plugins
# ------------------------------------------------------------------------------
brew "pure"
brew "zsh-autosuggestions"
brew "zsh-completions"
brew "zsh-history-substring-search"
brew "zsh-syntax-highlighting"

# ------------------------------------------------------------------------------
# Node, Python & JS runtime managers
# ------------------------------------------------------------------------------
brew "fnm"
brew "pnpm"
brew "uv"
brew "bun"

# ------------------------------------------------------------------------------
# CLI tools
# ------------------------------------------------------------------------------
brew "bat"
brew "eza"
brew "diff-so-fancy"

# ------------------------------------------------------------------------------
# macOS only (on Linux these come from the distro package manager, see
# linux/packages.sh, or aren't needed)
# ------------------------------------------------------------------------------
if OS.mac?
  # Modern bash 5 for scripts using `#!/usr/bin/env bash` (macOS ships 3.2)
  brew "bash"
  brew "zsh"
  brew "git"
  brew "tmux"
  brew "vim"
  brew "xan"
  brew "dockutil"

  # Docker CLI + plugins (on Linux, Docker comes from the distro; see packages.sh)
  brew "docker"
  brew "docker-compose"
  brew "docker-buildx"
end
