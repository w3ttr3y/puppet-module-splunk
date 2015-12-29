define splunk::service::enable_systemd (
  $splunk_home     = '/opt/splunk',
  $instance = '',
) {

$systemd_template = "
[Unit]
Description=Splunk <%= @instance %>
Wants=network.target
After=network.target

[Service]
Type=forking
RemainAfterExit=yes
ExecStart=<%= @splunk_home %>/bin/splunk start --answer-yes --no-prompt --accept-license
ExecStop=<%= @splunk_home %>/bin/splunk stop
ExecReload=<%= @splunk_home %>/bin/splunk restart
StandardOutput=syslog

[Install]
WantedBy=multi-user.target"

  if $::systemd_available != true {
    fail('systemd is not available; cannot enable the service via systemd')
  }

  anchor{"splunk:service:enable_systemd:${title}:begin": } ->
  file {"${::systemd::unit_path}/splunk_${instance}.service":
    ensure           => file,
    content          => inline_epp($systemd_template,
      {'splunk_home' => $splunk_home,
       'instance'    => $instance}),
    notify           => Exec['systemd-daemon-reload'],
  }
  anchor{"splunk:service:enable_systemd:${title}:end": }
}
