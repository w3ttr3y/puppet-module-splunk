
define splunk::install::tgz(
  $ensure      = 'present',
  $instance    = $title,
  $base_dir    = '/opt',
  $file        = 'splunk-6.2.2-255606-Linux-x86_64.tgz',
  $manifest    = 'splunk-6.2.2-255606-linux-2.6-x86_64-manifest',
  $source_dir  = 'puppet:///modules/splunk/installers',
  $staging_dir = '/opt',
  $user        = 'splunk',
  $group       = 'splunk',
  $tgz_cmd     = 'tar zxf %s -C %s --strip-components=1 --owner=%s --group=%s',
) {

  $tgz         = "${source_dir}/${file}"
  $splunk_home = "${base_dir}/${instance}"
  $creates     = "${splunk_home}/${manifest}"

  $splunk_home_ensure = $ensure ? {
    'absent' => 'absent',
    'purged' => 'absent',
    default  => 'directory',
  }

  $before_anchor = "begin_splunk::install::tgz_${title}"

  anchor{$before_anchor: }

  file{$splunk_home:
    ensure  => $splunk_home_ensure,
    force   => true,
    owner   => $user,
    group   => $group,
    require => Anchor[$before_anchor],
  }

  $staged_tgz = "${staging_dir}/${file}"

  $tgz_ensure = $ensure ? {
    'absent' => 'absent',
    'purged' => 'absent',
    default  => 'present'
  }

  if ! ($ensure == 'absent' or $ensure == 'purged' ) {
    #TODO: we never remove this file; I'd love to find a way to do that
    #TODO: find a better way to conditionally copy it; right now if we don't need it an error message gets printed
    file {$staged_tgz:
      ensure       => $tgz_ensure,
      source       => $tgz,
      validate_cmd => "/usr/bin/test ! -f ${creates}",
      require      => Anchor[$before_anchor],
    }

    # Extract the package
    exec {"Extract ${tgz} => ${splunk_home}":
      path    => '/usr/bin',
      command => sprintf($tgz_cmd, $staged_tgz, $splunk_home, $user, $group),
      creates => $creates,
      require => [ File[$splunk_home], File[$staged_tgz]],
      before  => Anchor["end_splunk::install::tgz_${title}"],
    }
  }

  anchor{"end_splunk::install::tgz_${title}": }
}
