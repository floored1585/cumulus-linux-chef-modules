#
# Cookbook Name:: cumulus-test
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
    echo "Rocket Turtle!\nexpires=$(date +%s)\n$0 $@" > /etc/cumulus/.license.txt'
  mode '0755'
end

include_recipe "cumulus-test::ports"
include_recipe "cumulus-test::license"
include_recipe "cumulus-test::interface_policy"
