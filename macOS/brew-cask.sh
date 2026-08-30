#!/usr/bin/env bash

# Tap extra homebrew casks
brew tap homebrew/cask-versions 2>/dev/null || true

# GUI Applications
apps=(
  appcleaner
  brave-browser
  bricklink-studio
  docker
  elgato-stream-deck
  figma
  # google-chrome
  # plantronics-hub
  # postgres-unofficial
  # tor-browser
  # visual-studio-code
)

echo "Installing macOS GUI applications via Homebrew Cask..."
brew install --cask "${apps[@]}"
