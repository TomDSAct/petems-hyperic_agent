# puppetlabs-java
class { 'java':
  distribution => 'jre',
}
->
class { 'hyperic_agent':
}