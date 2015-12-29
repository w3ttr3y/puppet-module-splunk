
define splunk::service::ownership::posix_chown (
  $splunk_home  = '/opt/splunk',
  $user         = 'splunk',
  $group        = 'splunk',
  $chown        = 'chown',
  $chown_opt    = '-R',
  $path         = '/bin',
  $refreshonly = true,
) {
  
  $exec_title = "chown ${splunk_home}"
  $notifyee   = Exec[$exec_title]

  anchor {"splunk::service::ownership::posix::begin::${title}": } ->
  # test -e /opt/splunk/var/run/splunk/splunkd.pid && /opt/splunk/bin/splunk stop ; chown...;
  exec{"chown ${splunk_home}":
    path        => $path,
    command     => "${chown} ${chown_opt} ${user}:${group} ${splunk_home}",
    refreshonly => $refreshonly,
  } ->
  anchor {"splunk::service::ownership::posix::end::${title}": }
  #TODO: what is Splunk is running; restart Splunk service?
  #TODO: exclude fifo's as they cause errors?
}
