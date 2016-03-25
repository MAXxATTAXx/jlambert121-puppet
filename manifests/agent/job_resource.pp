# document me
class puppet::agent::job_resource (
  $job_ensure = 'present'
) {

  case $::kernel {
    'Windows': {
      scheduled_task { 'puppet':
        ensure    => $job_ensure,
        command   => 'C:\\Program Files\\Puppet Labs\\Puppet\\bin\\puppet.bat',
        arguments => 'agent --onetime --no-daemonize',
        trigger   => {
          schedule         => daily,
          start_time       => '00:00',
          minutes_interval => 30,
          minutes_duration => 31,
        }
      }
    }
    'Linux': {
      cron { 'puppet':
        ensure  => $job_ensure,
        user    => 'root',
        command => '/opt/puppetlabs/bin/puppet agent --onetime --no-daemonize',
        hour    => '*',
        minute  =>  [ fqdn_rand(30), fqdn_rand(30) + 30 ],
      }
    }
    default: {
      fail("${::kernel} kernel is not supported")
    }
  }
}
