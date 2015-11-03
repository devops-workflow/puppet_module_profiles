# == Class: profiles::base
# ================================
#
# Install and configure base OS and utilities
#
class profiles::base {

  include ::epel
  # Defined in kafka: wget
  $pkg_utils = ['curl', 'sysstat', 'tcpdump', 'telnet', 'traceroute', 'unzip', 'xdelta' ]
  # Others: lsof, deltarpm, bash-completion
  package { $pkg_utils: ensure => latest, }

  # if physical
  #  pciutils, 
  unless ( $::is_virtual == "true" ) {
    include ::profiles::lldp # should only be for physical, not VMs
  }
  include ::profiles::nsswitch
  include ::profiles::sudo
  include ::profiles::firewall

}
