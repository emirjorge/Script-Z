#!/bin/bash
#By @ChumoGH|Plus
#Autor: Henry Chumo 
#Alias : ChumoGH

#DE FELICIDAD LANZA EN SUS GitHub LOS CODIGOS LIBRES

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
 


clear
function chekKEY {
[[ -z ${IP} ]] && IP=$(cat < /bin/ejecutar/IPcgh)
[[ -z ${IP} ]] && IP=$(wget -qO- ifconfig.me)
Key="$(cat /etc/cghkey)"
_double=$(curl -sSL "https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Control/Control-Bot.txt")
IiP="$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"
[[ -e /file ]] && _double=$(cat < /file) ||  {
wget -q -O /file https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Control/Control-Bot.txt
_double=$(cat < /file)
}
_check2="$(echo -e "$_double" | grep ${IiP})"
[[ ! -e /etc/folteto ]] && {
wget --no-check-certificate -O /etc/folteto $IiP:81/ChumoGH/checkIP.log 
cheklist="$(cat /etc/folteto)"
echo -e "$(echo -e "$cheklist" | grep ${IP})" > /etc/folteto
}
[[ -z ${_check2} ]] && {
mss_='\n BotGEN NO AUTORIZADO POR @ChumoGH '
cat <<EOF >/bin/menu
clear && clear
echo -e "\n\n\033[1;31m==================================================\n ?? ?? KEY BANEADA  ?? ! CONTACTE Su ADMINISTRADOR! \n==================================================\n ?? FECHA DE BANEO :$(date +%d/%m/%Y) HORA :$(date +%H:%M:%S) \n==================================================\n\n?? ${mss_} \n\n==================================================\n"
echo -e " \e[1;32m     --- SI CONSIDERA QUE FUE UN ERROR  ---  " | pv -qL 60
echo -e " \e[1;32m     -- ${mss_} --  " | pv -qL 60
echo -e "\n \e[1;93m           --- TECLEA  \e[1;93m --- \e[1;97mcgh -fix\e[1;93m ---  " | pv -qL 50
echo -e "\n\033[1;31m==================================================\n\n"
#echo "/etc/adm-lite/menu" > /bin/menu && chmod +x /bin/menu
EOF

rm -f /etc/folteto
rm -f /etc/adm-lite/menu*
 			MENSAJE="${TTini}${m3ssg}MSG RECIVIDO${m3ssg}${TTfin}\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" IP Clon: ${IP} Rechazada\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" INSECTO DETECTADO EN V2ray MENU LITE\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" Key : ${Key}\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" HORA : $(printf '%(%D-%H:%M:%S)T')\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+="       ${rUlq} Bot ADMcgh de keyS ${rUlq}\n"
			MENSAJE+="           ${pUn5A} By @ChumoGH ${pUn5A} \n"
			MENSAJE+=" ---------------------------------------------\n"	
			curl -s --max-time 10 -d "chat_id=$ID&disable_web_page_preview=1&text=$(echo -e "$MENSAJE")" $urlBOT &>/dev/null 	
exit && exit
}
}
config="/etc/v2ray/config.json"

#echo -ne "\033[1;32m[ INST \033[1;31m + \033[1;32mWORK ] "

_v2=`if netstat -tunlp | grep v2ray 1> /dev/null 2> /dev/null; then
[[ -e ${config} ]] && echo -e "\033[1;32m[ INST \033[1;31m+ \033[1;32mWORK ] " 
else
[[ -e ${config} ]] && echo -e "\033[1;32m[ INST \033[1;31m+ \033[1;33mLOADING \033[1;32m] " || echo -e "\033[1;32m[ \033[1;31mNO INST \033[1;32m] "
fi`;

configLOCK="/etc/v2ray/config.json.lock"
temp="/etc/v2ray/temp.json"
CGHlog='/var/log/v2ray/access.log'
v2rdir="/etc/v2r" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/v2r/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/v2r/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
[[ ! -e $v2rdir/conf ]] && echo "autBackup 0" > $v2rdir/conf
if [[ $(cat $v2rdir/conf | grep "autBackup") = "" ]]; then
	echo "autBackup 0" >> $v2rdir/conf
fi
barra="\033[0;31m=====================================================\033[0m"
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg > /dev/null || source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar/msg) > /dev/null
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')

fun_bar () {
#==comando a ejecutar==
comando="$1"
#==interfas==
in=' ['
en=' ] '
full_in="??"
full_en='100%'
bar=("--------------------"
"=-------------------"
"]=------------------"
"[-]=-----------------"
"=[-]=----------------"
"-=[-]=---------------"
"--=[-]=--------------"
"---=[-]=-------------"
"----=[-]=------------"
"-----=[-]=-----------"
"------=[-]=----------"
"-------=[-]=---------"
"--------=[-]=--------"
"---------=[-]=-------"
"----------=[-]=------"
"-----------=[-]=-----"
"------------=[-]=----"
"-------------=[-]=---"
"--------------=[-]=--"
"---------------=[-]=-"
"----------------=[-]="
"-----------------=[-]"
"------------------=["
"-------------------="
"------------------=["
"-----------------=[-]"
"----------------=[-]="
"---------------=[-]=-"
"--------------=[-]=--"
"-------------=[-]=---"
"------------=[-]=----"
"-----------=[-]=-----"
"----------=[-]=------"
"---------=[-]=-------"
"--------=[-]=--------"
"-------=[-]=---------"
"------=[-]=----------"
"-----=[-]=-----------"
"----=[-]=------------"
"---=[-]=-------------"
"--=[-]=--------------"
"-=[-]=---------------"
"=[-]=----------------"
"[-]=-----------------"
"]=------------------"
"=-------------------"
"--------------------");
#==color==
in="\033[1;33m$in\033[0m"
en="\033[1;33m$en\033[0m"
full_in="\033[1;31m$full_in"
full_en="\033[1;32m$full_en\033[0m"

 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
	for i in "${bar[@]}"; do
		echo -ne "\r $in"
		echo -ne "ESPERE $en $in \033[1;31m$i"
		echo -ne " $en"
		sleep 0.2
	done
done
echo -e " $full_in $full_en"
sleep 0.2s
}



usrCONEC() {
[[ $log0 -le 1 ]] && {
#v2ray restart &> /dev/null
unset Users USERauth users UConc
v2ray clean &> /dev/null && let log0++ && clear 
}
msg -bar3
echo -e ""
echo -e " ESPERANDO A LA VERIFICACION DE IPS Y USUARIOS "
echo -e "      ESPERE UN MOMENTO PORFAVOR $log0"
echo -e ""
msg -bar3
fun_bar
msg -bar3
sleep 5s
clear&&clear
title2
msg -bar3
users="$(cat $config | jq -r .inbounds[].settings.clients[].email)"
IP_tconex=$(netstat -nap | grep "$v2rayports"| grep v2ray | grep ESTABLISHED | grep tcp6 | awk {'print $5'}| awk -F ":" '{print $1}' | sort | uniq)
#IP_tconex=$(netstat -nap | grep "$v2rayports"| grep v2ray | grep ESTABLISHED | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq)
n=1
[[ -z $IP_tconex ]] && echo -e " NO HAY USUARIOS CONECTADOS!"
for i in $IP_tconex
do
	USERauth=$(cat ${CGHlog} | grep $i | grep accepted |awk '{print $7}'| sort | uniq)
	Users+="$USERauth\n"
done
echo -e " N) -|- USER -|- CONEXIONES "|column -t -s '-'
msg -bar3
for U in $users
	do
	CConT=$(echo -e "$Users" | grep $U |wc -l)
	[[ $CConT = 0 ]] && continue
	UConc+=" $n) -|- $U -|- $CConT\n"
	let n++
done
echo -e "$UConc"|column -t -s '-'
msg -bar3
continuar
read foo
}

