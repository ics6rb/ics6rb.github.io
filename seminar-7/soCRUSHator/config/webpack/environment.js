const { ProvidePlugin } = require('webpack')
const { environment } = require('@rails/webpacker')

environment.plugins.append(
  'Provide',
  new ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'],
  }),
)

module.exports = environment
