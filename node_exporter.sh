#!/bin/bash
cd
wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz
tar -zxpf node_exporter-1.4.0.linux-amd64.tar.gz
mv node_exporter-1.4.0.linux-amd64/node_exporter /usr/sbin/
rm -rf node_exporter-1.4.0.linux-amd64 node_exporter-1.4.0.linux-amd64.tar.gz
cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
User=root
EnvironmentFile=/etc/node_exporter.conf
ExecStart=/usr/sbin/node_exporter $OPTIONS
Restart=always

[Install]
WantedBy=multi-user.target
EOF
echo "OPTIONS=\"--collector.tcpstat --no-collector.zfs --no-collector.wifi\"" > /etc/node_exporter.conf
systemctl enable --now node_exporter.service

