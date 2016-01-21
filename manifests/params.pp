# == Class stagecoach::install
#
# This class is called from stagecoach to define default parameters
#
class stagecoach::params {

  case $::operatingsystem {
    'Darwin': {
      $add_to_path = false
    }

    default: {
      $add_to_path = true
    }
  }
}