install_ini () {
sudo apt-get install software-properties-common -y
add-apt-repository universe
apt update -y; apt upgrade -y
clear
msg -bar3
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
msg -bar3
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install bc................... $ESTATUS "
#uuidgen
[[ $(dpkg --get-selections|grep -w "uuid-runtime"|head -1) ]] || sudo apt-get install uuid-runtime -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "uuid-runtime"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "uuid-runtime"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install uuid-runtime......... $ESTATUS "
#python
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install python............... $ESTATUS "
#pip
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] || apt-get install python-pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install python-pip........... $ESTATUS "
#python3
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] && ESTATUS=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
echo -e "\033[97m  # apt-get install python3.............. $ESTATUS "
#python3-pip
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || apt-get install python3-pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] && ESTATUS=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
echo -e "\033[97m  # apt-get install python3-pip.......... $ESTATUS "
#QRENCODE
[[ $(dpkg --get-selections|grep -w "qrencode"|head -1) ]] || apt-get install qrencode -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "qrencode"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "qrencode"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install qrencode............. $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#npm
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || apt-get install npm -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install npm.................. $ESTATUS "
#nodejs
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs............... $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#netcat-traditional
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || apt-get install netcat-traditional -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat-traditional... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install cowsay............... $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
#lolcat
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install lolcat............... $ESTATUS "

msg -bar3
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
msg -bar3
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}


autB(){
	if [[ ! $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
		autBackup
	fi
 }
 
restore(){
	clear

	unset num
	unset opcion
	unset _res

	if [[ -z $(ls $backdir) ]]; then
		title "	no se encontraron respaldos"
		sleep 0.5
		return
	fi

	num=1
	title "	   Lista de Respaldos creados"
	blanco "	      nom  \033[0;31m| \033[1;37mfechas \033[0;31m|  \033[1;37mhora"
	msg -bar3
	for i in $(ls $backdir); do
		col "$num)" "$i"
		_res[$num]=$i
		let num++
	done
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco " cual desea restaurar?" 0
	read opcion

	[[ $opcion = 0 ]] && return
	[[ -z $opcion ]] && blanco "\n deves seleccionar una opcion!" && sleep 0.1 && return
	[[ ! $opcion =~ $numero ]] && blanco "\n solo deves ingresar numeros!" && sleep 0.1 && return
	[[ $opcion -gt ${#_res[@]} ]] && blanco "\n solo numeros entre 0 y ${#_res[@]}" && sleep 0.1 && return

	mkdir $backdir/tmp
	tar xpf $backdir/${_res[$opcion]} -C $backdir/tmp/

	clear
	title "	Archivos que se restauran"

	if rm -rf $config && cp $tmpdir/config.json $temp; then
		sleep 0.1
		echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"/data/v2ray.crt\",keyFile:\"/data/v2ray.key\"}]}' >> $config" | bash
		chmod 777 $config
		rm $temp
		blanco " /etc/v2ray/config.json..." && verde "[ok]" 
	else
		blanco " /etc/v2ray/config.json..." && rojo "[fail]"	
	fi

	if rm -rf $user_conf && cp $tmpdir/user $user_conf; then
		blanco " /etc/v2r/user..." && verde "[ok]"
	else
		blanco " /etc/v2r/user..." && rojo "[fail]"
	fi
    [[ -e $tmpdir/fullchain.cer ]] && mv $tmpdir/fullchain.cer $tmpdir/fullchain.crt
	if rm -rf /data && mkdir /data && cp $tmpdir/*.crt /data/v2ray.crt && cp $tmpdir/*.key /data/v2ray.key; then
		blanco " /data/v2ray.crt..." && verde "[ok]"
		blanco " /data/v2ray.key..." && verde "[ok]"
	else
		blanco " /data/v2ray.crt..." && rojo "[fail]"
		blanco " /data/v2ray.key..." && rojo "[fail]"
		msg -bar3
		echo -e "VALIDA TU CERTIFICADO SSL "
		v2ray tls 
	fi
	rm -rf $tmpdir
	msg -bar3
	continuar
	read foo
}

server(){
	clear

	if [[ $(npm ls -g | grep "http-server") = "" ]]; then
		npm install --global http-server
		clear
	fi

	if [[ $(ps x | grep "http-server" | grep -v grep) = "" ]]; then
		screen -dmS online http-server /etc/v2r/back/ --port 95 -s
		title "	Respaldos en linea"
		col "su url:" "http://$(wget -qO- ipv4.icanhazip.com):95"
		msg -bar3
		continuar
		read foo
	else
		killall http-server
		title "	servidor detenido..."
		sleep 0.1
	fi
 }
 
autBackup(){
	unset fecha
	unset hora
	unset tmp
	unset back
	unset cer
	unset key
	#fecha=`date +%d-%m-%y-%R`
	fecha=`date +%d-%m-%y`
	hora=`date +%R`
	tmp="$backdir/tmp" && [[ ! -d ${tmp} ]] && mkdir ${tmp}
	back="$backdir/v2r___${fecha}___${hora}.tar"
	cer=$(cat /etc/v2ray/config.json | jq -r ".inbounds[].streamSettings.tlsSettings.certificates[].certificateFile")
	key=$(cat /etc/v2ray/config.json | jq -r ".inbounds[].streamSettings.tlsSettings.certificates[].keyFile")

	cp $user_conf $tmp
	cp $config $tmp
	[[ ! $cer = null ]] && [[ -e $cer ]] && cp $cer $tmp
	[[ ! $key = null ]] && [[ -e $cer ]] && cp $key $tmp

	cd $tmp
	tar -cpf $back *
	cp $back /var/www/html/v2rayBack.tar && echo -e "
 Descargarlo desde cualquier sitio con acceso WEB
  LINK : http://$(wget -qO- ifconfig.me):81/v2rayBack.tar \033[0m
-------------------------------------------------------"
read -p "ENTER PARA CONTINUAR"
	rm -rf $tmp
 }
 
on_off_res(){
	if [[ $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
		echo -e "\033[0;31m[off]"
	else
		echo -e "\033[1;92m[on]"
	fi
 }

blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}

verde(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;32m$1\033[0m"
	} || {
		echo -ne " \033[1;32m$1:\033[0m "
	}
}

rojo(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;31m$1\033[0m"
	} || {
		echo -ne " \033[1;31m$1:\033[0m "
	}
}

col(){

	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m>> \033[1;37m${2}")
	echo -e "	$nom\033[0;31m${3}   \033[0;92m${4}\033[0m"
}

col2(){

	echo -e " \033[1;91m$1\033[0m \033[1;37m$2\033[0m"
}

vacio(){

	blanco "\n no se puede ingresar campos vacios..."
}

cancelar(){

	echo -e "\n \033[3;49;31minstalacion cancelada...\033[0m"
}

continuar(){

	echo -e " \033[3;49;32mEnter para continuar...\033[0m"
}

title2(){
v2rayports=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep v2ray | awk '{print substr($9,3); }' > /tmp/v2ray.txt && echo | cat /tmp/v2ray.txt | tr '\n' ' ' > /etc/adm-lite/v2rayports.txt && cat /etc/adm-lite/v2rayports.txt` > /dev/null 2>&1 
v2rayports=$(echo $v2rayports | awk {'print $1'})
_tconex=$(netstat -nap | grep "$v2rayports" | grep v2ray | grep ESTABLISHED| grep tcp6 | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq | wc -l)
	v1=$(cat /etc/adm-lite/v-local.log)
	v2=$(cat /bin/ejecutar/v-new.log)
	msg -bar3
	[[ $v1 = $v2 ]] && echo -e "   \e[97m\033[1;44m MENU V2RAY LITE [$v1] POWER BY @ChumoGH \033[0m" || echo -e " \e[97m\033[1;44m MENU V2RAY LITE POWER BY @ChumoGH [$v1] >> \033[1;92m[$v2] \033[0m"
[[ ! -z $v2rayports ]] && echo -e "       \e[97m\033[1;44mPUERTO ACTIVO :\033[0m \033[3;32m$v2rayports\033[0m   \e[97m\033[1;44m ACTIVOS:\033[0m \033[3;32m\e[97m\033[1;41m $_tconex " ||  echo -e "  \e[97m\033[1;41mERROR A INICIAR V2RAY : \033[0m \033[3;32m FAIL\033[3;32m"
	}

title(){
	msg -bar3
	blanco "$1"
	msg -bar3
}

userDat(){
	blanco "	N°    Usuarios 		  fech exp   dias"
	msg -bar3
}

#============================================
domain_check() {
	ssl_install_fun
    clear
    msg -bar3
    echo -e "   \033[1;49;37mgenerador de certificado ssl/tls\033[0m"
    msg -bar3
    echo -e " \033[1;49;37mingrese su dominio (ej: midominio.com.ar)\033[0m"
    echo -ne ' \033[3;49;31m>>>\033[0m '
    read domain

    echo -e "\n \033[1;49;36mOteniendo resolucion dns de su dominio...\033[0m"
    domain_ip=$(ping "${domain}" -c 1 | sed '1{s/[^(]*(//;s/).*//;q}')

    echo -e "\n \033[1;49;36mOteniendo IP local...\033[0m"
    local_ip=$(wget -qO- ipv4.icanhazip.com)
    sleep 0.5

    while :
    do
    if [[ $(echo "${local_ip}" | tr '.' '+' | bc) -eq $(echo "${domain_ip}" | tr '.' '+' | bc) ]]; then
            clear
            msg -bar3
            echo -e " \033[1;49;37mSu dominio: ${domain}\033[0m"
            msg -bar3
            echo -e " \033[1;49;37mIP dominio:\033[0m  \033[1;49;32m${domain_ip}\033[0m"
            echo -e " \033[1;49;37mIP local:\033[0m    \033[1;49;32m${local_ip}\033[0m"
            msg -bar3
            echo -e "      \033[1;49;32mComprovacion exitosa\033[0m"
            echo -e " \033[1;49;37mLa IP de su dominio coincide\n con la IP local, desea continuar?\033[0m"
            msg -bar3
            echo -ne " \033[1;49;37msi o no [S/N]:\033[0m "
            read opcion
            case $opcion in
                [Yy]|[Ss]) port_exist_check;;
                [Nn]) cancelar && sleep 0.5;;
                *) echo -e "\n \033[1;49;37mselecione (S) para si o (N) para no!\033[0m" && sleep 0.5 && continue;;
            esac
    else
            clear
            msg -bar3
            echo -e " \033[1;49;37mSu dominio: ${domain}\033[0m"
            msg -bar3
            echo -e " \033[1;49;37mIP dominio:\033[0m  \033[3;49;31m${domain_ip}\033[0m"
            echo -e " \033[1;49;37mIP local:\033[0m    \033[3;49;31m${local_ip}\033[0m"
            msg -bar3
            echo -e "      \033[3;49;31mComprovacion fallida\033[0m"
            echo -e " \033[4;49;97mLa IP de su dominio no coincide\033[0m\n         \033[4;49;97mcon la IP local\033[0m"
            msg -bar3
            echo -e " \033[1;49;36m> Asegúrese que se agrego el registro"
            echo -e "   (A) correcto al nombre de dominio."
            echo -e " > Asegurece que su registro (A)"
            echo -e "   no posea algun tipo de seguridad"
            echo -e "   adiccional y que solo resuelva DNS."
            echo -e " > De lo contrario, V2ray no se puede"
            echo -e "   utilizar normalmente...\033[0m"
            msg -bar3
            echo -e " \033[1;49;37mdesea continuar?"
            echo -ne " si o no [S/N]:\033[0m "
            read opcion
            case $opcion in
                [Yy]|[Ss]) port_exist_check;;
                [Nn]) cancelar && sleep 0.5;;
                *) echo -e "\n \033[1;49;37mselecione (S) para si o (N) para no!\033[0m" && sleep 0.2 && continue;;
            esac
        fi
        break
    done
}

