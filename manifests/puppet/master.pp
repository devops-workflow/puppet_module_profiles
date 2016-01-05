class profiles::puppet::master {

  include '::selinux'

  include '::puppet'
  include '::puppetdb::globals'
  include '::puppetdb'
  include '::puppetdb::master::config'

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

}
