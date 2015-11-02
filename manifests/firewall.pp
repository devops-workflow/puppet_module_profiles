class profiles::firewall {

  include ::firewall
  firewall { '001 Accept inbound traffic to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  } ->
  firewall { '002 Reject inbound, local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  } ->
  firewall { '003 Accept inbound RELATED, ESTABLISHED traffic':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  } ->
  firewall { '004 Accept inbound SSH':
    dport  => '22',
    proto  => 'tcp',
    action => 'accept',
  } ->
  firewall { '301 Accept outbound traffic from lo interface':
    chain    => 'OUTPUT',
    proto    => 'all',
    outiface => 'lo',
    action   => 'accept',
  } ->
  firewall { '302 Reject outbound, local traffic not on loopback interface':
    chain       => 'OUTPUT',
    outiface    => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  } ->
  firewall { '303 Accept outbound RELATED, ESTABLISHED traffic':
    chain  => 'OUTPUT',
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  } ->
  firewall { '304 Accept outbound TCP DNS':
    chain  => 'OUTPUT',
    dport  => '53',
    proto  => 'tcp',
    action => 'accept',
  } ->
  firewall { '304 Accept outbound UDP DNS':
    chain  => 'OUTPUT',
    dport  => '53',
    proto  => 'udp',
    action => 'accept',
  } ->
  firewall { '305 Accept outbound SSH':
    chain  => 'OUTPUT',
    dport  => '22',
    proto  => 'tcp',
    action => 'accept',
  } ->
  firewall { '306 Accept outbound HTTP/S':
    chain  => 'OUTPUT',
    dport  => ['80', '443'],
    proto  => 'tcp',
    action => 'accept',
  } ->
  firewall { '307 Accept outbound Puppet':
    chain  => 'OUTPUT',
    dport  => '8140',
    proto  => 'tcp',
    action => 'accept',
  } ->
  firewallchain { 'OUTPUT:filter:IPv4':
    policy => 'drop',
  } ->
  firewallchain { 'INPUT:filter:IPv4':
    policy  => 'drop',
  } ->
  firewallchain { 'FORWARD:filter:IPv4':
    policy => 'drop',
  }

}
