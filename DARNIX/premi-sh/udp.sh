#!/bin/bash

cd
rm -rf /etc/udp
mkdir -p /etc/udp


# install udp-custom
echo downloading udp-custom
wget "https://github.com/Rerechan02/UDP/raw/main/bin/udp-custom-linux-amd64" -O /etc/udp/udp-custom
chmod +x /etc/udp/udp-custom

echo downloading default config
wget "https://github.com/Rerechan02/UDP/raw/main/config/config.json" -O /etc/udp/config.json
chmod 644 /etc/udp/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/etc/udp/udp-custom server
WorkingDirectory=/etc/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/etc/udp/udp-custom server -exclude $1
WorkingDirectory=/etc/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

echo start service udp-custom
systemctl start udp-custom &>/dev/null

echo enable service udp-custom
systemctl enable udp-custom &>/dev/null

clear