# == Class: profiles::lldp
# ================================
#
# Install and configure 
#
class profiles::lldp {
  class { '::openlldp':
    autoupgrade    => true,
    service_enable => true,
  }

  # Config each ethX in ::interfaces
  $ethers = delete( split($::interfaces, ','), 'lo')

  openlldp::config::lldp { $ethers:
    adminstatus => 'rxtx',
  }
  openlldp::config::tlv { $ethers:
    portDesc => 'yes',
    sysName  => 'yes',
    sysDesc  => 'yes',
    sysCap   => 'yes',
    mngAddr  => 'yes',
  }
}

