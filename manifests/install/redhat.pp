# == Class: spm_monitor::install
#
# Installs SPM Monitor on RedHat.
#
# === Copyright
#
# Copyright 2019 Sematext
#

class spm_monitor::install::redhat() {
  yumrepo { 'sematext':
    descr    => 'Sematext Repo',
    baseurl  => 'http://pub-repo.sematext.com/redhat/$releasever/$basearch',
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
