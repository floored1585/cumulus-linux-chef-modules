#
# Cookbook Name:: cumulus-test
# Recipe:: interface_policy
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

# Create test files
%w( swp1 swp2 swp3 swp4 swp5 swp6 swp7 swp8 swp9 swp10 swp99 ).each do |intf|
  file "/etc/network/interfaces.d/#{intf}" do
    action :create
    content "iface #{intf}"
  end
end

# Tell interface_policy which interfaces we want; not that swp20 is NOT in the
# above list, and swp99 is NOT in this list
cumulus_interface_policy 'test' do
  allowed ['eth0', 'lo', 'swp1-10', 'swp20']
end
