class common_packages::java::openjdk {
  package { 'OpenJDK JRE':
    name    =>  'openjdk-6-jre',
    ensure  =>  latest,
  }
}
