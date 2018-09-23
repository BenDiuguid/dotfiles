module.exports = {
  config: {
    updateChannel: 'stable',
    fontSize: 15,
    fontFamily: 'Operator Mono',
    shell: '/usr/local/bin/zsh',
    hyperTabs: {
      trafficButtons: true,
    },
  },
  plugins: [
    'hyper-snazzy',
    'hypercwd',
    'hyper-search',
    'hyper-tabs-enhanced',
  ],
};
