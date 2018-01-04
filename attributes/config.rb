QA = {}

# Users
QA['apache'] = {}
QA['apache']['user'] = 'deployer'
QA['apache']['group'] = 'www-data'

# Domain
QA['fis-dotcom-v3'] = {}
QA['fis-dotcom-v3']['domain_name'] = 'qa-dotcom-v3.flatironschool.com'

# Platforms
QA['fis-dotcom-v3']['db_platform_suite'] = 'name'
QA['fis-dotcom-v3']['db_platform_ip'] = 'public' # <-- here goes public IP assigned by DO
QA['fis-dotcom-v3']['db_platform_ip_internal'] = 'private' # <-- here goes private IP assigned by DO

QA['fis-dotcom-v3']['web_platform_suite'] = 'name'
QA['fis-dotcom-v3']['web_platform_ip'] = 'public' # <-- here goes public IP assigned by DO
QA['fis-dotcom-v3']['web_platform_ip_internal'] = 'private' # <-- here goes private IP assigned by DO

QA['fis-dotcom-v3']['cache_platform_suite'] = 'name'
QA['fis-dotcom-v3']['cache_platform_ip'] = 'public' # <-- here goes public IP assigned by DO
QA['fis-dotcom-v3']['cache_platform_ip_internal'] = 'private' # <-- here goes private IP assigned by DO

# DB
QA['fis-dotcom-v3']['mysql_root_password'] = 'bfe510630e11e4423174c54df5b48c0b826366794957f5de'
QA['fis-dotcom-v3']['mysql_wp_password'] = '2ce62a25d9f8452d1a9890df6438f20185630bce1e9038b8'

STAGE = {}

ENVIRONMENTS = {
  qa: QA
}