# Capistrano

apt_package %w(git ruby-full build-essential ruby-dev ruby-bundler)

gem_package 'capistrano'
gem_package 'capistrano-ext'
gem_package 'capistrano-bundler'
gem_package 'capistrano-templating'

# New Gem File

cookbook_file 'Gemfile' do
  mode '0644'
  owner 'deployer'
  group 'www-data'
  action :create
end

# Bundle & Cap

execute "bundle_install" do
  command "bundle install"
end

execute "cap_install" do
  command "cap install"
end

# Deploy Files

cookbook_file '/config/deploy/qa.rb' do
  mode '0644'
  owner 'deployer'
  group 'www-data'
  action :create
end

cookbook_file '/config/deploy.rb' do
  mode '0644'
  owner 'deployer'
  group 'www-data'
  action :create
end

# Cap QA

execute "cap_qa_deploy" do
    command "eval \$(ssh-agent -s)\; ssh-add \/home\/deployer\/.ssh/id_rsa\; cap qa deploy"
end
