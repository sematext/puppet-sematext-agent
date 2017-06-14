# == Class: spm_monitor::install
#
# Installs SPM Monitor on supported OSes.
#
# === Examples
#
#  include spm_monitor::install
#
#  or
#
#  class { 'spm_monitor::install': }
#
# === Copyright
#
# Copyright 2016 Sematext
#

class spm_monitor::install {
  case $operatingsystem {
    'Amazon': { include spm_monitor::install::centos }
    'CentOS': { include spm_monitor::install::centos }
    'RedHat': { include spm_monitor::install::redhat }
    'Debian': { include spm_monitor::install::debian }
    'Ubuntu': { include spm_monitor::install::ubuntu }
    default:  { fail("Unsupported operatingsystem: ${operatingsystem}") }
  }
}

