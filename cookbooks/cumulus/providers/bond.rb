require 'json'

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name
  slaves = Cumulus::Utils.expand_port_list(new_resource.slaves)
  clag_id = new_resource.clag_id

  config = { 'bond-slaves' => slaves.join(' '),
             'bond-miimon' => 100,
             'bond-min-links' => 1,
             'bond-mode' => '802.3ad',
             'bond-xmit-hash-policy' => 'layer3+4',
             'bond-lacp-rate' => 1 }

  # Insert optional parameters
  config['clag-id'] = clag_id unless clag_id.nil?

  new = [ { 'auto' => true,
            'name' => name,
            'config' => config,
            'addr_method' => nil,
            'addr_family' => nil } ]

  current = Cumulus::Utils.if_to_hash(name)

  Chef::Log.debug("current config for bond #{name} is #{current.to_json}")
  Chef::Log.debug("desired config for bond #{name} is #{new.to_json}")

  if current.nil? or current != new
    Chef::Log.debug("updating config for bond #{name}")

    intf = Cumulus::Utils.hash_to_if(name, new)

    file Cumulus::Utils.interfaces_dir(name) do
      owner 'root'
      group 'root'
      content intf
    end

    new_resource.updated_by_last_action(true)
  end
end
