#!/bin/sh

# Add spaces to Dock without dockutil
# defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/System Preferences.app"

dockutil --no-restart --add '' --type spacer --section apps

dockutil --no-restart --add "/Applications/Google Chrome.app"

dockutil --no-restart --add '' --type spacer --section apps

dockutil --no-restart --add "/Applications/Hyper.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"

dockutil --no-restart --add '' --type spacer --section apps

dockutil --no-restart --add '~/Downloads' --view grid --display folder --section others

killall Dock
