#
# Cookbook:: apache_httpd
# Resource:: site
#
# Copyright:: 2021, Ben Hughes, All Rights Reserved.

unified_mode true

use 'partial/_config_file'
use 'partial/_template_properties'

action_class do
  def site_enabled?
    case node['platform_family']
    when 'rhel', 'fedora'
      ::File.exist?(new_resource.config_file) && !::File.exist?("#{new_resource.config_file}.disabled")
    when 'debian'
      ::File.symlink?(new_resource.config_file.gsub('available', 'enabled'))
    end
  end

  def site_disabled?
    case node['platform_family']
    when 'rhel', 'fedora'
      !::File.exist?(new_resource.config_file) && ::File.exist?("#{new_resource.config_file}.disabled")
    when 'debian'
      !::File.symlink?(new_resource.config_file.gsub('available', 'enabled'))
    end
  end
end

action :create do
  if site_disabled?
    Chef::Log.warn('Site is disabled, skipping creation')
    return
  end

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

action :enable do
  converge_by("Enable site configuration for #{new_resource.name}") do
    case node['platform_family']
    when 'rhel', 'fedora'
      ::File.rename("#{new_resource.config_file}.disabled", "#{new_resource.config_file}")
    when 'debian'
      shell_out!("/usr/sbin/a2enconf #{new_resource.name}")
    end
  end unless site_enabled?
end

action :disable do
  converge_by("Disable site configuration for #{new_resource.name}") do
    case node['platform_family']
    when 'rhel', 'fedora'
      ::File.rename("#{new_resource.config_file}", "#{new_resource.config_file}.disabled")
    when 'debian'
      shell_out!("/usr/sbin/a2disconf  #{new_resource.name}")
    end
  end unless site_disabled?
end
