# Install nvm.
brew install nvm
brew install yarn

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
# font-awesome-svg-png

# Globally install with npm
packages=(
  babel-cli
  babel-eslint
  browser-sync
  create-react-app
  cypress
  diffchecker
  eslint
  eslint-plugin-babel
  eslint-plugin-import
  eslint-plugin-react
  generator-react-cdk
  horizon
  mocha
  nodemon
  npm
  serverless
  sort-package-json
  trash-cli
  typescript
  webpack
  yarn
  yo
)

yarn global add "${packages[@]}"
