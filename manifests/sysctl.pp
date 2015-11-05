# == Class: profiles::sysctl
# ================================
#
# Install and configure of thias/sysctl
#
# Forge Module Ref:
#  - https://forge.puppetlabs.com/thias/sysctl
#
#
#

class profiles::sysctl {
  class { '::sysctl::base':
    purge => false,
  }
}

