# Install atom.
brew cask install atom

# Install atom packages
packages=(
  activate-power-mode
  atom-clock
  autocomplete-modules
  busy-signal
  double-tag
  editorconfig
  emmet
  file-icons
  highlight-selected
  hyperclick
  intentions
  js-hyperclick
  language-babel
  language-docker
  language-graphql
  language-haskell
  language-ignore
  language-jade
  linter
  linter-docker
  linter-eslint
  linter-jsonlint
  linter-ui-default
  open-recent
  pdf-view
  pigments
  prettier-atom
  project-manager
  sync-settings
  todo-show
  travis-ci-status
)

themes=(
  aesthetic-ui
  atom-material-syntax
  atom-material-ui
  nova-atom-syntax
  oceanic-next
  slack-ui
)

if [ $(which apm) ]; then
  apm install "${packages[@]}" --production
  apm install "${themes[@]}" --production
else
  echo "ERROR: apm not installed"
fi
