# == Class: profiles::jenkins::master
# ================================
#
# Install and configure a Jenkins server
#
class profiles::jenkins::master {
  # Jenkins Server
  Class['Epel'] -> File['/usr/bin/pip-python'] -> Class['Jenkins_job_builder::Install'] -> Package['setuptools'] -> Package['git'] -> Vcsrepo ['/root/jenkins-job-builder-config']
  Class['Jenkins'] -> File['/var/lib/jenkins/userContent/customIcon'] -> Class['Files']
  include ::epel
  class { '::jenkins':
    configure_firewall => true,
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
  package { 'git': }
  vcsrepo { '/root/jenkins-job-builder-config':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/devops-workflow/jenkins-job-builder-config.git',
    notify   => Exec['/root/jenkins-job-builder-config/run-jjb.sh'],
  }
  exec { '/root/jenkins-job-builder-config/run-jjb.sh':
    refreshonly => true,
  }
  file { '/var/lib/jenkins/userContent/customIcon':
    ensure => directory,
    owner  => jenkins,
    group  => jenkins,
  }

  # Master is also a build slave
  class { '::profiles::jenkins::slave': }
}
