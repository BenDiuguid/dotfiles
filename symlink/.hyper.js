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
  },
  plugins: [
    'hypercwd',
    // 'hyperpower',
    'hyperterm-tabs',
    'hyperterm-tab-icons',
    'hyper-snazzy',
    'hyper-simple-vibrancy',
    'hyper-simple-highlight-active-session',
  ],
};
