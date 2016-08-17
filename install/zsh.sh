# Install updated zsh.
brew install zsh

grep "/usr/local/bin/zsh" /private/etc/shells &>/dev/null || sudo zsh -c "echo /usr/local/bin/zsh >> /private/etc/shells"
chsh -s /usr/local/bin/zsh
