#
# Cookbook:: apache_httpd
# ResourcePartial:: _config_file
#
# Copyright:: Ben Hughes, All Rights Reserved.

include ApacheHttpd::Cookbook::GeneralHelpers
include ApacheHttpd::Cookbook::ConfigHelpers

property :owner, String,
          default: lazy { default_apache_user }

property :group, String,
          default: lazy { default_apache_group }

property :mode, String,
          default: '0640'

property :config_dir, String,
          default: lazy { default_config_dir }

property :config_file, String,
          default: lazy { ::File.join(config_dir, default_config_file) }
