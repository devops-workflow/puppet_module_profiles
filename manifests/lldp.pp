# == Class: profiles::lldp
# ================================
#
# Install and configure 
#
class profiles::lldp {
  class { 'openlldp':
    autoupgrade => True,
    service_enable => True,
  }
  #openlldp::config::lldp { 'intf': }
  #openlldp::config::tlv { 'intf': }
}

