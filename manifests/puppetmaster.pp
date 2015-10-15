class profiles::puppet::master {
  class { '::puppet':
    server => true,
    server_foreman => false,
    server_environments => [],
  }
}
