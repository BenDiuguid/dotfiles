# Install nvm.
brew install nvm

# If nvm is not a directory, source our system/.nvm file
[ "$(type -t nvm)" != function ] && source $DOTFILES_DIR/system/.nvm

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
  cypress
  diffchecker
  eslint
  eslint-plugin-babel
  eslint-plugin-import
  eslint-plugin-react
  generator-angular-fullstack
  generator-nm
  generator-react-cdk
  gulp
  horizon
  mocha
  node-nightly
  nodemon
  sort-package-json
  trash-cli
  typescript
  webpack
  yo
)

npm install -g "${packages[@]}"
