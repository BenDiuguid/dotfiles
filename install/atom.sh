# Install atom.
brew cask install atom

# Potentially useful plugins
# lucid-tabs
# term3
# tool-bar
# linter-flow
# nuclide
# atom-ternjs

# Install atom packages
packages=(
  atom-clock
  activate-power-mode
  atom-beautify
  autocomplete-modules
  double-tag
  editorconfig
  emmet
  file-icons
  highlight-selected
  hyperclick
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
  markdown-scroll-sync
  npm-outdated
  oceanic-next
  open-recent
  pdf-view
  pigments
  project-manager
  seti-syntax
  slack-ui
  split-diff
  sync-settings
  todo-show
  travis-ci-status
)

if [ $(which apm) ]; then
  apm install "${packages[@]}" --production
else
  echo "ERROR: apm not installed"
fi
