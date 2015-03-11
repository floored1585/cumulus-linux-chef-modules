actions :manage
default_action :manage

attribute :name, kind_of: String, name_attribute: true
attribute :allowed, kind_of: Array, required: true
attribute :location, kind_of: String, default: node['cumulus']['interfaces']['dir']
