source 'https://supermarket.chef.io'
source 'https://chef-supermarket.test.net'

metadata

cookbook 'test_net_helpers', '~> 1.3'

group :integration do
  cookbook 'apache_httpd_test', path: 'test/cookbooks/apache_httpd_test'
end
