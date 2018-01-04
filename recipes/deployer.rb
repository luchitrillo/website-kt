# Deployer

user "deployer" do
  comment "User for deployments"
  home "/home/deployer"
  manage_home true
  shell '/bin/bash'
  action :create
end

%w[/home/deployer /home/deployer/.ssh].each do |dir|
  directory dir do
    owner 'deployer'
    group 'deployer'
    recursive true
  end
end

# Templates

template "/home/deployer/.ssh/authorized_keys" do
  source "deployer_authorized_keys.erb"
  variables users: data_bag("users").map {|user| data_bag_item("users", user) }
  group "deployer"
  owner "deployer"
end

template "/home/deployer/.ssh/id_rsa" do
  source "deployer_id_rsa.erb"
  variables users: data_bag("keys").map {|user| data_bag_item("keys", user)}
  group "deployer"
  owner "deployer"
  mode '0600'
end

execute 'remove_key_white_spaces' do
  command '/usr/bin/find /home/deployer/.ssh/authorized_keys | /usr/bin/xargs perl -pi -e \'s/\s*ssh-rsa/ssh-rsa/\''
end

execute 'remove_key_white_spaces' do
  command '/usr/bin/find /home/deployer/.ssh/id_rsa | /usr/bin/xargs perl -pi -e \'s/\s*-----BEGIN/-----BEGIN/\''
end
=begin
directory "/var/postgresbackups" do
  owner 'deployer'
  group 'deployer'
  mode '0777'
  action :create
end

group "sysadmin" do
  action :modify
  members ["deployer"]
  append true
end
=end
