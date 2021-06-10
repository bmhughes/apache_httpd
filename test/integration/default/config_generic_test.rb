#
# Cookbook:: apache_httpd
# Spec:: config_generic
#
# Copyright:: 2021, Ben Hughes, All Rights Reserved.

describe file('/etc/httpd/conf.generic.d/01-test.conf') do
  it { should exist }
  it { should be_file }
  its('content') { should match 'LoadModule wsgi_module modules/mod_wsgi.so' }
  its('content') { should match /<VirtualHost \*:80>/ }
  its('content') { should match %r{    CustomLog '\|\/usr\/sbin\/rotatelogs -D -f \/var\/log\/httpd\/netbox.mds.gb.test.net\/%Y\/%m\/%d\/access.log' combined} }
end
