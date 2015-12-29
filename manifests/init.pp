# Class: splunk
# ===========================
#
# Full description of class splunk here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'splunk':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class splunk (
  $splunk_home                = '/opt/splunk',
  $user                       = 'splunk',
  $group                      = 'splunk',
  $cmd                        = 'bin/splunk',
  $is_posix                   = true,
  $service_ensure             = 'running',
  $service_enable             = true,
  $service_license_arg        = 'status',
  $service_license_accept_arg = ' --accept-license --no-prompt --answer-yes',
  $service_boot_enable_args   = 'enable boot-start',
  $service_boot_user_args     = '-user %s',
  $service_boot_path          = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  $service_boot_creates       = '/etc/init.d/splunk',
  #TODO: add instance variable
) {

  #Install

  #Service
  #TODO: update to also support systemd
  splunk::service{'default': 
    ensure             => $service_ensure,
    enable             => $service_enable,
    is_posix           => $is_posix,
    splunk_home        => $splunk_home,
    user               => $user,
    group              => $group,
    cmd                => $cmd,
    license_arg        => $service_license_arg,
    license_accept_arg => $service_license_accept_arg,
    boot_enable_args   => $service_boot_enable_args,
    boot_user_args     => $service_boot_user_args,
    boot_path          => $service_boot_path,
    boot_creates       => $service_boot_creates,
  }

  #Config

}
