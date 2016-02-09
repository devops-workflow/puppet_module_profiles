# == Class: profiles::base
# ================================
#
# Install and configure base OS and utilities
#
class profiles::base {

  include ::epel
  include ::profiles::base::packages
  # if physical
  #  pciutils, 
  unless ( $::is_virtual == "true" ) {
    include ::profiles::lldp # should only be for physical, not VMs
  }
  include ::profiles::nsswitch
  include ::profiles::sudo
  include ::profiles::timezone
  include ::profiles::base::firewall
  include ::profiles::base::selinux
  include ::profiles::base::ntp
  include ::profiles::base::ssh
}
