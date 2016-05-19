[ ! $(which brew) ] && return 0

# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

# Not on brew-cask
# Shazam
# Sonic Mobile Connect
# Pocket
# Twitter

# Install packages
apps=(
  1password
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
  iterm2
  java
  ngrok
  opera
  polymail
  robomongo
  safari-technology-preview
  skype
  slack
  sococo
  sublime-text3
  torbrowser
  transmission
  virtualbox
  visual-studio-code
  vivaldi
  webstorm
)

brew cask install "${apps[@]}"
