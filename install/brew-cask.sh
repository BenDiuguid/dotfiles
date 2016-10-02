# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

# Not on brew-cask
# Shazam (from itunes)
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
  github-desktop
  google-chrome
  google-chrome-canary
  google-drive
  gopro
  hyperterm
  iterm2
  java
  opera
  polymail
  postman
  robomongo
  safari-technology-preview
  servo
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
