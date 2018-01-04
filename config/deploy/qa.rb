# Environment: qa

require_relative "../../attributes/config.rb"

set :stage, :qa
default = ENVIRONMENTS[:qa]
# set :host, "web_platform_ip"
# server "#{fetch(:host)}", user: 'deployer', roles: %w{web} ,primary: true
server default['fis-dotcom-v3']['web_platform_ip'], user: 'deployer', roles: %w{web}, primary: true
