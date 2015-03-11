actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :ipv4, kind_of: Array, default: []
attribute :ipv6, kind_of: Array, default: []
attribute :addr_method, kind_of: [String, NilClass]
attribute :slaves, kind_of: Array, required: true
attribute :min_links, kind_of: Integer, default: 1
attribute :mode, kind_of: String, default: '802.3ad'
attribute :miimon, kind_of: Integer, default: 100
attribute :xmit_hash_policy, kind_of: String, default: 'layer3+4'
attribute :lacp_rate, kind_of: Integer, default: 1
attribute :alias_name, kind_of: [String, NilClass]
attribute :mtu, kind_of: [Integer, NilClass]
attribute :virtual_mac, kind_of: [String, NilClass]
attribute :virtual_ip, kind_of: [String, NilClass]
attribute :vids, kind_of: [Array, NilClass]
attribute :pvid, kind_of: [Integer, NilClass]
attribute :clag_id, kind_of: [Integer, NilClass]
attribute :mstpctl_portnetwork, [TrueClass, FalseClass, NilClass]
attribute :mstpctl_bpduguard, [TrueClass, FalseClass, NilClass]
attribute :location, kind_of: [String, NilClass]
