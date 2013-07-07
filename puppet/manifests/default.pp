Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class system-update {

  exec { 'apt-get update':
    command => 'apt-get update',
  }

  $sysPackages = [ "build-essential" ]
  package { $sysPackages:
    ensure => "installed",
    require => Exec['apt-get update'],
  }

}

class rvm-install {

  include rvm

  rvm_system_ruby {
    'ruby-1.9.3-p429':
      ensure      => 'present',
      default_use => false,
  }

  rvm_gem {
    'bundler':
      name => 'bundler',
      ruby_version => 'ruby-1.9.3-p429',
      ensure => latest,
      require => Rvm_system_ruby['ruby-1.9.3-p429'];
  }
}

include system-update
include mysql
include rvm-install
#include vcsrepo
include team_dashboard
