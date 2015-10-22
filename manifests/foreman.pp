class profiles::foreman ($release = '1.7') {

  case $::osfamily {
    'RedHat': {
      package { 'foreman-release': 
        provider => rpm,
        source   => "http://yum.theforeman.org/releases/${release}/el${::operatingsystemmajrelease}/${::architecture}/foreman-release.rpm",
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
  }

}
