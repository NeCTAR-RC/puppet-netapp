# This class manages nagios checks for NetApp devices

class netapp::nagios_checks (
  $host_use = 'generic-host',
  $service_use = 'generic-service',
  ){

  include nagios

  package { [ 'libwww-perl', 'libxml-perl' ]:
    ensure => installed,
  }

  file { '/usr/local/lib/site_perl':
    source  => 'puppet:///modules/netapp/nagios/site_perl',
    recurse => true,
  }

  file { '/usr/local/lib/nagios/plugins/check_netapp_ontapi':
    ensure => absent,
  }

  file { 'check_netapp_ontap':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    path    => '/usr/local/lib/nagios/plugins/check_netapp_ontap',
    source  => 'puppet:///modules/netapp/nagios/check_netapp_ontap.pl',
    require => File['/usr/local/lib/nagios'],
  }

  nagios::command { 'check_netapp_ontap':
    check_command => 'perl /usr/local/lib/nagios/plugins/check_netapp_ontap -H \'$ARG1$\' -u \'$ARG2$\' -p \'$ARG3$\' -o \'$ARG4$\'',
    require       => File['check_netapp_ontap'],
  }

  nagios::command { 'check_netapp_ontap_exclude':
    check_command => 'perl /usr/local/lib/nagios/plugins/check_netapp_ontap -H \'$ARG1$\' -u \'$ARG2$\' -p \'$ARG3$\' -o \'$ARG4$\' -m exclude,\'$ARG5$\'',
    require       => File['check_netapp_ontap'],
  }

  $host = hiera('netapp::nagios_checks::host')

  @@nagios_host { $host:
    use     => $host_use,
    target  => '/etc/nagios3/conf.d/nagios_host.cfg',
    tag     => $environment,
    require => File['nagios_confd'],
    notify  => Service['nagios3'],
  }

  netapp::nagios_checks::host { $host:
    require     => Nagios::Command['check_netapp_ontap'],
    service_use => $service_use,
  }
}
