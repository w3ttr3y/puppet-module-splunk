# Installs Splunk via a package (rpm, dpkg, etc)
class splunk::install::package (
) {

  anchor{'pre splunk::install::package': }

  file {'/tmp/splunk-6.3.1-f3e41e4b37b2-linux-2.6-x86_64.rpm':
    source  => 'puppet:///modules/splunk/installers/splunk-6.3.1-f3e41e4b37b2-linux-2.6-x86_64.rpm',
    require => Anchor['pre splunk::install::package'],
  }

  package {'splunk':
    ensure  => present,
    source  => '/tmp/splunk-6.3.1-f3e41e4b37b2-linux-2.6-x86_64.rpm',
    require => File['/tmp/splunk-6.3.1-f3e41e4b37b2-linux-2.6-x86_64.rpm'],
  }

  anchor{'post splunk::install::package':
    require => Package['splunk'],
  }
}
