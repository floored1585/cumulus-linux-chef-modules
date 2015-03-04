def whyrun_supported?
  true
end

use_inline_resources

action :manage do
  allowed = Cumulus::Utils.expand_port_list(new_resource.allowed)
  current = Dir.entries(::File.join('', 'etc', 'network', 'interfaces.d')).reject { |f| ::File.directory? f }

  # Intersect the two lists; we want the set that is in 'current' which are NOT
  # in 'allowed'
  remove = current - allowed

  Chef::Log.debug("Removing the following interfaces: #{remove}")

  unless remove.empty?
    # Warn if 'lo' is in the list we're about to remove, as that can produce
    # odd results
    if remove.include?('lo')
      Chef::Log.warn('Removing configuration for loopback interface "lo": this may cause unexpected behaviour.')
    end

    remove.each do |intf|
      file ::File.join('', 'etc', 'network','interfaces.d', intf) do
        action :delete
      end
    end

    new_resource.updated_by_last_action(true)
  end
end
