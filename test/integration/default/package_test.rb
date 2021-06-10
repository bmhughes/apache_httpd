#
# Cookbook:: apache_httpd
# Spec:: package
#
# Copyright:: 2021, Ben Hughes, All Rights Reserved.

packages = case os.family
           when 'debian'
             %w(apache2)
           else
             %w(httpd httpd-devel httpd-manual httpd-tools)
           end

packages.push('httpd-filesystem') if os.family.eql?('redhat') && os.release.to_i >= 8

packages.each do |package|
  describe package(package) do
    it { should be_installed }
  end
end
