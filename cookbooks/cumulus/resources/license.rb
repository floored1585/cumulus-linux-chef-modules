actions :install
default_action :install

attribute :name, kind_of: String, name_attribute: true
attribute :source, kind_of: String, required: true
attribute :force, kind_of: [TrueClass, FalseClass], default: false
