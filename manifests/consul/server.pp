class profiles::consul::server (
  $encrypt_string,
  $start_join,
) {

  firewall { '100 Accept inbound Consul server TCP':
    dport  => '8300',
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '100 Accept inbound Consul server UDP':
    dport  => '8300',
    proto  => 'udp',
    action => 'accept',
  }

  firewall { '100 Accept outbound Consul server TCP':
    chain    => 'OUTPUT',
    proto    => 'tcp',
    sport    => '8300',
    action   => 'accept',
  }

  firewall { '100 Accept outbound Consul server UDP':
    chain    => 'OUTPUT',
    proto    => 'udp',
    sport    => '8300',
    action   => 'accept',
  }

  firewall { '100 Accept inbound Consul serf_wan TCP':
    dport  => '8302',
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '100 Accept inbound Consul serf_wan UDP':
    dport  => '8302',
    proto  => 'udp',
    action => 'accept',
  }

  firewall { '100 Accept outbound Consul serf_wan TCP':
    chain    => 'OUTPUT',
    proto    => 'tcp',
    sport    => '8302',
    action   => 'accept',
  }

  firewall { '100 Accept outbound Consul serf_wan UDP':
    chain    => 'OUTPUT',
    proto    => 'udp',
    sport    => '8302',
    action   => 'accept',
  }

  file { '/etc/consul.d/bootstrap':
    ensure  => directory,
    require => File['/etc/consul.d'],
  }

  file { '/etc/consul.d/bootstrap/config.json':
    content => template("${module_name}/consul/bootstrap/config.json.erb"),
    require => File['/etc/consul.d/bootstrap'],
  }

  file { '/etc/consul.d/server':
    ensure  => directory,
    require => File['/etc/consul.d'],
  }

  file { '/etc/consul.d/server/config.json':
    content => template("${module_name}/consul/server/config.json.erb"),
    require => File['/etc/consul.d/server'],
  }

}
