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
ln -sfv "$DOTFILES_DIR/symlink/.inputrc" ~
ln -sfv "$DOTFILES_DIR/symlink/.tmux.conf" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~

# Package managers & packages
. "$DOTFILES_DIR/install/brew.sh"
. "$DOTFILES_DIR/install/bash.sh"
. "$DOTFILES_DIR/install/npm.sh"
. "$DOTFILES_DIR/install/gem.sh"
. "$DOTFILES_DIR/install/brew-cask.sh"
. "$DOTFILES_DIR/install/atom.sh"
. "$DOTFILES_DIR/install/meteor.sh"
. "$DOTFILES_DIR/osx/defaults.sh"
. "$DOTFILES_DIR/osx/defaults.dock.sh"

# Run tests
# bats test/*.bats
