# == Class: profiles::bind
# ================================
#
# Install and configure of thias/bind
#
# Ref:
#  - https://forge.puppetlabs.com/thias/bind
#  - https://github.com/thias/puppet-bind
#
class profiles::bind {
  class { '::bind':
  }

  bind::server::conf { '/etc/named.conf':
    acls => {
      'rfc1918' => [ '10/8', '172.16/12', '192.168/16' ],
    },
    listen_on_addr    => [ 'any' ],
    listen_on_v6_addr => [ 'any' ],
    forwarders        => [ '8.8.8.8', '8.8.4.4' ],
    directory         => '/var/named/',
    allow_query       => [ 'localnets' ],

    # CHAOS/TXT answers
    hostname          => 'none',
    server_id         => 'none',
    version           => 'none',

    # Zone file hash
    zones             => {
      'example.com' => [
        'type master',
        'file "example.com"',
      ],
#      '1.168.192.in-addr.arpa' => [
#        'type master',
#        'file "1.168.192.in-addr.arpa"',
#      ],
    },
  }
}
