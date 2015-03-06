#
# Cookbook Name:: cumulus-test
# Recipe:: default
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

# Setup a skeleton fake Cumulus Linux environment
%w( /etc/cumulus /usr/cumulus/bin /etc/network/ifupdown2/templates ).each do |cldir|
  directory cldir do
    recursive true
  end
end

file '/usr/cumulus/bin/cl-license' do
  content '#!/bin/sh
    echo "Rocket Turtle!\nexpires=$(date +%s)\n$0 $@" > /etc/cumulus/.license.txt'
  mode '0755'
end

# Setup the Cumulus repository and install ifupdown2
execute 'apt-update' do
  command 'apt-get update'
  action :nothing
end

file '/etc/apt/sources.list.d/cumulus.list' do
  content 'deb [ arch=amd64 ] http://repo.cumulusnetworks.com CumulusLinux-2.5 main'
  notifies :run, 'execute[apt-update]', :immediately
end

%w( python-ifupdown2 python-argcomplete python-ipaddr ).each do |pkg|
  apt_package pkg do
    options '--force-yes'
  end
end

include_recipe "cumulus-test::ports"
include_recipe "cumulus-test::license"
include_recipe "cumulus-test::interface_policy"
include_recipe "cumulus-test::bonds"
include_recipe "cumulus-test::bridges"
