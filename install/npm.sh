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

yarn cache clean

# Globally install with npm
packages=(
  create-react-app
  create-react-native-app
  eslint
  fkill-cli
  netlify-cli
  npm
  now
  preact-cli
  pure-prompt
  sort-package-json
  trash-cli
  typescript
)

yarn global add "${packages[@]}"
