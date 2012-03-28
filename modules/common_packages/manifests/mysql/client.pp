class common_packages::mysql::client {
  package { 'mysql-client':
    ensure  =>  latest,
  }
}
