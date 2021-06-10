#
# Cookbook:: apache_httpd
# Spec:: default
#
# Copyright:: 2021, Ben Hughes, All Rights Reserved.

require 'spec_helper'

describe 'apache_httpd_test::default' do
  platform 'centos', '8'

  context 'With apache_httpd::default' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
