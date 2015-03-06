#
# Cookbook Name:: cumulus-test
# Recipe:: bonds
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

cumulus_bond 'bond0' do
  slaves ['swp1-2', 'swp4']
  # clag_id 42
end
