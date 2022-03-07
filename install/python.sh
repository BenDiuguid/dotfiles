# Install python + pip
brew install python

packages=(
  pip
  setuptools
  awscli
)

pip install "${packages[@]}"
