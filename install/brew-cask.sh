# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

# Not on brew-cask
# Ableton Live Lite ( https://www.ableton.com/en/products/live-lite/ )
# Soundbrenner DAW ( http://www.soundbrenner.com/daw-tools/ )
# zeit now-desktop ( https://zeit.co/desktop )

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
  quik
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
  wmail
  zoomus
)

brew cask install "${apps[@]}"
