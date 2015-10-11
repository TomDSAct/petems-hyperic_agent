# hyperic_agent::repo - Used for managing the service for hyperic
#
class hyperic_agent::service {
  file { "/etc/init.d/${::hyperic_agent::service_name}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('hyperic_agent/hyperic.init.erb')
  }
  service { $::hyperic_agent::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
