#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/System Preferences.app"

dockutil --no-restart --add '' --type spacer --section apps

dockutil --no-restart --add "/Applications/Brave.app"
dockutil --no-restart --add "/Applications/Google Chrome.app"

dockutil --no-restart --add '' --type spacer --section apps

dockutil --no-restart --add "/Applications/Atom.app"
dockutil --no-restart --add "/Applications/Hyper.app"
dockutil --no-restart --add "/Applications/Utilities/Terminal.app"

dockutil --no-restart --add '' --type spacer --section apps

dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/App Store.app"

dockutil --no-restart --add '~/Downloads' --view grid --display folder --section others

# Add spaces to Dock without dockutil
# defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'

killall Dock
