#!/bin/bash

# Instalador de servidor Secure WireGuard
# https://github.com/leitura/wireguard-install
clear&&clear
RED='\033[0;31m'
ORANGE='\033[0;33m'
NC='\033[0m'

function isRoot() {
	if [ "${EUID}" -ne 0 ]; then
		echo "Você precisa executar este script como root"
		exit 1
	fi
}

function checkVirt() {
	if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ no es compatible"
		exit 1
	fi

	if [ "$(systemd-detect-virt)" == "lxc" ]; then
		echo "LXC no es compatible (todavía)."
		echo "WireGuard técnicamente puede ejecutarse en un contenedor LXC,"
		echo "pero el módulo del kernel debe estar instalado en el host,"
		echo "el contenedor debe ejecutarse con algunos parámetros específicos"
		echo "y solo las herramientas deben instalarse en el contenedor."
		exit 1
	fi
}

function checkOS() {
	# Check OS version
	if [[ -e /etc/debian_version ]]; then
		source /etc/os-release
		OS="${ID}" # debian or ubuntu
		if [[ ${ID} == "debian" || ${ID} == "raspbian" ]]; then
			if [[ ${VERSION_ID} -lt 10 ]]; then
				echo "Su versión de Debian (${VERSION_ID}) no es compatible. Utilice Debian 10 Buster o posterior"
				exit 1
			fi
			OS=debian # overwrite if raspbian
		fi
	elif [[ -e /etc/fedora-release ]]; then
		source /etc/os-release
		OS="${ID}"
	elif [[ -e /etc/centos-release ]]; then
		source /etc/os-release
		OS=centos
	elif [[ -e /etc/oracle-release ]]; then
		source /etc/os-release
		OS=oracle
	elif [[ -e /etc/arch-release ]]; then
		OS=arch
	else
		echo "Parece que no está ejecutando este instalador en un sistema Debian, Ubuntu, Fedora, CentOS, Oracle o Arch Linux"
		exit 1
	fi
}

function initialCheck() {
	isRoot
	checkVirt
	checkOS
}

