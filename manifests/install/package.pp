# Installs Splunk via a package (rpm, dpkg, etc)
class splunk::install::package (
    $ensure      = splunk::config::install::package::ensure,
    $file        = splunk::config::install::package::file,
    $packge_name = splunk::config::install::package::package_name,
    $provider    = splunk::config::install::package::provider,
    $dir         = splunk::config::install::package::dir,
) {

  anchor{'splunk::install::package::begin': } ->

  package {$::package_name:
    ensure   => $ensure,
    source   => "${::dir}/${::file}",
    provider =>  $::provider,
  } ->

  anchor{'splunk::install::package::end': }
}
