
class splunk::install::user (
  $manage           = $splunk::config::install::manage,
  $user             = $splunk::config::install::user,
  $ensure           = $splunk::config::install::ensure,
  $system           = $splunk::config::install::system,
  $comment          = $splunk::config::install::comment,
  $expiry           = $splunk::config::install::expiry,
  $forcelocal       = $splunk::config::install::forcelocal,
  $groups           = $splunk::config::install::groups,
  $gid              = $splunk::config::install::gid,
  $home             = $splunk::config::install::home,
  $password         = $splunk::config::install::password,
  $password_max_age = $splunk::config::install::password_max_age,
  $password_min_age = $splunk::config::install::password_min_age,
  $shell            = $splunk::config::install::shell,
  $purge_ssh_keys   = $splunk::config::install::purge_ssh_keys,
  $uid              = $splunk::config::install::uid,
) {

  if $manage {
      user{$::user:
        ensure           => $::user_ensure,
        system           => $::user_is_system,
        comment          => $::user_comment,
        expiry           => $::user_expiry,
        forcelocal       => $::user_forcelocal,
        groups           => $::user_groups,
        gid              => $::user_gid,
        home             => $::user_home,
        password         => $::user_password,
        password_max_age => $::user_max_age,
        password_min_age => $::user_min_age,
        shell            => $::user_shell,
        purge_ssh_keys   => $::purge_ssh_keys,
        uid              => $::user_uid,
      }
  }
}

