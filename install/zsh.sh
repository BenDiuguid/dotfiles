# Install updated zsh.
brew install zsh

grep "/opt/homebrew/bin/zsh" /private/etc/shells &>/dev/null || sudo zsh -c "echo /opt/homebrew/bin/zsh >> /private/etc/shells"
chsh -s /opt/homebrew/bin/zsh
