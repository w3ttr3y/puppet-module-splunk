# Class: splunk::config::install::user
# ===========================
#
# Configuration opertions for splunk::install::user, a class to manage an OS user for $SPLUNK_HOME ownership and for service ot run as.
#
# Parameters
# ----------
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
#  The expiration date for the user in zero-padded YYYY-MM-DD format; If this date is reached, it will cause errors with Splunk.  Default is absent (no expiration)
#  * `forcelocal`
#  If the account should be manage locally. Valid Values: undef, true, false, yes, no  Default: undef
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
#  The shell for the user; versions pre-6.2? need /bin/bash. Default: /sbin/nologin
#   * `purge_ssh_keys`
#  If the users's SSH keys should be purged. Default: false
#  * `uid`
#  The uid for the user. On Windows this parameter cannot be set. Default: undef
#
# Examples
# --------
#
# @example
#    class { 'splunk::config::install':
#      manage              => true,
#      expiry              => '2037-12-31',
#      forcelocal          => true,
#      gid                 => 'splunk',
#      home                => '/opt/splunk',
#      password_max_age    => 1,
#      password_min_age    => 1,
#      purge_ssh_keys => true,
#      uid                 => 499,
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
class splunk::config::install::user (
  $manage              = true,
  $user                = 'splunk',
  $ensure              = 'present',
  $system              = true,
  $comment             = 'Splunk Server',
  $expiry              = 'absent',
  $forcelocal          = undef,
  $groups              = [],
  $gid                 = '',
  $home                = undef,
  #TODO: default password is a unixism; set different default on Windows
  $password            = '!!',
  $password_max_age    = undef,
  $password_min_age    = undef,
  #TODO: earlier versions need bash
  $shell               = '/sbin/nologin',
  $purge_ssh_keys = false,
  $uid                 = undef, #On Windows, this is read only so throw an error
  ) {
    # TODO: Enure manage is true, false, yes, or no
    if ! ($manage in [undef, true, false, 'yes', 'no']) {
      fail('manage must be one of undef, true, false, yes, or no')
    }
    # TODO: user limitations?
    if ! ($ensure in ['present', 'absent', 'role' ] ) {
      fail('ensure must be one of present, absent, or role')
    }
    # TODO: ensure system is true, false, yes, or no
    if ! ($system in [true, false, 'yes', 'no' ]) {
      fail('system must be one of true, false, yes, or no')
    }
    # TODO: comment validation?
    require stdlib

    if ! ( $expiry == 'absent' or
        validate_re($expiry, '^\d{4}-\d{2}-\d{2}$/',
          'expiry must be absent or be a zero-padded date in YYYY-mm-dd form' ) ) {
      fail('expiry must be absent or be a zero-padded date in YYYY-mm-dd form')
    }

    if ! ( $forcelocal in [ undef, true, false, 'yes', 'no' ] ) {
      fail('forcelocal must be true, false, yes, or no')
    }

    # TODO: groups -- ensure they are valid groups
    # TODO: gid -- ensure its a valid gid
    # TODO: home - ?
    # TODO: password validation
    # TODO: password_max_aqe - validate
    # TODO: password_min_age - validate
    # TODO: shell - validate
    # TODO: uid - validate
}
