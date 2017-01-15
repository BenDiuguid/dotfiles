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

npm install --global yarn

### Interesting packages
# hotel

# Globally install with npm
packages=(
  babel-cli
  babel-eslint
  browser-sync
  create-react-app
  cypress-cli
  diffchecker
  eslint
  eslint-plugin-babel
  eslint-plugin-import
  eslint-plugin-react
  flow-bin
  horizon
  npm
  now
  serverless
  sort-package-json
  trash-cli
  typescript
  webpack
  yo
)

yarn global add "${packages[@]}"
