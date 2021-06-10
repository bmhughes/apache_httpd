#
# Cookbook:: apache_httpd
# Resource:: package
#
# Copyright:: Ben Hughes, All Rights Reserved.

unified_mode true

include ApacheHttpd::Cookbook::PackageHelpers

property :packages, [String, Array],
          default: lazy { default_install_packages }

action_class do
  def do_package_action(action)
    package 'Apache HTTPd' do
      package_name new_resource.packages

      action action
    end
  end
end

%i(install upgrade remove).each { |pkg_action| action(pkg_action) { do_package_action(action) } }
