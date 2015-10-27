class profiles::puppet::master {
  file { '/etc/hiera.yaml':
    ensure  => link,
    target  => '/etc/puppet/hiera.yaml',
    require => Class['::puppet'],
  }
}
