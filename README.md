# Readme

## Description

This cookbook provisions a installation for the dotcom-v3 marketing QA website throug 3 DO instances (DataBase / Web / Cache). It is configured to enable the [dotcom-v3 codebase](https://github.com/flatiron-labs/dotcom-v3) to be deployed via kitchen & capostrano directives.

## Supported Platforms

Ubuntu 16.04

## Usage

### Cookbook: website-do

website-do will run on 3 servers, so a run-list like this is necessary (.kitchen.yml):

```
---
driver:
  name: digitalocean
  region: nyc3
  size: 4gb
  username: root

provisioner:
  name: chef_zero
  require_chef_omnibus: 12.19.36
  data_bags_path: "data_bags"
  always_update_cookbooks: true
  client_rb:
    environment: qa

platforms:
  - name: ubuntu-16-04-x64

suites:
  - name: db
    driver:
      server_name: qa-dotcom-v3-db
    run_list:
      - recipe[website-do::default]
      - recipe[website-do::mysql]
  - name: web
    driver:
      server_name: qa-dotcom-v3-web
    run_list:
      - recipe[website-do::default]
      - recipe[website-do::apache]
      - recipe[website-do::capistrano]
      - recipe[website-do::wordpress]
  - name: cache
    driver:
      server_name: qa-dotcom-v3-cache
    run_list:
      - recipe[website-do::default]
      - recipe[website-do::varnish]
    attributes:
```

### Provisioning: Kitchen + Berkshelf + Capistrano (Digital Ocean Infrastructure)

Implemetaion with test-kitchen, digital ocean, berkshelf and capistrano for development:

* Install proper packages & gems.

```
sudo apt-get update && apt-get install -y git ruby-full build-essential ruby-dev ruby-bundler
wget https://packages.chef.io/files/stable/chefdk/1.4.3/ubuntu/16.04/chefdk_1.4.3-1_amd64.deb
dpkg -i chefdk_1.4.3-1_amd64.deb
gem install berkshelf test-kitchen kitchen-digitalocean capistrano capistrano-ext capistrano-bundler capistrano-templating
```

* Get into the 'website-do' folder and proceed with the following commands:

```
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa.pub
berks install; bundle install;
```

* Export the necessary Digital Ocean tokens:

```
export DIGITALOCEAN_ACCESS_TOKEN="5523aa2a9bddb77c3b095dd94ab11e8c2b067bf7ca8772934f8275ede6689f5b";
export DIGITALOCEAN_SSH_KEY_IDS="########"
```

NOTE: The DIGITALOCEAN_SSH_KEY_IDS is obtained by the following commands.

```
curl -X GET https://api.digitalocean.com/v2/account/keys -H "Authorization: Bearer $DIGITALOCEAN_ACCESS_TOKEN"
```

* From the 'website-do' directory, run kitchen directive to create the instances:

```
kitchen create
```

* Once the directive is completed and the servers are up, obtain the IP addres from the new Digital Ocean servers and include them into the 'config.rb' file into the 'attributes' folder:

```
...

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

...
```

* From the 'website-do' directory, run kitchen directive to converge the 3 isntances with the proper data base, the web server with the capistrano deployment, & the cache server:

```
kitchen converge
```

### License and Authors

Author:: Ozone (hello@ozoneops.com)