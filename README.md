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
  spm_token  => 'YOUR_SPM_TOKEN',
  spm_type   => 'mysql',
  mysql_user => 'spm-user',
  mysql_pass => 'spm-password',
  mysql_host => 'localhost',
  mysql_port => 3306,
}
```

## Limitations

This module is tested and officially supported on CentOS/RedHat 6 and 7, Debian 7 and 8 and Ubuntu 12.04 and 14.04.
Testing on other platforms has been light and cannot be guaranteed.

## Contributions

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request