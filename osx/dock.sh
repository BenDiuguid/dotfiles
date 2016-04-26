#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/System Preferences.app"
dockutil --no-restart --add "$HOME/Applications/Safari Technology Preview.app"
dockutil --no-restart --add "$HOME/Applications/Brave.app"
dockutil --no-restart --add "$HOME/Applications/Vivaldi.app"
dockutil --no-restart --add "$HOME/Applications/Google Chrome.app"

dockutil --no-restart --add "$HOME/Applications/Atom.app"
dockutil --no-restart --add "$HOME/Applications/WebStorm.app"
dockutil --no-restart --add "$HOME/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Utilities/Terminal.app"

dockutil --no-restart --add "$HOME/Applications/GitHub Desktop.app"
dockutil --no-restart --add "$HOME/Applications/Slack.app"
dockutil --no-restart --add "/Applications/App Store.app"


killall Dock

# Add spaces to Dock.
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
killall Dock

defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
killall Dock

defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
killall Dock
