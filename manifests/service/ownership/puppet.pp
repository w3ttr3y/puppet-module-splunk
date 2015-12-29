
define splunk::service::ownership::puppet (
  $ensure      = 'directory',
  $splunk_home = '/opt/splunk',
  $user        = 'splunk',
  $group       = 'splunk',
  $recurse     = true,
) {
  anchor{"splunk::service::ownership::puppet::begin::${title}": }
  file {$splunk_home:
    ensure  => $ensure,
    owner   => $user,
    group   => $group,
    recurse => $recurse,
    require => Anchor["splunk::service::ownership::puppet::begin::${title}"],
    before  => Anchor["splunk::service::ownership::puppet::end::${title}"],
  }
  anchor{"splunk::service::ownership::puppet::end::${title}": }
}
