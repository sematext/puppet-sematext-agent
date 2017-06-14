define spm_monitor::configure::memcached (
  $spm_token = undef,
  $port = 11211,
){
  validate_string($spm_token)
  validate_integer($port)

  if $spm_token == undef {
    fail('spm_token is mandatory')
  }
  if $port == undef {
    fail('port is mandatory')
  }

  $command = 'bash /opt/spm/bin/spm-client-memcached-setup-conf.sh'
  exec { "${command} ${spm_token} ${port}":
    path   => "/usr/bin:/usr/sbin:/bin",
  }
}
