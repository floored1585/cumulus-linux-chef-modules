require 'uri'

def whyrun_supported?
  true
end

use_inline_resources

action :install do
  if license_invalid? || new_resource.force
    source = new_resource.source

    validate_url!(source)
    execute "/usr/cumulus/bin/cl-license -i #{source}"

    new_resource.updated_by_last_action(true)
  end
end

##
# Check if the license file exists, and if if exists, if it has expired
#
# = Returns:
# true if either the license doesn't exist, the expiration date can not be read
# or the expiration date has passed, false otherwise.
#
def license_invalid?
  invalid = true
  begin
    if ::File.file?('/etc/cumulus/.license.txt')
      match = ::File.read('/etc/cumulus/.license.txt').match(/^expires=(\d+).*$/)
      invalid = Time.now.to_i >= match[1].to_i if match
    end
  rescue StandardError => e
    Chef::Application.fatal!("Checking Cumulus license file failed: #{e.message}")
  end

  invalid
end

##
# Parse the provided source URI and stop executation if the URL is invalid
#
def validate_url!(uri_str)
  begin
    URI.parse(uri_str)
  rescue URI::InvalidURIError
    Chef::Application.fatal!("The cumulus_license source URL #{uri_str} is invalid")
  end
end
