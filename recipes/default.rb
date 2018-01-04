# Update

apt_update 'update'

# Default

include_recipe 'sudo'
include_recipe 'openssh'
include_recipe 'website-do::deployer'
include_recipe 'resolvconf::default'
include_recipe 'nfs'
include_recipe 'ntp'

execute "echo 'Universal' > /etc/timezone"
execute "dpkg-reconfigure -f noninteractive tzdata"
execute "service cron restart"

node.set['ntp']['servers'] = ['0.us.pool.ntp.org', '1.us.pool.ntp.org', '2.us.pool.ntp.org', '3.us.pool.ntp.org']

resolvconf 'default'

template '/etc/update-motd.d/99-learn-custom' do
  source 'motd.erb'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
end
