class cowbuilder {
  package { ['cowbuilder', 'ubuntu-keyring', 'debian-archive-keyring']:
    ensure => present
  }
}
