brew cask install atom

# Globally install with apm

packages=(
  activate-power-mode
  atom-beautify
  editorconfig
  emmet
  git-control
  language-babel
  language-jade
  linter
  linter-eslint
  merge-conflicts
  oceanic-next
  project-manager
  react
  seti-syntax
  travis-ci-status
)

apm install "${packages[@]}" --production
