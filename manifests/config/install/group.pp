
class splunk::config::install::group (
  $manage     = true,
  $group      = 'splunk',
  $ensure     = 'present',
  $forcelocal = undef,
  $gid        = undef,
  $members    = undef,
  $system     = true,
) {
  if ! ( $manage in [ undef, true, false, 'yes', 'no'] ) {
    fail('manage must be one of undef, true, false, yes, or no')
  }
  #TODO: validate group
  if ! ($ensure in ['present', 'absent', 'role' ] ) {
    fail('ensure must be one of present, absent, or role')
  }
  if ! ( $forcelocal in [ undef, true, false, 'yes', 'no' ] ) {
    fail('forcelocal must be true, false, yes, or no')
  }
  #TODO: validate gid
  #TODO: validate members
  if ! ($system in [undef, true, false, 'yes', 'no' ]) {
    fail('system must be one of true, false, yes, or no')
  }
}
