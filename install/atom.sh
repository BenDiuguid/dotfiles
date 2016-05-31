if [ $(which brew) ]; then
  brew cask install atom
fi

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
  language-babel
  language-ignore
  language-jade
  linter
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
  react
  regex-tester
  rest-client
  seti-syntax
  slack-ui
  todo-show
  travis-ci-status
)

if [ $(which apm) ]; then
  apm install "${packages[@]}" --production
fi
