# Wordpress

template '/var/www/dotcom-v3/current/public/wp-config.php' do
  source 'wp-config.php.erb'
  mode '0755'
  owner 'www-data'
  group 'www-data'
  notifies :restart, 'service[apache2]'
end
