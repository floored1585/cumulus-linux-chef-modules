actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :ipv4, kind_of: Array
attribute :ipv6, kind_of: Array
attribute :addr_method, kind_of: String
attribute :vids, kind_of: Array
attribute :link_speed, kind_of: String
attribute :clag_enable, kind_of: [TrueClass, FalseClass]
attribute :clag_peer_ip, kind_of: String
attribute :clag_sys_mac, kind_of: String
attribute :alias, kind_of: String
attribute :virtual_mac, kind_of: String
attribute :virtual_ip, kind_of: String
