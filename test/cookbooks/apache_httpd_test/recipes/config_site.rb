#
# Cookbook:: apache_httpd_test
# Recipe:: config_site
#
# Copyright:: Ben Hughes, All Rights Reserved.

apache_httpd_config_site 'netbox_test' do
  variables({
    'virtualhost' => {
      '*:80' => {
        'options' => {
          'ServerName' => 'netbox.test.net',
          'ServerAdmin' => 'netbox@test.net',
          'CustomLog' => '\'|/usr/sbin/rotatelogs -D -f /var/log/httpd/netbox.test.net/%Y/%m/%d/access.log\' combined',
          'ErrorLog' => '\'|/usr/sbin/rotatelogs -D -f /var/log/httpd/netbox.test.net/%Y/%m/%d/error.log\'',
          'Redirect' => '/ https://netbox.test.net',
        },
      },
      '*:443' => {
        'options' => {
          'ServerName' => 'netbox.test.net',
          'ServerAdmin' => 'netbox@test.net',
          'CustomLog' => '\'|/usr/sbin/rotatelogs -D -f /var/log/httpd/netbox.test.net/%Y/%m/%d/ssl_access.log\' combined',
          'ErrorLog' => '\'|/usr/sbin/rotatelogs -D -f /var/log/httpd/netbox.test.net/%Y/%m/%d/ssl_error.log\'',
          'SSLEngine' => 'On',
          'SSLCertificateFile' => '\'/etc/test_net/certificates/netbox/netbox.test.net/fullchain.pem\'',
          'SSLCertificateKeyFile' => '\'/etc/test_net/certificates/netbox/netbox.test.net/privkey.pem\'',
          'ProxyPreserveHost' => 'On',
          'Alias' => [
            '/static /opt/netbox/netbox/static',
          ],
          'WSGIPassAuthorization' => 'On',
          'RequestHeader' => 'set \'X-Forwarded-Proto\' expr=%{REQUEST_SCHEME}',
          'ProxyPass' => '/ http://127.0.0.1:8001/',
          'ProxyPassReverse' => '/ http://127.0.0.1:8001/',
          'ProxyTimeout' => 60,
        },
        'directory' => {
          '/opt/netbox/netbox/static' => {
            'Options' => 'Indexes FollowSymLinks MultiViews',
            'AllowOverride' => 'None',
            'Require' => 'all granted',
          },
        },
        'location' => {
          '/static' => {
            'ProxyPass' => '!',
          },
        },
      },
    },
  })

  action %i(create enable)
end
