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

# Globally install with npm
packages=(
  fkill-cli
  npm
  pure-prompt
  trash-cli
  yarn
)

npm install --global "${packages[@]}"
