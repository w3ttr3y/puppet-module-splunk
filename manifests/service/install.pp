define splunk::service::install (

) {
    exec { 'Enable Splunk on boot':
      path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command => "${wet_splunk::common::params::directory::splunk_home}/bin/splunk enable boot-start -user ${wet_splunk::common::params::os_accounts::user}",
      creates => $osfamily ? {
        'windows' => undef,
        default => '/etc/init.d/splunk'},
        require => [Exec['Start Splunk'], Anchor['before wet_splunk::common::service']],
        onlyif  => 'test ! -f /etc/init.d/splunk',
    }
}
