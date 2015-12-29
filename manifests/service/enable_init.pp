define splunk::service::enable_init  (
  $splunk_home = '/opt/splunk',
  $cmd         = 'bin/splunk',
  $args        = 'enable boot-start',
  $user_args   = '-user %s',
  $user        = 'splunk',
  $path        = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  $creates     = '/etc/init.d/splunk',
) {

  $creates = $::osfamily ? {
    'windows' => undef,
    default   => $creates,
  }

  anchor{'splunk::service::enable_init::begin': } ->
  exec {"Enable Splunk Init Scripts ${title}":
    path    => $path,
    command => "${splunk_home}/${cmd} ${args} ${user_args}",
    creates => $creates,
  } ->
  anchor{'splunk::service::enable_init::end': }
}
