# puppetlabs-java
class { 'java':
  distribution => 'jre',
}
->
# No RHEL7 Yum repo avaliable:
# http://repo.vmware.com/pub/rhel5/
# http://repo.vmware.com/pub/rhel6/
# Have to download the RPM manually from https://www.vmware.com/go/download-hyperic
class { 'hyperic_agent':
  package_name => 'vcenter-hyperic-agent',
  manage_repo  => false,
}