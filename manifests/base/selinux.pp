class profiles::base::selinux (
  $state = 'permissive',
  $type = 'targeted',
) {

  case $::osfamily {
    'RedHat': {
      include '::selinux'
      include '::epel'
      Class['::epel'] -> Class['::selinux']

      package { 'selinux-policy': } ->
      file { '/etc/selinux/config':
        content => template("${module_name}/selinux/config.erb"),
      }
    }
    'Debian': {
      if ( $::operatingsystem == 'Ubuntu' ) {
        notify {"The selinux-policy-default package is currently broken.  Can't use SELinux":}
      }

      else {
        include '::selinux'

        package { 'selinux-policy-default': }

        package { 'selinux-basics': } ~>
        exec { '/usr/sbin/selinux-activate':
          refreshonly => true,
        }
      }
    }
  }
}
