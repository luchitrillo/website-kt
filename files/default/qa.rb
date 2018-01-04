# Environment: qa

set :stage, :qa
server server '127.0.0.1', user: 'deployer', roles: %w{web}, primary: true
