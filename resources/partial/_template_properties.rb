#
# Cookbook:: apache_httpd
# ResourcePartial:: _template_properties
#
# Copyright:: Ben Hughes, All Rights Reserved.

property :cookbook, String,
          default: 'apache_httpd'

property :source, String,
          default: lazy { default_config_file_template }

property :variables, Hash,
          default: {}

property :template_helpers, [String, Array],
          description: 'Additional helper modules to include in the template',
          coerce: proc { |p| Array(p) }
