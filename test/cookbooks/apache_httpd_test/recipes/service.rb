#
# Cookbook:: apache_httpd_test
# Recipe:: service
#
# Copyright:: Ben Hughes, All Rights Reserved.

apache_httpd_service 'httpd' do
  action %i(test enable start)
end
