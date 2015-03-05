require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

intf_dir = File.join('', 'etc', 'network', 'interfaces.d')

# Should have been created by the cumulus_bond resource
describe file("#{intf_dir}/bond0") do
  it { should be_file }
  its(:content) { should match(/iface bond0/) }
  its(:content) { should match(/bond-slaves swp1 swp2 swp4/) }
  its(:content) { should match(/clag-id 42/) }
end
