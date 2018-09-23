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
  figma
  firefox
  firefoxdeveloperedition
  flux
  gimp
  google-backup-and-sync
  google-chrome
  google-chrome-canary
  google-featured-photos
  google-trends
  graphql-playground
  hyper
  imageoptim
  iterm2
  java
  ngrok
  opera
  postman
  quik
  safari-technology-preview
  skype
  slack
  steam
  sublime-text
  torbrowser
  transmission
  virtualbox
  visual-studio
  visual-studio-code
  vivaldi
)

brew cask install "${apps[@]}"
