#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Make dotfiles executable.
[ -f "$DOTFILES_DIR/bin/dotfiles" ] && chmod +x $DOTFILES_DIR/bin/dotfiles

# symlink anything in the symlink folder to the user ~/ directory
for FILE in "$DOTFILES_DIR"/symlink/(.)**; ln -sfv $FILE ~

# Install all the things, and setup macOS defaults
for FILE in "$DOTFILES_DIR"/{install,macOS}/**(.); source $FILE
