class spm_monitor::install::ubuntu() {
  include apt

  apt::source { 'sematext':
    comment  => 'Sematext Repo',
    ensure   => present,
    location => 'http://pub-repo.sematext.com/ubuntu',
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
    enable  => true,
    ensure  => running,
    require => Package['spm-client'],
  }
}
