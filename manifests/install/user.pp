# Class: splunk::install::user
# ===========================
#
# Create/configure an OS user for $SPLUNK_HOME ownership and service user.
#
# Parameters
# ----------
#
#  All defaults listed are the defaults for splunk::config::install::user; 
#  You can instantaite it with different values to set different defaults.
#
#  * `manage`
#  Specifies if this module should manage the OS user. Default: true.
#  * `user`
#  The OS level user to own $SPLUNK_HOME and service run as. Default: splunk
#  * `ensure`
#  User's ensure value; same meaning as user type. Default: present
#  * `system`
#  Is this a system account (non-interactive). Defaults to true.
#  * `comment`
#  Users command; same meaning as user type. Default: "Splunk Server"
#  * `expiry`
#  The expiration date for the user in zero-padded YYYY-MM-DD format; 
#  If this date is reached, it will cause errors with Splunk.  
#  Default: absent (no expiration)
#  * `forcelocal`
#  If the account should be manage locally. 
#  Valid values: undef, true, false, yes, no  Default: undef
#  * `groups`
#  A list of groups the user should be a member; Default: []
#  * `gid`
#  The gid to list in passwd. Default: undef
#  * `home`
#  The user's home directory; Default: undef
#  * `password`
#  The password hash for the user. Default: !!
#  * `password_max_age`
#  The maximum age of the password.  Default: undef (no age)
#  * `password_min_age`
#  The minimum age of the password. Default: undef (no age)
#  * `shell`
#  The shell for the user; versions pre-6.2? need /bin/bash. 
#  Default: /sbin/nologin
#   * `user_purge_ssh_keys`
#  If the users's SSH keys should be purged. Default: false
#  * `uid`
#  The uid for the user. On Windows this parameter cannot be set. Default: undef
#
# Examples
# --------
#
# @example
#    class { 'splunk::install::user':
#      manage              => true,
#      expiry              => '2037-12-31',
#      forcelocal          => true,
#      gid                 => 'splunk',
#      home                => '/opt/splunk',
#      password_max_age    => 1,
#      password_min_age    => 1,
#      user_purge_ssh_keys => true,
#      uid                 => 499,
#    }
#
# @example
#    class { 'splunk::install::user':
#      manage              => false,
#    }
#
# @example
#    class { 'splunk::install::user':
#      manage              => true,
#      user                => 'splunker',
#      groups              => 'log_reader',
#      forcelocal          => true,
#      gid                 => 'splunker',
#      home                => '/opt/splunk',
#    }
#
# @example
#    class { 'splunk::install::user':
#      shell               => '/bin/bash
#      home                => '/opt/splunk',
#    }
#
# Authors
# -------
#
# William E. Triest III <w3ttr3y@w3ttr3y.com>
#
# Copyright
# ---------
#
# Copyright 2014-2015 William E. Triest III, unless otherwise noted.
#
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
      user { $::user:
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

