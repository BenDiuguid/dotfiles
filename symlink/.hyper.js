module.exports = {
  config: {
    updateChannel: 'stable',
    fontSize: 16,
    fontFamily: 'Operator Mono', // If not this, set fontSize: 15.
    shell: '/opt/homebrew/bin/zsh',
    hyperTabs: {
      trafficButtons: true,
    },
  },
  plugins: [
    'hyper-snazzy',
    'hypercwd',
    'hyper-search',
    'hyper-tabs-enhanced',
    // 'hyperpower',
  ],
};
