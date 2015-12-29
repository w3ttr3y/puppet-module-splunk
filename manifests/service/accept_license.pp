
define splunk::service::accept_license (
  $splunk_home = '/opt/splunk',
  $user        = 'splunk',
  $group       = 'splunk',
  $cmd         = 'bin/splunk',
  $arg         = 'status',
  $accept_arg  = ' --accept-license --no-prompt --answer-yes',
) {
  anchor{"splunk::service::accept_license::begin::${title}": }
  exec {'Accept License':
    path    => '/usr/bin',
    cwd     => $splunk_home,
    command => "${splunk_home}/${cmd} ${arg} ${accept_arg}",
    #On Windows Puppet can't execute as other users (at least as of 3.6.2)
    user    => $osfamily ? { 'windows' => nil, default => $user},
    group   => $osfamily ? { 'windows' => nil, default => $group},
    require => Anchor["splunk::service::accept_license::begin::${title}"],
    before  => Anchor["splunk::service::accept_license::end::${title}"],
    #TODO: asuming this won't work on Windows
    onlyif => "test -f ${splunk_home}/ftr",
  }
  anchor{"splunk::service::accept_license::end::${title}": }
}
