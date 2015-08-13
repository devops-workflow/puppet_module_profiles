# == Class: profiles::haproxy
# ================================
#
# Install and configure 
#
class profiles::haproxy {
  ### HAproxy server
  # Move data/parameters to Hiera once this is working
  class { '::haproxy':
    global_options   => {
      'log'                      => '127.0.0.1 local0',
      #'chroot'                   => '/var/lib/haproxy',
      'pidfile'                  => '/var/run/haproxy.pid',
      #'maxconn'                  => '4000',
      'user'                     => 'haproxy',
      'group'                    => 'haproxy',
      'daemon'                   => '',
      'stats'                    => 'socket /var/lib/haproxy/stats',
      'ca-base'                  => '/etc/ssl/certs',
      'crt-base'                 => '/etc/ssl/private',
      'ssl-default-bind-ciphers' => 'kEECDH+aRSA+AES:kRSA+AES:+AES256:RC4-SHA:!kEDH:!LOW:!EXP:!MD5:!aNULL:!eNULL',
      #'ssl-default-bind-options' => 'no-sslv3',
    },
    defaults_options => {
      'log'     => 'global',
      'mode'    => 'http',
      'stats'   => 'enable',
      'option'  => [
        'httplog',
        'dontlognull',
      ],
      'retries' => '3',
      'timeout' => [
        #'http-request 10s',
        #'queue 1m',
        'connect 60s',
        'client 60s',
        'server 60s',
        'check 10s',
      ],
      'maxconn' => '8000',
    },
  }

#  ::haproxy::listen { 'WXhttp':
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

#  ::haproxy::listen { 'WXhttps':
#    mode      => 'http',
#    options   => {
#      'option'  => [
#        'httpclose',
#        'forwardfor',
#      ],
#      'balance' => 'roundrobin',
#    },
#    bind      => {
#      "${::ipaddress}:443" => ['ssl', 'crt', '/etc/haproxy/dummy.pem'],
#    }
#  }

#  Haproxy::Balancermember <<| listening_service == 'httpFrontEnd' |>>

  # On web servers for listen
#  @@::haproxy::balancermember { $::fqdn:
#    listening_service => 'WXhttp',
#    server_names      => $::hostname,
#    ipaddresses       => $::ipaddress,
#    ports             => '80',
#    options           => 'check',
#  }

  # On web servers for listen
#  @@::haproxy::balancermember { $::fqdn:
#    listening_service => 'WXhttps',
#    server_names      => $::hostname,
#    ipaddresses       => $::ipaddress,
#    ports             => '443',
#    options           => 'check',
#  }

  haproxy::frontend { 'httpFrontEnd':
    ipaddress     => $::ipaddress,
    ports         => '80',
    mode          => 'http',
    options       =>  # [
      { 'default_backend' => 'httpBackEnd' },
    # ],
  }

  haproxy::frontend { 'httpsFrontEnd':
    #ipaddress     => $::ipaddress,
    #ports         => '443',
    #mode          => 'http',
    options       => [
      { 'default_backend' => 'httpsBackEnd' },
    ],
    bind          => {
      "${::ipaddress}:443" => ['ssl', 'crt', '/etc/haproxy/dummy.pem'],
    }
  }

  haproxy::backend { 'httpBackEnd':
    options => {
      'option'  => [
        'httpclose',
        'forwardfor',
      ],
      'balance' => 'roundrobin',
    },
  }

  haproxy::backend { 'httpsBackEnd':
    options     => {
      'option'  => [
        'httpclose',
        'forwardfor',
      ],
      'balance' => 'roundrobin',
      'mode'    => 'http',
    },
  }

  # On web servers for backend
  @@::haproxy::balancermember { "${::fqdn}-http":
    listening_service => 'httpBackEnd',
    server_names      => $::hostname,
    #ipaddresses       => $::ipaddress,
    ports             => '80',
    options           => 'check',
  }

  # On web servers for backend
  @@::haproxy::balancermember { "${::fqdn}-https":
    listening_service => 'httpsBackEnd',
    server_names      => $::hostname,
    #ipaddresses       => $::ipaddress,
    ports             => '443',
    options           => 'check',
  }

  # haproxy:: userlist, peers, peer

}
