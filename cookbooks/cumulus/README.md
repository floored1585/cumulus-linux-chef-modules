# DESCRIPTION

This cookbook contains LWRP's and libraries for configring and managing components of Cumulus Linux in a modular manner.

# TESTING

This cookbook comes with a Gemfile, Berksfile and Test-kitchen file for testing the Cumulus LWRP's

```shell
$ gem install bundler
$ bundle install
$ berks install
$ kitchen converge default-ubuntu-1204
```

# LWRP'S
## Configure Trident2 switch ports

```ruby
cumulus_ports 'speeds' do
  speed_10g ['swp1']
  speed_40g ['swp3','swp5-10', 'swp12']
  speed_40g_div_4 ['swp15','swp16']
  speed_4_by_10g ['swp20-32']
  notifies :restart, "service[switchd]"
end
```

# LIBRARIES
## Util

The Cumulus::Util library is intended for use internally by the LWRP's. It is not intended for direct use by users, although the functions are fully documented. This library and the functions are subject to change at any time, with no notice.