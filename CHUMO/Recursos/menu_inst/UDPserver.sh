#By @ChumoGH|Plus
clear&&clear

[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg > /dev/null || source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar/msg) > /dev/null


RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN="\033[0m"

APP_IMPORT_GUIDE="  Open 'HTTP Injector' \n  app -> Tunnel Type set 'Hysteria' -> \n  Settings -> Hysteria -> \n Pegue el URI de configuraci�n de Hysteria2 para importar \n "

ip=$(cat < /bin/ejecutar/IPcgh) || ip=$(curl -s4m8 ip.sb -k)

red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}


starthysteria(){
    systemctl start hysteria-server &>/dev/null
    systemctl enable hysteria-server &>/dev/null 2>&1
}

stophysteria(){
    systemctl stop hysteria-server &>/dev/null
    systemctl disable hysteria-server &>/dev/null 2>&1
}

showConf(){
    #yellow "Hysteria 2 client YML configuration file hy-client.yaml is as follows and saved to /root/hy/hy-client.yaml"
    #red "$(cat /root/hy/hy-client.yaml)"
    #yellow "Hysteria 2 client JSON configuration file hy-client.json is as follows and saved to /root/hy/hy-client.json"
    #red "$(cat /root/hy/hy-client.json)"
    green "$APP_IMPORT_GUIDE"
    yellow "Hysteria 2 config URI (with port hop) is as follows and saved to /root/hy/url.txt"
    red "$(cat /root/hy/url.txt)"
    yellow "Hysteria 2 config URI (without port hop) is as follows and saved to /root/hy/url-nohop.txt"
    red "$(cat /root/hy/url-nohop.txt)"
}



