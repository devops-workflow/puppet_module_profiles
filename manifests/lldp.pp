# == Class: profiles::lldp
# ================================
#
# Install and configure 
#
class profiles::lldp {
  class { 'openlldp':
    autoupgrade    => true,
    service_enable => true,
  }
  #openlldp::config::lldp { 'intf': }
  #openlldp::config::tlv { 'intf': }
}

