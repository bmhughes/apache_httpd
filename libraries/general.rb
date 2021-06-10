#
# Cookbook:: apache_httpd
# Library:: helpers
#
# Copyright:: Ben Hughes, All Rights Reserved.

module ApacheHttpd
  module Cookbook
    module GeneralHelpers
      def default_apache_user
        case node['platform_family']
        when 'rhel', 'fedora'
          'apache'
        when 'debian'
          'www-data'
        else
          raise ArgumentError, "Platform family #{node['platform_family']} is unsupported"
        end
      end

      def default_apache_group
        case node['platform_family']
        when 'rhel', 'fedora'
          'apache'
        when 'debian'
          'www-data'
        else
          raise ArgumentError, "Platform family #{node['platform_family']} is unsupported"
        end
      end

      def default_apache_service_name
        case node['platform_family']
        when 'rhel', 'fedora'
          'httpd'
        when 'debian'
          'apache2'
        else
          raise ArgumentError, "Platform family #{node['platform_family']} is unsupported"
        end
      end
    end
  end
end
