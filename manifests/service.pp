
define splunk::service (
  $ensure             = 'running',
  $enable             = true,
  $is_posix           = true,
  $splunk_home        = '/opt/splunk',
  $user               = 'splunk',
  $group              = 'splunk',
  $cmd                = 'bin/splunk',
  $license_arg        = 'status',
  $license_accept_arg = ' --accept-license --no-prompt --answer-yes',
  $boot_enable_args   = 'enable boot-start',
  $boot_user_args     = '-user %s',
  $boot_path          = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  $boot_creates       = '/etc/init.d/splunk',
  $utilize_systemd    = false,
  $instance           = $title,
  $service_install    = 'splunk::service::enable_init',
) {

  ########
  ##  Ownership
  ############
  # Ownership has two options: puppet directory or using find
  #
  # Puppet Directory uses Puppet's file type to recursively set
  # the owner and group on the files.  Unfortunately, it is slow.
  #
  # The alternative implementation uses find to find file not owned by user or group
  # and then it uses chmod to change the ownership.  This implementation is posix specific.
  if $is_posix {
    $ownership_type    = 'splunk::service::ownership::posix'
    $ownership_title   = $title
    $ownership_options = {
      splunk_home   => $splunk_home,
      user          => $user,
      group         => $group,
      chown         => 'chown',
      chown_opt     => '-R',
      path          => '/bin',
      refresh_only  => true,
    }
  } else {
    $ownership_type    = 'splunk::service::ownership::puppet' 
    $ownership_title   = $title
    $ownership_options = {
      ensure      => 'directory',
      splunk_home => $splunk_home,
      user        => $user,
      group       => $group,
      recurse     => true,
    }
  } 

  # By default, Splunk creates an init script
  # We can do better and create a systemd service though
  # We allow people to opt for an init script since
  # the init script is created by Splunk and is better tested
  if $service_install =='splunk::service::enable_systemd' and $::systemd_available == true {
    $service_notify = Exec['systemd-daemon-reload']
  
    $init_type = 'splunk::service::enable_systemd'
    $init_title = $title
    $init_options = {
      splunk_home => $splunk_home,
      instance    => $instance,
      before      => Splunk::Service::Service[$title],
    }
  } else {
    $service_notify = undef
    $init_type = 'splunk::service::enable_init'
    $init_title = $title
    $init_options = {
      splunk_home => $splunk_home,
      cmd         => $cmd,
      args        => $boot_enable_args,
      user_args   => $boot_user_args,
      user        => $user,
      path        => $boot_path,
      creates     => $boot_creates,
      before      => Splunk::Service::Service[$title],
    }
  }

  anchor{"splunk::service::begin::${title}": } ->

  # Accept License
  splunk::service::accept_license{$title:
    splunk_home => $splunk_home,
    user        => $user,
    group       => $group,
    cmd         => $cmd,
    arg         => $license_arg,
    accept_arg  => $license_accept_arg,
  } ->

  # Install INIT
  ensure_resource($init_type, $init_title, $init_options)

  # Ownership
  ensure_resource($ownership_type, $ownership_title, $ownership_options)

  # Service
  splunk::service::service { $title:
    ensure      => $ensure,
    enable      => $enable,
    splunk_home => $splunk_home,
    cmd         => $cmd,
    accept_arg  => $license_accept_arg,
  } ->
  anchor{"splunk::service::end::${title}": }
}
