# Dynamic syntax highlighting highlighters directory detection
if [[ -d "/opt/homebrew/share/zsh-syntax-highlighting/highlighters" ]]; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="/opt/homebrew/share/zsh-syntax-highlighting/highlighters"
elif [[ -d "/usr/local/share/zsh-syntax-highlighting/highlighters" ]]; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="/usr/local/share/zsh-syntax-highlighting/highlighters"
elif [[ -d "/home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/highlighters" ]]; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="/home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/highlighters"
fi

