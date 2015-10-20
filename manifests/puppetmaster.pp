class profiles::puppet::master {
  class { '::puppet':
    autosign => true,
    server => true,
    server_foreman => false,
    server_environments => [],
    server_external_nodes => '',
  }
}
