require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

describe file('/etc/cumulus') do
  it { should be_directory }
end

describe file('/etc/cumulus/ports.conf') do
  it { should be_file }
  its(:content) { should match(/# Managed by Chef/) }
  its(:content) { should match(/1=10G/) }
  its(:content) { should match(/3=40G/) }
  its(:content) { should match(/5=40G/) }
  its(:content) { should match(/10=40G/) }
  its(:content) { should match(/12=40G/) }
  its(:content) { should match(/15=40G\/4/) }
  its(:content) { should match(/16=40G\/4/) }
  its(:content) { should match(/20=4x10G/) }
  its(:content) { should match(/32=4x10G/) }
end
