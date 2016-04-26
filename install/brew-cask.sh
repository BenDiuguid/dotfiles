# Install Caskroom
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install packages
apps=(
  android-file-transfer
  android-studio
  appcleaner
  brave
  charles
  cyberduck
  discord
  drop-to-gif
  firefox
  firefoxdeveloperedition
  flux
  github-desktop
  google-chrome
  google-chrome-canary
  google-drive
  gopro
  java
  opera
  polymail
  robomongo
  safari-technology-preview
  skype
  slack
  sococo
  sublime-text3
  torbrowser
  virtualbox
  visual-studio-code
  vivaldi
  webstorm
)

brew cask install "${apps[@]}"
