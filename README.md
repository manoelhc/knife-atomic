# knife-atomic

[![Gem Version](https://badge.fury.io/rb/knife-atomic.svg)](https://rubygems.org/gems/knife-atomic) [![Build Status](https://travis-ci.org/manoelhc/knife-atomic.svg?branch=master)](https://travis-ci.org/manoelhc/knife-atomic)

Knife plugin to retrieve Chef structures with pinned versions of the cookbooks.

This plugin retrieves all the information from ```knife environment show <environment_name>``` and adds all the cookbook versions installed on nodes under the referred environment.

In other words, this plugin crosses information between the nodes to collect the installed cookbook versions and then outputs the environment details with them.

The command ```knife environment show <environment_name>``` retrieves something like:
```
chef_type:           environment
cookbook_versions:
  apt:         = 2.7.0
  aws:         = 4.1.3
default_attributes:
description:         MyApp Prod
json_class:          Chef::Environment
name:                myapp-prod
override_attributes:
  ...
```

Using this plugin, as ```knife environment show atomic <environment_name>```, retrieves something like:

```
chef_type:           environment
cookbook_versions:
  apache2:             = 3.1.0
  apt:                 = 2.7.0
  aws:                 = 4.1.3
  build-essential:     = 2.2.3
  chef-client:         = 1.1.2
  chef_handler:        = 1.1.4
  cron:                = 1.2.2
  java:                = 1.50.0
  mysql:               = 8.3.1
  nagios:              = 3.1.1
  nginx:               = 1.4.0
  nginx_simplecgi:     = 0.1.0
  ntp:                 = 0.8.2
  ohai:                = 5.0.0
  omnibus_updater:     = 2.0.0
  perl:                = 3.0.0
  php:                 = 4.0.0
  rsyslog:             = 1.4.0
  runit:               = 1.7.8
  ssh_authorized_keys: = 0.5.0
  xml:                 = 1.1.2
  yum:                 = 3.2.0
  yum-epel:            = 0.3.6
default_attributes:
description:         MyApp Prod
json_class:          Chef::Environment
name:                myapp-prod
override_attributes:
  ...
```

*IMPORTANT NOTE*: This plugin does not apply any changes (yet). You have to set it manually. For instance, you can do it by storing the JSON output and work with ```knife environment edit <environment_name>``` or ```knife environment from file <path_to_json_file>```

## Why should we care about versions?

There is a bunch of reasons to pin the cookbook versions. An excellent one is to
fix versions on prod to prevent deploying latest versions on prod, and thus avoiding
potential conflicts or installing local cookbooks which are in dev/test phase. When
your company uses a Chef server for all environments (dev/QA/prod), think about it.

## Install

Requirements:
 *  Chef 12.0 higher
 *  Ruby 2.2.2 or higher

You need to use ChefDK's gem and merely install as below:
```bash
chef gem install knife-atomic
```

## Get environment fixed versions

To run the plugin:

```bash
knife environment show atomic <environment_name>
```
