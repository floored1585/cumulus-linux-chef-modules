cumulus-linux-chef-modules
=============
This is the top level Git repository for Chef LWRP's, libraries and cookbooks for Cumulus Linux.

The following cookbooks can be found within the "cookbooks" directory.

## cumulus

Contains the following lightweight resource providers:

* cumulus_license
* cumulus_ports
* cumulus_interface_policy
* cumulus_interface
* cumulus_bond
* cumulus_bridge

Full documentation for these can be found in the [README](cookbooks/cumulus/README.md) within the cookbook.

This cookbook also contains the Cumulus::Util library and top-level recipes which can be used in conjunction with the providers.

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
* Author:: Cumulus Networks Inc.

* Copyright:: 2015 Cumulus Networks Inc.

Recipes are licensed under the Apache License, Version 2.0

All others are licensed under the GNU General Public License, Version 2.0

---

![Cumulus icon](http://cumulusnetworks.com/static/cumulus/img/logo_2014.png)

### Cumulus Linux

Cumulus Linux is a software distribution that runs on top of industry standard
networking hardware. It enables the latest Linux applications and automation
tools on networking gear while delivering new levels of innovation and
ﬂexibility to the data center.

For further details please see: [cumulusnetworks.com](http://www.cumulusnetworks.com)