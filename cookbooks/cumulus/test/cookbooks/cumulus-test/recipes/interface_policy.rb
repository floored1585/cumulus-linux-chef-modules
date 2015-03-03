#
# Cookbook Name:: cumulus-test
# Recipe:: interface_policy
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

cumulus_interface_policy 'test' do
  allowed ['eth0', 'lo', 'swp1-10', 'swp20']
end
