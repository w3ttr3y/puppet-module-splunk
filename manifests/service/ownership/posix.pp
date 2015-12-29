
define splunk::service::ownership::posix (
  $splunk_home  = '/opt/splunk',
  $user         = 'splunk',
  $group        = 'splunk',
  $path         = '/bin',
  $refreshonly = true,
  $options      = {},
  $chown_type   = 'posix_find',
) {
  $options = merge( {
    splunk_home => $splunk_home,
    user        => $user,
    group       => $group,
    path        => $path,
    refreshonly => $refreshonly,
    require     => Anchor["splunk::service::ownership::posix::begin::${title}"],
    before      => Anchor["splunk::service::ownership::posix::end::${title}"]
  }, $options)

  anchor {"splunk::service::ownership::posix::begin::${title}": }
  ensure_resource($chown_type, $title, $options)
  anchor {"splunk::service::ownership::posix::end::${title}": }
}
