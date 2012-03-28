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

# JAVA
class sun_jre_6 {
  package { 'debconf-utils':
    ensure  => installed,
  }

  exec { "agree-license":
    command => "/bin/echo -e sun-java6-jre shared/accepted-sun-dlj-v1-1 boolean true | debconf-set-selections",
    unless  => "debconf-get-selections | grep 'sun-java6-jre.*shared/accepted-sun-dlj-v1-1.*true'",
    path    => ["/usr/bin", "/bin"],
    require => Package["debconf-utils"],
  }

  package { 'sun-java6-jre':
    ensure  =>  latest,
    require => Exec["agree-license"],
  }
}

class java_runtimes {
  include sun_jre_6

  package { 'OpenJDK JRE':
    name    =>  'openjdk-6-jre',
    ensure  =>  latest,
  }
}

class firefox {
  package { 'firefox':
#    ensure  => "10.0.2+build1-0ubuntu0.$lsbdistrelease.1"
    ensure  => "11.0+build1-0ubuntu0.$lsbdistrelease.2",
  }
}

# NODES
node default {
  include timezone
  include mysql
  include java_runtimes
  include firefox
  include agent_service
}
