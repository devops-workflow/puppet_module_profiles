# == Class: profiles::haproxy
# ================================
#
# Install and configure 
#
class profiles::haproxy {
#  ### HAproxy
#  class { 'haproxy':
#    global_options  => {
#      'log'     => "${::ipaddress} local0",
#      #'chroot'  => '/var/lib/haproxy',
#      'pidfile' => '/var/run/haproxy.pid',
#      #'maxconn' => '4000',
#      'user'    => 'haproxy',
#      'group'   => 'haproxy',
#      'daemon'  => '',
#      'stats'   => 'socket /var/lib/haproxy/stats',
#      # ssl, ...
#    },
#    default_options => {
#      'log'     => 'global',
#      'stats'   => 'enable',
#      'option'  => [
#        'httplog',
#        'dontlognull',
#      ]
#      'retries' => '3',
#      'timeout' => [
#        'http-request 10s',
#        'queue 1m',
#        'connect 10s',
#        'client 1m',
#        'server 1m',
#        'check 10s',
#      ],
#      'maxconn' => '8000',
#    },
#  }
#  haproxy::listen { 'httpFrontEnd':
#    ipaddress => $::ipaddress,
#    ports     => '80',
#    mode      => 'http',
#    options   => {
#      'option'  => [
#        'httpclose',
#        'forwardfor',
#      ],
#      'balance' => 'roundrobin',
#    },
#  }
#  haproxy::listen { 'httpsFrontEnd':
#    mode      => 'http',
#    options   => {
#      'option'  => [
#        'httpclose',
#        'forwardfor',
#      ],
#      'balance' => 'roundrobin',
#    },
#    bind     => {
#      "$::ipaddress:443" => ['ssl', 'crt', '/etc/haproxy/dummy.pem'],
#  }
#  Haproxy::Balancermember <<| listening_service == 'httpFrontEnd' |>>

#  # On web servers
#  @@haproxy::balancermember { $::fqdn:
#    listening_service => 'httpFrontEnd',
#    server_names      => $::hostname,
#    ipaddresses       => $::ipaddress,
#    ports             => '80',
#    options           => 'check',
#  }
#  # On web servers
#  @@haproxy::balancermember { $::fqdn:
#    listening_service => 'httpsFrontEnd',
#    server_names      => $::hostname,
#    ipaddresses       => $::ipaddress,
#    ports             => '443',
#    options           => 'check',
#  }
#  haproxy::frontend { 'httpFrontEnd':
#    ipaddress     => $::ipaddress,
#    ports         => '80',
#    mode          => 'http',
#    options       => [
#      { 'default_backend' => 'httpBackEnd' },
#    ],
#  }
#  haproxy::frontend { 'httpsFrontEnd':
#    ipaddress     => $::ipaddress,
#    ports         => '443',
#    mode          => 'http',
#    options       => [
#      { 'default_backend' => 'httpsBackEnd' },
#    ],
#  }
#  haproxy::backend { 'httpBackEnd':
#    options => {
#      'option'  => [
#        'httpclose',
#        'forwardfor',
#      ],
#      'balance' => 'roundrobin',
#    },
#  }
#  haproxy::backend { 'httpsBackEnd':
#    options => {
#      'option'  => [
#        'httpclose',
#        'forwardfor',
#      ],
#      'balance' => 'roundrobin',
#    },
#  }
#  # haproxy:: userlist, peers, peer
}
