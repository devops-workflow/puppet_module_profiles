class profiles::consul::server {

  include ::profiles::consul::client

  firewall { '100 Accept inbound Consul server':
    dport  => '8300',
    proto  => 'all',
    action => 'accept',
  }

  firewall { '100 Accept outbound Consul server':
    chain    => 'OUTPUT',
    proto    => 'all',
    sport    => '8300',
    action   => 'accept',
  }

  firewall { '100 Accept inbound Consul serf_wan':
    dport  => '8302',
    proto  => 'all',
    action => 'accept',
  }

  firewall { '100 Accept outbound Consul serf_wan':
    chain    => 'OUTPUT',
    proto    => 'all',
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
