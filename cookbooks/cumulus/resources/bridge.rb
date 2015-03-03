actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :ipv4, kind_of: Array
attribute :ipv6, kind_of: Array
attribute :ports, kind_of: Array
attribute :mtu, kind_of: Integer
attribute :stp, kind_of: Boolean
attribute :mstpctl_treeprio, kind_of: Integer
attribute :vlan_aware, kind_of: Boolean
attribute :alias, kind_of: String
attribute :vids, kind_of: Array
attribute :pvid, kind_of: Integer
