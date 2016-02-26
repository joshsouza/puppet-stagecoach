# Class: stagecoach
# ===========================
#
# This installs the StageCoach node.js application deployment tool.
# It expects that your system will have node, npm, and forever installed in order
# to operate, but this module will not fail should those be missing (StageCoach simply
# won't work)
#
# Parameters
# ----------
#
# * `repo_url`
#   Where to obtain the StageCoach source code from. This module currently only
#   supports git repository urls
#   Default: https://github.com/punkave/stagecoach.git
#
# * `repo_ref`
#   Which git ref to use when checking out the StageCoach source code
#   Default: master
#
# * `user`
#   Which user to install StageCoach under. All StageCoach applications will run
#   under this user.
#   Default: stagecoach
#
# * `group`
#   Which group to install StageCoach under. All StageCoach files will have this set for their group
#   Default: stagecoach
#
# * `manage_user`
#   Should this module ensure that the user exists? Set this false if you will
#   create/manage the account elsewhere, and true if you'd like it handled for you.
#   Default: true
#   Note: 'managehome' is enabled so that you can manage ssh keys for this user, however
#    we have not added a parameter to set up the ssh key. You'll have to use a profile/resource for that.
#
# * `manage_group`
#   Should this module ensure that the group exists? Set this false if you will
#   create/manage the group elsewhere, and true if you'd like it handled for you.
#   Default: true
#
# * `install_root`
#   What directory to install StageCoach into. You will need to ensure that this path
#   exists (this module will not manage the root). StageCoach will be checked out into
#   the 'stagecoach' subdirectory of this value.
#   Default: /opt
#
# * `add_to_path`
#   Whether you would like to have the StageCoach binary folder added to the system
#   default path. This utilizes the /etc/profile.d/*.sh methodology for general
#   Linux compatibility, however it won't work on Darwin. Note that for remote
#   deployments to work, Node and StageCoach need to be in the path. There are
#   other approaches to this requirement, and you are free to pursue those and set
#   this parameter to false.
#   Default: true (for all OS'es other than Darwin)
#
class stagecoach (
  $repo_url = 'https://github.com/punkave/stagecoach.git',
  $repo_ref = 'master',
  $user = 'stagecoach',
  $group = 'stagecoach',
  $manage_user = true,
  $manage_group = true,
  $install_root = '/opt',
  $add_to_path = $::stagecoach::params::add_to_path,
  $dir_mode = '0755',
) inherits stagecoach::params {

  $stagecoach_home="${install_root}/stagecoach"

  class { '::stagecoach::install': } ->
  class { '::stagecoach::config': }

  contain '::stagecoach::install'
  contain '::stagecoach::config'
}
