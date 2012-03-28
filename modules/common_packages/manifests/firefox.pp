class common_packages::firefox {
  package { 'firefox':
#    ensure  => "10.0.2+build1-0ubuntu0.$lsbdistrelease.1"
    ensure  => "11.0+build1-0ubuntu0.$lsbdistrelease.2",
  }
}
