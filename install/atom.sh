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
  activate-power-mode
  atom-beautify
  atom-linter-node-dependencies
  autocomplete-modules
  double-tag
  editorconfig
  emmet
  file-icons
  highlight-selected
  hyperclick
  js-hyperclick
  jumpy
  language-babel
  language-docker
  language-graphql
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
  pigments
  project-manager
  regex-tester
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
