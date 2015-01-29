# This class contains services to check for a NetApp host

define netapp::nagios-checks::host ($service_use) {

  $user = hiera('netapp::nagios-checks::user')
  $password = hiera('netapp::nagios-checks::password')

  nagios::service { "${name}_aggregate":
    host_name           => $name,
    check_command       => "check_netapp_ontap!$name!$user!$password!aggregate_health",
    service_description => 'aggregate_health',
    use                 => $service_use,
  }
  nagios::service { "${name}_snapmirror":
    host_name           => $name,
    check_command       => "check_netapp_ontap!$name!$user!$password!snapmirror_health",
    service_description => 'snapmirror_health',
    use                 => $service_use,
  }
  nagios::service { "${name}_snapshot":
    host_name           => $name,
    check_command       => "check_netapp_ontap!$name!$user!$password!snapshot_health",
    service_description => 'snapshot_health',
    use                 => $service_use,
  }
  nagios::service { "${name}_filer_hardware":
    host_name           => $name,
    check_command       => "check_netapp_ontap!$name!$user!$password!filer_hardware_health",
    service_description => 'filer_hardware_health',
    use                 => $service_use,
  }
  nagios::service { "${name}_interface":
    host_name           => $name,
    check_command       => "check_netapp_ontap!$name!$user!$password!interface_health",
    service_description => 'interface_health',
    use                 => $service_use,
  }
  nagios::service { "${name}_port":
    host_name           => $name,
    check_command       => "check_netapp_ontap!$name!$user!$password!port_health",
    service_description => 'port_health',
    use                 => $service_use,
  }
  nagios::service { "${name}_alarms":
    host_name           => $name,
    check_command       => "check_netapp_ontap_exclude!$name!$user!$password!netapp_alarms!aggr_root",
    service_description => 'netapp_alarms',
    use                 => $service_use,
  }
  nagios::service { "${name}_cluster":
    host_name           => $name,
    check_command       => "check_netapp_ontap!$name!$user!$password!cluster_health",
    service_description => 'cluster_health',
    use                 => $service_use,
  }
  nagios::service { "${name}_disk":
    host_name           => $name,
    check_command       => "check_netapp_ontap!$name!$user!$password!disk_health",
    service_description => 'disk_health',
    use                 => $service_use,
  }
  nagios::service { "${name}_volume":
    host_name           => $name,
    check_command       => "check_netapp_ontap!$name!$user!$password!volume_health",
    service_description => 'volume_health',
    use                 => $service_use,
  }

}