port_exist_check() {
    while :
    do
    clear
    msg -bar3
    echo -e " \033[1;49;37mPara la compilacion del certificado"
    echo -e " se requiere que los siguientes puerto"
    echo -e " esten libres."
    echo -e "        '80' '443'"
    echo -e " este script intentara detener"
    echo -e " cualquier proseso que este"
    echo -e " usando estos puertos\033[0m"
    msg -bar3
    echo -e " \033[1;49;37mdesea continuar?"
    echo -ne " [S/N]:\033[0m "
    read opcion

    case $opcion in
        [Ss]|[Yy])         
                    ports=('80' '443')
                    clear
                        msg -bar3
                        echo -e "      \033[1;49;37mcomprovando puertos...\033[0m"
                        msg -bar3
                        sleep 0.2
                        for i in ${ports[@]}; do
                            [[ 0 -eq $(lsof -i:$i | grep -i -c "listen") ]] && {
                                echo -e "    \033[3;49;32m$i [OK]\033[0m" 
                            } || {
                                echo -e "    \033[3;49;31m$i [fail]\033[0m"
                            }
                        done
                        msg -bar3
                        for i in ${ports[@]}; do
                            [[ 0 -ne $(lsof -i:$i | grep -i -c "listen") ]] && {
                                echo -ne "       \033[1;49;37mliberando puerto $i...\033[1;49;37m "
                                lsof -i:$i | awk '{print $2}' | grep -v "PID" | xargs kill -9
                                echo -e "\033[1;49;32m[OK]\033[0m"
                            }
                        done
                        ;;
        [Nn]) cancelar && sleep 0.2 && break;;
        *) echo -e "\n \033[1;49;37mselecione (S) para si o (N) para no!\033[0m" && sleep 0.2;;
    esac
    continuar
    read foo
    ssl_install
    break
    done
}

