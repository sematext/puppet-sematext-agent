# == Class: spm_monitor::install
#
# Installs Sematext Infra & App agents on Debian.
#
# === Copyright
#
# Copyright 2019 Sematext
#

class spm_monitor::install::debian() {
  include apt

  apt::source { 'sematext':
    ensure   => present,
    comment  => 'Sematext Repo',
    location => 'http://pub-repo.sematext.com/debian',
    release  => 'sematext',
    repos    => 'main',
    key      => {
      id     => '5374946ADFDC6DA2E0A5B02CADF7F27BA9CDD5B9',
      source => 'https://pub-repo.sematext.com/sematext.gpg.key',
    }
  }

  package { 'spm-client':
    ensure  => latest,
    require => Apt::Source['sematext'],
  }

  service { 'spm-monitor':
    ensure  => running,
    enable  => true,
    require => Package['spm-client'],
  }
}
