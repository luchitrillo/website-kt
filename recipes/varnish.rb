# Varnish

include_recipe 'varnish::default'

varnish_repo 'configure' do
  major_version 4.1
end

package 'varnish'

service 'varnish' do
  action [:enable, :start]
end

# Templates

template '/etc/varnish/default.vcl' do
  source 'default.vcl.erb'
  mode '0644'
  owner 'root'
  group 'root'
  variables({
    backend_server_host: node['fis-dotcom-v3']['web_platform_ip_internal']
  })
end

cookbook_file '/etc/default/varnish' do
  mode '0644'
  owner 'root'
  group 'root'
  action :create
end

cookbook_file '/etc/varnish/secret' do
  mode '0600'
  owner 'root'
  group 'root'
  action :create
end

# Varnish log

varnish_log 'default'

varnish_log 'default_ncsa' do
  log_format 'varnishncsa'
end

# Redirect

directory '/etc/systemd/system/varnish.service.d' do
  mode 0644
  owner 'root'
  group 'root'
end

cookbook_file '/etc/systemd/system/varnish.service.d/customexec.conf' do
  mode '0644'
  owner 'root'
  group 'root'
  action :create
  #notifies :restart, 'service[varnish]'
end

execute "systemctl_reload" do
  command "systemctl daemon-reload"
end

execute "systemctl_reload" do
  command "service varnish restart"
end