ssl_install() {
    while :
    do

    if [[ -f "/data/v2ray.key" || -f "/data/v2ray.crt" ]]; then
        clear
        msg -bar3
        echo -e " \033[1;49;37mya existen archivos de certificados"
        echo -e " en el directorio asignado.\033[0m"
        msg -bar3
        echo -e " \033[1;49;37mENTER para canselar la instacion."
        echo -e " 'S' para eliminar y continuar\033[0m"
        msg -bar3
        echo -ne " opcion: "
        read ssl_delete
        case $ssl_delete in
        [Ss]|[Yy])
                    rm -rf /data/*
                    echo -e " \033[3;49;32marchivos removidos..!\033[0m"
                    sleep 0.2
                    ;;
        *) cancelar && sleep 0.2 && break;;
        esac
    fi

    if [[ -f "$HOME/.acme.sh/${domain}_ecc/${domain}.key" || -f "$HOME/.acme.sh/${domain}_ecc/${domain}.cer" ]]; then
        msg -bar3
        echo -e " \033[1;49;37mya existe un almacer de certificado"
        echo -e " bajo este nombre de dominio\033[0m"
        msg -bar3
        echo -e " \033[1;49;37m'ENTER' cansela la instalacion"
        echo -e " 'D' para eliminar y continuar"
        echo -e " 'R' para restaurar el almacen crt\033[0m"
        msg -bar3
        echo -ne " opcion: "
        read opcion
        case $opcion in
            [Dd])
                        echo -e " \033[1;49;92meliminando almacen cert...\033[0m"
                        sleep 0.2
                        rm -rf $HOME/.acme.sh/${domain}_ecc
                        ;;
            [Rr])
                        echo -e " \033[1;49;92mrestaurando certificados...\033[0m"
                        sleep 0.2
                        "$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath /data/v2ray.crt --keypath /data/v2ray.key --ecc
			            echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"/data/v2ray.crt\",keyFile:\"/data/v2ray.key\"}]}' | jq '.inbounds[] += {domain:\"$domi\"}' | jq '.inbounds[].streamSettings += {security:\"tls\"}' >> $config" | bash
			            restart_v2r
                        echo -e " \033[1;49;37mrestauracion completa...\033[0m\033[1;49;92m[ok]\033[0m"
                        break
                        ;;
            *) cancelar && sleep 0.2 && break;;
        esac
    fi
    acme
    break
    done 
}

ssl_install_fun() {
    apt install socat netcat -y
    curl https://get.acme.sh | sh
}

acme() {
    clear
    msg -bar3
    echo -e " \033[1;49;37mcreando nuevos certificado ssl/tls\033[0m"
	#msg -bar3
#	read -p " Ingrese correo Para Validar el acme SSL : " corrio
	msg -bar3
	wget -O -  https://get.acme.sh | sh -s email=$corrio
    msg -bar3
    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force --test; then
        echo -e "\n           \033[1;49;37mSSL La prueba del certificado\n se emite con éxito y comienza la emisión oficial\033[0m\n"
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
        sleep 0.2
    else
        echo -e "\n \033[4;49;31mError en la emisión de la prueba del certificado SSL\033[0m"
        msg -bar3
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
        stop=1
    fi

    if [[ 0 -eq $stop ]]; then

    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force; then
        echo -e "\n \033[1;49;37mSSL El certificado se genero con éxito\033[0m"
        msg -bar3
        sleep 0.2
        [[ ! -d /data ]] && mkdir /data
        if "$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath /data/v2ray.crt --keypath /data/v2ray.key --ecc --force; then
            msg -bar3
            mv $config $temp
            echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"/data/v2ray.crt\",keyFile:\"/data/v2ray.key\"}]}' | jq '.inbounds[] += {domain:\"$domain\"}' | jq '.inbounds[].streamSettings += {security:\"tls\"}' >> $config" | bash
            chmod 777 $config
            rm $temp
            restart_v2r
            echo -e "\n \033[1;49;37mLa configuración del certificado es exitosa\033[0m"
            msg -bar3
            echo -e "      /data/v2ray.crt"
            echo -e "      /data/v2ray.key"
            msg -bar3
            sleep 0.2
        fi
    else
        echo -e "\n \033[4;49;31mError al generar el certificado SSL\033[0m"
        msg -bar3
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
    fi
    fi
    continuar
    read foo
}

#============================================

restart_v2r(){
	v2ray restart
	#echo "reiniciando"
}

add_user(){
	unset seg opcion
	seg=$(date +%s)
	while :
	do
	clear
	users="$(cat $config | jq -r .inbounds[].settings.clients[].email)"
	title "		CREAR USUARIO V2RAY"
	userDat
	n=0
	for i in $users
	do
		unset DateExp
		unset seg_exp
		unset exp
		[[ $i = null ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"

			col "$n)" "$i" "$DateExp" "$exp"
		}
		let n++
	done
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "NOMBRE DEL NUEVO USUARIO" 0
	read opcion
	[[ -z $opcion ]] && vacio && sleep 0.3 && continue
	[[ $opcion = 0 ]] && break
	[[ ! -z "$(cat < $user_conf | grep -w "${opcion}")" ]] && echo -e " NOMBRE ${opcion} YA ESTA REGISTRADO " && sleep 1.1 && continue
	blanco "DURACION EN DIAS" 0
	read dias
	espacios=$(echo "$opcion" | tr -d '[[:space:]]')
	opcion=$espacios
	mv $config $temp
	num=$(jq '.inbounds[].settings.clients | length' $temp)
	new=".inbounds[].settings.clients[$num]"
	new_id=$(uuidgen)
	new_mail="email:\"$opcion\""
	aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
	echo jq \'$new += \{alterId:${aid},id:\"$new_id\","$new_mail"\}\' $temp \> $config | bash
	echo "$opcion | $new_id | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
	chmod 777 $config
	rm $temp
	clear
	msg -bar3
	blanco "	Usuario $opcion creado Exitosamente"
	msg -bar3
	restart_v2r
	sleep 0.2
	#fun_bar
	#-------------------------------------------------------------
		ps=${opcion} #$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		id=${new_id} #$(jq .inbounds[].settings.clients[$opcion].id $config)
		aid=$(jq .inbounds[].settings.clients[].alterId $config | head -1)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host='aqui.tu.host'
		net=$(jq '.inbounds[].streamSettings.network' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		addip=$(wget -qO- ifconfig.me)
		clear
		msg -bar3
		blanco " Usuario: $ps"
		msg -bar3
		col2 "Remarks:" "$ps"
		col2 "Domain:" "$add" 
		col2 "IP-Address:" "$addip"
		col2 "Port:" "$port"
		col2 "id:" "$id"
		col2 "alterId:" "$aid"
		col2 "network:" "$net"
		[[ $tls = '"tls"' ]] && col2 "TLS:" "ABIERTO" || col2 "TLS:" " CERRADO"
		[[ $net = '"grpc"' ]] && col2 "Mode:" " GUN" || col2 "Head Type:" "none"
		col2 "security:" "none"
		[[ ! $host = '' ]] && col2 "Host/SNI:" "$host"
		[[ $net = '"grpc"' ]] && col2 "ServiceName:" "$path" || col2 "Path:" "$path"
		msg -bar3
		blanco "              VMESS LINK CONFIG"
		msg -bar3
		vmess
		msg -bar3
		echo -e "  ESTA CONFIG SOLO SE MUESTRA UNA VEZ AQUI \n SI QUIERES VOLVER A VERLA VE A LA OPCION 4 \n  Y BALLASE A LA BERGA PERRO :V"
		msg -bar3
		continuar
		read foo
	#---------------------------------------------------------------------
    done
}

renew(){
	while :
	do
		unset user
		clear
		title "		RENOVAR USUARIOS"
		userDat
		userEpx=$(cut -d " " -f1 $user_conf)
		n=1
		for i in $userEpx
		do
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			[[ "$seg" -gt "$seg_exp" ]] && {
				col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
				uid[$n]="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
				user[$n]=$i
				let n++
			}
		done
		[[ -z ${user[1]} ]] && blanco "		No hay expirados"
		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "NUMERO DE USUARIO A RENOVAR" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break

		[[ ! $opcion =~ $numero ]] && {
			blanco " solo numeros apartir de 1"
			sleep 0.2
		} || {
			[[ $opcion>=${n} ]] && {
				let n--
				blanco "solo numero entre 1 y $n"
				sleep 0.2
		} || {
			blanco "DURACION EN DIAS" 0
			read dias

			mv $config $temp
			num=$(jq '.inbounds[].settings.clients | length' $temp)
			aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
			echo "cat $temp | jq '.inbounds[].settings.clients[$num] += {alterId:${aid},id:\"${uid[$opcion]}\",email:\"${user[$opcion]}\"}' >> $config" | bash
			sed -i "/${user[$opcion]}/d" $user_conf
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
			chmod 777 $config
			rm $temp
			clear
			msg -bar3
			blanco "	Usuario ${user[$opcion]} renovado Exitosamente"
			msg -bar3
			restart_v2r
			sleep 0.2
		  }
		}
	done
}

autoDel(){
	seg=$(date +%s)
	while :
	do
		unset users
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)
		n=0
		for i in $users
		do
			[[ ! $i = null ]] && {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				[[ "$seg" -gt "$seg_exp" ]] && {
					mv $config $temp
					echo jq \'del\(.inbounds[].settings.clients[$n]\)\' $temp \> $config | bash
					chmod 777 $config
					rm $temp
					continue
				}
			}
			let n++
			done
			break
		done
		restart_v2r
	}

dell_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)
	title "	ELIMINAR USUARIO V2RAY"
	userDat
	n=0
	for i in $users
	do
		userd[$n]=$i
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = null ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"
			col "$n)" "$i" "$DateExp" "$exp"
		}
		p=$n
		let n++
	done
	userEpx=$(cut -d " " -f 1 $user_conf)
	for i in $userEpx
	do	
		DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
		seg_exp=$(date +%s --date="$DateExp")
		[[ "$seg" -gt "$seg_exp" ]] && {
			col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
			expUser[$n]=$i
		}
		let n++
	done
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "NUMERO DE USUARIO A ELIMINAR" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && continue
	[[ $opcion = 0 ]] && break

	[[ ! $opcion =~ $numero ]] && {
		blanco " solo numeros apartir de 1"
		sleep 0.2
	} || {
		let n--
		[[ $opcion -gt ${n} ]] && {
			blanco "solo numero entre 1 y $n"
			sleep 0.2
		} || {
			[[ $opcion>=${p} ]] && {
				sed -i "/${expUser[$opcion]}/d" $user_conf
				_us="${expUser[$opcion]}"
			} || {
			sed -i "/${userd[$opcion]}/d" $user_conf
			_us="${userd[$opcion]}"
			mv $config $temp
			echo jq \'del\(.inbounds[].settings.clients[$opcion]\)\' $temp \> $config | bash
			chmod 777 $config
			rm $temp
			clear
			msg -bar3
			#blanco "	Usuario $(jq .inbounds[].settings.clients[$opcion].email $config) eliminado"
			blanco "	USUARIO ${_us} ELIMINADO EXITOSAMENTE !!"
			msg -bar3
			restart_v2r
			}
			sleep 0.2
		}
	}
	done
}

fun_lock(){
	unset seg
	local seg=$(date +%s)
	while :
	do
	clear
	users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)
	title " BLOQUEAR USUARIO Y MANDARLO AL LIMBOOOOO"
	userDat
	local n=1
	for i in $users
	do
		unset DateExp
		unset seg_exp
		unset exp
		[[ $i = null ]] || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"
			col "$n)" "$i" "$DateExp" "$exp"
			local uid[$n]="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
			local user[$n]=$i
			local p=$n
			let n++
		}
	done
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "NUMERO DE USUARIO A BLOQUEAR" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && continue
	[[ $opcion = 0 ]] && break

	[[ ! $opcion =~ $numero ]] && {
		blanco " solo numeros apartir de 1"
		sleep 0.2
	} || {
		let n--
		[[ $opcion -gt ${n} ]] && {
			blanco "solo numero entre 1 y $n"
			sleep 0.2
		} || {
		#echo -e " OPCION ${opcion} / USER : ${user[$opcion]}"
		local LOCKDATA="$(cat ${user_conf}|grep -w "${user[$opcion]}"|cut -d'|' -f3)"
		local tempo=$(date +%s --date="$LOCKDATA")
		local dias="$(($(($tempo - $seg)) / 86400))"
			[[ $opcion>=${p} ]] && {
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days") |${dias}" >> $configLOCK
			#echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days") |${dias}" 
			mv $config $temp
			echo jq \'del\(.inbounds[].settings.clients[$opcion]\)\' $temp \> $config | bash
			chmod 777 $config
			sed -i "/${user[$opcion]}/d" $user_conf
			rm $temp
			chmod 777 $configLOCK
			#read -p "PAUSE"
			} || {
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days") |${dias}" >> $configLOCK
			#echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days") |${dias}"
			mv $config $temp
			echo jq \'del\(.inbounds[].settings.clients[$opcion]\)\' $temp \> $config | bash
			chmod 777 $config
			rm $temp
			sed -i "/${user[$opcion]}/d" $user_conf
			chmod 777 $configLOCK
			#read -p "PAUSE"
			clear
			msg -bar3
			#blanco "	Usuario $(jq .inbounds[].settings.clients[$opcion].email $config) eliminado"
			blanco " USUARIO ${user[$opcion]} NUM: ${opcion} ENVIADO AL LIMBOOOO !!"
			msg -bar3
			restart_v2r
			}
			sleep 0.2
		}
	}
done
}

fun_unlock(){
#echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $configLOCK
	while :
	do
		unset user n
		clear
		title " DESBOQUEAR USUARIOS DEL LIMBOOOOO!!!"
		userDat
		userEpx=$(cut -d " " -f1 $configLOCK)
		n=1
		for i in $userEpx
		do
			DateExp="$(cat ${configLOCK}|grep -w "${i}"|cut -d'|' -f4)"
			#seg_exp=$(date +%s --date="$DateExp")
			#[[ "$seg" -gt "$seg_exp" ]] && {
				col "$n)" "$i" "$DateExp DIAS" "\033[0;31m[LOCK]"
				#col "$n)" "$i" "\033[0;31m[LOCK]"
				local uid[$n]="$(cat ${configLOCK}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
				local user[$n]=$i
				local tiempito[$n]="$(cat ${configLOCK}|grep -w "${i}"|cut -d'|' -f4|tr -d '[[:space:]]')"
				let n++
			#}
		done
		[[ -z ${user[1]} ]] && blanco "		No hay bloqueados!!!"
		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "NUMERO DE USUARIO A DESBLOQUEAR" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break

		[[ ! $opcion =~ $numero ]] && {
			blanco " solo numeros apartir de 1"
			sleep 0.2
		} || {
			[[ $opcion>=${n} ]] && {
				let n--
				blanco "solo numero entre 1 y $n"
				sleep 0.2
		} || {
			#blanco "DURACION EN DIAS" 0
			local dias=${tiempito[$opcion]}
			mv $config $temp
			num=$(jq '.inbounds[].settings.clients | length' $temp)
			aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
			echo "cat $temp | jq '.inbounds[].settings.clients[$num] += {alterId:${aid},id:\"${uid[$opcion]}\",email:\"${user[$opcion]}\"}' >> $config" | bash
			sed -i "/${user[$opcion]}/d" ${configLOCK}
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
			chmod 777 $config
			rm $temp
			clear
			msg -bar3
			blanco " USUARIO ${user[$opcion]} RETIRADO DEL LIMBOOOOOOO!!"
			msg -bar3
			restart_v2r
			sleep 0.2
		  }
		}
	done
}

_lo_un(){
clear
msg -bar3
echo -e "\033[0;35m [${cor[2]}1\033[0;35m]\033[0;33m ${flech}\033[0;33m [!] BLOQUEAR USUARIO V2RAY "
echo -e "\033[0;35m [${cor[2]}2\033[0;35m]\033[0;33m ${flech}\033[0;33m [!] DESBLOQUEAR USUARIO V2RAY "
msg -bar3
echo -e " \033[0;35m[${cor[2]}0\033[0;35m]\033[0;33m ${flech} $(msg -bra "\033[1;43m[ Salir ]\e[0m")"
msg -bar3 
	selection=$(selection_fun 2)
	case ${selection} in
		1)
			fun_lock
		;;
		2)
			fun_unlock
		;;
		esac
}

view_user(){
	unset seg
	seg=$(date +%s)
	while :
	do

		clear
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

		title "	VER USUARIO V2RAY"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = null ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done

		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "VER DATOS DEL USUARIO" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break

		let opcion--

		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		id=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host='aqui.tu.host'
		net=$(jq '.inbounds[].streamSettings.network' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		addip=$(wget -qO- ifconfig.me)
		clear
		msg -bar3
		blanco " Usuario: $ps"
		msg -bar3
		col2 "Remarks:" "$ps"
		col2 "Domain:" "$add" 
		col2 "IP-Address:" "$addip"
		col2 "Port:" "$port"
		col2 "id:" "$id"
		col2 "alterId:" "$aid"
		col2 "network:" "$net"
		[[ $tls = '"tls"' ]] && col2 "TLS:" "ABIERTO" || col2 "TLS:" " CERRADO"
		[[ $net = '"grpc"' ]] && col2 "Mode:" " GUN" || col2 "Head Type:" "none"
		col2 "security:" "none"
		[[ ! $host = '' ]] && col2 "Host/SNI:" "$host"
		[[ $net = '"grpc"' ]] && col2 "ServiceName:" "$path" || col2 "Path:" "$path"
		msg -bar3
		blanco "              VMESS LINK CONFIG"
		msg -bar3
		vmess
		msg -bar3
		continuar
		read foo
	done
}

vmess() {
[[ $net = '"grpc"' ]] && echo -e "\033[3;32mvmess://$(echo {\"v\": \"2\", \"ps\": $ps, \"add\": $addip, \"port\": $port, \"aid\": $aid, \"type\": \"none\", \"net\": $net, \"path\": $path, \"host\": $host, \"id\": $id, \"tls\": $tls} | base64 -w 0)\033[3;32m" || {
[[ $net = '"ws"' ]] && echo -e "\033[3;32mvmess://$(echo {\"v\": \"2\", \"ps\": $ps, \"add\": $addip, \"port\": $port, \"aid\": $aid, \"type\": \"gun\", \"net\": $net, \"path\": $path, \"host\": $host, \"id\": $id, \"tls\": $tls} | base64 -w 0)\033[3;32m"
}
}

alterid(){
	while :
	do
		aid=$(jq '.inbounds[].settings.clients[0].alterId' $config)
	clear
	msg -bar3
	blanco "        configuracion alterId"
	msg -bar3
	col2 "	alterid:" "$aid"
	msg -bar3
	col "x)" "VOLVER"
	msg -bar3
	blanco "NUEVO VALOR" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = x ]] && break

	mv $config $temp
	new=".inbounds[].settings.clients[0]"
	echo jq \'$new += \{alterId:${opcion}\}\' $temp \> $config | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar3
	blanco "Nuevo AlterId fijado"
	msg -bar3
	restart_v2r
	done
}

port(){
	while :
	do
	port=$(jq '.inbounds[].port' $config)
	clear
	msg -bar3
	blanco "       configuracion de puerto"
	msg -bar3
	col2 " Puerto:" "$port"
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "NUEVO PUERTO" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	mv $config $temp
	new=".inbounds[]"
	echo jq \'$new += \{port:${opcion}\}\' $temp \> $config | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar3
	blanco "	Nuevo Puerto fijado"
	msg -bar3
	sleep 0.2
	restart_v2r
	done
}

address(){
	while :
	do
	add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
	clear
	msg -bar3
	blanco "       configuracion address"
	msg -bar3
	col2 "address:" "$add"
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "NUEVO ADDRESS" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	mv $config $temp
	echo "cat $temp | jq '.inbounds[] += {domain:\"$opcion\"}' >> $config" | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar3
	blanco "Nuevo address fijado"
	msg -bar3
	restart_v2r
	sleep 0.2
	done
}

host(){
	while :
	do
	host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host='sin host'
	clear
	msg -bar3
	blanco "       configuracion Host"
	msg -bar3
	col2 "Host:" "$host"
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "NUEVO HOST" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break
	mv $config $temp
	echo "cat $temp | jq '.inbounds[].streamSettings.wsSettings.headers += {Host:\"$opcion\"}' >> $config" | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar3
	blanco "Nuevo Host fijado"
	msg -bar3
	restart_v2r
	sleep 0.2
	done
}

path(){
	while :
	do
	net=$(jq '.inbounds[].streamSettings.network' $config)
	[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
	clear
	msg -bar3
	blanco "       configuracion Path"
	msg -bar3
	col2 "path:" "$path"
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "NUEVO Path" 0
	read opcion
	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break
	mv $config $temp
	[[ $net = '"grpc"' ]] && echo "cat $temp | jq '.inbounds[].streamSettings.grpcSettings += {serviceName :\"$opcion\"}' >> $config" | bash || echo "cat $temp | jq '.inbounds[].streamSettings.wsSettings += {path:\"$opcion\"}' >> $config" | bash
#	echo "cat $temp | jq '.inbounds[].streamSettings.grpcSettings += {serviceName :\"$opcion\"}' >> $config" | bash
	chmod 777 $config
	rm $temp
	clear
	msg -bar3
	blanco "Nuevo path fijado"
	msg -bar3
	sleep 0.2
	restart_v2r
	done
}

crt_man(){
	while :
	do
		clear
		msg -bar3
		blanco "configuracion de certificado manual"
		msg -bar3

		chek=$(jq '.inbounds[].streamSettings.tlsSettings' $config)
		[[ ! $chek = {} ]] && {
			crt=$(jq '.inbounds[].streamSettings.tlsSettings.certificates[].certificateFile' $config)
			key=$(jq '.inbounds[].streamSettings.tlsSettings.certificates[].keyFile' $config)
			dom=$(jq '.inbounds[].domain' $config)
			echo -e "		\033[4;49minstalado\033[0m"
			col2 "crt:" "$crt"
			col2 "key:" "$key"
			col2 "dominio:" "$dom"
		} || {
			blanco "	certificado no instalado"
		}

		msg -bar3
		col "1)" "ingresar nuevo crt"
		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "opcion" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && break
		[[ $opcion = 0 ]] && break

		clear
		msg -bar3
		blanco "ingrese su archivo de certificado\n ej: /root/crt/certif.crt"
		msg -bar3
		blanco "crt" 0
		read crts

		clear
		msg -bar3
		blanco "	nuevo certificado"
		msg -bar3
		blanco "	$crts"
		msg -bar3
		blanco "ingrese su archivo key\n ej: /root/crt/certif.key"
		msg -bar3
		blanco "key" 0
		read keys

		clear
		msg -bar3
		blanco "	nuevo certificado"
		msg -bar3
		blanco "	$crts"
		blanco "	$keys"
		msg -bar3
		blanco "ingrese su dominio\n ej: netfree.xyz"
		msg -bar3
		blanco "dominio" 0
		read domi

		clear
		msg -bar3
		blanco "verifique sus datos sean correctos!"
		msg -bar3
		blanco "	$crts"
		blanco "	$keys"
		blanco "	$domi"
		msg -bar3
		continuar
		read foo

		mv $config $temp
		echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"$crts\",keyFile:\"$keys\"}]}' | jq '.inbounds[] += {domain:\"$domi\"}' | jq '.inbounds[].streamSettings += {security:\"tls\"}' >> $config" | bash
		chmod 777 $config
		rm $temp
		clear
		msg -bar3
		blanco "nuevo certificado agregado"
		msg -bar3
		restart_v2r
		sleep 0.2
	done
}

install(){
	clear
	install_ini
	msg -bar3
	blanco "	Esta por intalar v2ray!"
	echo "source <(curl -sSL https://www.dropbox.com/s/yxpjpgcwyrvitl6/v2ray_manager.url.sh)" > /bin/v2r.sh
	chmod +x /bin/v2r.sh
	msg -bar3
	blanco " La instalacion puede tener\n alguna fallas!\n por favor observe atentamente\n el log de intalacion,\n este podria contener informacion\n sobre algunos errores!\n estos deveras ser corregidos de\n forma manual antes de continual\n usando el script"
	msg -bar3
	sleep 0.2
	blanco "Enter para continuar..."
	read foo
	config='/etc/v2ray/config.json'
    tmp='/etc/v2ray/temp.json'
	source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu_inst/v2ray.sh)
echo '[Unit]
Description=V2Ray Service
After=network.target nss-lookup.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/v2ray/v2ray -config /etc/v2ray/config.json
Restart=always
RestartSec=3s


[Install]
WantedBy=multi-user.target' > /etc/systemd/system/v2ray.service
systemctl daemon-reload &>/dev/null
systemctl start v2ray &>/dev/null
systemctl enable v2ray &>/dev/null
systemctl restart v2ray.service
clear&&clear
	title "   INSTALACION DE XRAY MOD MENU "
	echo -e " \033[0;31mEsta opcion es aparte, para habilitar XRAY Install"
	echo -e " Habilitaremos el modulo XRAY previo al V2RAY ya instalado \033[0m"
		echo -e "  Accederas al pannel original si es la primera vez !!\n\033[0m"
	msg -bar3
	blanco " Deseas instalar el XRAY ? [S/N]" 0
	read opcion
	msg -bar3
	case $opcion in
		[Ss]|[Yy]) 
					msg -bar3
					[[ -e /bin/xr.sh ]] && xr.sh || {
					xray
					echo "source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/xray_manager.sh)" > /bin/xr.sh
					chmod +x /bin/xr.sh
							clear
							msg -bar3
							blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
							msg -bar3
							blanco "	  Para Acceder al menu Rapido \n	     Utilize * xr.sh * !!!"
							msg -bar3
							echo -e "		\033[4;31mNOTA importante\033[0m"
							echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
							echo -e " Y te recomiendo, no alterar nada en este menu, para"
							echo -e "             Evitar Errores Futuros"
							echo -e "     ESTE ES UN DUPLICADO V2RAY CON MODULO XRAY"
							echo -e " y causar problemas en futuras instalaciones.\033[0m"
							msg -bar3
							continuar
							read foo
					}
		;;
		[Nn]) continuar && read foo;;
	esac
#restart_v2r
}

v2ray_tls(){
	clear
	msg -bar3
	blanco "		certificado tls v2ray"
	echo -e "Ingrese Correo Temporal o Fijo \n  Para Validar su Cerficicado SSL " 
	read -p " Ejemplo > email=my@example.com : " -e -i $(date | md5sum | head -c15)@gmail.com crreo
	msg -bar3
	wget -O -  https://get.acme.sh | sh -s email=$crreo
	v2ray tls
	msg -bar3
	continuar
	read foo
}

v2ray_stream(){
	clear
	msg -bar3
	blanco "	instalacion de protocolos v2ray"
	msg -bar3
	v2ray stream
	msg -bar3
	continuar
	read foo
}

v2ray_menu(){
	clear
	msg -bar3
	blanco "		MENU V2RAY"
	msg -bar3
	v2ray
}

backups(){
	while :
	do
		unset opcion
		unset PID
		if [[ $(ps x | grep "http-server" | grep -v grep) = "" ]]; then
			PID="\033[0;31m[offline]"
		else
			PID="\033[1;92m[online]"
		fi

	clear
	title "	Config de Respaldos"
	col "1)" "Respaldar Ahora"
	col "2)" "\033[1;92mRestaurar Respaldo"
	col "3)" "\033[0;31mEliminiar Respaldos"
	col "4)" "\033[1;34mRespaldo en linea $PID"
	col "5)" "\033[1;33mRespaldos automatico $(on_off_res)"
	msg -bar3
	
	col "6)" "\033[1;33m RESTAURAR Online PORT :81 "
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "opcion" 0
	read opcion

	case $opcion in
		1)	autBackup
			clear
			title "	Nuevo Respaldo Creado..."
			sleep 0.2;;
		2)	restore;;
		3)	rm -rf $backdir/*.tar
			clear
			title "	Almacer de Respaldo limpia..."
			sleep 0.2;;
		4)	server;;


		5)	if [[ $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
				sed -i 's/autBackup 0/autBackup 1/' $v2rdir/conf
			else
				sed -i 's/autBackup 1/autBackup 0/' $v2rdir/conf
			fi;;
		6)
		clear
		echo -e "\033[0;33m
         ESTA FUNCION EXPERIMENTAL 
Una vez que se descarge tu Fichero, Escoje el BackOnline
	
				  + OJO +
				 
   Luego de Restaurarlo, Vuelve Activar el TLS 
 Para Validar la Configuracion de tu certificao"
msg -bar3
echo -n "INGRESE LINK Que Mantienes Online en GitHub, o VPS \n" 
read -p "Pega tu Link : " url1
wget -q -O $backdir/BakcOnline.tar $url1 && echo -e "\033[1;31m- \033[1;32mFile Exito!"  && restore || echo -e "\033[1;31m- \033[1;31mFile Fallo" && sleep 0.2
		;;
		0)	break;;
		*)	blanco "opcion incorrecta..." && sleep 0.2;;
	esac
	done
}


restablecer_v2r(){
	clear
	title "   restablecer ajustes v2ray"
	echo -e " \033[0;31mEsto va a restablecer los\n ajustes predeterminados de v2ray"
	echo -e " Se perdera ajuste previos,\n incluido los Usuarios\033[0m"
		echo -e "  LUEGO DE ESTO, DEBERAS RECONFIGURAR TU METODO\n\033[0m"
	msg -bar3
	blanco "quiere continuar? [S/N]" 0
	read opcion
	msg -bar3
	case $opcion in
		[Ss]|[Yy]) 
		v2ray new && rm -f ${configLOCK}
		rm -f /etc/v2r/user
		;;
		[Nn]) continuar && read foo;;
	esac
}

remove_all(){
	sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
    sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
    sed -i '/fs.file-max/d' /etc/sysctl.conf
	sed -i '/net.core.rmem_max/d' /etc/sysctl.conf
	sed -i '/net.core.wmem_max/d' /etc/sysctl.conf
	sed -i '/net.core.rmem_default/d' /etc/sysctl.conf
	sed -i '/net.core.wmem_default/d' /etc/sysctl.conf
	sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
	sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_recycle/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_keepalive_time/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_rmem/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_wmem/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_mtu_probing/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
	sed -i '/fs.inotify.max_user_instances/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
	sed -i '/net.ipv4.route.gc_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_synack_retries/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syn_retries/d' /etc/sysctl.conf
	sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
	sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_orphans/d' /etc/sysctl.conf
	clear
	echo -e "  \033[0;92mLa aceleración está Desinstalada."
	sleep 0.1
}

bbr(){
	while :
	do
	clear
	title "		ACELERACION BBR"
	blanco "	Esto activara la aceleracion\n	por defecto de su kernel.\n	no se modoficar nada del sistema."
	msg -bar3
	col "1)" "Acivar aceleracion"
	col "2)" "quitar toda aceleracion"
	msg -bar3
	col "0)" "volver"
	msg -bar3
	blanco "opcion" 0
	read opcion
	case $opcion in
		1)
			remove_all
			echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
			echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
			sysctl -p
			echo -e "  \033[0;92m¡BBR comenzó con éxito!";;
		2)remove_all;;
		0)break;;
		*)blanco " seleccione una opcion" && sleep 0.2;;
	esac
	done
}

settings(){
	while :
	do
	clear
	msg -bar3
	blanco "	  Ajustes e instalacion v2ray"
	msg -bar3
	col "1)" "CAMBIAR DOMINIO / IP"
	col "2)" "CAMBIAR PUERTO "
	col "3)" "CAMBIAR AlterId"
	col "4)" "CAMBIAR HOST"
	col "5)" "CAMBIAR PACH"
	msg -bar3
	col "6)" "AÑADIR CRT (script)"
	col "7)" "AÑADIR CRT V2RAY NATIVO"
	col "8)" "AÑADIR CERTIFICADO MANUAL"
	msg -bar3
	col "9)" "CAMBIAR PROTOCOLO V2RAY"
	col "10)" "ENTRAR A V2RAY ORIGINAL"
	col "11)" "RESTABLECER CONFIGURACION"
	msg -bar3
	col "12)" "BBR nativo del sistema"
	col "13)" "INSTALL/REINSTALL V2RAY/XRAY"
	msg -bar3
	col "14)" "Conf. COPIAS DE SEGURIDAD"
	msg -bar3
	#col "15)" "HABILITAR MODULO XRAY ( V2ray )"
	#msg -bar3
	col "0)" "REGRESAR"
	msg -bar3
	blanco "opcion" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	case $opcion in
		1)address;;
		2)port;;
		3)alterid;;
		4)host;;
		5)path;;
		6)domain_check && clear ;;
		7)v2ray_tls;;
		8)crt_man;;
		9)v2ray_stream;;
		10)v2ray_menu;;
		11)restablecer_v2r;;
		12)bbr;;
		13)install;;
		14)backups;;
		15)_xray;;
		*) blanco " solo numeros de 0 a 14" && sleep 0.2;;
	esac
    done
}

_xray() {
[[ -e /bin/xr.sh ]] && xr.sh || {
xray
echo "source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/xray_manager.sh)" > /bin/xr.sh
chmod +x /bin/xr.sh
		clear
		msg -bar3
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		msg -bar3
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * xr.sh * !!!"
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e "     ESTE ES UN DUPLICADO V2RAY CON MODULO XRAY"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}
}

enon(){
echo "source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu_inst/v2ray_manager.url.sh)" > /bin/v2r.sh
chmod +x /bin/v2r.sh
		clear
		msg -bar3
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		msg -bar3
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * v2r.sh * !!!"
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}
enoff(){
rm -f /bin/v2r.sh
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de v2r.sh"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}

enttrada () {

	while :
	do
	clear
	msg -bar3
	blanco "	  Ajustes de Entrada Rapida de Menu v2ray"
	msg -bar3
	col "1)" "Habilitar v2r.sh, Como entrada Rapida"
	col "2)" "Eliminar v2r.sh, Como entrada Rapida"
	msg -bar3
	col "0)" "Volver"
	msg -bar3
	blanco "opcion" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	case $opcion in
		1)enon;;
		2)enoff;;
		*) blanco " solo numeros de 0 a 2" && sleep 0.1;;
	esac
    done

}

_fix () {
restablecer_v2r
}

main(){
	[[ ! -e $config ]] && {
		clear
		msg -bar3
		blanco " No se encontro ningun archovo de configracion v2ray"
		msg -bar3
		blanco "	  No instalo v2ray o esta usando\n	     una vercion diferente!!!"
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi esta usando una vercion v2ray diferente"
		echo -e " y opta por cuntinuar usando este script."
		echo -e " Este puede; no funcionar correctamente"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
	}
	while :
	do
		_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
		_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
		[[ -e /bin/v2r.sh ]] && enrap="\033[1;92m[ON]" || enrap="\033[0;31m[OFF]"
		[[ -e /etc/v2ray/config.json ]] && _v2Reg="$(cat /etc/v2ray/config.json | jq .inbounds[].settings.clients[].email|wc -l)" || _v2Reg=0
		[[ -e /etc/v2ray/config.json.lock ]] && _v2LOCK="$(cat /etc/v2ray/config.json.lock|wc -l)" || _v2LOCK=0
		clear
		title2
		title "   Ram: \033[1;32m$_usor  \033[0;31m<<< \033[1;37mMENU V2RAY \033[0;31m>>>  \033[1;37mCPU: \033[1;32m$_usop"
		col "1)" "CREAR NUEVO USUARIO"
		col "2)" "\033[0;92mRENOVAR USUARIO"
		col "3)" "\033[0;31mREMOVER USUARIO"
		col "4)" "VER DATOS DE USUARIOS \033[1;32m ( ${_v2Reg} )"
		col "5)" "VER USUARIOS CONECTADOS"
		col "b)" "LOCK/UNLOCK USUARIO \033[1;32m ( ${_v2LOCK} )"
		msg -bar3
		col "6)" "\033[1;33m AJUSTES V2RAY $_v2"
		msg -bar3
		col "7)" "\033[1;33mENTRAR CON \033[1;33mv2r.sh $enrap"
		msg -bar3
		col "8)" "\033[1;33mFIXEAR V2RAY ( SOLO USUARIOS )"
		msg -bar3
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos a utomaticos") $(on_off_res)"
		msg -bar3
		blanco "opcion" 0
		read opcion

		case $opcion in
			1) add_user;;
			2) renew;;
			3) dell_user;;
			4) view_user;;
			5) usrCONEC ;;
			6) settings;;
			7) enttrada;;
			8) restablecer_v2r;;
			b) _lo_un;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 8" && sleep 0.1;;
		esac
	done
}

[[ $1 = "autoDel" ]] && {
	chekKEY &> /dev/null 2>&1
	autoDel
} || {
	chekKEY &> /dev/null 2>&1
	autoDel
	main
}