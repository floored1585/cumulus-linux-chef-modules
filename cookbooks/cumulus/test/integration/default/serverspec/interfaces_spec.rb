require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

intf_dir = File.join('', 'etc', 'network', 'interfaces.d')

# The recipe should have created the .d directory
describe file(intf_dir) do
  it { should be_directory }
end

# Should exist
%w( eth0 lo ).each do |intf|
  describe file("#{intf_dir}/#{intf}") do
    it { should be_file }
  end
end

(1..10).each do |intn|
  describe file("#{intf_dir}/swp#{intn}") do
    it { should be_file }
  end
end

# Should not have been created by interface_policy
describe file("#{intf_dir}/swp20") do
  it { should_not be_file }
end

# Should have been removed by interface_policy
describe file("#{intf_dir}/swp99") do
  it { should_not be_file }
end
