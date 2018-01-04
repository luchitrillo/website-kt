# Variables

mysql_root_password = node['fis-dotcom-v3']['mysql_root_password']
mysql_wp_password = node['fis-dotcom-v3']['mysql_wp_password']

# DB Service Create

mysql_service 'server' do
  port '3306'
  version '5.7'
  initial_root_password "#{mysql_root_password}"
  action [:create, :start]
end

# Socket Configuration

template '/etc/mysql-server/my.cnf' do
  source 'my.cnf.erb'
  mode '0644'
  owner 'root'
  group 'root'
  notifies :restart, 'mysql_service[server]'
end

# DB Root User Access Privileges

execute "create_root_user_privileges" do
  command "mysql -h `hostname` -uroot -p'#{mysql_root_password}' -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" IDENTIFIED BY \"#{mysql_root_password}\"'"
end

# DB Dumping (Dump file from Production - 06-20-2017)

cookbook_file '/tmp/db_v3_dump.sql' do
  mode '0655'
  owner 'root'
  group 'root'
  action :create
end

execute "db_dump" do
  command "mysql -h `hostname` -u root -p'#{mysql_root_password}' < /tmp/db_v3_dump.sql"
end

# Wordpress User Configuration

execute "create_wordpress_user" do
  command "mysql -h `hostname` -uroot -p'#{mysql_root_password}' -e 'CREATE USER \"wordpress\"@\"%\" IDENTIFIED BY \"#{mysql_wp_password}\"'"
end

execute "grant_wordpress_user" do
  command "mysql -h `hostname` -uroot -p'#{mysql_root_password}' -e 'GRANT ALL PRIVILEGES ON *.* TO \"wordpress\"@\"%\" WITH GRANT OPTION; FLUSH PRIVILEGES;'"
  notifies :restart, 'mysql_service[server]'
end
