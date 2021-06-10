#
# Cookbook:: apache_httpd_test
# Recipe:: config_module
#
# Copyright:: Ben Hughes, All Rights Reserved.

if platform?('centos') && node['platform_version'].to_i == 7
  package 'mod_wsgi' do
    action :install
  end

  apache_httpd_config_module '10-wsgi' do
    variables({
      'loadmodule' => [
        'wsgi_module modules/mod_wsgi.so',
      ],
    })
    action %i(create enable)
  end
else
  package 'python3-mod_wsgi' do
    action :install
  end

  apache_httpd_config_module '10-wsgi-python3' do
    variables({
      'ifmodule' => {
        '!wsgi_module' => {
          'LoadModule' => 'wsgi_module modules/mod_wsgi_python3.so',
        },
      },
    })
    action %i(create enable)
  end
end
