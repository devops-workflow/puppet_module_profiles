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
    proto  => tcp,
    action => accept,
  } ->
  firewallchain { 'INPUT:filter:IPv4':
    policy  => 'accept',
  } ->
  firewallchain { 'FORWARD:filter:IPv4':
    policy => 'drop',
  } ->
  firewall { '301 Accept outbound traffic from lo interface':
    chain    => 'OUTPUT',
    proto    => 'all',
    outiface => 'lo',
    action   => 'accept',
  } ->
  firewall { '302 Reject outound, local traffic not on loopback interface':
    chain       => 'OUTPUT',
    outiface    => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  } ->
  firewall { '303 Accept inbound RELATED, ESTABLISHED traffic':
    chain  => 'OUTPUT',
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  } ->
  firewall { '304 Accept inbound SSH':
    chain  => 'OUTPUT',
    dport  => '22',
    proto  => tcp,
    action => accept,
  } ->
  firewallchain { 'OUTPUT:filter:IPv4':
    policy => 'accept',
  }

}
