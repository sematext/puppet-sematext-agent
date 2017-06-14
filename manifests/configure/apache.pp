define spm_monitor::configure::apache (
  $spm_token = undef,
  $stats_url = 'http://localhost/server-status?auto',
  $user = undef,
  $pass = undef
){
  validate_string($spm_token)
  validate_string($stats_url)
  validate_string($user)
  validate_string($pass)

  if $spm_token == undef {
    fail('spm_token is mandatory')
  }

  $command = 'bash /opt/spm/bin/spm-client-apache-setup-conf.sh'
  if $stats_url == undef {
    if $user == undef or $pass == undef {
      exec { "${command} ${spm_token}":
        path   => "/usr/bin:/usr/sbin:/bin",
      }
    }
    else {
      exec { "${command} ${spm_token} username:${user} password:${pass}":
        path   => "/usr/bin:/usr/sbin:/bin",
      }
    }
  }
  else {
    if $user == undef or $pass == undef {
      exec { "${command} ${spm_token} statusUrl:${stats_url}":
        path   => "/usr/bin:/usr/sbin:/bin",
      }
    }
    else {
      exec { "${command} ${spm_token} statusUrl:${stats_url} username:${user} password:${pass}":
        path   => "/usr/bin:/usr/sbin:/bin",
      }
    }
  }
}
