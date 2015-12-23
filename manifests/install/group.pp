
class splunk::install::group (
  $manage     = $splunk::config::install::group::manage,
  $group      = $splunk::config::install::group::group,
  $ensure     = $splunk::config::install::group::ensure,
  $forcelocal = $splunk::config::install::group::forcelocal,
  $gid        = $splunk::config::install::group::gid,
  $members    = $splunk::config::install::group::members,
  $system     = $splunk::config::install::group::system,
) inherits splunk::config::install::group {
  if $manage {
    group{$::name:
      ensure     => $::ensure,
      forcelocal => $::forcelocal,
      gid        => $::gid,
      members    => $::memebers,
      system     => $::system,
    }
  }
}
