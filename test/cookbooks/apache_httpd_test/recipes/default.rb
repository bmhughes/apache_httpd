#
# Cookbook:: apache_httpd_test
# Recipe:: install
#
# Copyright:: Ben Hughes, All Rights Reserved.

include_recipe '::prepare'

include_recipe '::package'

include_recipe '::config_global'
include_recipe '::config_site'
include_recipe '::config_module'
include_recipe '::config_generic'

include_recipe '::service'
