# == Class stagecoach::config
#
# This class is called from stagecoach for configuration.
#
class stagecoach::config {

  file{"${::stagecoach::stagecoach_home}/settings":
    content => template('stagecoach/settings.erb'),
    owner   => $::stagecoach::user,
  }

  file{"${::stagecoach::stagecoach_home}/apps":
    ensure => directory,
    owner  => $::stagecoach::user,
  }
}
