require 'uri'

def whyrun_supported?
  true
end

use_inline_resources

action :install do
  unless license_exists?
    if license_expired? or new_resource.force
      source = new_resource.source

      validate_url!(source)
      execute "/usr/cumulus/bin/cl-license -i #{source}"

      new_resource.updated_by_last_action(true)
    end
  end
end 

def license_exists?
  ::File.file?('/etc/cumulus/.license.txt')
end

def license_expired?
  false
end

def validate_url!(uri_str)
  begin
    URI::parse(uri_str)
  rescue URI::InvalidURIError => e
    Chef::Application.fatal!("The cumulus_license source URL #{uri_str} is invalid")
  end
end
