class profiles::puppet::master {

  file { '/etc/hiera.yaml':
    ensure  => link,
    target  => '/etc/puppet/hiera.yaml',
    require => Class['::puppet'],
  }

  firewall { '100 Accept inbound Puppet traffic':
    proto  => '8140',
    action => 'accept',
  }
  firewall { '100 Accept outbound Puppet traffic':
    chain  => 'OUTPUT',
    proto  => '443',
    action => 'accept',
  }

}
