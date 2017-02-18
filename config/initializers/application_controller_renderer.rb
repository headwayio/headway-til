# Be sure to restart your server when you modify this file.

ApplicationController.renderer.defaults.merge!(
  http_host: ENV.fetch('host', 'https://headway.io'),
  https: ENV.fetch('protocol', 'https').include?('https')
)
