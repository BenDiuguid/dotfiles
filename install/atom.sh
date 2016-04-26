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
  merge-conflicts
  project-manager
  react
  travis-ci-status
)

apm install "${packages[@]}" --production
