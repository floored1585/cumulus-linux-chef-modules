#
# Cookbook Name:: cumulus-test
# Recipe:: interfaces
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

# With all defaults
cumulus_interface 'swp1' do
end

# Over-ride defaults
cumulus_interface 'swp2' do
  ipv4 ['192.168.200.1']
  ipv6 ['2001:db8:5678::']
  addr_method 'static'
  speed '1000'
  mtu 9000
  # ifquery doesn't seem to like clagd related parameters on an interface?
  # clagd_enable true
  # clagd_priority 1
  # clagd_peer_ip '10.1.2.3'
  # clagd_sys_mac 'aa:bb:cc:dd:ee:ff'
  vids ['1-4094']
  pvid 1
  alias_name 'interface swp2'
  virtual_mac '11:22:33:44:55:66'
  virtual_ip '192.168.10.1'
  mstpctl_portnetwork true
  mstpctl_bpduguard true
end
