# == Class stagecoach::install
#
# This class is called from stagecoach for install.
#
class stagecoach::install {

  if $::stagecoach::manage_user {
    user {$::stagecoach::user:
      ensure     => present,
      managehome => true,
      before     => Vcsrepo[$::stagecoach::stagecoach_home],
    }
  }

  if $::stagecoach::manage_group {
    group {$::stagecoach::group:
      ensure  => present,
    }
  }

  file {$::stagecoach::stagecoach_home:
    ensure => directory,
    owner  => $::stagecoach::user,
    group  => $::stagecoach::group,
    mode   => $::stagecoach::dir_mode,
    before => Vcsrepo[$::stagecoach::stagecoach_home],
  }

  # Do not change 'ensure => present' to 'latest', or local config changes will get overwritten
  vcsrepo {$::stagecoach::stagecoach_home:
    ensure   => present,
    user     => $::stagecoach::user,
    group    => $::stagecoach::group,
    provider => git,
    source   => $::stagecoach::repo_url,
    revision => $::stagecoach::repo_ref,
  }

  # Adds stagecoach to the bash path (Doesn't work on Mac)
  if ($::stagecoach::add_to_path) {
    file {'/etc/profile.d/stagecoach.sh':
      content => template('stagecoach/profile.sh.erb'),
      mode    => '0644',
    }
  }
}
