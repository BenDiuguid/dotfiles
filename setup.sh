#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Make dotfiles executable.
[ -f "$DOTFILES_DIR/bin/dotfiles" ] && chmod +x $DOTFILES_DIR/bin/dotfiles

# symlink anything in the symlink folder to the user ~/ directory
ln -sfv "$DOTFILES_DIR/symlink/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/symlink/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/symlink/.hyper.js" ~
ln -sfv "$DOTFILES_DIR/symlink/.tmux.conf" ~
ln -sfv "$DOTFILES_DIR/symlink/.zshenv" ~
ln -sfv "$DOTFILES_DIR/symlink/.zshrc" ~

# Install all the things, order matters.
source "$DOTFILES_DIR/install/brew.sh"
source "$DOTFILES_DIR/install/bash.sh"
source "$DOTFILES_DIR/install/zsh.sh"
source "$DOTFILES_DIR/install/npm.sh"
source "$DOTFILES_DIR/install/gem.sh"
source "$DOTFILES_DIR/install/python.sh"
source "$DOTFILES_DIR/install/meteor.sh"
source "$DOTFILES_DIR/install/brew-cask.sh"
source "$DOTFILES_DIR/install/atom.sh"
source "$DOTFILES_DIR/install/mac.sh"

# Setup macOS defaults
source "$DOTFILES_DIR/macOS/defaults.sh"
source "$DOTFILES_DIR/macOS/defaults.dock.sh"
