# spm_monitor

#### Table of Contents

1. [Description](#description)
2. [Setup](#setup)
3. [Usage](#usage)
4. [Limitations](#limitations)
5. [Contributions](#contributions)

## Description

The spm_monitor module can install and configure Sematext SPM Monitor on
CentOS, RedHat, Debian and Ubuntu systems.

## Install

Install `spm_monitor` as a module in your Puppet master's module path.

    puppet module install sematext-spm_monitor


## Usage

### Using the `spm_monitor::install` Class

To install SPM Monitor, just declare the spm_monitor::install class.

```puppet
include 'spm_monitor::install'
```

or

``` puppet
class { 'spm_monitor::install':}
```

### Using the `spm_monitor::configure` Class

To configure SPM Monitor, you need to declare the spm_monitor::configure class
with the correct parameters for the application type.

``` puppet
class { 'spm_monitor::configure':
  monitoring_token  => 'MONITORING_TOKEN',
  infra_token  => 'INFRA_TOKEN',
  agent_type => 'standalone'
  app_type   => 'mysql',
  args => {
    'SPM_MONITOR_MYSQL_DB_USER' => 'mysql-user',
    'SPM_MONITOR_MYSQL_DB_PASSWORD' => 'mysql-password',
  }
}

class { 'spm_monitor::configure':
  monitoring_token  => 'MONITORING_TOKEN',
  infra_token  => 'INFRA_TOKEN',
  agent_type => 'standalone'
  app_type   => 'elasticsearch',
  args => {
    'SPM_MONITOR_ES_NODE_HOSTPORT' => 'localhost:9200',
  }
}

class { 'spm_monitor::configure':
  monitoring_token  => 'MONITORING_TOKEN',
  infra_token  => 'INFRA_TOKEN',
  agent_type => 'standalone'
  app_type   => 'zookeeper',
  args => {
    'jmx_host' => 'localhost',
    'jmx_port' => '3000',
  }
}

class { 'spm_monitor::configure':
  monitoring_token  => 'MONITORING_TOKEN',
  infra_token  => 'INFRA_TOKEN',
  agent_type => 'standalone'
  app_type   => 'kafka',
  args => {
    'app_subtype' => 'kafka-broker',
    'jmx_host' => 'localhost',
    'jmx_port' => '3000',
  }
}
```

## Limitations

This module is tested and officially supported on CentOS/RedHat 6 and 7, Debian 8 and 9 and Ubuntu 16.04 and 18.04.
Testing on other platforms has been light and cannot be guaranteed.

## Contributions

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request