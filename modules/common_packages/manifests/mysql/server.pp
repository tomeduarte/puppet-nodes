class common_packages::mysql::server {
  package { 'mysql-server':
    ensure  =>  latest,
  }
}
