class profiles::base::resolv (
  $domain = 'example.com',
  $name_servers = ['8.8.8.8'],
  $search_domains = [$domain],
) {

  file { '/etc/resolv.conf':
    content => template("${module_name}/resolv.conf.erb"),
  }

}
