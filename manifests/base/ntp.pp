class profiles::base::ntp (
  $servers  = ['127.0.0.1'],
  $restrict = ['127.0.0.1'],
) {

  include '::firewall'

  firewall { '100 Accept inbound NTP':
    dport  => ['123'],
    proto  => 'udp',
    action => 'accept',
  }

  firewall { '100 Accept outbound NTP':
    chain  => 'OUTPUT',
    dport  => ['123'],
    proto  => 'udp',
    action => 'accept',
  }

  class { '::ntp':
    servers  => $servers,
    restrict => $restrict,
  }
}
