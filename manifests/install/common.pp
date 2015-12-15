#A common class used for installing - create user, group, and delegates to a lower levle install class
class splunk::install::common (
  $ensure,
  $file,
  $packge_dir,
  $package_provider,
  $temp_dir,
  $install_class,
  $file_ensure,
  
  #Group options
  $group,
  $group_ensure,
  $group_is_system,
  $group_forcelocal,
  $group_gid, 
  
  #User options
  $user,
  $user_ensure,
  $user_is_system,
  $user_comment,
  $user_expiry,
  $user_forcelocal,
  $user_groups,
  $user_gid,
  $user_home,
  $user_password,
  $user_password_max_age,
  $user_password_min_age,
  $user_shell,
  $user_purge_ssh_keys,
  $user_uid,
) {

  anchor{'splunk::install::common::begin': } ->
  
  group{$::group:
    ensure     => $::group_ensure,
    system     => $::group_is_system,
    gid        => $::group_gid,
    forcelocal => $::group_forcelocal,
  } ->

  user{$::user:
    ensure              => $::user_ensure,
    system              => $::user_is_system,
    comment             => $::user_comment,
    expiry              => $::user_expiry,
    forcelocal          => $::user_forcelocal,
    groups              => $::user_groups,
    gid                 => $::user_gid,
    home                => $::user_home,
    password            => $::user_password,
    password_max_age    => $::user_max_age,
    password_min_age    => $::user_min_age,
    shell               => $::user_shell,
    user_purge_ssh_keys => $::user_purge_ssh_keys,
    uid                 => $::user_uid,
  } ->

  $t_file = "${temp_dir}/${file}"
  file {$t_file:
    ensure => $file_ensure,
    source => "${package_dir}/${package_file}"
  } ->

  class {$::install_class:
    ensure            => $::ensure,
    package_file      => $::package_file,
    package_name      => $::package_name,
    package_provider  => $::provider,
    tmp_dir           => $::tmp_dir,
  } ->


  anchor{'splunk::install::common::end': }
}
