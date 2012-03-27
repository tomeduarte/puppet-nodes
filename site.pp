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

# NODES
node default {
  include timezone
}
