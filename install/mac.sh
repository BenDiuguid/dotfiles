brew install mas

mas signin

packages=(
  GarageBand
  iMovie
  iPhoto
  Keynote
  Numbers
  Pages
  Shazam
  Vaunt
  Xcode
)

mas install "${packages[@]}"
