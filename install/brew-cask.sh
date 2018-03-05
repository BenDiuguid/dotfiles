# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

# Not on brew-cask
# zeit now-desktop ( https://zeit.co/desktop )

# Install packages
apps=(
  android-file-transfer
  android-studio
  appcleaner
  atom
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
  google-featured-photos
  google-trends
  hyper
  imageoptim
  iterm2
  java
  opera
  postman
  quik
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
  zoomus
)

brew cask install "${apps[@]}"
