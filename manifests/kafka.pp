# == Class: profiles::kafka
# ================================
#
# Install and configure 
#
class profiles::kafka {
#  class { '::kafka':
#    version       => '0.8.2.1',
#    scala_version => '2.10',
#    #install_dir   => 
#    #mirror_url    => 
#  }

  class { '::kafka::broker':
    version       => '0.8.2.1',
    scala_version => '2.10',
#    install_dir   => 
#    mirror_url    => 
    config        => {
      'broker.id'                       => '0',
      'port'                            => '25700',
      'host.name'                       => '192.168.30.20',
      'num.network.threads'             => '2',
      'socket.send.buffer.bytes'        => '1048576',
      'socket.receive.buffer.bytes'     => '1048576',
      'socket.request.max.bytes'        => '104857600',
      'log.dirs'                        => '/var/log/kafka',
      'auto.create.topics.enable'       => 'false',
      'num.partitions'                  => '2',
      'log.flush.interval.messages'     => '10000',
      'log.flush.interval.ms'           => '1000',
      'log.retention.hours'             => '24',
      'log.segment.bytes'               => '536870912',
      'log.cleanup.interval.mins'       => '1',
      'zookeeper.connect'               => '192.168.30.20:25699',
      'zookeeper.connection.timeout.ms' => '1000000',
    }
  }
#  class { '::kafka::consumer': }
#  class { '::kafka::producer': }
}
