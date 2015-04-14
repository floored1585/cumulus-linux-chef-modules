require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

intf_dir = File.join('', 'etc', 'network', 'interfaces.d')

# Classic bridge driver
describe file("#{intf_dir}/br0") do
  it { should be_file }
  its(:content) { should match(/iface br0/) }
  its(:content) { should match(/bridge-ports swp9 glob swp10-11 swp12/) }
  its(:content) { should match(/bridge-stp True/) }
end

describe file("#{intf_dir}/br1") do
  it { should be_file }
  its(:content) { should match(/iface br1/) }
  its(:content) { should match(/bridge-ports glob swp12-13/) }
  its(:content) { should match(/bridge-stp False/) }
  its(:content) { should match(/mtu 9000/) }
  its(:content) { should match(/mstpctl-treeprio 4096/) }
  its(:content) { should match(/address 10.0.0.1\/24/) }
  its(:content) { should match(/address 2001:db8:abcd::\/48/) }
end

# New bridge driver
describe file("#{intf_dir}/bridge2") do
  it { should be_file }
  its(:content) { should match(/iface bridge2/) }
  its(:content) { should match(/bridge-vlan-aware True/) }
  its(:content) { should match(/bridge-ports glob swp15-16/) }
  its(:content) { should match(/bridge-stp True/) }
end

describe file("#{intf_dir}/bridge3") do
  it { should be_file }
  its(:content) { should match(/iface bridge3/) }
  its(:content) { should match(/bridge-vlan-aware True/) }
  its(:content) { should match(/bridge-ports glob swp17-18/) }
  its(:content) { should match(/bridge-stp False/) }
  its(:content) { should match(/mtu 9000/) }
  its(:content) { should match(/mstpctl-treeprio 4096/) }
  its(:content) { should match(/bridge-pvid 1/) }
  its(:content) { should match(/bridge-vids 1-4094/) }
  its(:content) { should match(/address 192.168.100.0\/16/) }
  its(:content) { should match(/address 2001:db8:1234::\/48/) }
end
