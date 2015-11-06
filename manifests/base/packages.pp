class profiles::base::packages {

  case $::osfamily {
    'RedHat': {
      package { 'vim-enhanced': }
    }
    'Debian': {
      package { 'vim': }
    }
  }  

  # Defined in kafka: wget
  $pkg_utils = ['curl', 'sysstat', 'tcpdump', 'telnet', 'traceroute', 'unzip', 'xdelta' ]
  # Others: lsof, deltarpm, bash-completion
  package { $pkg_utils: ensure => latest, }

}
