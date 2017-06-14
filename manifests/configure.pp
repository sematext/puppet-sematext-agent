# == Class: spm_monitor::configure
#
# Full description of class spm_monitor::configure here.
#
# === Parameters
#
# [*spm_token*]
#   SPM Token unique to each SPM application
#
# [*spm_type*]
#   SPM application type (apache, haproxy, javaagent, ...)
#
# [*apache_stats_url*]
#   Apache server status URL provided by mod_status
#
# [*apache_user*]
#   User needed to acces the info provided by mod_status
#
# [*apache_pass*]
#   Password needed to acces the info provided by mod_status
#
# [*haproxy_stats_url*]
#   HAProxy stats URL
#
# [*java_app_type*]
#   SPM Java application type (es, kafka, zk, ...)
#
# [*java_app_subtype*]
#   SPM Java application subtype (kafka-broker, kafka-producer, kafka-consumer, ...)
#
# [*java_jvm_name*]
#   SPM Java JVM name
#
# [*java_tracing*]
#   SPM tracing for Java aplications (true or false)
#
# [*java_jmx_params*]
#   SPM JMX parameters for standalone applications
#
# [*memcached_port*]
#   Port on which memcached is listening
#
# [*mysql_user*]
#   MySQL user needed to access the server
#
# [*mysql_pass*]
#   MySQL password needed to access the server
#
# [*mysql_host*]
#   MySQL server hostname
#
# [*mysql_port*]
#   MySQL port on which the server is listening
#
# [*nginx_stats_url*]
#   Nginx server status URL
#
# [*nginx_user*]
#   User needed to acces the info provided Nginx
#
# [*nginx_pass*]
#   Password needed to acces the info provided Nginx
#
# [*nginx_plus_stats_url*]
#   Nginx Plus server status URL
#
#
# === Examples
#
#  class { 'spm_monitor::configure':
#    spm_token  => 'YOUR_TOKEN',
#    spm_type   => 'mysql',
#    mysql_user => 'spm-user',
#    mysql_pass => 'spm-password',
#    mysql_host => 'localhost',
#    mysql_port => 3306,
#  }
#
# === Copyright
#
# Copyright 2016 Sematext
#

define spm_monitor::configure (
  $spm_token = undef,
  $spm_type = undef,
  $apache_stats_url = 'http://localhost/server-status?auto',
  $apache_user = undef,
  $apache_pass = undef,
  $haproxy_stats_url = 'http://localhost/haproxy_stats;csv',
  $java_app_type = 'jvm',
  $java_app_subtype = undef,
  $java_jvm_name = 'default',
  $java_tracing = undef,
  $java_jmx_params = undef,
  $memcached_port = 11211,
  $mysql_user = 'spm-user',
  $mysql_pass = 'spm-password',
  $mysql_host = 'localhost',
  $mysql_port = 3306,
  $nginx_stats_url = 'http://localhost/nginx_status',
  $nginx_user = undef,
  $nginx_pass = undef,
  $nginx_plus_stats_url = 'http://localhost/status',
){
  validate_string($spm_token)
  validate_string($spm_type)
  validate_string($apache_stats_url)
  validate_string($apache_user)
  validate_string($apache_pass)
  validate_string($haproxy_stats_url)
  validate_string($java_app_type)
  validate_string($java_app_subtype)
  validate_string($java_jvm_name)
  validate_integer($memcached_port)
  validate_string($mysql_user)
  validate_string($mysql_pass)
  validate_string($mysql_host)
  validate_integer($mysql_port)
  validate_string($nginx_stats_url)
  validate_string($nginx_plus_stats_url)

  if $spm_token == undef {
    fail("spm_token is mandatory")
  }
  if $spm_type == undef {
    fail("spm_token is mandatory")
  }

  case $spm_type {
    'apache': {
      spm_monitor::configure::apache { "${spm_token}":
        spm_token => $spm_token,
        stats_url => $apache_stats_url,
        user => $apache_user,
        pass => $apache_pass
      }
    }
    'haproxy': {
      spm_monitor::configure::haproxy { "${spm_token}":
        spm_token => $spm_token,
        stats_url => $haproxy_stats_url
      }
    }
    'memcached': {
      spm_monitor::configure::memcached { "${spm_token}":
        spm_token => $spm_token,
        port => $memcached_port
      }
    }
    'mysql': {
      spm_monitor::configure::mysql { "${spm_token}":
        spm_token => $spm_token,
        user => $mysql_user,
        pass => $mysql_pass,
        host => $mysql_host,
        port => $mysql_port
      }
    }
    'nginx': {
      spm_monitor::configure::nginx { "${spm_token}":
        spm_token => $spm_token,
        stats_url => $nginx_stats_url,
        user => $nginx_user,
        pass => $nginx_pass
      }
    }
    'nginx-plus': {
      spm_monitor::configure::nginxplus { "${spm_token}":
        spm_token => $spm_token,
        stats_url => $nginx_plus_stats_url
      }
    }
    'javaagent': {
      spm_monitor::configure::javaagent { "${spm_token}-${java_app_type}-${java_jvm_name}":
        spm_token => $spm_token,
        app_type => $java_app_type,
        app_subtype => $java_app_subtype,
        jvm_name => $java_jvm_name,
        tracing => $java_tracing
      }
    }
    'standalone': {
      spm_monitor::configure::standalone { "${spm_token}-${java_app_type}-${java_jvm_name}":
        spm_token => $spm_token,
        app_type => $java_app_type,
        app_subtype => $java_app_subtype,
        jvm_name => $java_jvm_name,
        jmx_params => $java_jmx_params,
        tracing => $java_tracing
      }
    }
    default: { fail("Unsupported SPM application type: ${$spm_type}") }
  }
}

