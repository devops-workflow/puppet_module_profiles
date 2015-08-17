# == Class: profiles::zookeeper
# ================================
#
# Install and configure 
#
class profiles::zookeeper {
  class { '::zookeeper':
    id                     => 1,
    url                    => 'http://www.eu.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz',
    digest_string          => '971c379ba65714fd25dc5fe8f14e9ad1',
    follow_redirects       => true,
    extension              => 'tar.gz',
    digest_type            => 'md5',
    user                   => 'zookeeper',
    manage_user            => true,
    tmpDir                 => '/tmp',
    installDir             => '/opt/zookeeper',
    jvmFlags               => '-Dzookeeper.log.threshold=INFO -Xmx1g',
    checksum               => true,
    clientPortAddress      => '127.0.0.1',
    cnxTimeout             => 20000,
    configDir              => '/etc/zookeeper',
    create_aio_service     => true,
    dataDir                => '/var/lib/zookeeper',
    # Move to separate drive
    dataLogDir             => '/var/log/zookeeper',
    globalOutstandingLimit => 1000,
    maxClientCnxns         => 60,
    purgeInterval          => 1,
    leaderServes           => 'yes',
    servers                => {
      0 => {
            ip           => '192.168.30.20',
            leaderPort   => 2888,
            electionPort => 3888,
      }
    },
    service_name           => 'zookeeper',
    snapCount              => 100000,
    snapRetainCount        => 3,
    standaloneEnabled      => true,
    syncEnabled            => true,
    syncLimit              => 5,
    tickTime               => 2000,
    electionAlg            => 3,
    initLimit              => 10,
    clientPort             => 25699,
    leaderPort             => 3888,
    leaderElectionPort     => 2888,
    install_java           => true,
    java_package           => 'java-1.8.0-openjdk',
    manage_firewall        => false,
    manage_service         => false,
  }

  zookeeper::resource::configuration {'localhost': }
}
