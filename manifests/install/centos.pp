# == Class: spm_monitor::install
#
# Installs SPM Monitor on CentOS.
#
# === Copyright
#
# Copyright 2019 Sematext
#

class spm_monitor::install::centos {
  yumrepo { 'sematext':
    descr    => 'Sematext Repo',
    baseurl  => 'http://pub-repo.sematext.com/centos/$releasever/$basearch',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'https://pub-repo.sematext.com/sematext.gpg.key',
  }

  package { 'spm-client':
    ensure  => latest,
    require => Yumrepo['sematext']
  }

  service { 'spm-monitor':
    ensure  => running,
    enable  => true,
    require => Package['spm-client'],
  }
}
