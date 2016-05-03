brew install nvm

nvm install 6.0
nvm use 6.0
nvm alias default 6.0

# Globally install with npm

packages=(
  ava
  bower
  browser-sync
  diffchecker
  eslint
  generator-angular-fullstack
  generator-nm
  generator-react-cdk
  gulp
  less
  mocha
  node-gyp
  nodemon
  plop
  pug
  sort-package-json
  typescript
  yo
)

npm install -g "${packages[@]}"
