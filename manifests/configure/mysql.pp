define spm_monitor::configure::mysql (
  $spm_token = undef,
  $user = 'spm-user',
  $pass = 'spm-password',
  $host = 'localhost',
  $port = 3306,
){
  validate_string($spm_token)
  validate_string($user)
  validate_string($pass)
  validate_string($host)
  validate_integer($port)

  if $spm_token == undef {
    fail('spm_token is mandatory')
  }
  if $user == undef {
    fail('user is mandatory')
  }
  if $pass == undef {
    fail('pass is mandatory')
  }
  if $host == undef {
    fail('host is mandatory')
  }
  if $port == undef {
    fail('port is mandatory')
  }

  $command = 'sudo bash /opt/spm/bin/spm-client-mysql-setup-conf.sh'
  exec { "${command} ${spm_token} ${user} ${pass} ${host}:${port}":
    path   => "/usr/bin:/usr/sbin:/bin",
  }
}
