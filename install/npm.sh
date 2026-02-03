# Install nvm.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# For some reason this didn't work right after the install.
# Grab latest node version and set it to default
nvm install node
nvm use node
nvm alias default node

# npm completion installiation.
npm completion > /usr/local/etc/bash_completion.d/npm

# Globally install with npm
packages=(
  npm
  pure-prompt
  trash-cli
  yarn
)

npm install --global "${packages[@]}"
