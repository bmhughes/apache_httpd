#
# Cookbook:: apache_httpd_test
# Recipe:: config_generic
#
# Copyright:: Ben Hughes, All Rights Reserved.

apache_httpd_config_generic '01-test' do
  config_dir '/etc/httpd/conf.generic.d'

  variables({
    'options' => {
      'options' => {
        'LoadModule' => 'wsgi_module modules/mod_wsgi.so',
      },
    },
    'virtualhost' => [
      {
        'listen' => '*:80',
        'options' => {
          'ServerName' => 'netbox.test.net',
          'ServerAdmin' => 'netbox@test.net',
          'CustomLog' => '\'|/usr/sbin/rotatelogs -D -f /var/log/httpd/netbox.test.net/%Y/%m/%d/access.log\' combined',
          'ErrorLog' => '\'|/usr/sbin/rotatelogs -D -f /var/log/httpd/netbox.test.net/%Y/%m/%d/error.log\'',
          'Redirect' => '/ https://netbox.test.net',
        },
      },
    ],
  })
end
