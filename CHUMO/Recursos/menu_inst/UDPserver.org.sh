#!/bin/bash  
clear  
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg > /dev/null || source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar/msg) > /dev/null

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m ► Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

os_system(){ 
 system=$(cat -n /etc/issue |grep 1 |cut -d ' ' -f6,7,8 |sed 's/1//' |sed 's/      //') 
 distro=$(echo "$system"|awk '{print $1}') 
 case $distro in 
 Debian) vercion=$(echo $system|awk '{print $3}'|cut -d '.' -f1);; 
 Ubuntu) vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2);; 
 esac 
 }

download_udpServer(){
	msg -nama '        Descargando binario UDPserver ----'
	if wget -O /usr/bin/udpServer 'https://bitbucket.org/iopmx/udprequestserver/downloads/udpServer' &>/dev/null ; then
		chmod +x /usr/bin/udpServer
		msg -verd 'OK'
	else
		msg -verm2 'fail'
		rm -rf /usr/bin/udpServer*
	fi
chekKEY &> /dev/null 2>&1	
make_service
}

function chekKEY {
[[ -z ${IP} ]] && IP=$(cat < /bin/ejecutar/IPcgh)
Key="$(cat /etc/cghkey)"
_Key='/etc/cghkey'
[[ -e /file ]] && _double=$(cat < /file) ||  {
wget -q -O /file https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Control/Control-Bot.txt
_double=$(curl -sSL "https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Control/Control-Bot.txt")
}
IiP="$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"
_check2="$(echo -e "$_double" | grep ${IiP} | awk '{print $1}')"
[[ -z ${_check2} ]] && {
mss_='\n BotGEN NO AUTORIZADO POR @ChumoGH '
rm -f /etc/folteto
rm -rf /etc/adm-lite/*
}
[[ ! -e /etc/folteto ]] && {
wget --no-check-certificate -O /etc/folteto $IiP:81/ChumoGH/checkIP.log 
cheklist="$(cat /etc/folteto)"
echo -e "$(echo -e "$cheklist" | grep ${IP})" > /etc/folteto
}
cheklist="$(cat /etc/folteto)"
chekKEY="$(echo -e "$cheklist" | grep ${Key} | awk '{print $5}')"
chekIP="$(echo -e "$cheklist" | grep ${IP} | awk '{print $3}')"
[[ -z ${chekKEY} || -z ${chekIP} ]] && {
xyz=$(curl -sSL "https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Control/token.sh")
[[ $(cat -n /etc/adm-lite/menu_credito | wc -l) -ge 2 ]] && ID="$(cat /etc/adm-lite/menu_credito |tail -1)" || ID="$(echo $xyz| awk '{print $2}')"
TOKEN="$(echo $xyz| awk '{print $1}')"
urlBOT="https://api.telegram.org/bot$TOKEN/sendMessage"
echo 'clear&&clear
echo -e "\n\n\n \033[0;31m ==================================================
   ¡ ${lLaM} KEY BANEADA POR ABUSO DE DATOS  🚫 ! CONTACTE Su ADMINISTRADOR
   ${mss_}
 ================================================== \n\n
  SI ESTO FUE UN ERROR - TECLEA ** cgh ** \n\n" 
' > /bin/menu 
[[ ! -d /etc/banned ]] && mkdir /etc/banned 
chmod +x /bin/menu 
mv /etc/adm-lite/menu /etc/banned/ 
mv /etc/adm-lite/usercodes /etc/banned/ 
[[ ! -e ${_Key} ]] && {
rm -f /etc/folteto
rm -rf /etc/adm-lite/*
}
rm -f /etc/folteto
 			MENSAJE="${TTini}${m3ssg}MSG RECIVIDO${m3ssg}${TTfin}\n"
			MENSAJE+="$(msg -br)\n"
			MENSAJE+=" IP Clon: ${IP} Rechazada\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" ${lLaM} INSECTO DETECTADO EN UDPServer ${lLaM}\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+="       ${rUlq} Bot generador de key ${rUlq}\n"
			MENSAJE+="           ${pUn5A} By @ChumoGH ${pUn5A} \n"
			MENSAJE+=" ---------------------------------------------\n"	
			curl -s --max-time 10 -d "chat_id=$ID&disable_web_page_preview=1&text=$(echo -e "$MENSAJE")" $urlBOT &>/dev/null 	
exit && exit
}
}

_mssBOT () {
xyz=$(curl -sSL "https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Control/token.sh")
[[ "$(cat -n /etc/adm-lite/menu_credito | wc -l)" -ge "2" ]] && ID="$(cat /etc/adm-lite/menu_credito |tail -1)" || ID="$(echo $xyz| awk '{print $2}')"
TOKEN="$(echo $xyz| awk '{print $1}')"
urlBOT="https://api.telegram.org/bot$TOKEN/sendMessage"
data=$1
MENSAJE="${TTini}${m3ssg}MSG RECIVIDO${m3ssg}${TTfin}\n"
			MENSAJE+="$(msg -br)\n"
			MENSAJE+=" SERVICIO udpServer| $data \n"
			MENSAJE+=" IP : $(wget -qO- ifconfig.me) \n"
			MENSAJE+="$(msg -br)\n"
			MENSAJE+=" KEY : $(cat /etc/cghkey)\n"
			MENSAJE+="$(msg -br)\n"
			MENSAJE+=" HORA : $(printf '%(%D-%H:%M:%S)T')\n"
			MENSAJE+="       ${rUlq} Bot generador de key ${rUlq}\n"
			MENSAJE+="           ${pUn5A} By @ChumoGH ${pUn5A} \n"
			MENSAJE+="$(msg -br)\n"	
curl -s --max-time 10 -d "chat_id=$ID&disable_web_page_preview=1&text=$(echo -e "$MENSAJE")" $urlBOT &>/dev/null 	
}


make_service(){
	ip_nat=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n 1p)
	interfas=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}'|grep "$ip_nat"|awk {'print $NF'})
	ip_publica=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")

	#ip_nat=$(fun_ip nat)
	#interfas=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}'|grep "$ip_nat"|awk {'print $NF'})
	#ip_publica=$(fun_ip)
	msg -nama '        Ejecutando servicio UDPserver .....'
	if screen -dmS UDPserver /usr/bin/udpServer -ip=$ip_publica -net=$interfas -mode=system &>/dev/null ; then
		msg -verd 'OK'
		_mssBOT "ACTIVADO!!"
	else
		msg -verm2 'fail'
		_mssBOT " FALLIDO!!"
	fi
}

 
  reset_slow(){
  clear
  msg -bar
  msg -ama "        Reiniciando UDPserver...."
  screen -ls | grep UDPserver | cut -d. -f1 | awk '{print $1}' | xargs kill
  if screen -dmS UDPserver /usr/bin/udpServer -ip=$ip_publica -net=$interfas -mode=system ;then
  msg -verd "        Con exito!!!"    
  _mssBOT "REINICIADO!!"
  msg -bar
  else    
  msg -verm "        Con fallo!!!"    
  msg -bar
  fi
  read -p "ENTER PARA CONTINUAR"
  }  
  
  stop_slow(){
  clear
  msg -bar
  msg -ama "        Deteniendo UDPserver...."
  if screen -ls | grep UDPserver | cut -d. -f1 | awk '{print $1}' | xargs kill ; then
  msg -verd "         Con exito!!!"   msg -bar
  else
  msg -verm "        Con fallo!!!"    msg -bar
  fi
  read -p "ENTER PARA CONTINUAR"
  }    
  
  remove() {
  stop_slow
  rm -f /usr/bin/udpServer*
  _mssBOT "REMOVIDO!!"
  }
  
  info() {
  msg -bar
  echo
  msg -ama "         INSTALADOR UDPserver | @ChumoGH•Plus"
  echo 
  msg -bar
  msg -ama "         SOURCE OFICIAL DE NewToolWorks"
  echo -e "      https://bitbucket.org/iopmx/udprequestserver/src/master/"
  msg -bar
  msg -ama "         URL DE APP OFICIAL "
  echo -e "https://play.google.com/store/apps/details?id=com.newtoolsworks.sockstunnel"
  msg -bar
  msg -ama "         CODIGO REFACTORIZADO POR @ChumoGH"
  msg -bar
  read -p " PRESIONA ENTER PARA CONTINUAR"
  clear
  }
os_system
  
while : 
do
  [[ $(ps x | grep udpServer| grep -v grep) ]] && _pid="\033[1;32m[ON]" || _pid="\033[1;31m[OFF]"
  tittle
  msg -ama "         BINARIO OFICIAL DE NewToolWorks"

[[ $(echo -e "${vercion}") < 20  ]] && {
msg -bar
echo -e "\e[1;31m  SISTEMA:  \e[33m$distro $vercion \e[1;31m	CPU:  \e[33m$(lscpu | grep "Vendor ID" | awk '{print $3}')" 
echo -e " "
echo -e "  UTILIZA LAS VARIANTES MENCIONADAS DENTRO DEL MENU "
echo ""
msg -ama "        SE RECOMIENDA USAR UBUNTU 20.04 "
echo ""
msg -ama "                  O SUPERIOR"
echo ""
echo -e "         [ ! ]  Power by @ChumoGH  [ ! ]"
echo ""
msg -bar
read -p " PRESIONA ENTER PARA CONTINUAR"
return
}
  msg -bar
  msg -ama "         INSTALADOR UDPserver | @ChumoGH•Plus"
  msg -bar
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {

msg -ama "    BINARIO NO COMPATIBLE CON PLATAFORMAS ARM "
echo ""
echo -e "		[ ! ]  Power by @ChumoGH  [ ! ]"
echo ""
msg -bar
read -p " PRESIONA ENTER PARA CONTINUAR"
return
}
  menu_func "Instalar UDPserver $_pid" "$(msg -ama "Reiniciar UDPserver")" "$(msg -verm2 "Detener UDPserver")" "$(msg -verm2 "Remover UDPserver")" "$(msg -ama "Info de Proyecto")"
  msg -bar
  echo -ne "$(msg -verd "  [0]") $(msg -verm2 "=>>") " && msg -bra "\033[1;41m Volver "
  msg -bar
  opcion=$(selection_fun 6)  
  case $opcion in
  1)download_udpServer;;
  2)reset_slow;;
  3)stop_slow;;
  4)remove;;
  5)info;;
  0)exit;;
  esac  
done
