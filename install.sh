#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR #EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# EXTRA_DIR="$HOME/.extra"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Make dotfiles executable.
[ -f "$DOTFILES_DIR/bin/dotfiles" ] && chmod +x $DOTFILES_DIR/bin/dotfiles

# Bunch of symlinks
ln -sfv "$DOTFILES_DIR/symlink/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/symlink/.zshrc" ~
ln -sfv "$DOTFILES_DIR/symlink/.zshenv" ~
ln -sfv "$DOTFILES_DIR/symlink/.inputrc" ~
ln -sfv "$DOTFILES_DIR/symlink/.tmux.conf" ~
ln -sfv "$DOTFILES_DIR/symlink/.eslintrc.yml" ~
ln -sfv "$DOTFILES_DIR/symlink/.hyperterm.js" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~


# Package managers & packages
source "$DOTFILES_DIR/install/brew.sh"
source "$DOTFILES_DIR/install/bash.sh"
source "$DOTFILES_DIR/install/zsh.sh"
source "$DOTFILES_DIR/install/npm.sh"
source "$DOTFILES_DIR/install/gem.sh"
source "$DOTFILES_DIR/install/brew-cask.sh"
source "$DOTFILES_DIR/install/atom.sh"
source "$DOTFILES_DIR/install/meteor.sh"
source "$DOTFILES_DIR/osx/defaults.sh"
source "$DOTFILES_DIR/osx/defaults.dock.sh"

# Run tests
# bats test/*.bats
