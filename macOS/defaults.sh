#!/usr/bin/env bash

# macOS system defaults
# Only settings that differ from a stock macOS install (captured from Ben's Mac).
# Inspired by https://mths.be/macos
#
# Re-inspect a domain at any time with e.g. `defaults read com.apple.dock`.

# Close any open System Settings panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Appearance: Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

###############################################################################
# Trackpad                                                                    #
###############################################################################

# Written to both the built-in and Bluetooth (Magic Trackpad) domains
for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
	# Tap to click
	defaults write "$domain" Clicking -bool true
	# Three-finger drag (disables three-finger swipes; four-finger swipes take over)
	defaults write "$domain" TrackpadThreeFingerDrag -bool true
	defaults write "$domain" TrackpadThreeFingerHorizSwipeGesture -int 0
	defaults write "$domain" TrackpadThreeFingerVertSwipeGesture -int 0
done

# Tap to click for the current host & login screen
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

###############################################################################
# Desktop & Stage Manager (WindowManager)                                     #
###############################################################################

# Only show desktop on wallpaper click while in Stage Manager (not in standard mode)
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

###############################################################################
# Dock & Mission Control                                                      #
###############################################################################

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "cfprefsd" \
	"Dock" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null || true
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
