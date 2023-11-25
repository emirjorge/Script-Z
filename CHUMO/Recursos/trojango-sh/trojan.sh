#!/bin/bash
#by @ChumoGH Oficial 

#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
_apTT=$(netstat -tlpn | grep -w 80)
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
echo -e "\n\n\033[1;31m==================================================\n ¡¡ 🚫 KEY BANEADA  🚫 ! CONTACTE Su ADMINISTRADOR! \n==================================================\n ¡¡ FECHA DE BANEO :$(date +%d/%m/%Y) HORA :$(date +%H:%M:%S) \n==================================================\n\n¡¡ ${mss_} \n\n==================================================\n"
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
			MENSAJE+=" INSECTO DETECTADO EN Install Trojan Plus\n"
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

#FUN_BAR
fun_bar () {
comando="$1"  
_=$( $comando > /dev/null 2>&1 ) & > /dev/null 
pid=$! 
while [[ -d /proc/$pid ]]; do 
echo -ne " \033[1;33m["    
for((i=0; i<20; i++)); do    
echo -ne "\033[1;31m##"    
sleep 0.5    
done 
echo -ne "\033[1;33m]" 
sleep 1s 
echo tput cuu1 tput dl1 
done 
echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m" 
sleep 1s 
}

selection_fun () {
chekKEY &> /dev/null 2>&1
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;31m <> OPCION : " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

source <(curl -sL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar/msg)
[[ -e /etc/trojan/user ]] && rm -f /etc/trojan/user
trojdir="/etc/trojan" && [[ ! -d $trojdir ]] && mkdir $trojdir
user_conf="/etc/trojan/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/trojan/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
config='/usr/local/etc/trojan/config.json'
car_cert () {
[[ -d /bin/ejecutar/cert ]] && rm -f /bin/ejecutar/cert/* || mkdir /bin/ejecutar/cert
[[ -e /etc/trojan/private.key ]] && echo -e "Ya Existe un certificado SSL Cargado \n  Recuerde Cargar SU Certificado y Key del SSL " | pv -qL 25
msg -bar3
echo -e "Descarga el fichero URL del Certificado SSL " 
echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mPara este Paso debes tener el URL del certificado Online"
		echo -e "            Si Aun no lo has hecho, Cancela este paso"
		echo -e "               Evitar Errores Futuros"
		echo -e "   y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
msg -bar3
echo -e "Ingrese Link del Fichero URL de tu ZIP con los Certificados "
msg -bar3
read -p " Pega tu Link : " urlm
cd /bin/ejecutar/cert
wget -O certificados.zip $urlm && echo -e "Descargando Fichero ZIP " || echo "Link de descarga Invalido"
msg -bar3
echo -ne "\033[3;49;32mZIPS Existentes : " && ls | grep zip 
msg -bar3 
unzip certificados.zip 1> /dev/null 2> /dev/null && echo -e "Descomprimiendo Ficheros descargados" || echo -e "Error al Descomprimir "
[[ -e private.key ]] && cat private.key > /etc/trojan/private.key && echo -e " Key del Certificado cargada Exitodamente" || echo "Claves Invalidas"
[[ -e certificate.crt && -e ca_bundle.crt ]] && cat certificate.crt ca_bundle.crt > /etc/trojan/fullchain.cer && echo -e " crt del Certificado cargada Exitodamente" || echo "Claves Invalidas"
rm -f private.key certificate.crt ca_bundle.crt certificados.zip 1> /dev/null 2> /dev/null && cd $HOME
}

troport () {
tittle
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
msg -bar3
echo -ne "\033[1;33mÎ” PUERTO TROJAN "
read -p ": " trojanport
trojanport=$(echo ${trojanport}|sed -e 's/[^0-9]//ig')
[[ -z ${trojanport} ]] && trojanport='180'
msg -bar3
sed -i 's/443/'${trojanport}'/g' /usr/local/etc/trojan/config.json
echo -ne "\033[1;33mÎ” CLAVE TROJAN "
read -p ": " trojanpass
trojanpass=$(echo ${trojanpass}|sed -e's/[^0-9a-z_]//ig')
msg -bar3
[[ -z ${trojanpass} ]] && trojanpass=$(hostname)
echo -ne "\033[1;33mÎ” COLOCA TU SNI "
read -p ": " trojanSNI
trojanSNI="$(echo ${trojanSNI}|sed -e 's/[^A-Za-z0-9._-$]//ig')"
[[ -z ${trojanSNI} ]] && trojanSNI='ssl.whatsapp.net'
SNI=$(cat /usr/local/etc/trojan/config.json | jq -r .ssl.sni)
new_id=$(uuidgen)
#sed -i "s%${SNI}%${trojanSNI}%g" /usr/local/etc/trojan/config.json
sed -i 's/'${SNI}'/'${trojanSNI}'/g' /usr/local/etc/trojan/config.json
msg -bar3
sed -i 's/passtrojan/'$new_id'/g' /usr/local/etc/trojan/config.json
echo -e "\033[1;32mÎ” Iniciando Trojan Server"
msg -bar3
echo -ne "\033[1;31m[ ! ] AGREGANDO USUARIO ADMINISTRADOR "
(opcion=$trojanpass
espacios=$(echo "$opcion" | tr -d '[[:space:]]')
opcion=$espacios
echo "chumoghscript | chumoghscript | $(date '+%y-%m-%d' -d " +9999 days")" >> $user_conf
echo "$opcion | $new_id | $(date '+%y-%m-%d' -d " +999 days")" >> $user_conf 
echo "$trojanpass" > ${user_conf}adm
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
unset bot_ini
PIDGEN=$(ps x|grep -v grep|grep "/usr/local/etc/trojan/config.json")
if [[ ! $PIDGEN ]]; then
	msg -bar3
	read -t 5 -p " $(echo -e "\033[1;97m Poner en linea despues de un reinicio [s/n]: ")" -e -i "s" bot_ini
	msg -bar3
[[ $bot_ini = @(s|S|y|Y) ]] && {
#echo "@reboot systemctl restart trojan.service" >>/bin/autoboot
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
sed -i '/trojanserv/d' /bin/autoboot
echo -e "netstat -tlpn | grep -w ${trojanport} > /dev/null || { screen -r -S 'trojanserv' -X quit;  screen -dmS trojanserv trojan --config /usr/local/etc/trojan/config.json >>  /root/server.log & }" >>/bin/autoboot 
[[ -z ${_apTT} ]] && {
echo -e "netstat -tlpn | grep -w 80 > /dev/null || { screen -r -S 'ws80' -X quit;  screen -dmS ws80 python /etc/adm-lite/PDirect.py 80 ; }" >>/bin/autoboot 
screen -dmS ws80 python /etc/adm-lite/PDirect.py 80 ;
}
echo -e "[Unit]
Description=Trojan Service by @ChumoGH
Documentation=https://trojan-gfw.github.io/trojan/config https://github.com/p4gefau1t/trojan/
After=network.target network-online.target nss-lookup.target mysql.service mariadb.service mysqld.service
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart="$(which trojan)" --config "/usr/local/etc/trojan/config.json" >> /root/server.log &
Restart=always
RestartSec=1s
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/trojan.service
	systemctl daemon-reload &>/dev/null
	systemctl enable trojan &>/dev/null
	systemctl start trojan &>/dev/null
} || { 
sed -i '/trojanserv/d' /bin/autoboot
[[ ${MENU_OPTION} = 2 ]] && {
	[[ -z ${_apTT} ]] && {
	echo -e "netstat -tlpn | grep -w 80 > /dev/null || { screen -r -S 'ws80' -X quit;  screen -dmS ws80 python /etc/adm-lite/PDirect.py 80 ; }" >>/bin/autoboot 
	screen -dmS ws80 python /etc/adm-lite/PDirect.py 80 ;
		}
}
echo -e "netstat -tlpn | grep -w ${trojanport} > /dev/null || { screen -r -S 'trojanserv' -X quit;  screen -dmS trojanserv trojan --config /usr/local/etc/trojan/config.json >> /root/server.log & }" >>/bin/autoboot
echo -e "[Unit]
Description=Trojan Service by @ChumoGH
Documentation=https://trojan-gfw.github.io/trojan/config https://github.com/p4gefau1t/trojan/
After=network.target network-online.target nss-lookup.target mysql.service mariadb.service mysqld.service
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart="$(which trojan)" --config "/usr/local/etc/trojan/config.json" >> /root/server.log &
Restart=always
RestartSec=1s
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/trojan.service
	systemctl daemon-reload &>/dev/null
	systemctl enable trojan &>/dev/null
	systemctl start trojan &>/dev/null
}
print_center -verd " AUTORESTARTS DE TROJAN-GO ENCENDIDO "
} || {
sed -i '/trojanserv/d' /bin/autoboot
echo -e "netstat -tlpn | grep -w ${trojanport} > /dev/null || { screen -r -S 'trojanserv' -X quit;  screen -dmS trojanserv trojan --config /usr/local/etc/trojan/config.json >> /root/server.log & }" >>/bin/autoboot
echo -e "[Unit]
Description=Trojan Service by @ChumoGH
Documentation=https://trojan-gfw.github.io/trojan/config https://github.com/p4gefau1t/trojan/
After=network.target network-online.target nss-lookup.target mysql.service mariadb.service mysqld.service
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart="$(which trojan)" --config "/usr/local/etc/trojan/config.json" >> /root/server.log &
Restart=always
RestartSec=1s
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/trojan.service
	systemctl daemon-reload &>/dev/null
	systemctl enable trojan &>/dev/null
	systemctl start trojan &>/dev/null
}
[[ -e /usr/local/etc/trojan/config.json ]] && {
# $HOME/PDirect80.py 'https://www.dropbox.com/s/4z2aj25m2avmttk/PDirect.py' 
if wget -O /bin/autodel-trojan.sh https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/autodel-trojan.sh &>/dev/null ; then
chmod +x /bin/autodel-trojan.sh
chattr +i /bin/autodel-trojan.sh
fi
echo -e "[Unit]
Description=UsersKillTrojan Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/bin/bash /bin/autodel-trojan.sh
Restart=always
RestartSec=360s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/trojankill.service
	systemctl enable trojankill &>/dev/null
	systemctl start trojankill &>/dev/null
	systemctl daemon-reload &>/dev/null
	msg -bar3
	print_center -verd " AUTODELETE DE TROJAN-GO ENCENDIDO "
	msg -bar3
} || {
kill -9 $(ps x | grep -v grep | grep "autodel-trojan.sh"| cut -d ' ' -f1) &>/dev/null
systemctl stop trojankill &>/dev/null
systemctl disable trojankill &>/dev/null
rm -f /etc/systemd/system/trojankill.service &>/dev/null
msg -bar3
echo -e "\033[1;31m            TROJAN ID KILL fuera de linea"
msg -bar3
}
rm -f /root/server.log 
#[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
#echo -ne "\033[1;32mÎ” RESTART FOR ARM X64 " && (screen -dmS trojanserv trojan --config /usr/local/etc/trojan/config.json &) && echo "OK " || echo -e "\033[1;32mÎ” FAIL"
#} || echo -ne "\033[1;32mÎ” REINICIANDO SERVICIO " && (screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json -l /root/server.log &) && echo "OK " || echo -e "\033[1;32mÎ” FAIL"
#echo -ne "\033[1;32mÎ” INICIANDO SERVICIO " && systemctl restart trojan.service && echo "OK " || echo -e "\033[1;32mÎ” FAIL"
msg -bar3
else
killall trojan &> /dev/null
systemctl stop trojankill &>/dev/null
systemctl disable trojankill &>/dev/null
rm -f /etc/systemd/system/trojankill.service &>/dev/null
systemctl stop trojan &>/dev/null
systemctl disable trojan &>/dev/null
rm -f /etc/systemd/system/trojan.service &>/dev/null
fi
clear
[[ ! -z $(ps x | grep trojan | grep -v grep) ]] && {
tittle
SNI=$(cat /usr/local/etc/trojan/config.json | jq -r .ssl.sni)
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m                  Trojan Server Instalado"
echo -e " Remarks   :" "$trojanpass"
echo -e " IP-Address:" "$IP"
echo -e " Port      :" "$trojanport"
echo -e " CLAVE     :" "$new_id"
echo -e " TCP       :" " OPEN"
echo -e " NetWork   :" " WS/TCP"
msg -bar3
echo
[[ $(uname -m 2> /dev/null) != x86_64 ]] &&  {
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e "	\033[0;31m PARA PROCESADORES ARM 64 "
		echo -e "  Si utilizas procesador ARM, este es solo"
		echo -e "             compatible con 1 SNI"
		echo -e "     El Host SNI/BugHost que añadiste "
		echo -e " TU HOST : ${SNI}\033[0m"
		msg -bar3
		echo 
		msg -bar3
		echo
		}
echo -ne "$(msg -verd "") $(msg -verm2 " LINK TCP: ") "&& msg -bra "\033[1;41m trojan://$new_id@$IP:$trojanport"
echo 
msg -bar3
echo 
echo -ne "$(msg -verd "") $(msg -verm2 " LINK WS: ") "&& msg -bra "\033[1;41m trojan://$new_id@$IP:$trojanport?path=%2F&security=tls&type=ws&sni=$SNI"
echo
msg -bar3
echo -e "\033[1;33m Si necesitas cambiar el password edita el archivo o Ve a Menu Administrativo"
echo -e "\033[1;32m Ruta de Configuracion: /usr/local/etc/trojan/config.json"
msg -bar3
[[ $(ps x | grep trojan | grep -v grep) ]] && echo "source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/mod-trojan.sh)" > /bin/troj.sh && chmod +x /bin/troj.sh
}  || {
tittle
echo -e " ERROR INTERNO DE LA CONFIGURACION"
rm -rf $trojdir
}
}

certdom () {
[[ -d /etc/trojan ]] && rm -rf /etc/trojan
mkdir /etc/trojan 1> /dev/null 2> /dev/null
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
echo -e " -> BUSCANDO FILE COMPATIBLE CON ARM"
curl -LO --progress-bar https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json && wget -q -O /usr/local/etc/trojan/config.json https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json
} || {
echo -e " -> DESCARGANDO FILE NATIVO PROCESADORES X86_64"
curl -LO --progress-bar https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/config.json && wget -q --show-progress -O /usr/local/etc/trojan/config.json https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/config.json
[[ ${MENU_OPTION} = 2 ]] && wget https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json &>/dev/null -O /usr/local/etc/trojan/config.json &>/dev/null
}
source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/certUP.sh)
[[ -e /data/cert.crt && -e /data/cert.key ]] && {
cat /data/cert.key > /etc/trojan/private.key
cat /data/cert.crt > /etc/trojan/fullchain.cer
echo -e "CERTIFICADO GENERADO"
echo -ne " \033[1;31m[ ! ] CARGANDO Certificado TROJAN" # Generate CA Config
(
#sed -i '13i        "cert":"/etc/trojan/fullchain.cer",' /usr/local/etc/trojan/config.json
#sed -i '14i        "key":"/etc/trojan/private.key",' /usr/local/etc/trojan/config.json
newdataCERT='/etc/trojan/fullchain.cer'
newdataKEY='/etc/trojan/private.key'
dataCERT=$(cat $config | jq -r .ssl.cert)
dataKEY=$(cat $config | jq -r .ssl.key)
sed -i "s%${dataCERT}%${newdataCERT}%g" $config
sed -i "s%${dataKEY}%${newdataKEY}%g" $config
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar3
echo -e "CERTIFICADO GENERADO EXITOSAMENTE"
msg -bar3
} ||  {
echo -e " ERROR AL CREAR CERTIFICADO "
}
}

troman(){
clear
tittle
[[ -d /etc/trojan ]] && rm -rf /etc/trojan
mkdir /etc/trojan 1> /dev/null 2> /dev/null
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
echo -e " -> BUSCANDO FILE COMPATIBLE CON ARM"
curl -LO --progress-bar https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json && wget -q --show-progress -O /usr/local/etc/trojan/config.json https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json
} || {
echo -e " -> DESCARGANDO FILE NATIVO PROCESADORES X86_64"
curl -LO --progress-bar https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/config.json && wget -q --show-progress -O /usr/local/etc/trojan/config.json https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/config.json
[[ ${MENU_OPTION} = 2 ]] && wget https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json &>/dev/null -O /usr/local/etc/trojan/config.json &>/dev/null
}
openssl genrsa 2048 > /etc/trojan/private.key
chmod 400 /etc/trojan/private.key
openssl req -new -x509 -nodes -sha256 -days 365 -key /etc/trojan/private.key -out /etc/trojan/fullchain.cer
clear
msg -bar3
echo -ne " \033[1;31m[ ! ] GENERANDO Certificado TROJAN" # Generate CA Config
(
#sed -i '13i        "cert":"/etc/trojan/fullchain.cer",' /usr/local/etc/trojan/config.json
#sed -i '14i        "key":"/etc/trojan/private.key",' /usr/local/etc/trojan/config.json
newdataCERT='/etc/trojan/fullchain.cer'
newdataKEY='/etc/trojan/private.key'
dataCERT=$(cat $config | jq -r .ssl.cert)
dataKEY=$(cat $config | jq -r .ssl.key)
sed -i "s%${dataCERT}%${newdataCERT}%g" $config
sed -i "s%${dataKEY}%${newdataKEY}%g" $config
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar3
echo -e " CERTIFICADO GENERADO EXITOSAMENTE"
msg -bar3
}

troauto() {
clear
tittle
msg -bar3
[[ ! -d /usr/local/etc/trojan ]] && mkdir /usr/local/etc/trojan
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
echo -ne " -> BUSCANDO FILE COMPATIBLE CON ARM  - "
#curl -LO --progress-bar https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json || wget -q --show-progress -O /usr/local/etc/trojan/config.json https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json
if wget https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json &>/dev/null -O /usr/local/etc/trojan/config.json &>/dev/null ; then
echo "[ OK ]"
else
echo "[ FAIL ]"
fi
} || {
echo -e " -> DESCARGANDO FILE NATIVO PROCESADORES X86_64 - "
#curl -LO --progress-bar https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/config.json || wget -q --show-progress -O /usr/local/etc/trojan/config.json https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/config.json
if wget https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/config.json &>/dev/null -O /usr/local/etc/trojan/config.json &>/dev/null ; then
[[ ${MENU_OPTION} = 2 ]] && wget https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/configARM.json &>/dev/null -O /usr/local/etc/trojan/config.json &>/dev/null
echo " FICHERO CONFIG  DESCARGADO"
else
echo " IMPOSIBLE CONEGIR FICHERO"
fi
}
echo -ne " \033[1;31m[ ! ] GENERANDO Certificado TROJAN" # Generate CA Config
[[ -d /etc/trojan ]] && rm -rf /etc/trojan
mkdir /etc/trojan 
(
openssl genrsa -out /etc/trojan/private.key 2048 > /dev/null 2>&1
chmod 400 /etc/trojan/private.key > /dev/null 2>&1
(echo "$(curl -sSL ipinfo.io | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"; echo ""; echo "$(wget -qO- ifconfig.me)"; echo ""; echo ""; echo ""; echo "@ChumoGH")|openssl req -new -x509 -nodes -sha256 -days 365 -key /etc/trojan/private.key -out /etc/trojan/fullchain.cer > /dev/null 2>&1
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
#echo -e "\033[1;37mÎ” Generando Configuracion"
#sed -i '13i        "cert":"/etc/trojan/fullchain.cer",' /usr/local/etc/trojan/config.json
newdataCERT='/etc/trojan/fullchain.cer'
newdataKEY='/etc/trojan/private.key'
dataCERT=$(cat $config | jq -r .ssl.cert)
dataKEY=$(cat $config | jq -r .ssl.key)
sed -i "s%${dataCERT}%${newdataCERT}%g" $config
sed -i "s%${dataKEY}%${newdataKEY}%g" $config
cd $HOME
msg -bar3
echo -e " CERTIFICADO GENERADO EXITOSAMENTE"
msg -bar3
#fun_bar
}


[[ -e /etc/adm-lite/menu_credito ]] && nomkey="$(cat < /etc/adm-lite/menu_credito|head -1)" || nomkey="$(curl -sSL "https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Lista/menu_credito")"
IP=$(wget -qO- ifconfig.me)
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}
insta_tro () {
clear
tittle
killall trojan &> /dev/null
if [[ $(uname -m 2> /dev/null) != x86_64 ]]; then
msg -bar3 
echo ""
echo -e " FAVOR EJECUTE EL SCRIPT EN MAQUINAS x86_64 "
echo ""
msg -bar3
echo -e " ARQUITECTURA NO COMPATIBLE CON TROJAN-GO "
echo ""
echo -e " NECESITA ACTIVAR PROXY SOCKS 80 PARA CONTINUAR"
echo ""
echo -e "   INTENTAREMOS REDEFINIR UN INSTALADOR"
echo ""
msg -bar3
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/trojan-ARM.sh)"
else
msg -bar3
echo ""
	echo " LEE DETALLADAMENTE ANTES DE CONTINUAR"
	echo ""
	echo "       Trojan Golang usa modulo de Golang "
	echo "    En este menu te damos a escojer la Opcion"
	echo " TCP - Metodo SSL+TLS Compatible con cualquier SNI"
	echo " TCP+WS - Metodo SSL+TLS + WS ( Admite 1 solo SNI )"
	echo ""
	echo "   ¿Qué quieres hacer?"
	echo ""
	echo " 1) TROJAN-GO | TCP ( Predeterminado )"
	echo " 2) TROJAN-GO | TCP + WS "
	msg -bar3
	echo "   0) Salir + Cancelar"
	until [[ ${MENU_OPTION} =~ ^[1-2]$ ]]; do
	read -t 5 -p " Selecione una opcion [1-2]: " -e -i "1" MENU_OPTION
	done
	case "${MENU_OPTION}" in
	1)
		bash -c "$(wget -O- https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)" 
		;;
	2)
		sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/trojan-ARM.sh)"
		;;
	0)
		exit 0
		;;
	esac
fi
clear
}
tittle
msg -bar3
echo -e "\033[1;37m       - INSTALADOR TROJAN  - ChumoGH|ADM \033[0m"
echo ""
echo -e "\033[1;37m     CORREJIDO EL PROBLEMA DE PROCESADORES ARM \033[0m"
echo ""
echo -e "\033[1;33m       Se instalara¡ el servidor de Trojan\033[0m"
echo -e "\033[1;33m Si ya tenias una instalacion Previa, esta se eliminara\033[0m"
#echo -e "\033[1;33m     Debes tener instalado previamente GO Lang\033[0m"
#[[ ! -z $(which go) ]] && echo -e "               \033[1;33m Go Lang Instalado" || echo -e "\033[1;33m Instale Go Lang en ( *\033[1;33m menu\033[1;32m *\033[1;33m opcion 7 \033[1;32m*\033[1;33m opcion 15 \033[1;32m)"
msg -bar3
echo -e "\033[1;33m En caso de Carga o Certificado con Dominio\n     DEBES TENER LIBRES PUERTOS 80 / 443 \033[0m"
msg -bar3
echo -e "\033[1;33m Deseas Continuar?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(N|n) ]] && exit 
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e " MENU DE GENERACION DE CERTIFICADOS "
menutro () {
fun_ip
echo -e " "
msg -bar3
echo -e " \033[7;49;35m ===>>►► 🐲 Menu TROJAN ChumoGH💥VPS 🐲 ◄◄<<=== \033[0m"
msg -bar3
echo -e "  \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m➮\033[0;33m CERTIFICADO SSL AUTOMATICO    \033[0;32m(#OFICIAL) "
echo -e "  \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m➮\033[0;31m CERT SSL CON DOMINIO     \033[0;33m(#EXPERIMENTAL) "
echo -e "  \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m➮\033[0;33m CERTIFICADO CON CARGA ZIP     \033[0;32m(#OFICIAL) "
#msg -bar3
#echo -e "  \033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m➮\033[0;33m MENU ADMINISTRADOR TROJAN-GO  \033[0;32m(#OFICIAL) "
msg -bar3
selection=$(selection_fun 4)
case ${selection} in
1) insta_tro && troauto && troport ;;
2) insta_tro && certdom && troport;;
3) insta_tro && car_cert && troport;;
4)
[[ ! -z $(which troj.sh) ]] && troj.sh || echo -e "\033[1;33m INSTALE EL SERVICIO PRIMERO" 
read -p " Enter";;
esac
}
fi
menutro && exit