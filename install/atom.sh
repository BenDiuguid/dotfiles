if [ $(which brew) ]; then
  brew cask install atom
fi

# Install atom packages
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

if [ $(which apm) ]; then
  apm install "${packages[@]}" --production
fi
