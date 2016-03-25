# document me
class puppet::server (
) {
  # Original Purpose: Guarantee that server files are present/absent 
  # depending the configrutation
  # New Purpose: The same but only guarantee this when the osfamily 
  # is Debian/RedHat
  if $::osfamily in ['Debian','RedHat'] {
    class { '::puppet::server::install': } ->
    class { '::puppet::server::config': } ~>
    class { '::puppet::server::service': }

    Class['puppet::server::install'] ~> Class['puppet::server::service']
  }
}
