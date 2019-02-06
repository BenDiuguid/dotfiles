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
  brave
  docker
  figma
  firefox
  firefoxdeveloperedition
  flux
  google-backup-and-sync
  google-chrome
  google-chrome-canary
  google-featured-photos
  google-trends
  graphql-playground
  hyper
  imageoptim
  java
  ngrok
  opera
  postman
  quik
  skype
  slack
  torbrowser
  transmission
  virtualbox
  visual-studio
  visual-studio-code
  vivaldi
)

brew cask install "${apps[@]}"
