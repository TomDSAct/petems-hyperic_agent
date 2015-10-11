# hyperic_agent::repo - Used for managing repos for hyperic (just yum for now)
#
class hyperic_agent::repo {
  if $::hyperic_agent::manage_repo {
    file { '/etc/yum.repos.d/vfabric.repo':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
    case $::hyperic_agent::vfabric_version {
      '5': {
        file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}":
          ensure => file,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => "puppet:///modules/hyperic_agent/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}"
        }
        if $::hyperic_agent::enable_repo {
          yumrepo { 'vfabric':
            descr    => "VMWare vFabric ${::hyperic_agent::vfabric_version} - \$basearch",
            enabled  => '1',
            gpgcheck => '1',
            gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}",
            baseurl  => "${::hyperic_agent::repo_path}rhel${::operatingsystemmajrelease}/vfabric/${::hyperic_agent::vfabric_version}/\$basearch"
          }
        } else {
          yumrepo { 'vfabric':
            descr    => "VMWare vFabric ${::hyperic_agent::vfabric_version} - \$basearch",
            enabled  => '0',
            gpgcheck => '1',
            gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}",
            baseurl  => "${::hyperic_agent::repo_path}rhel${::operatingsystemmajrelease}/vfabric/${::hyperic_agent::vfabric_version}/\$basearch"
          }
        }
        hyperic_agent::rpm_gpg_key{ "VFABRIC-${::hyperic_agent::vfabric_version}":
          gpg_path      => "/etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}",
          before        => Yumrepo['vfabric'],
        }
      }
      default: {
        file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}-EL${::operatingsystemmajrelease}":
          ensure => file,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => "puppet:///modules/hyperic_agent/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}-EL${::operatingsystemmajrelease}"
        }
        if $::hyperic_agent::enable_repo {
          yumrepo { 'vfabric':
            descr    => "VMWare vFabric ${::hyperic_agent::vfabric_version} - \$basearch",
            enabled  => '1',
            gpgcheck => '1',
            gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}-EL${::operatingsystemmajrelease}",
            baseurl  => "${::hyperic_agent::repo_path}rhel${::operatingsystemmajrelease}/vfabric/${::hyperic_agent::vfabric_version}/\$basearch"
          }
        } else {
          yumrepo { 'vfabric':
            descr    => "VMWare vFabric ${::hyperic_agent::vfabric_version} - \$basearch",
            enabled  => '0',
            gpgcheck => '1',
            gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}-EL${::operatingsystemmajrelease}",
            baseurl  => "${::hyperic_agent::repo_path}rhel${::operatingsystemmajrelease}/vfabric/${::hyperic_agent::vfabric_version}/\$basearch"
          }
        }
        hyperic_agent::rpm_gpg_key{ "VFABRIC-${::hyperic_agent::vfabric_version}-EL${::operatingsystemmajrelease}":
          gpg_path   => "/etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}-EL${::operatingsystemmajrelease}",
          before     => Yumrepo['vfabric'],
        }
      }
    }
  } else {
    # Don't do anything if we're not managing the repo.
  }
}