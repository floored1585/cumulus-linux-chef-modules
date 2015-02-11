def whyrun_supported?
  true
end

use_inline_resources

action :install do
  unless license_exists?
    execute "/usr/cumulus/bin/cl-license -i #{new_resource.source}" do
    end
    new_resource.updated_by_last_action(true)
  end
end 

def license_exists?
  ::File.file?('/etc/cumulus/.license.txt')
end
