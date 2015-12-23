define splunk::install::tgz_version (
  $version = undef,
  $build,
  $ensure = 'present',
  $instance = $title,
  $base_dir = undef,
  $file_format = '',
  $source_dir = undef,
  # TODO: adjust this to work with 32-bit
  $manifest_template_ver = 'splunk-%s-%s-linux.2.6-x86_64-manifest',
  $manifest_template_gen = 'splunk-*-manifest',
  #TODO: adjust this to work for 32-bit
  $tgz_file_template     = 'splunk-%s-%s-Linux-x86_64.tgz'
) {

  # ensure ensure is present, installed, purged, held, latest?
  if $ensure == 'absent' or $ensure == 'purged' {
    
  } elsif $ensure == 'present' or $ensure == 'installed' {
    $real_manifest = $manifest_template_gen
  } else {
    $ensure_version = $ensure
    $real_version   = pick($version,$ensure_version)
    $real_manifest  = sprintf($manifest_template_ver, $real_version, $build)
  }

  splunk::install::tgz {$title:
    ensure     => $ensure,
    instance   => $instance,
    base_dir   => $base_dir,
    file       => sprintf($tgz_file_template, $real_version, build),
    manifest   => $real_manifest,
    source_dir => $source_dir,
  }
}
