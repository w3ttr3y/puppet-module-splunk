
class splunk::config::install::package (
    $ensure       = present,
    $file         = 'splunk-6.3.1-f3e41e4b37b2-linux-2.6-x86_64.rpm',
    $package_name = 'splunk',
    $provider     = 'rpm',
    $dir          = '/tmp',
) { }
