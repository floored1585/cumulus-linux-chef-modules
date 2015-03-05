require 'json'

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name
  slaves = Cumulus::Utils.expand_port_list(new_resource.slaves)
  config = { 'bond-slaves' => slaves.join(' '),
             'bond-miimon' => 100,
             'bond-min-links' => 1,
             'bond-mode' => '802.3ad',
             'bond-xmit-hash-policy' => 'layer3+4',
             'bond-lacp-rate' => 1 }

  new = [ { 'auto' => true,
            'name' => name,
            'config' => config,
            'addr_method' => nil,
            'addr_family' => nil } ]

  current = if_to_hash(name)

  Chef::Log.debug("current config for bond #{name} is #{current.to_json}")
  Chef::Log.debug("desired config for bond #{name} is #{new.to_json}")

  if current.nil? or current != new
    Chef::Log.debug("updating config for bond #{name}")

    intf = hash_to_if(name, new)

    file interfaces_dir(name) do
      owner 'root'
      group 'root'
      content intf
    end

    new_resource.updated_by_last_action(true)
  end
end

def interfaces_dir(fname = '')
  ::File.join('', 'etc', 'network', 'interfaces.d', fname)
end

def if_to_hash(name)
  begin
    json = ''
    IO.popen("ifquery #{name} -o json") do |ifquery|
      json = ifquery.read
    end
    return JSON.load(json)
  rescue Exception => ex
    Chef::Log.fatal("I have fallen and I can't get up: #{ex}")
  end
end

def hash_to_if(name, hash)
  begin
    intf = ''
    IO.popen("ifquery -i - -t json #{name}", mode='r+') do |ifquery|
      ifquery.write(hash.to_json)
      ifquery.close_write

      intf = ifquery.read
      ifquery.close
    end
    Chef::Log.debug("ifquery produced the following:\n#{intf}")
    return intf
  rescue Exception => ex
    Chef::Log.fatal("I have fallen and I can't get up: #{ex}")
  end
end
