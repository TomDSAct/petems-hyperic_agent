# hyperic_agent - Used for managing installation and configuration
# of a Hyperic agent
#
# @example
#   include hyperic_agent
#
# @example
#   class { 'hyperic_agent':
#     server_ip      => '1.2.3.4',
#     server_login   => 'hq-username',
#     server_enc_pw  => 'encrypted-password-here',
#     server_enc_key => 'your-encrypted-key-here',
#   }
#
# @author Peter Souter, Paul Bailey, and various Github contributors
#
# @param agent_group [String] Group the hyperic agent should run as
#
# @param agent_version [String]  Version of the hyperic agent to install
#
# @param agent_user [String] User the hyperic agent should run as
#
# @param enable_repo [Boolean] Enable the VMWare vFabric repo
#
# @param java_home [String] Path to $JAVA_HOME that Hyperic should use
#
# @param manage_repo [Boolean] Enable repo management
#
# @param manage_package [Boolean] Enable repo management
#
# @param package_name [String] Name of the package to install
#
# @param repo_path [String] Path to the VMWare vFabric repo
#
# @param server_ip [String] IP address of the Hyperic server
#
# @param server_port [String] Non-SSl port of the Hyperic server
#
# @param server_ssl_port [String] SSl port of the Hyperic server
#
# @param server_secure [String] Should the agent use SSL
#
# @param server_login [String] Login username of the Hyperic agent
#
# @param server_enc_pw [String] Encrypted password of the Hyperic agent
#
# @param server_enc_key [String] Encryption key of the Hyperic agent
#
# @param service_name [String] Name of the service to use
#
# @param vfabric_version [String] vFabric version to use
#
class hyperic_agent (
  $agent_group     = $::hyperic_agent::params::agent_group,
  $agent_version   = $::hyperic_agent::params::agent_version,
  $agent_user      = $::hyperic_agent::params::agent_user,
  $enable_repo     = $::hyperic_agent::params::enable_repo,
  $java_home       = $::hyperic_agent::params::java_home,
  $manage_package  = $::hyperic_agent::params::manage_package,
  $manage_repo     = $::hyperic_agent::params::manage_repo,
  $package_name    = $::hyperic_agent::params::package_name,
  $repo_path       = $::hyperic_agent::params::repo_path,
  $server_ip       = $::hyperic_agent::params::server_ip,
  $server_port     = $::hyperic_agent::params::server_port,
  $server_ssl_port = $::hyperic_agent::params::server_ssl_port,
  $server_secure   = $::hyperic_agent::params::server_secure,
  $server_login    = $::hyperic_agent::params::server_login,
  $server_enc_pw   = $::hyperic_agent::params::server_enc_pw,
  $server_enc_key  = $::hyperic_agent::params::server_enc_key,
  $service_name    = $::hyperic_agent::params::service_name,
  $vfabric_version = $::hyperic_agent::params::vfabric_version,
) inherits ::hyperic_agent::params {

  validate_bool($enable_repo)
  validate_bool($manage_repo)
  validate_bool($manage_package)
  validate_string($agent_version)
  validate_string($vfabric_version)

  class { '::hyperic_agent::repo': } ->
  class { '::hyperic_agent::install': } ->
  class { '::hyperic_agent::config': } ~>
  class { '::hyperic_agent::service': } ->
  Class['::hyperic_agent']
}
