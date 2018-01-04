require_relative 'config.rb'

case node.chef_environment

# Environments

when 'qa'
  default_values = ENVIRONMENTS[:qa]

# Users

default['apache']['user'] = default_values['apache']['user']
default['apache']['group'] = default_values['apache']['group']

# Domain

default['fis-dotcom-v3']['domain_name'] = default_values['fis-dotcom-v3']['domain_name']

# Platforms

default['fis-dotcom-v3']['db_platform_suite'] = default_values['fis-dotcom-v3']['db_platform_suite']
default['fis-dotcom-v3']['db_platform_ip'] = default_values['fis-dotcom-v3']['db_platform_ip']
default['fis-dotcom-v3']['db_platform_ip_internal'] = default_values['fis-dotcom-v3']['db_platform_ip_internal']

default['fis-dotcom-v3']['web_platform_suite'] = default_values['fis-dotcom-v3']['web_platform_suite']
default['fis-dotcom-v3']['web_platform_ip'] = default_values['fis-dotcom-v3']['web_platform_ip']
default['fis-dotcom-v3']['web_platform_ip_internal'] = default_values['fis-dotcom-v3']['web_platform_ip_internal']

default['fis-dotcom-v3']['cache_platform_suite'] = default_values['fis-dotcom-v3']['cache_platform_suite']
default['fis-dotcom-v3']['cache_platform_ip'] = default_values['fis-dotcom-v3']['cache_platform_ip']
default['fis-dotcom-v3']['cache_platform_ip_internal'] = default_values['fis-dotcom-v3']['cache_platform_ip_internal']

# DB

default['fis-dotcom-v3']['mysql_root_password'] = default_values['fis-dotcom-v3']['mysql_root_password']

# Papertrail

# set['papertrail']['port'] = 56758
# set['papertrail']['host'] = 'logs2'
# set['papertrail']['certificate_checksum'] = '7019189e20ed695e9092e67d91a3b37249474f4c4c6355193ce6d2cb648f147c'

end
