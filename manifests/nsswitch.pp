# == Class: profiles::nsswitch
# ================================
#
# Install and configure of trlinkin/nsswitch
#
# Forge Module Ref:
#  - https://forge.puppetlabs.com/trlinkin/nsswitch
#
#
# Available parameters are:
#  - passwd
#  - group
#  - shadow
#  - hosts
#  - bootparams
#  - aliases
#  - automount
#  - ethers
#  - netgroup
#  - netmasks
#  - networks
#  - protocols
#  - publickey
#  - rpc
#  - services
#  - sudo
#

class profiles::nsswitch {
  #
  # This should likely be moved to Hiera...
  #
  case $::osfamily {
    'Debian': {
      $passwd     = ['compat']
      $group      = ['compat']
      $shadow     = ['compat']
      $hosts      = ['files','myhostname','dns']
      #$bootparams = []
      #$aliases    = []
      #automount  = []
      $ethers     = ['db','files']
      $netgroup   = ['nis']
      #$initgroups = []
      #$netmasks   = []
      $networks   = ['files']
      $protocols  = ['db','files']
      #$publickey  = []
      $rpc        = ['db','files']
      $services   = ['db','files']
      #$sudo       = []
    }
    'RedHat': {
      $passwd     = ['files', 'sss']
      $group      = ['files', 'sss']
      $shadow     = ['files', 'sss']
      $hosts      = ['files', 'dns']
      $bootparams = ['nisplus', '[NOTFOUND=return]', 'files' ]
      $aliases    = ['files','nisplus']
      $automount  = ['files']
      $ethers     = ['files']
      #*****************************************************************
      # ********* Default for CentOS -- Not included in Module *********
      $initgroups = ['files']
      #*****************************************************************
      $netgroup   = ['files', 'sss']
      $netmasks   = ['files']
      $networks   = ['files']
      $protocols  = ['files']
      $publickey  = ['nisplus']
      $rpc        = ['files']
      $services   = ['files', 'sss']
      #$sudo       = ['files']
    }
    default: { warning( "Operating System not defined for $::modulename" ) }
  }

  class { '::nsswitch':
    passwd     => $passwd,
    group      => $group,
    shadow     => $shadow,
    hosts      => $hosts,
    bootparams => $bootparams,
    aliases    => $aliases,
    automount  => $automount,
    ethers     => $ethers,
    #initgroups => $initgroups, # ***** NOT IN MODULE (eg. CentOS) *****
    netgroup   => $netgroup,
    netmasks   => $netmasks,
    networks   => $networks,
    protocols  => $protocols,
    publickey  => $publickey,
    rpc        => $rpc,
    services   => $services,
    #sudo       => $sudo,
  }
}

