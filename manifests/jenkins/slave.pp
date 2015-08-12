# == Class: profiles::jenkins::slave
# ================================
#
# Install and configure a Jenkins slave
#
class profiles::jenkins::slave {
  include epel

  package { 'puppet-lint':
    ensure   => latest,
    provider => 'pe_gem',
  }
  # Add puppet-lint plugins
  package { 'lsb': ensure => latest, }
  package { 'jb': ensure => latest, }
}
