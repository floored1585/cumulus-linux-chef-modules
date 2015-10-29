cumulus-linux-chef-modules CHANGELOG
====================================

This file is used to list changes made in each version of the cumulus-linux-chef-modules cookbook.

1.2.1
-----
- Ian Clark (PR)
 Add pre-down/post-up
 Fix ifquery -o comparison
1.2.0
-----
- Kristian Van Der Vliet
  Add lacp_bypass attributes to Bonds:
    - lacp_bypass_allow
    - lacp_bypass_period
    - lacp_bypass_priority
    - lacp_bypass_all_active
  Add mstpctl_portadminedge attribute to Bonds & Interfaces.

1.1.0
-----
- Kristian Van Der Vliet
  Updates to the cumulus_license module to work with both new & old style Cumulus Linux licenses.

1.0.3
-----
- Kristian Van Der Vliet
  Fix cumulus_ports LWRP on Chef 11.x

1.0.2
-----
- James Findley
  Use yes/no instead of True/False for Bonds & Bridges
  Ports will now only run notifies actions if the inline resource updated anything

- Kristian Van Der Vliet
  Fix bridge definitions with multiple ports
  Update tests to check for this situation.

1.0.1
-----
- James Findley
  Fix metadata.rb so that it works on Chef < 12

1.0.0
-----
- Kristian Van Der Vliet
  Initial release of cumulus-linux-chef-modules
