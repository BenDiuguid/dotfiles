# Tap extra homebrew casks.
brew tap homebrew/cask-versions
brew tap homebrew/cask-drivers

# Install packages
apps=(
  appcleaner
  brave-browser
  bricklink-studio
  docker
  elgato-stream-deck
  figma
  firefox
  google-chrome
  hyper
  plantronics-hub
  postgres-unofficial
  tor-browser
  visual-studio-code
)

brew install --cask "${apps[@]}"
