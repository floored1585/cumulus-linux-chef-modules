actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :ipv4, kind_of: Array, default: []
attribute :ipv6, kind_of: Array, default: []
attribute :ports, kind_of: Array, required: true
attribute :mtu, kind_of: [Integer, NilClass]
attribute :stp, kind_of: [TrueClass, FalseClass], default: true
attribute :mstpctl_treeprio, kind_of: [Integer, NilClass]
attribute :vlan_aware, kind_of: [TrueClass, FalseClass], default: false
attribute :alias, kind_of: [String, NilClass]
attribute :vids, kind_of: [Array, NilClass]
attribute :pvid, kind_of: [Integer, NilClass]
