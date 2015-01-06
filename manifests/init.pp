class cowbuilder {
  package { 'cowbuilder':
    ensure => present
  }

  file { '/usr/share/debootstrap/scripts/trusty':
    ensure  => link,
    target  => '/usr/share/debootstrap/scripts/gutsy',
    require => Package['cowbuilder']
  }

  file { '/usr/share/debootstrap/scripts/utopic':
    ensure  => link,
    target  => '/usr/share/debootstrap/scripts/gutsy',
    require => Package['cowbuilder']
  }

}
