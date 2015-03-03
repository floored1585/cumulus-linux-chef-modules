actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :slaves, kind_of: Array, required: true
attribute :clag_id, kind_of: Integer
