actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :ipv4, kind_of: Array, default: []
attribute :ipv6, kind_of: Array, default: []
attribute :addr_method, kind_of: [String, NilClass]
attribute :vids, kind_of: [Array, NilClass]
attribute :pvid, kind_of: [Integer, NilClass]
attribute :speed, kind_of: [String, NilClass]
attribute :mtu, kind_of: [Integer, NilClass]
attribute :clagd_enable, kind_of: [TrueClass, FalseClass], default: false
attribute :clagd_peer_ip, kind_of: [String, NilClass]
attribute :clagd_priority, kind_of: [Integer, NilClass]
attribute :clagd_sys_mac, kind_of: [String, NilClass]
attribute :clagd_args, kind_of: [String, NilClass]
attribute :alias_name, kind_of: [String, NilClass]
attribute :virtual_mac, kind_of: [String, NilClass]
attribute :virtual_ip, kind_of: [String, NilClass]
attribute :mstpctl_portnetwork, [TrueClass, FalseClass, NilClass]
attribute :mstpctl_bpduguard, [TrueClass, FalseClass, NilClass]
attribute :location, kind_of: [String, NilClass]
