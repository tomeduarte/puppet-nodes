# file buckets
  filebucket { 'main':
    server  => 'puppet',
    path    => false,
  }

# nodes
node default {
  include timezone
  include common_packages
  include agent_service

  # no backups for normal nodes
  File { backup  => false, }
}

node /^special\d+$/ inherits default {
  notify { 'special node, backing up':}
  # we want backups on special nodes
  File { backup => 'main', }
}
