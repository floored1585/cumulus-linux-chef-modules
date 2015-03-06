def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name
  addr_method = new_resource.addr_method
  link_speed = new_resource.link_speed
  clag_enable = new_resource.clag_enable
  clag_peer_ip = new_resource.clag_peer_ip
  clag_sys_mac = new_resource.clag_sys_mac
  alias_name = new_resource.alias
  virtual_mac = new_resource.virtual_mac
  virtual_ip = new_resource.virtual_ip
  vids = new_resource.vids

  ipv4 = new_resource.ipv4
  ipv6 = new_resource.ipv6
  address = ipv4 + ipv6

  # Family is always 'inet' if a method is set
  addr_family = addr_method.nil? ? nil : 'inet'

  config = {}

  # Insert optional parameters
  config['address'] = address unless address.nil?
  config['alias'] = alias_name unless alias_name.nil?
  config['vids'] = vids unless vids.nil?
  config['virtual-mac'] = virtual_mac unless virtual_mac.nil?
  config['virtual-ip'] = virtual_ip unless virtual_ip.nil?

  if clag_enable
    config['clagd-enable'] = true
    config['clagd-peer-ip'] = clag_peer_ip unless clag_peer_ip.nil?
    config['clagd-sys-mac'] = clag_sys_mac unless clag_sys_mac.nil?
  end

  unless link_speed.nil?
    config['link-speed'] = link_speed
    # link-duplex is always set to 'full' if link-speed is set
    config['link-duplex'] = 'full'
  end

  new = [ { 'auto' => true,
            'name' => name,
            'config' => config,
            'addr_method' => addr_method,
            'addr_family' => addr_family } ]

  current = Cumulus::Utils.if_to_hash(name)

  Chef::Log.debug("current config for interface #{name} is #{current.to_json}")
  Chef::Log.debug("desired config for interface #{name} is #{new.to_json}")

  if current.nil? or current != new
    Chef::Log.debug("updating config for interface #{name}")

    intf = Cumulus::Utils.hash_to_if(name, new)

    file Cumulus::Utils.interfaces_dir(name) do
      owner 'root'
      group 'root'
      content intf
    end

    new_resource.updated_by_last_action(true)
  end
end
