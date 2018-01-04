# Capistrano Deployment

# config valid only for current version of Capistrano
# lock "3.8.1"

require "capistrano/scm/git"
# install_plugin Capistrano::SCM::Git
# require 'capistrano/grunt'
# require 'capistrano/ext/multistage'
# set :stages, ["qa", "staging", "production"]
# set :default_stage, "qa"

# Setup project

set :application, "dotcom-v3"
set :repo_url, "git@github.com:flatiron-labs/dotcom-v3.git"
set :repo_tree, 'build/'
set :git_shallow_clone, 1
# set :scm, :git

# Setup Capistrano

set :log_level, :info
set :deploy_user, "deployer"
set :branch, (ENV["BRANCH"] || 'master') # Should be a "qa" branch with "qa" adapted site code
set :deploy_to, "/var/www/dotcom-v3"
set :use_sudo, false
set :ssh_options, forward_agent: true
set :pty, true
set :keep_releases, 25
