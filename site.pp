# TIMEZONE
class timezone($zone='Etc/UTC') {
  package { 'tzdata':
    ensure => present,
  }

  file { '/etc/timezone':
    content => inline_template('<%= zone %>'),
  }

  exec { 'set-timezone':
    command     =>  'dpkg-reconfigure -f noninteractive tzdata',
    path        =>  ['/usr/sbin'],
    require     =>  File['/etc/timezone'],
    subscribe   =>  File['/etc/timezone'],
    refreshonly =>  true,
  }
}

# MYSQL
class mysql_client {
  package { 'mysql-client':
    ensure  =>  latest,
  }
}
class mysql_server {
  package { 'mysql-server':
    ensure  =>  latest,
  }
}
class mysql {
  include mysql_client
  include mysql_server
}

# NODES
node default {
  include timezone
  include mysql
}
