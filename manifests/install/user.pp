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
  $manage           = $splunk::config::install::user::manage,
  $user             = $splunk::config::install::user::user,
  $ensure           = $splunk::config::install::user::ensure,
  $system           = $splunk::config::install::user::system,
  $comment          = $splunk::config::install::user::comment,
  $expiry           = $splunk::config::install::user::expiry,
  $forcelocal       = $splunk::config::install::user::forcelocal,
  $groups           = $splunk::config::install::user::groups,
  $gid              = $splunk::config::install::user::gid,
  $home             = $splunk::config::install::user::home,
  $password         = $splunk::config::install::user::password,
  $password_max_age = $splunk::config::install::user::password_max_age,
  $password_min_age = $splunk::config::install::user::password_min_age,
  $shell            = $splunk::config::install::user::shell,
  $purge_ssh_keys   = $splunk::config::install::user::purge_ssh_keys,
  $uid              = $splunk::config::install::user::uid,
) inherits splunk::config::install::user {
  if $manage {
      user { $user:
        ensure           => $ensure,
        system           => $system,
        comment          => $comment,
        expiry           => $expiry,
        forcelocal       => $forcelocal,
        groups           => $groups,
        gid              => $gid,
        home             => $home,
        password         => $password,
        password_max_age => $password_max_age,
        password_min_age => $password_min_age,
        shell            => $shell,
        purge_ssh_keys   => $purge_ssh_keys,
        uid              => $uid,
      }
  }
}

