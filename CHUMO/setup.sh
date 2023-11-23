#CREADOR Henry Chumo | 25/08/2022
# UPDATE  | 20/08/2023
#Alias : @ChumoGH
# -*- ENCODING: UTF-8 -*-

apt --fix-broken install
dpkg --configure -a
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games;
fecha=`date +"%d-%m-%y"`;
SCPdir="/etc/adm-lite"
SCPinstal="$HOME/install"

rm -f instala.*
[[ -e /etc/folteto ]] && rm -f /etc/folteto
[[ -e /bin/ejecutar/IPcgh ]] && rm -f /bin/ejecutar/IPcgh
[[ ! -z $1 ]] && {
[[ "$1" == '--ADMcgh' ]] && echo -e " ESPERE UN MOMENTO $1" || {

exit&&exit
}
rm -f wget*
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
dpkg-reconfigure --frontend noninteractive tzdata >/dev/null 2>&1
[[ $(dpkg --get-selections|grep -w "sudo"|head -1) ]] || apt install sudo -y &> /dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "uuid-runtime"|head -1) ]] || apt-get install uuid-runtime -y &>/dev/null
source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar/msg)
_double=$(curl -sSL "https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Control/Control-Bot.txt")
COLS=$(tput cols)
os_system(){ 
 system=$(cat -n /etc/issue |grep 1 |cut -d ' ' -f6,7,8 |sed 's/1//' |sed 's/      //') 
 distro=$(echo "$system"|awk '{print $1}') 
 case $distro in 
 Debian) vercion=$(echo $system|awk '{print $3}'|cut -d '.' -f1);; 
 Ubuntu) vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2);; 
 esac 
 link="https://raw.githubusercontent.com/emirjorge/Script-Z/master/Repositorios/${vercion}.list" 
 #case $vercion in 
 #8|9|10|11|16.04|18.04|20.04|20.10|21.04|21.10|22.04)wget -O /etc/apt/sources.list ${link} &>/dev/null;; 
 #esac 
 }


#PRUEBA DE MODULOS BETA A ELIMINAR EN UPDATE V5.2

