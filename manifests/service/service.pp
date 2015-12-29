
define splunk::service::service (
  $ensure      = 'running',
  $enable      = true,
  $splunk_home = '/opt/splunk',
  $cmd         = 'bin/splunk',
  $accept_arg  = ' --accept-license --no-prompt --answer-yes'
) {
  $splunk = "${splunk_home}/${cmd}"
  service{$name:
    ensure  => $ensure,
    enable  => $enable,
    start   => "${splunk} start ${accept_arg}",
    stop    => "${splunk} stop",
    restart => "${splunk} restart",
    status  => "${splunk} status",
  }
}
