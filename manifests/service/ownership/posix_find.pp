
define splunk::service::ownership::posix_find (
  $splunk_home   = '/opt/splunk',
  $user          = 'splunk',
  $group         = 'splunk',
  $find          = 'find',
  $find_cond     = '! \( -user %s -group %s \) ! -type p',
  $find_templt   = '%s %s %s -exec chown %s:%s {} \;',
  $unless_templt = 'test $(%s %s %s -printf \'.\' | wc -c) -eq 0 ',
  $path          = '/bin',
  $refreshonly  = true,
) {

  $exec_title = "find chown ${splunk_home}"
  $notifyee   = Exec[$exec_title]

  $real_find_cond = sprintf($find_cond, $user, $group)

  anchor {"splunk::service::ownership::posix_find::begin::${title}": } ->
  # TODO: we could do something like:
  # test -e /opt/splunk/var/run/splunk/splunkd.pid && /opt/splunk/bin/splunk stop ; find ...
  exec{$exec_title:
    path        => $path,
    command     => sprintf(find_templt, $find, $splunk_home, $real_find_cond, $user, $group, $user, $group),
    refreshonly => $refreshonly,
    unless      => sprintf($unless_templt, $find, $splunk_home, $real_find_cond, $user, $group),
  } ->
  anchor {"splunk::service::ownership::posix_find::end::${title}": }
}
