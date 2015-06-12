# Copyright (C) 2015  Cumulus Networks Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
require 'uri'

def whyrun_supported?
  true
end

def wrapper_path
  @temp_path ||= ::File.join(::Dir.tmpdir, 'ce-license-wrapper')
end

use_inline_resources

action :install do

  # Make the license wrapper available
  wrapper = cookbook_file 'create_wrapper' do
    action :create
    backup false
    owner 'root'
    group 'root'
    mode 0755
    cookbook 'cumulus'
    source 'ce-license-wrapper'
    path wrapper_path
  end
  wrapper.run_action(:create)

  if !license? || new_resource.force
    source = new_resource.source

    validate_url!(source)
    license = execute "#{wrapper_path} -e -i #{source}"

    new_resource.updated_by_last_action(license.updated_by_last_action?)
  end

  # Remove the wrapper
  remove = file wrapper_path do
    action :delete
    backup false
  end
  remove.run_action(:delete)

end

##
# Check if a license file is already installed
#
# = Returns:
# true if the license exists, false otherwise.
#
def license?
  installed = false
  begin
    _license_info = `#{wrapper_path} -j`
    installed = $?.success?
  rescue StandardError => e
    Chef::Application.fatal!("Checking Cumulus license file failed: #{e.message}")
  end

  installed
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
