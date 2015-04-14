#
# Cookbook Name:: cumulus-test
# Recipe:: bridges
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

# Classic bridge driver with defaults
cumulus_bridge 'br0' do
  ports ['swp9', 'swp10-11', 'swp12']
end

# Classic bridge driver over-ride all defaults
cumulus_bridge 'br1' do
  ports ['swp12-13']
  ipv4 ['10.0.0.1/24', '192.168.1.0/16']
  ipv6 ['2001:db8:abcd::/48']
  alias_name 'classic bridge number 1'
  mtu 9000
  stp false
  mstpctl_treeprio 4096
  virtual_ip '192.168.100.1'
end

# New bridge driver with defaults
cumulus_bridge 'bridge2' do
  ports ['swp15-16']
  vlan_aware true 
end

# New bridge driver over-ride all defaults
cumulus_bridge 'bridge3' do
  ports ['swp17-18']
  vlan_aware true
  vids ['1-4094']
  pvid 1
  ipv4 ['10.0.100.1/24', '192.168.100.0/16']
  ipv6 ['2001:db8:1234::/48']
  alias_name 'new bridge number 3'
  mtu 9000
  stp false
  mstpctl_treeprio 4096
  virtual_mac 'aa:bb:cc:dd:ee:ff'
end
