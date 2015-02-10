require 'utils.rb'

def whyrun_supported?
  true
end

use_inline_resources

action :configure do
  template '/etc/cumulus/ports.conf' do
    cookbook cumulus-cl-ports-chef
    source 'ports.erb'
    variables({
      :speed_10g => Cumulus::Utils.expand_port_list(new_resource.speed_10g),
      :speed_40g => Cumulus::Utils.expand_port_list(new_resource.speed_40g),
      :speed_40_div_4g => Cumulus::Utils.expand_port_list(new_resource.speed_40_div_4g),
      :speed_4_by_10g => Cumulus::Utils.expand_port_list(new_resource.speed_4_by_10g)
    })
    owner 'root'
    group 'root'
    mode '0600'
    backup false
  end
  new_resource.updated_by_last_action(true)
end
