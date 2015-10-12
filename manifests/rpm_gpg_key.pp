# hyperic_agent::rpm_gpg_key - This define is a repurposed version of stahma's epel beauty and imports the RPM GPG keys for vFabric
#
# @example
#   hyperic_agent::rpm_gpg_key{
#     gpg_path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-5.3-EL6"
#   }
#
# @param gpg_path [String] Path of the RPM GPG key to import
#
define hyperic_agent::rpm_gpg_key($gpg_path) {
  # Given the path to a key, see if it is imported, and if not, import it
  exec {  "import-${name}":
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => "rpm --import ${gpg_path}",
    unless    => "rpm -q gpg-pubkey-$(echo $(gpg --throw-keyids < ${gpg_path}) | cut --characters=11-18 | tr '[A-Z]' '[a-z]')",
    require   => File[$gpg_path],
    logoutput => on_failure,
  }
}
