def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name
  ports = Cumulus::Utils.expand_port_list(new_resource.ports)
  mtu = new_resource.mtu
  mstpctl_treeprio = new_resource.mstpctl_treeprio
  alias_name = new_resource.alias
  ipv4 = new_resource.ipv4
  ipv6 = new_resource.ipv6
  address = ipv4 + ipv6

  config = { 'bridge-ports' => ports,
             'bridge-stp' => new_resource.stp }

  # Insert optional parameters
  config['address'] = address unless address.nil?
  config['mtu'] = mtu unless mtu.nil?
  config['mstpctl-treeprio'] = mstpctl_treeprio unless mstpctl_treeprio.nil?
  config['alias'] = alias_name unless alias_name.nil?

  if new_resource.vlan_aware
    config['bridge-vlan-aware'] = true

    # vids & pvid are valid
    vids = new_resource.vids
    pvid = new_resource.pvid

    config['bridge-vids'] = vids unless vids.nil?
    config['bridge-pvid'] = pvid unless pvid.nil?
  end

  new = [ { 'auto' => true,
            'name' => name,
            'config' => config,
            'addr_method' => nil,
            'addr_family' => nil } ]

  current = Cumulus::Utils.if_to_hash(name)

  Chef::Log.debug("current config for bridge #{name} is #{current.to_json}")
  Chef::Log.debug("desired config for bridge #{name} is #{new.to_json}")

  if current.nil? or current != new
    Chef::Log.debug("updating config for bridge #{name}")

    intf = Cumulus::Utils.hash_to_if(name, new)

    file Cumulus::Utils.interfaces_dir(name) do
      owner 'root'
      group 'root'
      content intf
    end

    new_resource.updated_by_last_action(true)
  end
end
