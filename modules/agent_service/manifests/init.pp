# AGENT SERVICE

class agent_service {
  # our daemon is a simple ruby looper
  # thus, requirements are: ruby1.8, rubygems1.8, looper gem
  package { 'ruby1.8':
    ensure  => present,
  }

  package { 'rubygems1.8':
    ensure  => present,
  }

  package { 'looper':
    provider  => 'gem',
    ensure    => installed,
    require   => Package['rubygems1.8']
  }

  file { "agent.init":
    path    => '/etc/init.d/agent.init',
    source  => 'puppet:///modules/agent_service/agent.init',
    ensure  => present,
    owner   => 'root', group => 'root', mode => '755',
    notify  => Service['agent'],
  }

  file { "agent.bin":
    path    => '/usr/local/bin/agent',
    source  => 'puppet:///modules/agent_service/agent.bin',
    ensure  => present,
    owner   => 'root', group => 'root', mode => '755',
    notify  => Service['agent']
  }

  service { "agent":
    name        => 'agent.init',
    ensure      => running,
    enable      => true,
    hasstatus   => false,
    hasrestart  => true,
  }
}
