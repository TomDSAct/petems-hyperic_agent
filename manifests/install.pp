# hyperic_agent::install - Used for managing config files for a hyperic agents
#
class hyperic_agent::install {
  group { $::hyperic_agent::agent_group:
    ensure => present,
    system => true,
  }
  user { $::hyperic_agent::agent_user:
    ensure  => present,
    system  => true,
    home    => '/opt/hyperic',
    shell   => '/sbin/nologin',
    gid     => 'vfabric',
    require => Group['vfabric']
  }
  if $::hyperic_agent::manage_package {
    if $::hyperic_agent::manage_repo {
      package { $::hyperic_agent::package_name:
        ensure   => $::hyperic_agent::agent_version,
        provider => yum,
        require  => Yumrepo['vfabric']
      }
    } else {
      package { $::hyperic_agent::package_name:
        ensure   => present
      }
    }
  }
}
