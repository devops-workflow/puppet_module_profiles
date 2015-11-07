class profiles::base::selinux (
  $state = 'permissive',
  $type = 'targeted',
) {

  case $::osfamily {
    'RedHat': {
      include '::selinux'
      include '::epel'
      Class['::epel'] -> Class['::selinux']

      package { 'selinux-policy': }

      file { '/etc/selinux/config':
        content => template("${module_name}/selinux/config.erb"),
        require => Package['selinux-policy'],
      }
    }
    'Debian': {
      if ( $::operatingsystem == 'Ubuntu' ) {
        notify {"The selinux-policy-default package is currently broken.  Can't use SELinux":}
      }

      else {
        include '::selinux'

        package { 'selinux-basics':
          notify => Exec['/usr/sbin/selinux-activate'],
        }

        exec { '/usr/sbin/selinux-activate':
          refreshonly => true,
        }
      }
    }
  }
}
