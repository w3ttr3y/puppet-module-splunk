
class splunk::config::install::common (

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
) { }
