# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

# Not on brew-cask
# Sonic Mobile Connect (from itunes)

# Install packages
apps=(
  android-file-transfer
  android-studio
  appcleaner
  atom
  blisk
  brave
  charles
  cyberduck
  discord
  docker
  firefox
  firefoxdeveloperedition
  flux
  google-chrome
  google-chrome-canary
  google-drive
  gopro
  hyper
  iterm2
  java
  opera
  postman
  robomongo
  safari-technology-preview
  skype
  slack
  sublime-text
  torbrowser
  transmission
  virtualbox
  visual-studio-code
  vivaldi
  webstorm
)

brew cask install "${apps[@]}"
