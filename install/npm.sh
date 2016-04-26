brew install nvm

nvm install 5
nvm use 5
nvm alias default 5

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
  jade
  less
  mocha
  node-gyp
  nodemon
  plop
  sort-package-json
  typescript
  yo
)

npm install -g "${packages[@]}"
