brew install mas

mas signin

packages=(
  682658836 # GarageBand
  408981434 # iMovie
  409183694 # Keynote
  409203825 # Numbers
  409201541 # Pages
  497799835 # Xcode
  897118787 # Shazam
  668208984 # GIPHY CAPTURE
)

mas install "${packages[@]}"
