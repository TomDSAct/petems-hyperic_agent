# hyperic_agent::config - Used for managing config files for a hyperic agents
#
class hyperic_agent::config {
  file { '/opt/hyperic/hyperic-hqee-agent/conf/agent.properties':
    ensure  => file,
    owner   => $::hyperic_agent::agent_user,
    group   => $::hyperic_agent::agent_group,
    mode    => '0644',
    content => template('hyperic_agent/agent.properties.erb')
  }
  file { '/opt/hyperic/hyperic-hqee-agent/conf/agent.scu':
    ensure  => file,
    owner   => $::hyperic_agent::agent_user,
    group   => $::hyperic_agent::agent_group,
    mode    => '0600',
    content => template('hyperic_agent/agent.scu.erb')
  }
}
