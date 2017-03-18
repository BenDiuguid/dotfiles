module.exports = {
  config: {
    fontSize: 15,
    fontFamily: 'Operator Mono',
    cursorColor: 'rgba(133,133,137,0.60)',
    cursorShape: 'BLOCK',
    termCSS: `
      x-screen {
        -webkit-font-smoothing: subpixel-antialiased !important;
      }
    `,
    shell: '/usr/local/bin/zsh',
    hyperlinks: {
      clickAction: 'open',
      defaultBrowser: true,
    },
  },
  plugins: [
    // THEMES:
    // theme viewer: https://hyperthemes.matthi.coffee/
    'hyper-snazzy',

    // PLUGINS:
    // 'hyperpower', // Show Off!
    'hypercwd',
    'hyperterm-tab-icons',
    'hyper-simple-vibrancy',
    'hyper-simple-highlight-active-session',
    'hyperlinks',
    // 'hyperlayout', // really cool! (replaces tmux/tmuxinator)
    // 'hyper-statusline', // looks like the bottom of atom
  ],
};
