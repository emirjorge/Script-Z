#!/bin/bash 
  
 #=== setup === 
 cd 
 mkdir -p /etc/udp 
 mkdir -p /etc/udp
  
 sudo apt update -y 
 sudo apt upgrade -y 
 sudo apt install -y wget 
 sudo apt install -y curl 
 sudo apt install -y dos2unix 
  # [+get files ⇣⇣⇣+] 
   wget "https://raw.githubusercontent.com/Rerechan02/UDP/main/bin/udp-request-linux-amd64" -O /usr/bin/udp-request &>/dev/null  
   chmod +x /usr/bin/udp-request 
  
   # [+udpgw+] 
   wget -O /etc/udpgw 'https://raw.githubusercontent.com/Rerechan02/UDP/main/module/udpgw' 
   mv /etc/udpgw /bin 
   chmod +x /bin/udpgw 
  
   # [+service+] 
   wget -O /etc/udpgw.service 'https://raw.githubusercontent.com/Rerechan02/UDP/main/config/udpgw.service' 
   mv /etc/udpgw.service /etc/systemd/system

wget -O /etc/udp-request.service 'https://raw.githubusercontent.com/Rerechan02/UDP/main/config/udp-request.service' 
   mv /etc/udp-request.service /etc/systemd/system
  
   chmod 640 /etc/systemd/system/udpgw.service
  
   systemctl daemon-reload &>/dev/null 
   systemctl enable udpgw &>/dev/null 
   systemctl start udpgw &>/dev/null 
   systemctl enable udp-request &>/dev/null 
   systemctl start udp-request &>/dev/null 
  
     systemctl enable udpgw.service &>/dev/null 
   systemctl start udpgw.service &>/dev/null 
   systemctl enable udp-request.service &>/dev/null 
   systemctl start udp-request.service &>/dev/null 

   # [+config+] 
   wget "https://raw.githubusercontent.com/Rerechan02/UDP/main/config/config.json" -O /etc/udp/config.json &>/dev/null 
   chmod 644 /etc/udp/config.json
 clear