rutaSCRIPT () {
rm -f setup*
act_ufw() {
[[ -f "/usr/sbin/ufw" ]] && ufw allow 81/tcp ; ufw allow 8888/tcp
}
#[[ -z $(cat /etc/resolv.conf | grep "8.8.8.8") ]] && echo "nameserver	8.8.8.8" >> /etc/resolv.conf
#[[ -z $(cat /etc/resolv.conf | grep "1.1.1.1") ]] && echo "nameserver	1.1.1.1" >> /etc/resolv.conf
cd $HOME
fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

fun_install () {
clear
[[ -z ${IP} ]] && IP=$(wget -qO- ifconfig.me)
#Key="$(cat /etc/cghkey)"
Key="$1"
IiP="$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"
[[ ! -e /file ]] && wget -q -O /file https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Control/Control-Bot.txt
_double=$(cat < /file)
_check2="$(echo -e "$_double" | grep ${IiP})"
[[ -z ${_check2} ]] && {
invalid_key '--ban'
} || {
[[ -e /etc/adm-lite/cabecalho ]] && source <(curl -sSL 'https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Complementos/BaseInstall') '--finish'
#[[ -e /etc/adm-lite/cabecalho ]] && source autoStart.sh '--finish'
}
msg -bar3
cd $HOME
[[ -e $HOME/lista ]] && rm -f $HOME/lista*
[[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal} 
}
## root check
if ! [ $(id -u) = 0 ]; then
clear
		echo ""
		echo " ===================================================="
		echo " 	           	�21�21�21     Error Fatal!! x000e1  �21�21�21"
		echo " ===================================================="
		echo "                    �40 Este script debe ejecutarse como root! �40"

		echo "                              Como Solucionarlo "
		
		echo "                            Ejecute el script as�:"
		echo "                               �30     �31 "
		echo "                                (  sudo -i )"
		echo "                                   sudo su"
		echo "                                 Retornando . . ."
		echo $(date)
		exit
fi


function_verify () {
echo "verify" > $(echo -e $(echo 2f62696e2f766572696679737973|sed 's/../\\x&/g;s/$/ /'))
echo 'MOD @ChumoGH ChumoGHADM' > $(echo -e $(echo 2F7573722F6C69622F6C6963656E6365|sed 's/../\\x&/g;s/$/ /'))
[[ $(dpkg --get-selections|grep -w "libpam-cracklib"|head -1) ]] || apt-get install libpam-cracklib -y &> /dev/null
echo -e '# Modulo @ChumoGH
password [success=1 default=ignore] pam_unix.so obscure sha512
password requisite pam_deny.so
password required pam_permit.so' > /etc/pam.d/common-password && chmod +x /etc/pam.d/common-password
# - Deshabilitamos ipv6 permantente
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -p
echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.d/70-disable-ipv6.conf
sysctl -p -f /etc/sysctl.d/70-disable-ipv6.conf
}

verificar_arq () {
[[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
mv -f ${SCPinstal}/$1 ${SCPdir}/$1 && chmod +x ${SCPdir}/$1
}
fun_ip

error_conex () {
[[ -e $HOME/lista-arq ]] && list_fix="$(cat < $HOME/lista-arq)" || list_fix=""
msg -bar3 
echo -e "\033[41m     --      SISTEMA ACTUAL $(lsb_release -si) $(lsb_release -sr)      --"
[[ "$list_fix" = "" ]] && {
msg -bar3 
echo -e " ERROR (PORT 8888 TCP) ENTRE GENERADOR <--> VPS "
echo -e "    NO EXISTE CONEXION ENTRE EL GENERADOR "
echo -e "  - \e[3;32mGENERADOR O KEYGEN COLAPZADO\e[0m - "
msg -bar3
echo -e "  - DIRIGETE AL BOT Y ESCRIBE /restart "
echo -e "  - Y REINTENTA NUEVAMENTE CON SU KEY "
msg -bar3
}
invalid_key
}

invalid_key () {
[[ $1 == '--ban' ]] && {
cd $HOME 
service ssh stop
[[ -e ${SCPinstal} ]] && rm -rf ${SCPinstal}
[[ -d $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -d ${SCPdir} ]] && rm -rf ${SCPdir}
[[ -d $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -e /bin/menu ]] && rm /bin/menu
[[ -e $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -e $HOME/log.txt ]] && rm -f $HOME/log.txt
[[ -e /bin/troj.sh ]] && rm -f /bin/troj.sh
[[ -e /bin/v2r.sh ]] && rm -f /bin/v2r.sh
[[ -e /bin/clash.sh ]] && rm -f /bin/clash.sh
rm -f instala.*  > /dev/null
rm -f /bin/cgh > /dev/null
rm -rf /bin/ejecutar > /dev/null
figlet " Key Invalida" | boxes -d stone -p a2v1 > error.log
msg -bar3 >> error.log
echo "  KEY NO PERMITIDA, ADQUIERE UN RESELLER OFICIAL" >> error.log
echo "  ----------------------------------------------" >> error.log
echo "  KEY NO PERMITIDA, ADQUIERE UN RESELLER OFICIAL" >> error.log
echo "  ----------------------------------------------" >> error.log
echo -e ' https://t.me/ChumoGH  - @ChumoGH' >> error.log
msg -bar3 >> error.log
cat error.log | lolcat
exit&&exit&&exit&&exit
}
[[ -e $HOME/lista-arq ]] && list_fix="$(cat < $HOME/lista-arq)" || list_fix=''
echo -e ' '
msg -bar3 
#echo -e "\033[41m     --      SISTEMA ACTUAL $(lsb_release -si) $(lsb_release -sr)      --"
echo -e " \033[41m-- CPU :$(lscpu | grep "Vendor ID" | awk '{print $3}') SISTEMA : $(lsb_release -si) $(lsb_release -sr) --"
[[ "$list_fix" = "" ]] && {
msg -bar3 
echo -e " ERROR (PORT 8888 TCP) ENTRE GENERADOR <--> VPS "
echo -e "    NO EXISTE CONEXION ENTRE EL GENERADOR "
echo -e "  - \e[3;32mGENERADOR O KEYGEN COLAPSADO\e[0m - "
msg -bar3
echo -e "  - DIRIGETE AL BOT Y ESCRIBE /restart "
echo -e "  - Y REINTENTA NUEVAMENTE CON SU KEY "
msg -bar3
}
[[ "$list_fix" = "KEY INVALIDA!" ]] && {
IiP="$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"
cheklist="$(curl -sSL $IiP:81/ChumoGH/checkIP.log)"
chekIP="$(echo -e "$cheklist" | grep ${Key} | awk '{print $3}')"
chekDATE="$(echo -e "$cheklist" | grep ${Key} | awk '{print $7}')"
msg -bar3
echo ""
[[ ! -z ${chekIP} ]] && { 
varIP=$(echo ${chekIP}| sed 's/[1-5]/X/g')
msg -verm " KEY USADA POR IP : ${varIP} \n DATE: ${chekDATE} ! "
echo ""
msg -bar3
} || {
echo -e "    PRUEBA COPIAR BIEN TU KEY "
[[ $(echo "$(ofus "$Key"|cut -d'/' -f2)" | wc -c ) = 18 ]] && echo -e "" || echo -e "\033[1;31m CONTENIDO DE LA KEY ES INCORRECTO"
echo -e "   KEY NO COINCIDE CON EL CODEX DEL ADM "
msg -bar3
tput cuu1 && tput dl1
}
}
msg -bar3
[[ $(echo "$(ofus "$Key"|cut -d'/' -f2)" | wc -c ) = 18 ]] && echo -e "" || echo -e "\033[1;31m CONTENIDO DE LA KEY ES INCORRECTO"
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
cd $HOME 
[[ -e ${SCPinstal} ]] && rm -rf ${SCPinstal}
[[ -d $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -d ${SCPdir} ]] && rm -rf ${SCPdir}
[[ -d $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -e /bin/menu ]] && rm /bin/menu
[[ -e $HOME/chumogh ]] && rm -rf $HOME/chumogh
[[ -e $HOME/log.txt ]] && rm -f $HOME/log.txt
[[ -e /bin/troj.sh ]] && rm -f /bin/troj.sh
[[ -e /bin/v2r.sh ]] && rm -f /bin/v2r.sh
[[ -e /bin/clash.sh ]] && rm -f /bin/clash.sh
rm -f instala.*  > /dev/null
rm -f /bin/cgh > /dev/null
rm -rf /bin/ejecutar > /dev/null
figlet " Key Invalida" | boxes -d stone -p a2v1 > error.log
msg -bar3 >> error.log
echo "  Key Invalida, Contacta con tu Provehedor" >> error.log
echo -e ' https://t.me/ChumoGH  - @ChumoGH' >> error.log
msg -bar3 >> error.log
cat error.log | lolcat
#msg -bar3
echo -e "    \033[1;44m  Deseas Reintentar con OTRA KEY\033[0;33m  :v"
echo -ne "\033[0;32m "
read -p "  Responde [ s | n ] : " -e -i "n" x
[[ $x = @(s|S|y|Y) ]] && funkey || {
exit&&exit
}
}

funkey () {
unset Key
while [[ ! $Key ]]; do
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
#[[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp ; ufw allow 81/tcp ; ufw allow 8888/tcp
clear
 
fun_ip
declare -A cpu_model=$(uname -m)
[[ $cpu_model = "aarch64" ]] && cpu_model=" ARM64 Pro" || cpu_model=$(lscpu | grep "Vendor ID" | awk '{print $3}')
_sys="$(lsb_release -si)-$(lsb_release -sr)"
msg -bar3 
echo -e "   \033[41m- CPU: \033[100m${cpu_model}\033[41m SISTEMA : \033[100m${_sys}\033[41m -\033[0m"
msg -bar3 
echo -e "  ${FlT}${rUlq} ADMcgh Plus $(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/version/v-new.log) | @ChumoGH OFICIAL 2023 ${rUlq}${FlT}  -" | lolcat
msg -bar3
figlet ' . ADMcgh . ' | boxes -d stone -p a0v0 | lolcat
echo "           PEGA TU KEY DE INSTALACION " | lolcat
echo -ne " " && msg -bar3
echo -ne " \033[1;41m Key : \033[0;33m" && read Key
tput cuu1 && tput dl1
done
Key="$(echo "$Key" | tr -d '[[:space:]]')"
cd $HOME
IiP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
_checkBT="$(echo -e "$_double"|grep "$IiP")"
new_id=$(uuidgen) 
[[ -z ${new_id} ]] && new_id="${_checkBT}-no-uuid"
[[ $(curl -s --connect-timeout 5 $IiP:8888) ]] && {
tput cuu1 && tput dl1
msg -bar3
echo -ne " \e[90m\e[43m CHEK KEY : \033[0;33m"
echo -e " \e[3;32m ENLAZADA AL GENERADOR\e[0m" | pv -qL 50
tput cuu1 && tput dl1
msg -bar3
echo -ne " \033[1;41m ESTAUS : \033[0;33m"
tput cuu1 && tput dl1
echo -ne "\033[1;34m [ \e[3;32m VALIDANDO CONEXION \e[0m \033[1;34m]\033[0m"
if wget --no-check-certificate -O $HOME/lista-arq $(ofus "$Key")/$IP/$_sys/${new_id}  &>/dev/null ; then
echo -e "\033[1;34m [ \e[3;32m DONE \e[0m \033[1;34m]\033[0m"
else
echo -e "\033[1;34m [ \e[3;31m FAIL \e[0m \033[1;34m]\033[0m"
invalid_key && exit
fi
#SE CREA ID KERNEL DE VERIFICACION EN BINARIOS DE MODULOS UNICOS
echo "${new_id}" > /linux-kernel
#FIN DE CREACION DE ID KERNEL DE VERIFICACION EN BINARIOS DE MODULOS
[[ -d /etc/adm-lite/userDIR/ ]] && {
mkdir /USERS &>/dev/null
mv /etc/adm-lite/userDIR/* /USERS/
}
if [ -z "${_checkBT}" ]; then
	#[[ -z ${_checkBT} ]] && {
		rm -f $HOME/lista*
		tput cuu1 && tput dl1
		echo -e "\n\e[3;31mRECHAZADA, POR GENERADOR NO AUTORIZADO!!\e[0m\n" && sleep 1s
		echo
		echo -e "\e[3;31mESTE USUARIO NO ESTA AUTORIZADO !!\e[0m" && sleep 1s
		invalid_key "--ban"
		exit
		tput cuu1 && tput dl1
fi
} || {
	echo -e "\e[3;31mCONEXION FALLIDA\e[0m" && sleep 1s
	invalid_key && exit
}

helice() {
		downloader_files >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
}
sleep 1s
tput cuu1 && tput dl1
downloader_files() {
[[ -e $HOME/log.txt ]] && rm -f $HOME/log.txt
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   for arqx in $(cat $HOME/lista-arq); do
   wget --no-check-certificate -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}" 
   done
}
echo -ne "\033[1;37m COMPILANDO SCRIPT VIA\033[1;32m \033[1;37mHTTPS \033[1;32m127.0.0.1:85\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
echo -e "\e[1DOk"
msg -bar3
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
[[ -e ${SCPdir}/cabecalho ]] && {
echo $Key > /etc/cghkey
clear
rm -f $HOME/log.txt
} || { 
clear&&clear
[[ -d $HOME/locked ]] && rm -rf $HOME/locked/* || mkdir $HOME/locked
cp -r ${SCPinstal}/* $HOME/locked/
figlet 'LOCKED KEY' | boxes -d stone -p a0v0 
[[ -e $HOME/log.txt ]] && ff=$(cat < $HOME/log.txt | wc -l) || ff='ALL'
 msg -ne " ${aLerT} "
echo -e "\033[1;31m [ $ff FILES DE KEY BLOQUEADOS ] " | pv -qL 50 && msg -bar3
echo -e " APAGA TU CORTAFUEGOS O HABILITA PUERTO 81 Y 8888"
echo -e "   ---- AGREGANDO REGLAS AUTOMATICAS ----"
act_ufw
echo -e "   Si esto no funciona PEGA ESTOS COMANDOS  " 
echo -e "   sudo ufw allow 81 && sudo ufw allow 8888 "
msg -bar3 
echo -e "             sudo apt purge ufw -y"
   invalid_key && exit
}
[[ -d /etc/alx ]] || mkdir /etc/alx
[[ -e /etc/folteto ]] && rm -f /etc/folteto
[[ -e /bin/ejecutar/IPcgh ]] && rm -f /bin/ejecutar/IPcgh
msg -bar3
killall apt apt-get &> /dev/null
function_verify
fun_install "${Key}"
else
invalid_key
fi
sudo sync 
echo 3 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=3 > /dev/null 2>&1
}
funkey
}

ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".") txt[$i]="x";;
"x") txt[$i]=".";;
"5") txt[$i]="s";;
"s") txt[$i]="5";;
"1") txt[$i]="@";;
"@") txt[$i]="1";;
"2") txt[$i]="?";;
"?") txt[$i]="2";;
"4") txt[$i]="0";;
"0") txt[$i]="4";;
"/") txt[$i]="K";;
"K") txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}

function printTitle
{
    echo ""
    echo -e "\033[1;92m$1\033[1;91m"
    printf '%0.s-' $(seq 1 ${#1})
    echo ""
}
killall apt apt-get &> /dev/null
TIME_START="$(date +%s)"
DOWEEK="$(date +'%u')"
[[ -e $HOME/cgh.sh ]] && rm $HOME/cgh.*

fun_bar () {
comando[0]="$1"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 0.5s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

msg -bar3
printTitle " ORGANIZANDO INTERFAZ DEL INSTALADOR "
echo ""
update_pak () {
echo "" 
[[ $(dpkg --get-selections|grep -w "pv"|head -1) ]] || apt install pv -y &> /dev/null 
os_system 
echo -e "		[ ! ]  ESPERE UN MOMENTO  [ ! ]"
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || apt-get install lolcat -y &>/dev/null 
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install  -y &>/dev/null
echo ""
msg -bar3
[[ $(echo -e "${vercion}" | grep -w "22.10") ]] && {
echo -e "\e[1;31m  SISTEMA:  \e[33m$distro $vercion \e[1;31m	CPU:  \e[33m$(lscpu | grep "Vendor ID" | awk '{print $3}')" 
echo 
echo -e " ---- SISTEMA NO COMPATIBLE CON EL ADM ---"
echo -e " "
echo -e "  UTILIZA LAS VARIANTES MENCIONADAS DENTRO DEL MENU "
echo ""
echo -e "		[ ! ]  Power by @ChumoGH  [ ! ]"
echo ""
msg -bar3
exit && exit
}
echo -e "\e[1;31m  SISTEMA:  \e[33m$distro $vercion \e[1;31m	CPU:  \e[33m$(lscpu | grep "Vendor ID" | awk '{print $3}')" 
msg -bar3
dpkg --configure -a > /dev/null 2>&1 && echo -e "\033[94m    ${TTcent} INTENTANDO RECONFIGURAR UPDATER ${TTcent}" | pv -qL 80
msg -bar3
echo -e "\033[94m    ${TTcent} UPDATE DATE : $(date +"%d/%m/%Y") & TIME : $(date +"%H:%M") ${TTcent}" | pv -qL 80
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get install net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "boxes"|head -1) ]] || apt-get install boxes -y &>/dev/null
msg -bar3
apt-get install software-properties-common -y > /dev/null 2>&1 && echo -e "\033[94m    ${TTcent} INSTALANDO NUEVO PAQUETES ( S|P|C )    ${TTcent}" | pv -qL 80
msg -bar3
echo -e "\033[94m    ${TTcent} PREPARANDO BASE RAPIDA INSTALL    ${TTcent}" | pv -qL 80 
msg -bar3
echo -e "\033[94m    ${TTcent} CHECK IP FIJA $(wget -qO- ifconfig.me)    ${TTcent}" | pv -qL 80 
msg -bar3
echo " "
sleep 2s
#[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y -qq --silent &>/dev/null
clear&&clear
rm $(pwd)/$0 &> /dev/null 
return
}
clear&&clear
update_pak
clear&&clear
rutaSCRIPT ${distro} ${vercion}
rm -f instala.* lista*
echo -e " TIEMPO DE EJECUCION $((($(date +%s)-$TIME_START)/60)) min."
[[ -z $_TIME_START ]] || {
while true; do
read -p " ENTER PARA IR AL MENU"
[[ -d /USERS ]] && mv /USERS/* /etc/adm-lite/userDIR/ && rm -rf /USERS
[[ "$((($(date +%s)-$_TIME_START)/60))" -ge "2" ]] && break
sleep 0.5s
echo -e " TIEMPO DE INSTALACION $((($(date +%s)-$_TIME_START)/60)) min."
tput cuu1 && tput dl1
tput cuu1 && tput dl1
done
}
#chekKEY
[[ -e "$(which cgh)" ]] && $(which cgh) || echo -e " INSTALACION NO COMPLETADA CON EXITO !"
} || {
echo -e " NO SE RECIBIÓ PARÁMETROS "
rm -f setup*
rm -f /etc/folteto
}
