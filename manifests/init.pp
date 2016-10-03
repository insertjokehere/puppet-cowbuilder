class cowbuilder {
  package { ['cowbuilder', 'ubuntu-keyring', 'debian-keyring']:
    ensure => present
  }
}
