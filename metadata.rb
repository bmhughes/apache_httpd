name 'apache_httpd'
maintainer 'Ben Hughes'
maintainer_email 'Test@test.co.uk'
license 'All Rights Reserved'
description 'Installs/Configures apache_httpd'
version '0.1.0'
chef_version '>= 16.0'

issues_url 'https://gitlab.test.co.uk/chef/wrappers/apache_httpd/issues'
source_url 'https://gitlab.test.co.uk/chef/wrappers/apache_httpd'

%w(centos fedora redhat debian ubuntu).each { |os| supports os }

depends 'test_net_helpers', '~> 1.3'
