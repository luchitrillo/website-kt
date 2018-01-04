# Metadata

name 'website-do'
maintainer 'The Authors'
maintainer_email 'hello@ozoneops.com'
license 'All Rights Reserved'
description 'Installs/Configures website-do'
long_description 'Installs/Configures website-do'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
depends 'resolvconf', '~> 0.4.0'
depends "remote_syslog2"
depends 'mysql', '~> 8.0'
depends 'varnish', '~> 3.1.0'
depends 'sudo', '~> 3.5.1'
depends "openssh"
depends "nfs", ">= 2.2.2"
depends "ntp"
depends "apt"

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/website-do/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/website-do'
