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
  deco
  discord
  docker
  firefox
  firefoxdeveloperedition
  flux
  google-chrome
  google-chrome-canary
  google-drive
  hyper
  iterm2
  java
  opera
  origami-studio
  postman
  robomongo
  safari-technology-preview
  skype
  slack
  sublime-text
  torbrowser
  transmission
  virtualbox
  visual-studio
  visual-studio-code
  vivaldi
  webstorm
  zoomus
)

brew cask install "${apps[@]}"
