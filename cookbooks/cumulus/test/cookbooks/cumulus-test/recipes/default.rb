#
# Cookbook Name:: cumulus-cl-ports-chef-test
# Recipe:: default
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

# Setup a skeleton fake Cumulus Linux environment
directory '/usr/cumulus/bin' do
  recursive true
end

directory '/etc/cumulus' do
end

file '/usr/cumulus/bin/cl-license' do
  content '#!/bin/sh
    echo "Rocket Turtle!\n$0 $@" > /etc/cumulus/.license.txt'
  mode '0755'
end

# Invoke the providers
cumulus_ports 'speeds' do
  speed_10g ['swp1']
  speed_40g ['swp3','swp5-10', 'swp12']
  speed_40g_div_4 ['swp15','swp16']
  speed_4_by_10g ['swp20-32']
end

cumulus_license 'test' do
  source 'http://localhost/test.lic'
end
