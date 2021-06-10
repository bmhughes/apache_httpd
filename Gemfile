source 'https://rubygems.org'

require 'chef/cookbook/metadata'

m = Chef::Cookbook::Metadata.new
m.from_file 'metadata.rb'
m.gems.each do |name, version|
  gem name, version
end
