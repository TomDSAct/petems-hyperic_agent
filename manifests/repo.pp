# hyperic_agent::repo - Used for managing repos for hyperic (just yum for now)
#
class hyperic_agent::repo {
  if $::hyperic_agent::manage_repo {

    if $::operatingsystemmajrelease == '7' {
      fail('There is currently no RHEL7 Repo. Mark $manage_repo parameter as false and host the RPM yourself: https://www.vmware.com/go/download-hyperic')
    }

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
        yumrepo { 'vfabric':
          descr    => "VMWare vFabric ${::hyperic_agent::vfabric_version} - \$basearch",
          enabled  => '1',
          gpgcheck => '1',
          gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}",
          baseurl  => "${::hyperic_agent::repo_path}rhel${::operatingsystemmajrelease}/vfabric/${::hyperic_agent::vfabric_version}/\$basearch"
        }
        hyperic_agent::rpm_gpg_key{ "VFABRIC-${::hyperic_agent::vfabric_version}":
          gpg_path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}",
          before   => Yumrepo['vfabric'],
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
        yumrepo { 'vfabric':
          descr    => "VMWare vFabric ${::hyperic_agent::vfabric_version} - \$basearch",
          enabled  => '1',
          gpgcheck => '1',
          gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}-EL${::operatingsystemmajrelease}",
          baseurl  => "${::hyperic_agent::repo_path}rhel${::operatingsystemmajrelease}/vfabric/${::hyperic_agent::vfabric_version}/\$basearch"
        }
        hyperic_agent::rpm_gpg_key{ "VFABRIC-${::hyperic_agent::vfabric_version}-EL${::operatingsystemmajrelease}":
          gpg_path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-VFABRIC-${::hyperic_agent::vfabric_version}-EL${::operatingsystemmajrelease}",
          before   => Yumrepo['vfabric'],
        }
      }
    }
  } else {
    # Don't do anything if we're not managing the repo.
  }
}
