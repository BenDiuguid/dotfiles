# Install atom.
brew cask install atom

# Install atom packages
packages=(
  activate-power-mode
  atom-beautify
  atom-linter-node-dependencies
  autocomplete-modules
  editorconfig
  emmet
  git-control
  highlight-selected
  jumpy
  language-docker
  language-babel
  language-ignore
  language-jade
  linter
  linter-docker
  linter-jsonlint
  linter-eslint
  lucid-tabs
  markdown-scroll-sync
  merge-conflicts
  npm-outdated
  oceanic-next
  open-recent
  pigments
  project-manager
  regex-tester
  seti-syntax
  slack-ui
  travis-ci-status
)

if [ $(which apm) ]; then
  apm install "${packages[@]}" --production
fi
