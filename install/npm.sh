
[ ! $(which brew) ] && brew install nvm

# If nvm is not a directory, source our system/.nvm file
[ "$(type -t nvm)" != function ] && source $DOTFILES_DIR/system/.nvm

# Grab latest node version and set it to default
nvm install node
nvm use node
nvm alias default node

# npm completion installiation.
npm completion > /usr/local/etc/bash_completion.d/npm

# Globally install with npm
packages=(
  ava
  babel-cli
  bower
  browser-sync
  cypress
  devtool
  diffchecker
  eslint
  generator-angular-fullstack
  generator-nm
  generator-react-cdk
  gulp
  horizon
  less
  mocha
  node-gyp
  node-ip
  nodemon
  plop
  pug-cli
  sort-package-json
  trash-cli
  typescript
  webpack
  yo
)

npm install -g "${packages[@]}"
