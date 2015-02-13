#
# Cookbook Name:: cumulus-test
# Recipe:: license
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

cumulus_license 'test' do
  source 'http://localhost/test.lic'
end

cumulus_license 'test-with-force' do
  source 'http://localhost/test.lic'
  force true
end
