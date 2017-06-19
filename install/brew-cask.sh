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
  caprine
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
  google-featured-photos
  google-trends
  hyper
  imageoptim
  insomnia
  iterm2
  java
  opera
  opera-neon
  origami-studio
  postman
  quik
  robomongo
  rocket
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
