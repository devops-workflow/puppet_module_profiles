class profiles::consul::client (
  $configuration_root,
  $download_file,
  $download_source,
  $encrypt_string,
  $server,
  $start_join,
) {

  include ::firewall

  firewall { '100 Accept inbound Consul serf_lan TCP':
    proto  => 'tcp',
    dport  => '8301',
    action => 'accept',
  }

  firewall { '100 Accept inbound Consul serf_lan UDP':
    proto  => 'udp',
    dport  => '8301',
    action => 'accept',
  }

  firewall { '100 Accept outbound Consul serf_lan TCP':
    chain    => 'OUTPUT',
    proto    => 'tcp',
    sport    => '8301',
    action   => 'accept',
  }

  firewall { '100 Accept outbound Consul serf_lan UDP':
    chain    => 'OUTPUT',
    proto    => 'udp',
    sport    => '8301',
    action   => 'accept',
  }

  exec { 'download-consul-zipfile':
    command => "/usr/bin/wget ${download_source}/${download_file} -O /root/${download_file}",
    unless  => "/bin/ls /usr/bin/consul",
  } ->
  exec { 'unzip-consul-zipfile':
    command => "/usr/bin/unzip /root/${download_file} -d /root",
    unless  => "/bin/ls /usr/bin/consul",
  } ->
  exec { 'copy-consul-bin':
    command => "/bin/mv /root/consul /usr/bin/consul",
    unless  => "/bin/ls /usr/bin/consul",
  } ->
  exec { 'delete-consul-zipfile':
    command => "/bin/rm /root/${download_file}",
    onlyif  => "/bin/ls /root/${download_file}",
  }

  group { 'consul':
    ensure => present,
  } ->
  user { 'consul':
    ensure => present,
    groups => ['consul'],
  }

  file { '/etc/consul.d':
    ensure => directory,
  }

  file { '/etc/consul.d/client':
    ensure  => directory,
    require => File['/etc/consul.d'],
  }

  file { '/etc/consul.d/client/client.json':
    content => template("${module_name}/consul/client/client.json.erb"),
    require => File['/etc/consul.d/client'],
  }

  file { '/etc/consul.d/client/http_check.json':
    content => template("${module_name}/consul/client/http_check.json.erb"),
    require => File['/etc/consul.d/client'],
  }

  file { '/var/consul':
    ensure  => directory,
    owner   => 'consul',
    group   => 'consul',
    require => File['/etc/consul.d'],
  }

  if ($server) {
    class { '::profiles::consul::server':
      encrypt_string => $encrypt_string,
      start_join     => $start_join,
    } -> Service['consul']
  }

  if ( $::osfamily == 'RedHat' ) {
    if ( $::operatingsystemmajrelease >= 7 ) {
      file { '/usr/lib/systemd/system/consul.service':
        mode    => '0755',
        content => template("${module_name}/consul/systemd.erb"),
        before  => Service['consul'],
      }
    }
    else {
      file { '/etc/init.d/consul':
        mode    => '0755',
        content => template("${module_name}/consul/init.erb"),
        before  => Service['consul'],
      }
    }
  }
  if ( $::osfamily == 'Debian' ) {
    file { '/etc/init/consul.conf':
      mode    => '0644',
      content => template("${module_name}/consul/upstart.erb"),
      before  => Service['consul'],
    } ->
    file { '/etc/init.d/consul':
      ensure => link,
      target => '/lib/init/upstart-job',
    }
  }

  service { 'consul':
    ensure => running,
    enable => true,
  }

}
