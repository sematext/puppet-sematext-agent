# == Class: spm_monitor::configure
#
# Full description of class spm_monitor::configure here.
#
# === Parameters
#
# [*monitoring_token*]
#   Monitoring Token unique to each application
#
# [*infra_token*]
#   Infra Token unique to each account
#
# [*agent_type*]
#   Agent type (standalone, javaagent)
#
# [*app_type*]
#   Application type (mysql, elasticsearch, zookeeper, kafka, ...)
#
# [*app_name*]
#   Application name used when more than one application runs on the same host
#
# [*args*]
#   Extra arguments hash for each application type
#
#
# === Examples
#
#  class { 'spm_monitor::configure':
#    monitoring_token  => 'MONITORING_TOKEN',
#    infra_token  => 'INFRA_TOKEN',
#    agent_type => 'standalone'
#    app_type   => 'mysql',
#    args => {
#      'SPM_MONITOR_MYSQL_DB_USER' => 'mysql-user',
#      'SPM_MONITOR_MYSQL_DB_PASSWORD' => 'mysql-password',
#    }
#  }
#
#  class { 'spm_monitor::configure':
#    monitoring_token  => 'MONITORING_TOKEN',
#    infra_token  => 'INFRA_TOKEN',
#    agent_type => 'standalone'
#    app_type   => 'elasticsearch',
#    args => {
#      'SPM_MONITOR_ES_NODE_HOSTPORT' => 'localhost:9200',
#    }
#  }
#
#  class { 'spm_monitor::configure':
#    monitoring_token  => 'MONITORING_TOKEN',
#    infra_token  => 'INFRA_TOKEN',
#    agent_type => 'standalone'
#    app_type   => 'zookeeper',
#    args => {
#      'jmx_host' => 'localhost',
#      'jmx_port' => '3000',
#    }
#  }
#
#  class { 'spm_monitor::configure':
#    monitoring_token  => 'MONITORING_TOKEN',
#    infra_token  => 'INFRA_TOKEN',
#    agent_type => 'standalone'
#    app_type   => 'kafka',
#    args => {
#      'app_subtype' => 'kafka-broker',
#      'jmx_host' => 'localhost',
#      'jmx_port' => '3000',
#    }
#  }
#
# === Copyright
#
# Copyright 2019 Sematext
#

class spm_monitor::configure (
  String $monitoring_token,
  String $infra_token,
  String $app_type,
  Optional[String] $agent_type = 'standalone',
  Optional[String] $app_name = 'default',
  Optional[Hash] $args = undef,

){
  if $args == undef {
    $command = "/opt/spm/bin/setup-sematext \\
      --monitoring-token ${ monitoring_token } \\
      --infra-token ${ infra_token } \\
      --agent-type ${ agent_type } \\
      --app-type ${ app_type }"

    $config = "/opt/spm/spm-monitor/conf/spm-monitor-config-${ monitoring_token }-${ app_name }.properties"

    exec { $command:
      creates => $config,
    }
  }
  else {
    $extra_args = $args
      .map |$key, $value| { "--${key} ${value}" }
      .join(' ')

    if !has_key($args, 'app_subtype') {
      $command = "/opt/spm/bin/setup-sematext \\
        --monitoring-token ${ monitoring_token } \\
        --infra-token ${ infra_token } \\
        --agent-type ${ agent_type } \\
        --app-type ${ app_type } \\
        ${extra_args}"

      $config = "/opt/spm/spm-monitor/conf/spm-monitor-config-${ monitoring_token }-${ app_name }.properties"

      exec { $command:
        creates => $config,
      }
    }
    else {
      $app_subtype = $args['app_subtype']

      $command = "/opt/spm/bin/setup-sematext \\
        --monitoring-token ${ monitoring_token } \\
        --infra-token ${ infra_token } \\
        --agent-type ${ agent_type } \\
        --app-type ${ app_type } \\
        --app-subtype ${ app_subtype } \\
        ${extra_args}"

      $config = "/opt/spm/spm-monitor/conf/spm-monitor-${ app_subtype }-config-${ monitoring_token }-${ app_name }.properties"

      exec { $command:
        creates => $config,
      }
    }
  }
}
