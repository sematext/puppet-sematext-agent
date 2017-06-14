define spm_monitor::configure::nginxplus (
  $spm_token = undef,
  $stats_url = 'http://localhost/status',
){
  validate_string($spm_token)
  validate_string($stats_url)

  if $spm_token == undef {
    fail('spm_token is mandatory')
  }

  $command = 'bash /opt/spm/bin/spm-client-nginx-plus-setup-conf.sh'
  if $stats_url == undef {
    exec { "${command} ${spm_token}":
      path   => "/usr/bin:/usr/sbin:/bin",
    }
  }
  else {
    exec { "${command} ${spm_token} statusUrl:${stats_url}":
      path   => "/usr/bin:/usr/sbin:/bin",
    }
  }
}
