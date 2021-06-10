#
# Cookbook:: apache_httpd_test
# Recipe:: prepare
#
# Copyright:: Ben Hughes, All Rights Reserved.

execute 'system_self_signed' do
  command 'openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/CN=localhost" -keyout /etc/pki/tls/private/localhost.key -out /etc/ssl/certs/localhost.crt'
  not_if { ::File.exist?('/etc/pki/tls/private/localhost.key') && ::File.exist?('/etc/ssl/certs/localhost.crt') }

  action :run
end

directory '/etc/test_net/certificates/netbox/netbox.test.net' do
  owner 'root'
  group 'root'
  mode '0755'

  recursive true

  action :create
end

file '/etc/test_net/certificates/netbox/netbox.test.net/fullchain.pem' do
  content lazy { File.read('/etc/ssl/certs/localhost.crt') }

  owner 'root'
  group 'root'
  mode '0755'

  action :create
end

file '/etc/test_net/certificates/netbox/netbox.test.net/privkey.pem' do
  content lazy { File.read('/etc/pki/tls/private/localhost.key') }

  owner 'root'
  group 'root'
  mode '0755'

  action :create
end
