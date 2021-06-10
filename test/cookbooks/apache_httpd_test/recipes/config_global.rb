#
# Cookbook:: apache_httpd_test
# Recipe:: config_global
#
# Copyright:: Ben Hughes, All Rights Reserved.

apache_httpd_config_global 'httpd.conf' do
  variables({
    'options' => {
      'ServerRoot' => '"/etc/httpd"',
      'Listen' => 80,
      'User' => 'apache',
      'Group' => 'apache',
      'ServerAdmin' => 'root@localhost',
      'DocumentRoot' => '/var/www/html',
      'ErrorLog' => 'logs/error_log',
      'LogLevel' => 'warn',
      'AddDefaultCharset' => 'UTF-8',
      'EnableSendfile' => 'on',
    },
    'include' => [
      'conf.modules.d/*.conf',
    ],
    'include_optional' => [
      'conf.d/*.conf',
      'conf.site.d/*.conf',
      'conf.generic.d/*.conf',
    ],
    'directory' => {
      '/' => {
        'AllowOverride' => 'None',
        'Require' => 'all denied',
      },
      '/var/www' => {
        'AllowOverride' => 'None',
        'Require' => 'all granted',
      },
      '/var/www/html' => {
        'AllowOverride' => 'None',
        'Options' => 'Indexes FollowSymLinks',
        'Require' => 'all granted',
      },
      '/var/www/cgi-bin' => {
        'AllowOverride' => 'None',
        'Require' => 'all granted',
      },
    },
    'ifmodule' => {
      'dir_module' => {
        'DirectoryIndex' => 'index.html',
      },
      'log_config_module' => {
        'LogFormat' => [
          '"%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined',
          '"%h %l %u %t \"%r\" %>s %b" common',
        ],
        'CustomLog' => '"logs/access_log" combined',
        'ifmodule' => {
          'logio_module' => {
            'LogFormat' => '"%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio',
          },
        },
      },
      'alias_module' => {
        'ScriptAlias' => '/cgi-bin/ "/var/www/cgi-bin/"',
      },
      'mime_module' => {
        'TypesConfig' => '/etc/mime.types',
        'AddType' => [
          'application/x-compress .Z',
          'application/x-gzip .gz .tgz',
          'text/html .shtml',
        ],
        'AddOutputFilter' => 'INCLUDES .shtml',
      },
      'mime_magic_module' => {
        'MIMEMagicFile' => 'conf/magic',
      },
    },
    'files' => {
      '.ht*' => {
        'Require' => 'all denied',
      },
    },
  })
end
