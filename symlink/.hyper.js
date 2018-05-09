module.exports = {
  config: {
    updateChannel: 'stable',
    fontSize: 15,
    fontFamily: 'Operator Mono',
    shell: '/usr/local/bin/zsh',
    hyperTabs: {
      trafficButtons: true,
    },
    css:`
      .terminal, .term_fit:not(.term_term) {
        opacity: 1 !important;
      }
    `,
  },
  plugins: [
    'hyper-snazzy',
    'hypercwd',
    'hyper-search',
    'hyper-tabs-enhanced',
  ],
};
