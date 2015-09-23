# == Class: profiles::base
# ================================
#
# Install and configure base OS and utilities
#
class profiles::base {
  include ::epel
  # Defined in kafka: wget
  $pkg_utils = ['curl', 'sysstat', 'tcpdump', 'telnet', 'traceroute', 'unzip', 'xdelta' ]
  package { $pkg_utils: ensure => latest, }

  include ::profiles::lldp
}
