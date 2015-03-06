actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :ipv4, kind_of: Array, default: []
attribute :ipv6, kind_of: Array, default: []
attribute :addr_method, kind_of: String
attribute :vids, kind_of: [Array, NilClass]
attribute :link_speed, kind_of: [String, NilClass]
attribute :clag_enable, kind_of: [TrueClass, FalseClass], default: false
attribute :clag_peer_ip, kind_of: [String, NilClass]
attribute :clag_sys_mac, kind_of: [String, NilClass]
attribute :alias, kind_of: [String, NilClass]
attribute :virtual_mac, kind_of: [String, NilClass]
attribute :virtual_ip, kind_of: [String, NilClass]
