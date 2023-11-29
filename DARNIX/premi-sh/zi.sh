#!/bin/bash
# Zivpn UDP Module installer
# Creator Zahid Islam
mkdir -p /etc/zivpn
echo -e "Updating server"
sudo apt-get update && apt-get upgrade -y
systemctl stop zivpn.service 1> /dev/null 2> /dev/null
echo -e "Downloading UDP Service"

#[+main+]
# wget https://github.com/zahidbd2/udp-zivpn/releases/download/udp-zivpn_1.4.9/udp-zivpn-linux-amd64 -O /usr/local/bin/zivpn 1> /dev/null 2> /dev/null
#[+pre+]
wget https://raw.githubusercontent.com/Rerechan02/UDP/main/bin/udp-zivpn-linux-amd64 -O /usr/local/bin/zivpn 1> /dev/null 2> /dev/null
chmod +x /usr/local/bin/zivpn
mkdir /etc/zivpn 1> /dev/null 2> /dev/null

#[+main+]
# wget https://raw.githubusercontent.com/zahidbd2/udp-zivpn/main/config.json -O /etc/zivpn/config.json 1> /dev/null 2> /dev/null
#[+pre+]
cat <<EOF > /etc/zivpn/config.json
{
  "listen": ":5666",
  "cert": "/etc/xray/xray.crt",
  "key":  "/etc/xray/xray.key",
  "obfs":"zivpn",
  "auth": {
    "mode": "passwords", 
    "config": ["zi"]
  }
}

EOF

##
cat <<EOF > /etc/systemd/system/zivpn.service
[Unit]
Description=zivpn VPN Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/etc/zivpn
ExecStart=/usr/local/bin/zivpn -config /etc/zivpn/config.json server
Restart=always
RestartSec=3
Environment=HYSTERIA_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
EOF


systemctl enable zivpn.service
systemctl start zivpn.service
iptables -t nat -A PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport 20000:50000 -j DNAT --to-destination :5666
ufw allow 20000:50000/udp
ufw allow 5666/udp
rm zi.* 1> /dev/null 2> /dev/null
echo -e "Installed"
clear