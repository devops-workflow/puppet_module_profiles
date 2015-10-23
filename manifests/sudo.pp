# == Class: profiles::sudo
# ================================
#
# Install and configure of saz/sudo
#
# Ref: https://forge.puppetlabs.com/saz/sudo
#
class profiles::sudo {
  class { '::sudo':
    purge               => false,
    config_file_replace => false,
  }
  sudo::conf { 'devops':
    priority => 10,
    content  => "%devops ALL=(ALL) ALL",
  }
}
