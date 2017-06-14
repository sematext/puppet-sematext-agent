define spm_monitor::configure::javaagent (
  $spm_token = undef,
  $app_type = 'jvm',
  $app_subtype = undef,
  $jvm_name = 'default',
  $tracing = undef,
){
  validate_string($spm_token)
  validate_string($app_type)
  validate_string($app_subtype)
  validate_string($jvm_name)
  validate_string($tracing)

  if $spm_token == undef {
    fail('spm_token is mandatory')
  }
  if $app_type == undef {
    fail('app_type is mandatory')
  }
  if $jvm_name == undef {
    fail('jvm_name must not be undefined')
  }

  if $app_subtype == undef {
    $command = "bash /opt/spm/bin/spm-client-setup-conf.sh ${spm_token} ${app_type} javaagent jvmname:${jvm_name}"
    $properties = "/opt/spm/spm-monitor/conf/spm-monitor-config-${spm_token}-${jvm_name}.properties"
  }
  else {
    $command = "bash /opt/spm/bin/spm-client-setup-conf.sh ${spm_token} ${app_type} javaagent ${app_subtype} jvmname:${jvm_name}"
    $properties = "/opt/spm/spm-monitor/conf/spm-monitor-${app_subtype}-config-${spm_token}-${jvm_name}.properties"
  }

  exec { "${command}":
    path => "/usr/bin:/usr/sbin:/bin",
  }

  if $tracing != undef {
    file_line { "tracing-${properties}":
      path => $properties,
      match  => '^SPM_MONITOR_TRACING_ENABLED=.*',
      line => "SPM_MONITOR_TRACING_ENABLED=${tracing}",
      require => Exec["${command}"]
    }
  }
}
