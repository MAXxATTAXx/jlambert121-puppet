# document me
class puppet::agent::service (
  $runmode = $::puppet::runmode,
){

  if ( $::puppet::agent ) {
    $mode = $runmode
  } else {
    $mode = 'none'
  }

  case $runmode {
    'cron': {
      class { '::puppet::agent::job_resource': }
      service { 'puppet':
        ensure => 'stopped',
        enable => false,
      }
    }
    'service': {
      class { '::puppet::agent::job_resource':
        job_ensure => 'absent',
      }
      service { 'puppet':
        ensure => 'running',
        enable => true,
      }
    }
    'none': {
      class { '::puppet::agent::job_resource':
        job_ensure => 'absent',
      }
      service { 'puppet':
        ensure => 'stopped',
        enable => false,
      }
    }
    default: {
      fail("Unsupported runmode ${runmode} in puppet::agent::service")
    }
  }
}