inst_port(){
    iptables -t nat -F PREROUTING &>/dev/null 2>&1
	msg -bar3
	echo -e "Configure el puerto Hysteria2 entre [1-65535] "
    read -p " (Enter para puerto aleatorio) : " port
    [[ -z $port ]] && port=$(shuf -i 2000-65535 -n 1)
    until [[ -z $(ss -tunlp | grep -w udp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") ]]; do
        if [[ -n $(ss -tunlp | grep -w udp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") ]]; then
            echo -e "${RED} $port ${PLAIN} El puerto ya est� ocupado por otro programa, �cambie el puerto e int�ntelo de nuevo! "
            echo -e "Configure el puerto Hysteria2 entre [1-65535] "
			read -p " (Enter para puerto aleatorio) : " port
            [[ -z $port ]] && port=$(shuf -i 2000-65535 -n 1)
        fi
    done
    inst_jump
}

inst_jump(){
    green "El modo de uso del puerto Hysteria 2 es el siguiente:"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} Puerto Unico ${YELLOW}410default411${PLAIN}"
    echo -e " ${GREEN}2.${PLAIN} Puerto RANGOS/RAMDOM (INICIO-FIN )"
    echo ""
    read -rp "Escoge [1-2]: " jumpInput
    if [[ $jumpInput == 2 ]]; then
        read -p "Configure el puerto de inicio del puerto de rango (recomendado entre 10000-65535):" firstport
        read -p "Configure el puerto final de un puerto de rango (recomendado entre 10000-65535, debe ser m�s grande que el puerto de inicio anterior):" endport
        if [[ $firstport -ge $endport ]]; then
            until [[ $firstport -le $endport ]]; do
                if [[ $firstport -ge $endport ]]; then
                    red "El puerto de inicio que configur� es menor que el puerto final; vuelva a ingresar el puerto inicial y final"
                    read -p "Configure el puerto de inicio del puerto de rango (recomendado entre 10000-65535): " firstport
                    read -p ":" endport
                fi
            done
        fi
        iptables -t nat -A PREROUTING -p udp --dport $firstport:$endport  -j DNAT --to-destination :$port
        ip6tables -t nat -A PREROUTING -p udp --dport $firstport:$endport  -j DNAT --to-destination :$port
        netfilter-persistent save &>/dev/null 2>&1
    else
        red " DEFAULD MODO UNICO PUERTO"
    fi
}


install_bin(){
clear&&clear
msg -bar3
NAME=hysteria
VERSION=$(curl -fsSL https://api.github.com/repos/apernet/hysteria/releases/latest | grep -w tag_name |sed -e 's/[^v.0-9 -]//ig'| tr -d '[:space:]')
[[ $(uname -m 2> /dev/null) != x86_64 ]] && TARBALL="$NAME-linux-arm64" || TARBALL="$NAME-linux-amd64"
msg -nama "     Descargando Modulo ${VERSION}.(Evozi)."
if wget -O /bin/Hysteria2 https://github.com/apernet/hysteria/releases/download/app/${VERSION}/${TARBALL} &>/dev/null ; then
		chmod +x /bin/Hysteria2
		msg -verd ' OK'
	else
		msg -verm2 ' FAIL '
		rm -f /bin/Hysteria2
fi
echo "
[Unit]
Description=Hysteria2 Server Service ChumoGH
After=network.target

[Service]
Type=simple
ExecStart=/bin/Hysteria2 server --config /etc/adm-lite/HYSTERIA/config.yaml
WorkingDirectory=~
User=root
Group=root
Environment=HYSTERIA_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
" > /hysteria-server.service
chmod +x /hysteria-server.service
install -Dm644 /hysteria-server.service /etc/systemd/system
#systemctl disable hysteria-server.service &>/dev/null
#systemctl start hysteria-server.service &>/dev/null
#systemctl enable hysteria-server.service &>/dev/null
#rm -f /hysteria-server.service 
}

inst_pwd(){
    read -p "Establecer contrase�a de Hysteria2 (ingrese para obtener una contrase�a aleatoria): " auth_pwd
    [[ -z $auth_pwd ]] && auth_pwd=$(date +%s%N | md5sum | cut -c 1-8)
}

inst_site(){
msg -bar3
echo -e "INGRESA SU SNI ( HOST FAKE ) "
msg -bar3
    echo -e "Ingrese su Sitio WEB Falso A Hysteria 2 (elimine https://) "
	read -rp  " [Default : plus.admcgh.online]: " proxysite
    [[ -z $proxysite ]] && proxysite='plus.admcgh.online'
}

inst_cert(){
msg -bar3
echo -ne " Ingresa Tu Dominio Enlazado a este IP ( Omite con Enter ) :"
read -p " " domainH2
[[ -z ${domainH2} ]] && domainH2='Hysteria2'
        cert_path="/etc/hysteria/cert.crt"
        key_path="/etc/hysteria/private.key"
        openssl ecparam -genkey -name prime256v1 -out /etc/hysteria/private.key
        openssl req -new -x509 -days 36500 -key /etc/hysteria/private.key -out /etc/hysteria/cert.crt -subj "/CN=${domainH2}"
        chmod 777 /etc/hysteria/cert.crt
        chmod 777 /etc/hysteria/private.key
        hy_domain=$domainH2
        domain=$domainH2
}

_hysteria2(){
[[ -d /etc/hysteria ]] || mkdir /etc/hysteria
[[ -d /etc/adm-lite/HYSTERIA ]] || mkdir /etc/adm-lite/HYSTERIA/
    install_bin
	clear&&clear
    # Ask user for Hysteria configuration
    inst_cert
	clear&&clear
    inst_port
	clear&&clear
    inst_pwd
	clear&&clear
    inst_site
	clear&&clear
    # Set up the Hysteria configuration file
#cat << EOF > /etc/hysteria/config.yaml
cat << EOF > /etc/adm-lite/HYSTERIA/config.yaml
listen: :$port

tls:
  cert: $cert_path
  key: $key_path

obfs:
  type: salamander
  salamander:
    password: $auth_pwd

quic:
  initStreamReceiveWindow: 16777216
  maxStreamReceiveWindow: 16777216
  initConnReceiveWindow: 33554432
  maxConnReceiveWindow: 33554432

auth:
  type: password
  password: $auth_pwd

masquerade:
  type: proxy
  proxy:
    url: https://$proxysite
    rewriteHost: true
EOF

    # Determine the final inbound port range
    if [[ -n $firstport ]]; then
        last_port="$port,$firstport-$endport"
    else
        last_port=$port
    fi

    # Add brackets to the IPv6 address
    if [[ -n $(echo $ip | grep ":") ]]; then
        last_ip="[$ip]"
    else
        last_ip=$ip
    fi

    mkdir /root/hy
    cat << EOF > /root/hy/hy-client.yaml
server: $ip:$last_port

auth: $auth_pwd

tls:
  sni: $hy_domain
  insecure: true

obfs: $auth_pwd

quic:
  initStreamReceiveWindow: 16777216
  maxStreamReceiveWindow: 16777216
  initConnReceiveWindow: 33554432
  maxConnReceiveWindow: 33554432

fastOpen: true

socks5:
  listen: 127.0.0.1:5080

transport:
  udp:
    hopInterval: 30s 
EOF
    cat << EOF > /root/hy/hy-client.json
{
  "server": "$ip:$last_port",
  "auth": "$auth_pwd",
  "tls": {
    "sni": "$hy_domain",
    "insecure": true
  },
  "obfs": "$auth_pwd",
  "quic": {
    "initStreamReceiveWindow": 16777216,
    "maxStreamReceiveWindow": 16777216,
    "initConnReceiveWindow": 33554432,
    "maxConnReceiveWindow": 33554432
  },
  "fastOpen": true,
  "socks5": {
    "listen": "127.0.0.1:5080"
  },
  "transport": {
    "udp": {
      "hopInterval": "30s"
    }
  }
}
EOF
echo " IP : $(cat < /bin/ejecutar/IPcgh)" > /etc/adm-lite/HYSTERIA/data.yaml
echo " DOMINIO : ${domainH2}" >> /etc/adm-lite/HYSTERIA/data.yaml
echo " Authentication : ${auth_pwd}" >> /etc/adm-lite/HYSTERIA/data.yaml
echo " PUERTO : ${port}" >> /etc/adm-lite/HYSTERIA/data.yaml
echo " SNI : ${proxysite}" >> /etc/adm-lite/HYSTERIA/data.yaml
echo " RANGO DE PUERTOS : 10000:65000" >> /etc/adm-lite/HYSTERIA/data.yaml
echo -e " \n 	Power By @ChumoGH" >> /etc/adm-lite/HYSTERIA/data.yaml
    url="hy2://$auth_pwd@$ip:$last_port/?insecure=1&sni=$hy_domain&obfs=salamander&obfs-password=$auth_pwd#HttpInjector-hysteria2"
    echo $url > /root/hy/url.txt
    nohopurl="hy2://$auth_pwd@$ip:$port/?insecure=1&sni=$hy_domain&obfs=salamander&obfs-password=$auth_pwd#HttpInjector-hysteria2"
    echo $nohopurl > /root/hy/url-nohop.txt
    systemctl daemon-reload &>/dev/null
    systemctl enable hysteria-server &>/dev/null
    systemctl start hysteria-server &>/dev/null
    if [[ -n $(systemctl status hysteria-server 2>/dev/null | grep -w active) && -f '/etc/adm-lite/HYSTERIA/config.yaml' ]]; then
        green " Servicio Hysteria2 Iniciado Exitosamente"
    else
        red "ERROR, NO SE PUDO EJECUTAR EL SERVICIO DE HYSTERIA2 , \n\nEjecute systemctl status hysteria-server para ver el estado del servicio"
    fi
    #yellow "Hysteria 2 client YML configuration file hy-client.yaml is as follows and saved to /root/hy/hy-client.yaml"
    #red "$(cat /root/hy/hy-client.yaml)"
    #yellow "Hysteria 2 client JSON configuration file hy-client.json is as follows and saved to /root/hy/hy-client.json"
    #red "$(cat /root/hy/hy-client.json)"
msg -bar3
cat /etc/adm-lite/HYSTERIA/data.yaml
msg -bar3
    green "$APP_IMPORT_GUIDE"
    yellow "El URI de configuraci�n de Hysteria 2 (con salto de puerto) "
    red "$(cat /root/hy/url.txt)"
    yellow "El URI de configuraci�n de Hysteria 2 (sin salto de puerto) "
    red "$(cat /root/hy/url-nohop.txt)"
read -p "$(green "Hysteria 2 Modulos UDP By @ChumoGH Finalizado ") "
}

_hysteria(){
clear&&clear
[[ ! -d /etc/adm-lite/HYSTERIA ]] && mkdir /etc/adm-lite/HYSTERIA
NAME=hysteria
#VERSION=$(curl -fsSL https://api.github.com/repos/HyNetwork/hysteria/releases/latest | grep tag_name | sed -E 's/.*"v(.*)".*/\1/')
VERSION=$(curl -fsSL https://api.github.com/repos/HyNetwork/hysteria/releases/latest | grep -w tag_name |sed -e 's/[^v.0-9 -]//ig'| tr -d '[:space:]')
[[ $(uname -m 2> /dev/null) != x86_64 ]] && TARBALL="$NAME-linux-arm64" || TARBALL="$NAME-linux-amd64"
interfas="$(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1)"
#https://github.com/apernet/hysteria/releases/download/app%2Fv2.0.2/hysteria-linux-amd64

sys="$(which sysctl)"

ip4t=$(which iptables)
ip6t=$(which ip6tables)

#OBFS=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 10)
OBFS='ADMcghPLUS'

msg -nama '   INGRESA TU SUBDOMINIO/DOMINIO  \n'
#msg -nama '              Prederteminado ( ENTER )\n'
read -p "               DOMAIN : " domain
sleep 4s
del 1
msg -nama "     COMPIANDO CERTIFICADO SSL (UDP). . . . "
[[ -e /etc/adm-lite/HYSTERIA/udpmod.ca.key && -e /etc/adm-lite/HYSTERIA/udpmod.server.crt ]] && {
msg -verd ' OK'
} || {
#(
#openssl genrsa -out /etc/adm-lite/HYSTERIA/udpmod.ca.key 2048  2048
#openssl req -new -x509 -days 3650 -key /etc/adm-lite/HYSTERIA/udpmod.ca.key -subj "/C=CN/ST=GD/L=SZ/O=ChumoGH, Inc./CN=ChumoGH Root CA" -out /etc/adm-lite/HYSTERIA/udpmod.ca.crt
#openssl req -newkey rsa:2048 -nodes -keyout /etc/adm-lite/HYSTERIA/udp.server.key -subj "/C=CN/ST=GD/L=SZ/O=ChumoGH, Inc./CN=${domain}" -out /etc/adm-lite/HYSTERIA/udpmod.server.csr
#openssl x509 -req -extfile <(printf "subjectAltName=DNS:${domain},DNS:${domain}") -days 3650 -in /etc/adm-lite/HYSTERIA/udpmod.server.csr -CA /etc/adm-lite/HYSTERIA/udpmod.ca.crt -CAkey /etc/adm-lite/HYSTERIA/udpmod.ca.key -CAcreateserial -out /etc/adm-lite/HYSTERIA/udp.server.crt
#
(openssl genpkey -algorithm RSA -out /etc/adm-lite/HYSTERIA/udpmod.ca.key
openssl req -x509 -new -nodes -key /etc/adm-lite/HYSTERIA/udpmod.ca.key -days 3650 -out /etc/adm-lite/HYSTERIA/udpmod.ca.crt -subj "/C=CN/ST=GD/L=SZ/O=ChumoGH, Inc./CN=ChumoGH Root CA"
openssl req -newkey rsa:2048 -nodes -keyout /etc/adm-lite/HYSTERIA/udp.server.key -subj "/C=CN/ST=GD/L=SZ/O=ChumoGH, Inc./CN=${domain}" -out /etc/adm-lite/HYSTERIA/udpmod.server.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:${domain}") -days 3650 -in /etc/adm-lite/HYSTERIA/udpmod.server.csr -CA /etc/adm-lite/HYSTERIA/udpmod.ca.crt -CAkey /etc/adm-lite/HYSTERIA/udpmod.ca.key -CAcreateserial -out /etc/adm-lite/HYSTERIA/udp.server.crt
) &>/dev/null && msg -verd ' OK'

}
del 1
[[ -e /etc/adm-lite/HYSTERIA/udp.server.crt ]] && chmod +x /etc/adm-lite/HYSTERIA/udp.server.crt
[[ -e /etc/adm-lite/HYSTERIA/udp.server.key ]] && chmod +x /etc/adm-lite/HYSTERIA/udp.server.key
msg -nama "     Descargando BINARIO  v${VERSION}.(FAKE). "
#if wget -O /bin/hysteria https://github.com/apernet/hysteria/releases/download/app%2F${VERSION}/${TARBALL} &>/dev/null ; then
if wget -O /bin/hysteria https://github.com/apernet/hysteria/releases/download/v1.3.5/${TARBALL} &>/dev/null ; then
		chmod +x /bin/hysteria
		msg -verd ' OK'
	else
		msg -verm2 ' FAIL '
		rm -f /bin/hysteria
fi
sleep 4s && del 1
msg -nama '     Descargando Motor JSON . . . . '
if wget -O /etc/adm-lite/HYSTERIA/config.json https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu_inst/UDPserver-sh/config.json &>/dev/null ; then
		chmod +x /etc/adm-lite/HYSTERIA/config.json
		sed -i "s/setobfs/${OBFS}/" /etc/adm-lite/HYSTERIA/config.json
		msg -verd ' OK'
	else
		msg -verm2 ' FAIL '
		rm -rf /etc/adm-lite/HYSTERIA/config.json
fi
sleep 4s && del 1
msg -nama '     COMPILANDO GoLang AUTHSSH '
#if wget -O /bin/authSSH https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/authSSH &>/dev/null ; then
if wget -O /bin/authSSH https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu_inst/UDPserver-sh/authSSH &>/dev/null ; then
		chmod +x /bin/authSSH
		msg -verd ' OK'
	else
		msg -verm2 ' FAIL '
		rm -rf /bin/authSSH
fi
sleep 4s && del 1
msg -nama '     COMPILANDO BINARIO DE SYSTEMA . . . . '
if wget -O /etc/adm-lite/HYSTERIA/hysteria.service https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu_inst/UDPserver-sh/hysteria.service &>/dev/null ; then
		chmod +x /etc/adm-lite/HYSTERIA/hysteria.service
		systemctl disable hysteria.service &>/dev/null
		#rm -f /etc/systemd/system/hysteria.service
		
		msg -verd ' OK'
	else
		msg -verm2 ' FAIL '
		rm -f /etc/adm-lite/HYSTERIA/hysteria.service
fi
sleep 4s && del 1
		sed -i "s%sysb%${sys}%g" /etc/adm-lite/HYSTERIA/hysteria.service
		sed -i "s%ip4tbin%${ip4t}%g" /etc/adm-lite/HYSTERIA/hysteria.service
		sed -i "s%ip6tbin%${ip6t}%g" /etc/adm-lite/HYSTERIA/hysteria.service
		sed -i "s%iptb%${interfas}%g" /etc/adm-lite/HYSTERIA/hysteria.service
		
install -Dm644 /etc/adm-lite/HYSTERIA/hysteria.service /etc/systemd/system

systemctl start hysteria &>/dev/null
systemctl enable hysteria &>/dev/null
rm -f /etc/adm-lite/HYSTERIA/hysteria.service /etc/adm-lite/HYSTERIA/udpmod*
echo " IP : $(cat < /bin/ejecutar/IPcgh)" > /etc/adm-lite/HYSTERIA/data
echo " DOMINIO : ${domain}" >> /etc/adm-lite/HYSTERIA/data
echo " OBFS : ${OBFS}" >> /etc/adm-lite/HYSTERIA/data
echo " PUERTO : 36712" >> /etc/adm-lite/HYSTERIA/data
echo " ALPN : h3" >> /etc/adm-lite/HYSTERIA/data
echo " RANGO DE PUERTOS : 10000:65000" >> /etc/adm-lite/HYSTERIA/data
echo -e " \n 	Power By @ChumoGH" >> /etc/adm-lite/HYSTERIA/data
msg -bar3
echo ""
echo " --- TUS DATOS DE SERVICIO SON ---"
msg -bar3
figlet -p -f smslant Hysteria | lolcat
msg -bar3
cat /etc/adm-lite/HYSTERIA/data
msg -bar3
enter
[[ $(ps x | grep hysteria| grep -v grep) ]] && echo -e "$(msg -verd 'SERVICIO HYSTERIA INICIADO EXITOSAMENTE')" || echo -e "$(msg -verm2 'SERVICIO HYSTERIA NO INICIADO')"
_menuH
}

_menuH(){
clear&&clear
msg -bar3
cat /etc/adm-lite/HYSTERIA/data
msg -bar3
unset op
[[ $(cat /etc/adm-lite/HYSTERIA/config.json | grep -w '//"alpn"') ]] && _ap='\033[0;31mOFF' || _ap='\033[0;32mON'
menu_func "CAMBIAR PUERTO" "CAMBIAR OBFS" "ALPN (http injector)  \033[0;32m[ ${_ap}\033[0;32m ]" "REINICIAR SERVICIO" "\033[0;31mREMOVER SERVICIO"
msg -bar3
  selecy=$(selection_fun 5)  
case $selecy in
1)
clear&&clear
unset _col
msg -bar3
echo  -e "INGRESE EL NUEVO PUERTO DE SERVICIO "
read -p " PUERTO : " _col
#_PA=$(cat /etc/adm-lite/HYSTERIA/config.json | grep -i listen |cut -d '"' -f4 |sed -e 's/[^0-9]//ig')
_PA=$(cat /etc/adm-lite/HYSTERIA/config.json |jq -r .listen |sed -e 's/[^0-9]//ig')
  #sed -i "s%/bin/false%filemancgh%g" /etc/adm-lite/HYSTERIA/config.json
[[ ${_col} ]] && { 
sed -i "s/${_PA}/${_col}/" /etc/adm-lite/HYSTERIA/config.json 
sed -i "s/${_PA}/${_col}/" /etc/adm-lite/HYSTERIA/data
systemctl restart hysteria &>/dev/null
}
  ;;
  2)
clear&&clear
unset _col
msg -bar3
echo  -e "INGRESE SU NUEVO OBFS "
read -p " OBFS : " _col
_obfs=$(cat /etc/adm-lite/HYSTERIA/config.json |jq -r .obfs)
  #sed -i "s%/bin/false%filemancgh%g" /etc/adm-lite/HYSTERIA/config.json
[[ ${_col} ]] && { 
sed -i "s/${_obfs}/${_col}/" /etc/adm-lite/HYSTERIA/config.json 
sed -i "s/${_obfs}/${_col}/" /etc/adm-lite/HYSTERIA/data
systemctl restart hysteria &>/dev/null
}
;;
3)
clear&&clear
[[ $(cat /etc/adm-lite/HYSTERIA/config.json | grep -w '//"alpn"') ]] && { 
sed -i '12d' /etc/adm-lite/HYSTERIA/config.json 
sed -i '12i\        "alpn": "h3",' /etc/adm-lite/HYSTERIA/config.json 
} || {
sed -i '12d' /etc/adm-lite/HYSTERIA/config.json 
sed -i '12i\        //"alpn": "h3",' /etc/adm-lite/HYSTERIA/config.json 
}
systemctl restart hysteria &>/dev/null
;;
4)
clear&&clear
unset _col
msg -bar3
systemctl restart hysteria &>/dev/null
;;
5)
clear&&clear
rm -f /etc/adm-lite/HYSTERIA/*
systemctl disable hysteria &>/dev/null
systemctl remove hysteria &>/dev/null
rm -f /etc/systemd/system/hysteria.service
systemctl stop hysteria &>/dev/null
exit
;;
  esac  
}

_menuH2(){
clear&&clear
msg -bar3
cat /etc/adm-lite/HYSTERIA/data.yaml
msg -bar3
green "$APP_IMPORT_GUIDE"
yellow "El URI de configuraci�n de Hysteria 2 (con salto de puerto) "
red "$(cat /root/hy/url.txt)"
yellow "El URI de configuraci�n de Hysteria 2 (sin salto de puerto) "
red "$(cat /root/hy/url-nohop.txt)"
msg -bar3
unset op
[[ $(cat /etc/adm-lite/HYSTERIA/config.yaml | grep -w '//"alpn"') ]] && _ap='\033[0;31mOFF' || _ap='\033[0;32mON'
menu_func "CAMBIAR PUERTO" "CAMBIAR CONTRASE�A" "REINICIAR SERVICIO" "\033[0;31mREMOVER SERVICIO"
msg -bar3
  selecy=$(selection_fun 5)  
case $selecy in
1)
clear&&clear
unset _col
msg -bar3
    oldport=$(cat /etc/adm-lite/HYSTERIA/config.yaml 2>/dev/null | sed -n 1p | awk '{print $2}' | awk -F ":" '{print $2}')    
	echo  -e "INGRESE EL NUEVO PUERTO DE SERVICIO "
	read -p "Puerto [1-65535] (Puerto Ramdom Enter): " port
    [[ -z $port ]] && port=$(shuf -i 2000-65535 -n 1)
    until [[ -z $(ss -tunlp | grep -w udp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") ]]; do
        if [[ -n $(ss -tunlp | grep -w udp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") ]]; then
            echo -e "${RED} $port ${PLAIN} Puerto Ocupado , Reintente Nuevamente!  "
            read -p "Puerto [1-65535] (Puerto Ramdom Enter): " port
            [[ -z $port ]] && port=$(shuf -i 2000-65535 -n 1)
        fi
    done
    sed -i "1s#$oldport#$port#g" /etc/adm-lite/HYSTERIA/config.yaml
    sed -i "1s#$oldport#$port#g" /root/hy/hy-client.yaml
    sed -i "2s#$oldport#$port#g" /root/hy/hy-client.json
    sed -i "s#$oldport#$port#g" /root/hy/url.txt
    stophysteria && starthysteria
    green "Su puerto fue modificado Exitosamente : $port"
    cat /root/hy/url.txt
  ;;
  2)
clear&&clear
unset _col
msg -bar3
    oldpasswd=$(cat /etc/adm-lite/HYSTERIA/config.yaml 2>/dev/null | sed -n 20p | awk '{print $2}')
    oldobfs=$(cat /etc/adm-lite/HYSTERIA/config.yaml 2>/dev/null | sed -n 10p | awk '{print $2}')
	echo  -e "INGRESE SU NUEVA CLAVE/CONTRASE�A "
    read -p " (Enter Clave RAMDON): " passwd
    [[ -z $passwd ]] && passwd=$(date +%s%N | md5sum | cut -c 1-8)

    sed -i "20s#$oldpasswd#$passwd#g" /etc/adm-lite/HYSTERIA/config.yaml
    sed -i "10s#$oldobfs#$passwd#g" /etc/adm-lite/HYSTERIA/config.yaml
    sed -i "3s#$oldpasswd#$passwd#g" /root/hy/hy-client.yaml
    sed -i "9s#$oldobfs#$passwd#g" /root/hy/hy-client.yaml
    sed -i "3s#$oldpasswd#$passwd#g" /root/hy/hy-client.json
    sed -i "8s#$oldobfs#$passwd#g" /root/hy/hy-client.json
    sed -i "s#$oldpasswd#$passwd#g" /root/hy/url.txt
    sed -i "s#$oldobfs#$passwd#g" /root/hy/url.txt
    stophysteria && starthysteria
    green "Su nueva contrase�a $passwd se aplico Exitosamente"
    cat /root/hy/url.txt
;;
3)
stophysteria && starthysteria
;;
4)
clear&&clear
rm -f /etc/adm-lite/HYSTERIA/*
    systemctl stop hysteria-server.service >/dev/null 2>&1
    systemctl disable hysteria-server.service >/dev/null 2>&1
    rm -f /lib/systemd/system/hysteria-server.service /lib/systemd/system/hysteria-server@.service
    rm -rf /bin/Hysteria2 /etc/hysteria /root/hy /root/hysteria.sh
    rm -f /bin/Hysteria2
    iptables -t nat -F PREROUTING >/dev/null 2>&1
    netfilter-persistent save >/dev/null 2>&1
exit
;;
  esac  
}

unset _So _Cu _HIS _HIS2
while : 
[[ $(ps x | grep -w 'udpServer'| grep -v grep) ]] && _So="$(msg -verd 'ON')" || _So="$(msg -verm2 'OFF')"
[[ $(ps x | grep -w 'UDP-Custom'| grep -v grep) ]] && _Cu="$(msg -verd 'ON')" || _Cu="$(msg -verm2 'OFF')"
[[ $(ps x | grep -w '/bin/hysteria' | grep -v grep) ]] && _HIS="$(msg -verd 'ON')" || _HIS="$(msg -verm2 'OFF')"
[[ $(ps x | grep -w '/bin/Hysteria2'| grep -v grep) ]] && _HIS2="$(msg -verd 'ON')" || _HIS2="$(msg -verm2 'OFF')"
_MSYS=" \n$(print_center "\033[0;35mUsuarios SSH del Sistema")"
_MSYS2="\n$(print_center "\033[0;35mNO SOPORTA USERS DE SISTEMA")"

do
unset port
  tittle
  #menu_func " UDP-REQUEST  SocksIP    \033[0;31m[${_So}\033[0;31m]${_MSYS}" "UDP-CUSTOM HTTPCustom \033[0;31m[${_Cu}\033[0;31m]${_MSYS}" "UDP-Hysteria APPMod's \033[0;31m[${_HIS}\033[0;31m] ${_MSYS}"
  echo -e "\033[0;35m [${cor[2]}01\033[0;35m]\033[0;33m ${flech}${cor[3]}UDP-REQUEST  SocksIP         \033[0;31m[${_So}\033[0;31m] ${_MSYS}" 
  echo -e "\033[0;35m [${cor[2]}02\033[0;35m]\033[0;33m ${flech}${cor[3]}UDP-CUSTOM HTTPCustom        \033[0;31m[${_Cu}\033[0;31m] ${_MSYS}" 
  echo -e "\033[0;35m [${cor[2]}03\033[0;35m]\033[0;33m ${flech}${cor[3]}UDP-Hysteria APPMod's        \033[0;31m[${_HIS}\033[0;31m] ${_MSYS}"
  echo -e "\033[0;35m [${cor[2]}04\033[0;35m]\033[0;33m ${flech}${cor[3]}UDP-Hysteria2 HTTP-Injector  \033[0;31m[${_HIS2}\033[0;31m] ${_MSYS2}"
  msg -bar3
  echo -ne "$(msg -verd "  [0]") $(msg -verm2 "=>>") " && msg -bra "\033[1;41m Volver "
  msg -bar3
  opcion=$(selection_fun 4)
  case $opcion in
  1) source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu_inst/UDPserver.org.sh) && exit;;
  2) source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu_inst/udp-custom.sh) && exit;;
  3) [[ $(ps x | grep -w "/bin/hysteria"| grep -v grep) ]] && _menuH || _hysteria ;;
  4) [[ $(ps x | grep -w "/bin/Hysteria2"| grep -v grep) ]] && _menuH2 || _hysteria2 ;;
  0) exit;;
  esac  
done

pruebas(){

echo '[Unit]
Description=HysteriaUDP MOD Service BY @ChumoGH
After=network.target

[Service]
User=root
Group=root'	> /etc/adm-lite/HYSTERIA/hysteria.service
echo "ExecStartPost=${sys} net.ipv4.ip_forward=1
ExecStartPost=${sys} net.ipv4.conf.all.rp_filter=0
ExecStartPost=${sys} net.ipv4.conf.${interfas}.rp_filter=0
ExecStartPost=${ip4t} -t nat -A PREROUTING -i ${interfas} -p udp --dport 10000:65000 -j DNAT --to-destination :36712
ExecStartPost=${ip6t} -t nat -A PREROUTING -i ${interfas} -p udp --dport 10000:65000 -j DNAT --to-destination :36712
ExecStopPost=${ip4t} -t nat -D PREROUTING -i ${interfas} -p udp --dport 10000:65000 -j DNAT --to-destination :36712
ExecStopPost=${ip6t} -t nat -D PREROUTING -i ${interfas} -p udp --dport 10000:65000 -j DNAT --to-destination :36712" >> /etc/adm-lite/HYSTERIA/hysteria.service

echo 'WorkingDirectory=/etc/adm-lite/HYSTERIA
Environment="PATH=/etc/adm-lite/HYSTERIA"
ExecStart=/bin/hysteria -config /etc/adm-lite/HYSTERIA/config.json server

[Install]
WantedBy=multi-user.target
' >> /etc/adm-lite/HYSTERIA/hysteria.service
		
}
