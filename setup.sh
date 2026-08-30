#!/usr/bin/env bash

# Dotfiles Setup Coordinator
set -e

# Get current dir (so this script can run from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "================================================================="
echo " Setting up dotfiles from $DOTFILES_DIR"
echo "================================================================="

# 1. Update dotfiles itself first if managed by git
if [ -d "$DOTFILES_DIR/.git" ]; then
  echo "==> Pulling latest dotfiles changes from git..."
  git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master || true
fi

# 2. Make custom scripts in bin/ executable if present
[ -f "$DOTFILES_DIR/bin/dotfiles" ] && chmod +x "$DOTFILES_DIR/bin/dotfiles"

# 3. Symlink anything in the symlink folder to the user home directory
echo "==> Creating dotfile symlinks in $HOME..."
for file in "$DOTFILES_DIR"/symlink/.*; do
  basename="$(basename "$file")"
  if [[ "$basename" == "." || "$basename" == ".." || "$basename" == ".git" ]]; then
    continue
  fi

  if [[ "$basename" == ".config" && -d "$file" ]]; then
    # Symlink individual application directories in ~/.config without replacing ~/.config
    mkdir -p "$HOME/.config"
    for app_dir in "$file"/*; do
      [ -e "$app_dir" ] || continue
      app_name="$(basename "$app_dir")"
      ln -sfnv "$app_dir" "$HOME/.config/$app_name"
    done
  else
    ln -sfv "$file" "$HOME/$basename"
  fi
done

# 4. OS Detection and OS-specific setup
OS_TYPE="$(uname -s)"
echo "==> Detected Operating System: $OS_TYPE"

if [[ "$OSTYPE" == darwin* ]] || [[ "$OS_TYPE" == "Darwin" ]]; then
  if [ -f "$DOTFILES_DIR/macOS/setup.sh" ]; then
    echo "==> Executing macOS setup..."
    source "$DOTFILES_DIR/macOS/setup.sh"
  fi
elif [[ "$OSTYPE" == linux* ]] || [[ "$OS_TYPE" == "Linux" ]]; then
  if [ -f "$DOTFILES_DIR/linux/setup.sh" ]; then
    echo "==> Executing Linux setup..."
    source "$DOTFILES_DIR/linux/setup.sh"
  fi
else
  echo "Warning: Unsupported OS ($OS_TYPE). Skipping OS-specific setup."
fi

# 5. Shared language runtimes & tooling (order matters)
echo "==> Installing cross-platform runtimes & CLI tools..."
[ -f "$DOTFILES_DIR/install/node.sh" ] && source "$DOTFILES_DIR/install/node.sh"
[ -f "$DOTFILES_DIR/install/pnpm.sh" ] && source "$DOTFILES_DIR/install/pnpm.sh"
[ -f "$DOTFILES_DIR/install/agy.sh" ] && source "$DOTFILES_DIR/install/agy.sh"
[ -f "$DOTFILES_DIR/install/bun.sh" ] && source "$DOTFILES_DIR/install/bun.sh"
[ -f "$DOTFILES_DIR/install/python.sh" ] && source "$DOTFILES_DIR/install/python.sh"

# 6. Validate environment health
if [ -f "$DOTFILES_DIR/validate.sh" ] && [[ "$*" != *"--skip-validate"* ]]; then
  echo ""
  "$DOTFILES_DIR/validate.sh" || true
fi

echo "================================================================="
echo " Dotfiles setup completed successfully!"
echo " Reload your shell or run 'reSource' / 'source ~/.zshrc' to apply."
echo "================================================================="
