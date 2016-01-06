class profiles::puppet::master {

  Class['::puppetdb::globals'] -> Class['::puppetdb'] -> Class['::puppetdb::master::config'] -> Class['::puppetboard']

  include '::puppet'
  include '::puppetdb::globals'
  include '::puppetdb'
  include '::puppetdb::master::config'

  include '::apache::mod::wsgi'
  include '::puppetboard'
  include '::puppetboard::apache::conf'

  include '::selinux'

  exec { 'puppetdb-ssl-setup':
    command     => '/sbin/puppetdb ssl-setup',
    refreshonly => true,
    subscribe   => Exec['puppet_server_config-generate_ca_cert'],
    before      => Service['puppetdb'],
  }

  # Vagrant hosts need to resolve their Facter fqdn
  if ($::virtual == 'virtualbox') {
    host { $::fqdn:
      ip => $::ipaddress_enp0s8,
    }
  }

  if ( $::osfamily == 'RedHat' ) {
    include '::epel'
    Class['::epel'] -> Class['::selinux']

    file { '/etc/yum.repos.d/passenger.repo':
      source => "puppet:///modules/${module_name}/puppet/passenger.repo",
    }
  }

  file { '/etc/hiera.yaml':
    ensure  => link,
    target  => '/etc/puppet/hiera.yaml',
    require => Class['::puppet'],
  }

  firewall { '100 Accept inbound Puppet traffic':
    proto  => 'tcp',
    dport  => '8140',
    action => 'accept',
  }

  firewall { '100 Accept outbound Puppet traffic':
    chain  => 'OUTPUT',
    proto  => 'tcp',
    sport  => '8140',
    action => 'accept',
  }

  selinux::audit2allow { 'puppet-master':
    source  => "puppet:///modules/${module_name}/selinux/messages.puppet-master",
    require => Class['::selinux'],
  }

  selinux::audit2allow { 'puppetdb':
    source  => "puppet:///modules/${module_name}/selinux/messages.puppetdb",
    require => Class['::selinux'],
  }

  selinux::audit2allow { 'puppetboard':
    source  => "puppet:///modules/${module_name}/selinux/messages.puppetboard",
    require => Class['::selinux'],
  }

}
