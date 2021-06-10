#
# Cookbook:: apache_httpd
# Resource:: config_generic
#
# Copyright:: 2021, Ben Hughes, All Rights Reserved.

unified_mode true

use 'partial/_config_file'
use 'partial/_template_properties'

action :create do
  directory new_resource.config_dir do
    owner 'root'
    group 'root'
    mode '0755'

    recursive true
  end unless ::Dir.exist?(new_resource.config_dir)

  template new_resource.config_file do
    cookbook new_resource.cookbook
    source new_resource.source

    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode

    helpers(ApacheHttpd::Cookbook::TemplateHelpers)
    new_resource.template_helpers.each { |th| helpers(::Object.const_get(th)) } unless nil_or_empty?(new_resource.template_helpers)

    variables(new_resource.variables)

    action :create
  end
end

action :delete do
  file new_resource.config_file { action(:delete) }
end
