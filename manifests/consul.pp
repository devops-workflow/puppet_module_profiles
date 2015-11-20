class profiles::consul (
  $configuration_root = '/etc/consul.d',
  $download_file      = '0.5.2_linux_amd64.zip',
  $download_source    = 'https://dl.bintray.com/mitchellh/consul',
  $encrypt_string     = 'CHANGE_ME',
  $server             = false,
  $start_join         = ["${::ipaddress}"],
) {

  class { '::profiles::consul::client':
    configuration_root => $configuration_root,
    download_file      => $download_file,
    download_source    => $download_source,
    encrypt_string     => $encrypt_string,
    server             => $server,
    start_join         => $start_join,
  }

}
