class profiles::consul::client (
  $configuration_root   = '/etc/consul.d'
  $download_file        = '0.5.2_linux_amd64.zip',
  $download_source      = 'https://dl.bintray.com/mitchellh/consul',
) {

  include ::firewall

  firewall { '100 Accept inbound Consul serf_lan':
    dport  => '8301',
    proto  => 'all',
    action => 'accept',
  }

  firewall { '100 Accept outbound Consul serf_lan':
    chain    => 'OUTPUT',
    proto    => 'all',
    sport    => '8301',
    action   => 'accept',
  }

  package { 'unzip':}

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

  group { 'consul': } ->
  user { 'consul':
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

}
