# Creates a cowbuilder base image
define cowbuilder::base(
  $path=$title,
  $arch=$::architecture,
  $dist=$::lsbdistcodename,
  $mirror=undef,
  $othermirrors=undef,
  $keyring=undef,
  $components='main',
  $debootstrapopts=undef,
  $extrapackages=undef,
  $debootstrap='debootstrap',
  $httpproxy=undef
)
{
  if ($othermirrors != undef) {
    validate_array($othermirrors)
    $othm = join($othermirrors,'|')
    $param_othermirrors="--othermirror \"${othm}\""
  } else {
    $param_othermirrors=''
  }

  if ($keyring != undef) {
    $param_keychain = "--debootstrapopts --keyring=${keyring}"
  } else {
    $param_keychain = ''
  }

  if ($debootstrapopts != undef) {
    validate_array($debootstrapopts)
    $dbstop = join($debootstrapopts, ' --debootstrapopts ')
    $param_debootstrapopts = "--debootstraptops ${dbstop}"
  } else {
    $param_debootstraptops = ''
  }

  if ($extrapackages != undef) {
    validate_array($extrapackages)
    $extrap = join($extrapackages, ' ')
    $param_extrapackages = "--extrapackages ${extrap}"
  } else {
    $param_extrpackages = ''
  }

  if ($httpproxy != undef) {
    $param_httpproxy = "--http-proxy ${httpproxy}"
  } else {
    $param_httpproxy = ''
  }

  if ($arch != $::architecture or ($arch == 'i386' and $::architecture == 'amd64')) {
    $debootstrap = 'debootstrap'
  } else {
    $debootstrap = 'qemu-debootstrap'
    ensure_packages(['qemu-user-static'])
  }

  exec { "cowbuilder-create-${title}":
    command => "cowbuilder --create --distribution ${dist} --architecture ${arch} --basepath ${path} --mirror ${mirror} ${param_othermirrors} --components \"${components}\" ${param_extrapackages} ${param_httpproxy} --debootstrap ${debootstrap} ${param_debootstrapopts} ${param_keychain} --debootstrap ${debootstrap}",
    unless  => "test -d ${path}",
    path    => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin'],
    timeout => 0
  }
}
