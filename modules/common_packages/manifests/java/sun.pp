class common_packages::java::sun {
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

