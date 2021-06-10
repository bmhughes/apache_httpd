#
# Cookbook:: apache_httpd
# Library:: package
#
# Copyright:: Ben Hughes, All Rights Reserved.

module ApacheHttpd
  module Cookbook
    module PackageHelpers
      def default_install_packages
        case node['platform_family']
        when 'rhel', 'fedora'
          if platform?('centos') && node['platform_version'].to_i == 7
            %w(httpd httpd-devel httpd-manual httpd-tools mod_ssl)
          else
            %w(httpd httpd-devel httpd-filesystem httpd-manual httpd-tools mod_ssl)
          end
        when 'debian'
          %w(apache2)
        else
          raise ArgumentError, "Platform family #{node['platform_family']} is unsupported"
        end
      end
    end
  end
end
