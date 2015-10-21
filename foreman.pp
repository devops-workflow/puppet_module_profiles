class profiles::foreman {

  package { 'epel-release': }
  package { 'foreman-release': 
    provider => rpm,
    source   => 'http://yum.theforeman.org/releases/1.7/el7/x86_64/foreman-release.rpm',
  }
  package { 'foreman-installer':
    require => Package['foreman-release'],
    notify  => Exec['foreman-installer'],
  }
  exec { 'foreman-installer':
    command     => '/sbin/foreman-installer > /root/foreman-installer.log',
    timeout     => 0,
    refreshonly => true,
  }

}
