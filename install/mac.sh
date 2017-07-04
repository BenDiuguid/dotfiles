brew install mas

mas signin

packages=(
  # GarageBand
  682658836
  # iMovie
  408981434
  # Keynote
  409183694
  # Numbers
  409203825
  # Pages
  409201541
  # Xcode
  497799835
  # Shazam
  897118787
  # Vaunt
  1191209926
  # GIPHY CAPTURE
  668208984
)

mas install "${packages[@]}"