function installQuestions() {
	echo "¡Bienvenido al instalador de WireGuard!"
	#echo "O repositório git está disponível em: https://github.com/leitura/wireguard-install"
	echo ""
	echo "Necesito hacer algunas preguntas antes de comenzar la configuración."
	echo "Puede dejar las opciones predeterminadas y simplemente presionar Entrar si está de acuerdo con ellas."
	echo ""

	# Detect public IPv4 or IPv6 address and pre-fill for the user
	#SERVER_PUB_IP=$(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | awk '{print $1}' | head -1)
	SERVER_PUB_IP=$(wget -qO- ifconfig.me)
	if [[ -z ${SERVER_PUB_IP} ]]; then
		# Detect public IPv6 address
		SERVER_PUB_IP=$(ip -6 addr | sed -ne 's|^.* inet6 \([^/]*\)/.* scope global.*$|\1|p' | head -1)
	fi
	read -rp "Dirección pública IPv4 o IPv6: " -e -i "${SERVER_PUB_IP}" SERVER_PUB_IP

	# Detect public interface and pre-fill for the user
	SERVER_NIC="$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)"
	until [[ ${SERVER_PUB_NIC} =~ ^[a-zA-Z0-9_]+$ ]]; do
		read -rp "Interface pública: " -e -i "${SERVER_NIC}" SERVER_PUB_NIC
	done

	until [[ ${SERVER_WG_NIC} =~ ^[a-zA-Z0-9_]+$ && ${#SERVER_WG_NIC} -lt 16 ]]; do
		read -rp "Nombre de la interfaz WireGuard: " -e -i wg0 SERVER_WG_NIC
	done

	until [[ ${SERVER_WG_IPV4} =~ ^([0-9]{1,3}\.){3} ]]; do
		read -rp "WireGuard IPv4 do servidor: " -e -i 10.66.66.1 SERVER_WG_IPV4
	done

	until [[ ${SERVER_WG_IPV6} =~ ^([a-f0-9]{1,4}:){3,4}: ]]; do
		read -rp "WireGuard IPv6 en el servidor: " -e -i fd42:42:42::1 SERVER_WG_IPV6
	done

	# Generate random number within private ports range
	RANDOM_PORT=$(shuf -i49152-65535 -n1)
	until [[ ${SERVER_PORT} =~ ^[0-9]+$ ]] && [ "${SERVER_PORT}" -ge 1 ] && [ "${SERVER_PORT}" -le 65535 ]; do
		read -rp "Puerto WireGuard del servidor [1-65535]: " -e -i "${RANDOM_PORT}" SERVER_PORT
	done

	# Adguard DNS by default
	until [[ ${CLIENT_DNS_1} =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; do
		read -rp "1Mer resolvedor de DNS a ser usado para los clientes: " -e -i 8.8.8.8 CLIENT_DNS_1
	done
	until [[ ${CLIENT_DNS_2} =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; do
		read -rp "Segundo resolvedor de DNS a ser usado para los clientes (opcional): " -e -i 8.8.4.4 CLIENT_DNS_2
		if [[ ${CLIENT_DNS_2} == "" ]]; then
			CLIENT_DNS_2="${CLIENT_DNS_1}"
		fi
	done

	echo ""
	echo "Está bien, eso era todo lo que necesitaba. Estamos listos para configurar su servidor WireGuard ahora."
	echo "Podrá generar un cliente al final de la instalación."
	read -n1 -r -p "Presione cualquier tecla para continuar."
}

fun_limpram() {

		if [[ ${OS} == 'ubuntu' ]] || [[ ${OS} == 'debian' && ${VERSION_ID} -gt 10 ]]; then
		apt-get update -y &> /dev/null
		apt-get install -y wireguard iptables resolvconf qrencode &> /dev/null
	elif [[ ${OS} == 'debian' ]]; then
		if ! grep -rqs "^deb .* buster-backports" /etc/apt/; then
			echo "deb http://deb.debian.org/debian buster-backports main" >/etc/apt/sources.list.d/backports.list
			apt-get update &> /dev/null
		fi
		apt update
		apt-get install -y iptables resolvconf qrencode &> /dev/null
		apt-get install -y -t buster-backports wireguard &> /dev/null
	elif [[ ${OS} == 'fedora' ]]; then
		if [[ ${VERSION_ID} -lt 32 ]]; then
			dnf install -y dnf-plugins-core &> /dev/null
			dnf copr enable -y jdoss/wireguard &> /dev/null
			dnf install -y wireguard-dkms &> /dev/null
		fi
		dnf install -y wireguard-tools iptables qrencode &> /dev/null
	elif [[ ${OS} == 'centos' ]]; then
		yum -y install epel-release elrepo-release &> /dev/null
		if [[ ${VERSION_ID} -eq 7 ]]; then
			yum -y install yum-plugin-elrepo &> /dev/null
		fi
		yum -y install kmod-wireguard wireguard-tools iptables qrencode &> /dev/null
	elif [[ ${OS} == 'oracle' ]]; then
		dnf install -y oraclelinux-developer-release-el8 &> /dev/null
		dnf config-manager --disable -y ol8_developer &> /dev/null
		dnf config-manager --enable -y ol8_developer_UEKR6 &> /dev/null
		dnf config-manager --save -y --setopt=ol8_developer_UEKR6.includepkgs='wireguard-tools*'
		dnf install -y wireguard-tools qrencode iptables
	elif [[ ${OS} == 'arch' ]]; then
		pacman -S --needed --noconfirm wireguard-tools qrencode
	fi

	# Make sure the directory exists (this does not seem the be the case on fedora)
	[[ -d /etc/wireguard ]] || mkdir /etc/wireguard >/dev/null 2>&1

	chmod 600 -R /etc/wireguard/

	SERVER_PRIV_KEY=$(wg genkey)
	SERVER_PUB_KEY=$(echo "${SERVER_PRIV_KEY}" | wg pubkey)

	# Save WireGuard settings
	echo "SERVER_PUB_IP=${SERVER_PUB_IP}
SERVER_PUB_NIC=${SERVER_PUB_NIC}
SERVER_WG_NIC=${SERVER_WG_NIC}
SERVER_WG_IPV4=${SERVER_WG_IPV4}
SERVER_WG_IPV6=${SERVER_WG_IPV6}
SERVER_PORT=${SERVER_PORT}
SERVER_PRIV_KEY=${SERVER_PRIV_KEY}
SERVER_PUB_KEY=${SERVER_PUB_KEY}
CLIENT_DNS_1=${CLIENT_DNS_1}
CLIENT_DNS_2=${CLIENT_DNS_2}" >/etc/wireguard/params

	# Add server interface
	echo "[Interface]
Address = ${SERVER_WG_IPV4}/24,${SERVER_WG_IPV6}/64
ListenPort = ${SERVER_PORT}
PrivateKey = ${SERVER_PRIV_KEY}" >"/etc/wireguard/${SERVER_WG_NIC}.conf"

	if pgrep firewalld; then
		FIREWALLD_IPV4_ADDRESS=$(echo "${SERVER_WG_IPV4}" | cut -d"." -f1-3)".0"
		FIREWALLD_IPV6_ADDRESS=$(echo "${SERVER_WG_IPV6}" | sed 's/:[^:]*$/:0/')
		echo "PostUp = firewall-cmd --add-port ${SERVER_PORT}/udp && firewall-cmd --add-rich-rule='rule family=ipv4 source address=${FIREWALLD_IPV4_ADDRESS}/24 masquerade' && firewall-cmd --add-rich-rule='rule family=ipv6 source address=${FIREWALLD_IPV6_ADDRESS}/24 masquerade'
PostDown = firewall-cmd --remove-port ${SERVER_PORT}/udp && firewall-cmd --remove-rich-rule='rule family=ipv4 source address=${FIREWALLD_IPV4_ADDRESS}/24 masquerade' && firewall-cmd --remove-rich-rule='rule family=ipv6 source address=${FIREWALLD_IPV6_ADDRESS}/24 masquerade'" >>"/etc/wireguard/${SERVER_WG_NIC}.conf"
	else
		echo "PostUp = iptables -A FORWARD -i ${SERVER_PUB_NIC} -o ${SERVER_WG_NIC} -j ACCEPT; iptables -A FORWARD -i ${SERVER_WG_NIC} -j ACCEPT; iptables -t nat -A POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE; ip6tables -A FORWARD -i ${SERVER_WG_NIC} -j ACCEPT; ip6tables -t nat -A POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE
PostDown = iptables -D FORWARD -i ${SERVER_PUB_NIC} -o ${SERVER_WG_NIC} -j ACCEPT; iptables -D FORWARD -i ${SERVER_WG_NIC} -j ACCEPT; iptables -t nat -D POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE; ip6tables -D FORWARD -i ${SERVER_WG_NIC} -j ACCEPT; ip6tables -t nat -D POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE" >>"/etc/wireguard/${SERVER_WG_NIC}.conf"
	fi

	# Enable routing on the server
	echo "net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1" >/etc/sysctl.d/wg.conf

	sysctl --system

	systemctl start "wg-quick@${SERVER_WG_NIC}" &> /dev/null
	systemctl enable "wg-quick@${SERVER_WG_NIC}" &> /dev/null
	
	sync
	echo 3 >/proc/sys/vm/drop_caches
	sync && sysctl -w vm.drop_caches=3
	sysctl -w vm.drop_caches=0
	swapoff -a
	swapon -a
	v2ray clean 1> /dev/null 2> /dev/null
	rm -rf /tmp/* > /dev/null 2>&1
	killall kswapd0 > /dev/null 2>&1
	killall tcpdump > /dev/null 2>&1
	killall ksoftirqd > /dev/null 2>&1
	rm -f /var/log/syslog*
	sleep 4
}
function aguarde() {
	sleep 1
	helice() {
		fun_limpram >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m INSTALANDO Y CONFIGURANDO \033[1;32mWire\033[1;37m|\033[1;32mGuard\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1DOk"
}


function installWireGuard() {
msg -bar2
	# Run setup questions first
	installQuestions
	msg -bar2
	echo ""
	echo -e " ESPERA MIENTRAS DE COMPLETA EL PROCESO . . . "
	echo -e " "
	# Install WireGuard tools and module
aguarde
echo ""
msg -bar2
	newClient
	echo "Si desea agregar más clientes, simplemente necesita ejecutar este script nuevamente."

	# Check if WireGuard is running
	systemctl is-active --quiet "wg-quick@${SERVER_WG_NIC}" 
	WG_RUNNING=$?

	# WireGuard might not work if we updated the kernel. Tell the user to reboot
	if [[ ${WG_RUNNING} -ne 0 ]]; then
		echo -e "\n${RED}AVISO: WireGuard no parece estar ejecutándose.${NC}"
		echo -e "${ORANGE}Puede verificar que WireGuard se está ejecutando con: systemctl status wg-quick@${SERVER_WG_NIC}${NC}"
		echo -e "${ORANGE}Si obtiene algo como \"No se puede encontrar el dispositivo ${SERVER_WG_NIC}\", por favor reinicie!${NC}"
	fi
}

function newClient() {
	ENDPOINT="${SERVER_PUB_IP}:${SERVER_PORT}"

	echo ""
	echo " DIJITE UN NOMBRE PARA SU 1 CLIENTE "
	echo -e "El nombre debe constar de caracteres alfanuméricos. \n También puede incluir un guión bajo o un guión y no puede exceder los 15 caracteres."

	until [[ ${CLIENT_NAME} =~ ^[a-zA-Z0-9_-]+$ && ${CLIENT_EXISTS} == '0' && ${#CLIENT_NAME} -lt 16 ]]; do
		read -rp "NOMBRE DEL CLIENTE: " -e CLIENT_NAME
		CLIENT_EXISTS=$(grep -c -E "^### Client ${CLIENT_NAME}\$" "/etc/wireguard/${SERVER_WG_NIC}.conf")

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "Ya se ha creado un cliente con el nombre especificado, elija otro nombre."
			echo ""
		fi
	done

	for DOT_IP in {2..254}; do
		DOT_EXISTS=$(grep -c "${SERVER_WG_IPV4::-1}${DOT_IP}" "/etc/wireguard/${SERVER_WG_NIC}.conf")
		if [[ ${DOT_EXISTS} == '0' ]]; then
			break
		fi
	done

	if [[ ${DOT_EXISTS} == '1' ]]; then
		echo ""
		echo "A sub-rede configurada suporta apenas 253 clientes."
		exit 1
	fi

	BASE_IP=$(echo "$SERVER_WG_IPV4" | awk -F '.' '{ print $1"."$2"."$3 }')
	until [[ ${IPV4_EXISTS} == '0' ]]; do
		read -rp "Cliente WireGuard IPv4: ${BASE_IP}." -e -i "${DOT_IP}" DOT_IP
		CLIENT_WG_IPV4="${BASE_IP}.${DOT_IP}"
		IPV4_EXISTS=$(grep -c "$CLIENT_WG_IPV4/24" "/etc/wireguard/${SERVER_WG_NIC}.conf")

		if [[ ${IPV4_EXISTS} == '1' ]]; then
			echo ""
			echo "Ya se ha creado un cliente con el IPv4 especificado, elija otro IPv4."
			echo ""
		fi
	done

	BASE_IP=$(echo "$SERVER_WG_IPV6" | awk -F '::' '{ print $1 }')
	until [[ ${IPV6_EXISTS} == '0' ]]; do
		read -rp "WireGuard IPv6 do cliente: ${BASE_IP}::" -e -i "${DOT_IP}" DOT_IP
		CLIENT_WG_IPV6="${BASE_IP}::${DOT_IP}"
		IPV6_EXISTS=$(grep -c "${CLIENT_WG_IPV6}/64" "/etc/wireguard/${SERVER_WG_NIC}.conf")

		if [[ ${IPV6_EXISTS} == '1' ]]; then
			echo ""
			echo "Ya se ha creado un cliente con el IPv6 especificado, elija otro IPv6."
			echo ""
		fi
	done

	# Generate key pair for the client
	CLIENT_PRIV_KEY=$(wg genkey)
	CLIENT_PUB_KEY=$(echo "${CLIENT_PRIV_KEY}" | wg pubkey)
	CLIENT_PRE_SHARED_KEY=$(wg genpsk)

	# Home directory of the user, where the client configuration will be written
	if [ -e "/home/${CLIENT_NAME}" ]; then
		# if $1 is a user name
		HOME_DIR="/home/${CLIENT_NAME}"
	elif [ "${SUDO_USER}" ]; then
		# if not, use SUDO_USER
		if [ "${SUDO_USER}" == "root" ]; then
			# If running sudo as root
			HOME_DIR="/root"
		else
			HOME_DIR="/home/${SUDO_USER}"
		fi
	else
		# if not SUDO_USER, use /root
		HOME_DIR="/root"
	fi

	# Create client file and add the server as a peer
	echo "[Interface]
PrivateKey = ${CLIENT_PRIV_KEY}
Address = ${CLIENT_WG_IPV4}/32,${CLIENT_WG_IPV6}/128
DNS = ${CLIENT_DNS_1},${CLIENT_DNS_2}

[Peer]
PublicKey = ${SERVER_PUB_KEY}
PresharedKey = ${CLIENT_PRE_SHARED_KEY}
Endpoint = ${ENDPOINT}
AllowedIPs = 0.0.0.0/0,::/0" >>"${HOME_DIR}/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf"

	# Add the client as a peer to the server
	echo -e "\n### Client ${CLIENT_NAME}
[Peer]
PublicKey = ${CLIENT_PUB_KEY}
PresharedKey = ${CLIENT_PRE_SHARED_KEY}
AllowedIPs = ${CLIENT_WG_IPV4}/32,${CLIENT_WG_IPV6}/128" >>"/etc/wireguard/${SERVER_WG_NIC}.conf"

	wg syncconf "${SERVER_WG_NIC}" <(wg-quick strip "${SERVER_WG_NIC}")

	echo -e "\nAqui está o arquivo de configuração do seu cliente como um código QR:"

	qrencode -t ansiutf8 -l L <"${HOME_DIR}/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf"

	echo "Também está disponível em ${HOME_DIR}/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf"
	cp ${HOME_DIR}/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf /var/www/html/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf
	echo -e " ==================================================="
	echo ""
	echo -e " URL WEB : http://$(wget -qO- ifconfig.me):81/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf"
	echo -e ""
	echo -e " ==================================================="
	
}

function revokeClient() {
	NUMBER_OF_CLIENTS=$(grep -c -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "¡No tienes clientes existentes!"
		#exit 1
	fi

	echo ""
	echo "Seleccione el cliente existente que desea revocar"
	grep -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf" | cut -d ' ' -f 3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Selecione un cliente [1]: " CLIENT_NUMBER
		else
			read -rp "Selecione un cliente [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done

	# match the selected number to a client name
	CLIENT_NAME=$(grep -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

	# remove [Peer] block matching $CLIENT_NAME
	sed -i "/^### Client ${CLIENT_NAME}\$/,/^$/d" "/etc/wireguard/${SERVER_WG_NIC}.conf"

	# remove generated client file
	rm -f "${HOME}/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf"

	# restart wireguard to apply changes
	wg syncconf "${SERVER_WG_NIC}" <(wg-quick strip "${SERVER_WG_NIC}")
}

function uninstallWg() {
	echo ""
	read -rp "¿Realmente desea eliminar WireGuard? [y/n]: " -e -i n REMOVE
	if [[ $REMOVE == 'y' ]]; then
		checkOS

		systemctl stop "wg-quick@${SERVER_WG_NIC}"
		systemctl disable "wg-quick@${SERVER_WG_NIC}"

		if [[ ${OS} == 'ubuntu' ]]; then
			apt-get autoremove --purge -y wireguard qrencode
		elif [[ ${OS} == 'debian' ]]; then
			apt-get autoremove --purge -y wireguard qrencode
		elif [[ ${OS} == 'fedora' ]]; then
			dnf remove -y wireguard-tools qrencode
			if [[ ${VERSION_ID} -lt 32 ]]; then
				dnf remove -y wireguard-dkms
				dnf copr disable -y jdoss/wireguard
			fi
			dnf autoremove -y
		elif [[ ${OS} == 'centos' ]]; then
			yum -y remove kmod-wireguard wireguard-tools qrencode
			yum -y autoremove
		elif [[ ${OS} == 'oracle' ]]; then
			yum -y remove wireguard-tools qrencode
			yum -y autoremove
		elif [[ ${OS} == 'arch' ]]; then
			pacman -Rs --noconfirm wireguard-tools qrencode
		fi

		rm -rf /etc/wireguard
		rm -f /etc/sysctl.d/wg.conf

		# Reload sysctl
		sysctl --system

		# Check if WireGuard is running
		systemctl is-active --quiet "wg-quick@${SERVER_WG_NIC}"
		WG_RUNNING=$?

		if [[ ${WG_RUNNING} -eq 0 ]]; then
			echo "WireGuard no se pudo desinstalar correctamente."
			exit 1
		else
			echo "WireGuard desinstalado con exito."
			exit 0
		fi
	else
		echo ""
		echo "Eliminación abortada!"
	fi
}

function manageMenu() {
	echo "¡Bienvenido a la instalación de WireGuard!"
	#echo "El repositorio git está disponible en: https://github.com/leitura/wireguard-install"
	echo ""
	echo "Parece que WireGuard ya está instalado."
	echo ""
	echo " ¿Qué quieres hacer?"
	echo " 1) Agregar un nuevo usuario"
	echo " 2) Revocar usuario existente"
	echo " 3) Desinstalar WireGuard"
	echo " 4) Salir"
	until [[ ${MENU_OPTION} =~ ^[1-4]$ ]]; do
		read -rp "Selecione uma opcion [1-4]: " MENU_OPTION
	done
	case "${MENU_OPTION}" in
	1)
		newClient
		;;
	2)
		revokeClient
		;;
	3)
		uninstallWg
		;;
	4)
		exit 0
		;;
	esac
}

# Check for root, virt, OS...
initialCheck

# Check if WireGuard is already installed and load params
if [[ -e /etc/wireguard/params ]]; then
	source /etc/wireguard/params
	manageMenu
else
	installWireGuard
fi
