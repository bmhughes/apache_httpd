#
# Cookbook:: apache_httpd
# Library:: config
#
# Copyright:: 2021, Ben Hughes, All Rights Reserved.

module ApacheHttpd
  module Cookbook
    module ConfigHelpers
      def default_config_dir
        case declared_type
        when :apache_httpd_config_global
          default_config_dir_global
        when :apache_httpd_config_site
          default_config_dir_site
        when :apache_httpd_config_module
          default_config_dir_module
        else
          raise ArgumentError, "Config file path for resource type #{declared_type} is unsupported"
        end
      end

      def default_config_file
        case declared_type
        when :apache_httpd_config_global
          default_config_file_global
        when :apache_httpd_config_site, :apache_httpd_config_module, :apache_httpd_config_generic
          "#{name}.conf"
        else
          raise ArgumentError, "Config file path for resource type #{declared_type} is unsupported"
        end
      end

      def default_config_file_template
        case declared_type
        when :apache_httpd_config_global
          'httpd.conf.erb'
        when :apache_httpd_config_site
          'site.erb'
        when :apache_httpd_config_module
          'module.erb'
        when :apache_httpd_config_generic
          'generic.erb'
        else
          raise ArgumentError, "Config file template for resource type #{declared_type} is unsupported"
        end
      end

      private

      def default_config_dir_global
        case node['platform_family']
        when 'rhel', 'fedora'
          '/etc/httpd/conf'
        when 'debian'
          '/etc/apache2'
        else
          raise ArgumentError, "Platform family #{node['platform_family']} is unsupported"
        end
      end

      def default_config_file_global
        case node['platform_family']
        when 'rhel', 'fedora'
          'httpd.conf'
        when 'debian'
          'apache2.conf'
        else
          raise ArgumentError, "Platform family #{node['platform_family']} is unsupported"
        end
      end

      def default_config_dir_site
        case node['platform_family']
        when 'rhel', 'fedora'
          '/etc/httpd/conf.site.d'
        when 'debian'
          '/etc/apache2/sites-available'
        else
          raise ArgumentError, "Platform family #{node['platform_family']} is unsupported"
        end
      end

      def default_config_dir_module
        case node['platform_family']
        when 'rhel', 'fedora'
          '/etc/httpd/conf.modules.d'
        when 'debian'
          '/etc/apache2/modules-available'
        else
          raise ArgumentError, "Platform family #{node['platform_family']} is unsupported"
        end
      end
    end
  end
end
