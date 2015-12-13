
class splunk::service (
  $service_manage,
  $service_enable,
  $splunk_home,
  $user,
  $group,
  $service,
  $service_state = 'running',
) {
  #TODO: fails in the case that Splunk is running as a user other than $user (e.g. is Splunk is running as root when it shouldn't
  anchor{'splunk::service::begin': }

  # If we're not supposed to manage the service, nothing to do!
  if $wet_splunk::common::params::service::manage {

    # You can debate if this should be part of managing the service vs installing, but
    # this will prevent you from managing the service so its a prereq
    # and if you aren't managing the service, then you can manually deal with this step, so
    # even though its not where I would initially place it I think it makes sense here
    exec {'Start Splunk':
      path    => '/usr/bin',
      cwd     => $wet_splunk::common::params::directory::splunk_home,
      #The RPM doesn't always stop Splunk; the tgz method might not either, so stop it if necessary
      command => "${wet_splunk::common::params::directory::splunk_home}/bin/splunk stop ; ${wet_splunk::common::params::directory::splunk_home}/bin/splunk start --accept-license --no-prompt --answer-yes",
      #On Windows Puppet can't execute as other users (at least as of 3.6.2)
      user    => $osfamily ? { 'windows' => nil, default => $wet_splunk::common::params::os_accounts::user},
      group   => $osfamily ? { 'windows' => nil, default => $wet_splunk::common::params::os_accounts::group},
      require => Anchor['before wet_splunk::common::service'],
      #TODO: asuming this won't work on Windows
      onlyif  => "test -f ${wet_splunk::common::params::directory::splunk_home}/ftr",
    }

    exec { 'Enable Splunk on boot':
      path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command => "${wet_splunk::common::params::directory::splunk_home}/bin/splunk enable boot-start -user ${wet_splunk::common::params::os_accounts::user}",
      creates => $osfamily ? {
        'windows' => undef,
        default => '/etc/init.d/splunk'},
        require => [Exec['Start Splunk'], Anchor['before wet_splunk::common::service']],
        onlyif  => 'test ! -f /etc/init.d/splunk',
    }

    exec {'Stop Splunk':
      path    => '/bin',
      command => "${wet_splunk::common::params::directory::splunk_home}/bin/splunk stop",
      onlyif  => "test -f ${wet_splunk::common::params::directory::splunk_home}/var/run/splunk/splunkd.pid -a $(ps -o user -p $(awk -vORS=, '{ print \$1 }' ${wet_splunk::common::params::directory::splunk_home}/var/run/splunk/splunkd.pid | sed 's/,\$//') | tail -n+2 | grep -v ${wet_splunk::common::params::os_accounts::user} | wc -l) -gt 0",
      require => [Exec['Start Splunk'], Anchor['before wet_splunk::common::service']],
      notify   => Exec['Chown Splunk Home']
    }

    exec{'Chown Splunk Home':
      path        => '/bin',
      command     => "chown -R ${wet_splunk::common::params::os_accounts::user}:${wet_splunk::common::params::os_accounts::group} ${wet_splunk::common::params::directory::splunk_home}",
      refreshonly => true,
      before => Service[$wet_splunk::common::params::service::service_name],
    }

     #If $splunk_home isn't owned by the splunk user, it can cause issues, so let's ensure its owned by Splunk
     #I'd like to have the init script do this, but until then
    file { $::splunk_home :
      ensure  => directory,
      recurse => true, # enable recursive directory management
      owner   => $::user,
      group   => $::group,
      #  #This is the its initial value from the RPM; probably should change it to something else,
      #  # but right now I'm just trying to initiating massive changes
        #seluser => 'unconfined_u',
        #seluser => undef,
      selinux_ignore_defaults => true,
      require => Anchor['before wet_splunk::common::service'],
    }

    service { $wet_splunk::common::params::service::service_name:
      ensure => $wet_splunk::common::params::service::ensure,
      enable => $wet_splunk::common::params::service::enable,
      #Before starting, ensure the splunk user owns the directory and
      #that the init script has been created.
      require => [ #File[$wet_splunk::common::params::directory::splunk_home],
                   Exec['Enable Splunk on boot']]
    }

  } # end if service_manage

  anchor{'splunk::service::end': }
}
