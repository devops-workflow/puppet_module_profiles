# == Class: profiles::jenkins::master
# ================================
#
# Install and configure a Jenkins server
#
class profiles::jenkins::master {
  # Jenkins Server
  Class['Epel'] -> Class['Jenkins_job_builder::Config']
  Class['Jenkins'] -> Class['Files']
  include ::epel
  include ::jenkins
  include ::jenkins_job_builder
  include ::files
  files::list{'jenkins-master':}
  package { 'graphviz': ensure => latest, }

  # Master is also a build slave
  class { '::profiles::jenkins::slave': }
}
