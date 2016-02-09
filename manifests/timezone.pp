# == Class: profiles::timezone
# ================================
#
# Install and configure of saz/timezone
#
# Ref: https://forge.puppetlabs.com/saz/timezone
#
class profiles::timezone {
  class { '::timezone':
    timezone => UTC,
  }
}
