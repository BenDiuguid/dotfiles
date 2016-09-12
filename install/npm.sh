# Install nvm.
brew install nvm

if [ "$(type -t nvm)" != function ]; then
  source $DOTFILES_DIR/system/.nvm
fi

# Grab latest node version and set it to default
nvm install node
nvm use node
nvm alias default node

# npm completion installiation.
npm completion > /usr/local/etc/bash_completion.d/npm

### Interesting packages
# hotel

# Globally install with npm
packages=(
  ava
  babel-cli
  babel-eslint
  browser-sync
  cli-theme-test
  cypress
  diffchecker
  eslint
  eslint-plugin-babel
  eslint-plugin-flowtype
  eslint-plugin-html
  eslint-plugin-import
  eslint-plugin-json
  eslint-plugin-markdown
  eslint-plugin-react
  font-awesome-svg-png
  generator-angular-fullstack
  generator-nm
  generator-react-cdk
  gulp
  horizon
  mocha
  node-nightly
  nodemon
  serverless
  sort-package-json
  trash-cli
  typescript
  webpack
  yo
)

npm install -g "${packages[@]}"
