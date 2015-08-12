# Class: profiles::couchbase
# ================================
#
# Install and configure 
#
class profiles::couchbase {
  ### Couchbase
#  class { 'couchbase':
#    size     => 1024,
#    user     => '',
#    password => '',
#    version  => latest,
#    #edition  => ,
#  }
#  couchbase::bucket { 'memcached':
#    port     => 11211,  # 11207,11209,11210
#    size     => 1024,
#    user     => '',
#    password => '',
#    type     => 'memcached',
#    replica  => 1,
#  }
#  couchbase::moxi { 'default':
#    nodes => [''],
#  }
  #couchbase::client { 'lang': } # ruby, python
  # For unsupport language
  # Example for example42/php
  #Class['Couchbase'] -> Couchbase::Client <| |> -> Class['Php'] -> Php::Pecl::Module <| |>
}
