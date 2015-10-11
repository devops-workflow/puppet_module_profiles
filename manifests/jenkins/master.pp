# == Class: profiles::jenkins::master
# ================================
#
# Install and configure a Jenkins server
#
class profiles::jenkins::master {
  # Jenkins Server
  Class['Epel'] -> File['/usr/bin/pip-python'] -> Class['Jenkins_job_builder::Install'] -> Package['setuptools']
  Class['Jenkins'] -> Class['Files']
  include ::epel
  class { '::jenkins':
   configure_firewall => true
  }
  include ::jenkins_job_builder
  include ::files
  files::list{'jenkins-master':}
  package { 'graphviz': ensure => latest, }
  file { '/usr/bin/pip-python':
    ensure => link,
    target => '/usr/bin/pip',
  }
  package { 'setuptools':
    ensure   => latest,
    provider => pip,
  }


  # Master is also a build slave
  class { '::profiles::jenkins::slave': }
}
