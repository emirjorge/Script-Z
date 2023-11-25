#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH

clear
config="/usr/local/etc/trojan/config.json"
configLOCK="/usr/local/etc/trojan/config.json.lock"
temp="/etc/trojan/temp.json"
trojdir="/etc/trojan" && [[ ! -d $trojdir ]] && mkdir $trojdir
user_conf="/etc/trojan/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/trojan/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
[[ ! -e $trojdir/conf ]] && echo "autBackup 0" > $trojdir/conf
if [[ $(cat $trojdir/conf | grep "autBackup") = "" ]]; then
	echo "autBackup 0" >> $trojdir/conf
fi
unset barra
barra="\033[0;34m•••••••••••••••••••••••••••••••••••••••••••••••••\033[0m"
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar/msg)
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')

ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="x";;
"x")txt[$i]=".";;
"5")txt[$i]="s";;
"s")txt[$i]="5";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="0";;
"0")txt[$i]="4";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}


restroj(){
msg -bar3
[[ $(ps x | grep trojan | grep -v grep) ]] && {
kill $(ps x | grep trojan| grep -v grep | cut -d " " -f1) &> /dev/null
[[ $(ps x | grep trojan | grep -v grep) ]] && killall $(which trojan) &> /dev/null
}
[[ -e /root/server.log ]] && echo "@ChumoGH " > /root/server.log || touch /root/server.log
#[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
#echo -ne " \033[1;32m  • RESTART FOR ARM X64 • " && (screen -dmS trojanserv $(which trojan) --config /usr/local/etc/trojan/config.json >> /root/server.log &) && echo "\033[1;35m OK " || echo -e "\033[1;32mÎ” FAIL"
#} || echo -ne "\033[1;32m  • REINICIANDO SERVICIO • " && (screen -dmS trojanserv $(which trojan) /usr/local/etc/trojan/config.json -l /root/server.log &) && echo "OK " || echo -e "\033[1;32mÎ” FAIL"
systemctl restart trojan &>/dev/null
msg -bar3
#chekKEY &> /dev/null 2>&1
[[ "$(ps x | grep trojan| grep -v grep)" ]] && echo -e "  • SERVICIO CORRIENDO EN EL PUERTO | ➣ $(cat $config | jq -r .local_port) "
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
			MENSAJE+=" INSECTO DETECTADO EN TROJAN-GO Plus\n"
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


restore(){
	clear

	unset num
	unset opcion
	unset _res

	if [[ -z $(ls $backdir) ]]; then
		title "	no se encontraron respaldos"
		sleep 0.3
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
	[[ -z $opcion ]] && blanco "\n deves seleccionar una opcion!" && sleep 2 && return
	[[ ! $opcion =~ $numero ]] && blanco "\n solo deves ingresar numeros!" && sleep 2 && return
	[[ $opcion -gt ${#_res[@]} ]] && blanco "\n solo numeros entre 0 y ${#_res[@]}" && sleep 2 && return

	mkdir $backdir/tmp
	tar xpf $backdir/${_res[$opcion]} -C $backdir/tmp/

	clear
	title "	Archivos que se restauran"

	if rm -rf $config && cp $tmpdir/config.json $temp; then
		sleep 1
		cat $temp > $config
		chmod 777 $config
		rm $temp
		blanco " /usr/local/etc/trojan/config.json..." && verde "[ok]" 
	else
		blanco " /usr/local/etc/trojan/config.json..." && rojo "[fail]"	
	fi

	if rm -rf $user_conf && cp $tmpdir/user $user_conf; then
		blanco " /etc/troja/user..." && verde "[ok]"
	else
		blanco " /etc/trojan/user..." && rojo "[fail]"
	fi
    #[[ -e $tmpdir/fullchain.cer ]] && mv $tmpdir/fullchain.cer $tmpdir/fullchain.crt
	if cp $tmpdir/*.cer /etc/trojan/fullchain.cer && cp $tmpdir/*.key /etc/trojan/private.key; then
		blanco " /etc/trojan/fullchain.cer..." && verde "[ok]"
		blanco " /etc/trojan/private.key..." && verde "[ok]"
	else
		blanco " /etc/trojan/fullchain.cer..." && rojo "[fail]"
		blanco " /etc/trojan/private.key..." && rojo "[fail]"
		echo $barra
		echo -e "VALIDA TU CERTIFICADO SSL "
		fi
	rm -rf $tmpdir
	msg -bar3
	continuar
	read foo
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
	col "7)" "\033[1;33m RESPALDO LOCAL "
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "opcion" 0
	read opcion

	case $opcion in
		1)	backup
			clear
			title "	Nuevo Respaldo Creado..."
			sleep 0.5;;
		2)	restore;;
		3)	rm -rf $backdir/*.tar
			clear
			title "	Almacer de Respaldo limpia..."
			sleep 0.5;;
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
echo -e "INGRESE LINK Online en GitHub, o VPS \n" 
read -p "Pega tu Link : " url1
wget -q -O $backdir/BakcOnline.tar $url1 && echo -e "\033[1;31m- \033[1;32mFile Exito!"  && restore || echo -e "\033[1;31m- \033[1;31mFile Fallo" && sleep 2
		;;
		7)
		bakc;;
		0)	break;;
		*)	blanco "opcion incorrecta..." && sleep 2;;
	esac
	done
}



backup() {
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
	back="$backdir/troj___${fecha}___${hora}.tar"
	[[ -e /etc/trojan/fullchain.cer ]] && cer="/etc/trojan/fullchain.cer"
	[[ -e /etc/trojan/private.key ]] && key="/etc/trojan/private.key"

	cp $user_conf $tmp
	cp $config $tmp
	[[ ! $cer = null ]] && [[ -e $cer ]] && cp $cer $tmp
	[[ ! $key = null ]] && [[ -e $cer ]] && cp $key $tmp

	cd $tmp
	tar -cpf $back *
	cp $back /var/www/html/trojanBack.tar && echo -e "
 Descargarlo desde cualquier sitio con acceso WEB
  LINK : http://$(wget -qO- ifconfig.me):81/trojanBack.tar \033[0m
-------------------------------------------------------"
read -p "ENTER PARA CONTINUAR"
	rm -rf $tmp
 }

trojan() 
{
wget -q https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango.sh; chmod +x trojango.sh; ./trojango.sh
rm -f trojango.sh
}


install_ini () {
add-apt-repository universe
apt update -y; apt upgrade -y
clear
echo -e "$BARRA"
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
echo -e "$BARRA"
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install bc................... $ESTATUS "
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
chekKEY &> /dev/null 2>&1
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
echo -e "$BARRA"
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
echo -e "$BARRA"
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}


changeCERT () {
clear&&clear
unset opcion
			dataCERT=$(cat $config | jq -r .ssl.cert)
			dataKEY=$(cat $config | jq -r .ssl.key)
			msg -bar3 && echo ""
			echo -e " INGRESO DE RUTA DE CERTIFICADO SSL VALIDO ACTUAL" && echo ""
			echo -e " DATA CRT : ${dataCERT}" && echo "" && echo -e " DATA CRT : ${dataKEY}" && echo "" && msg -bar3 && echo -e ""
	while :
    do
	echo -e " DESEAS CAMBIAR RUTA DE TU CERTIFICADO SSL ? "
			read -p " [SI / NO ] :" opcion
            case $opcion in
				0)break ;;
                [Yy]|[Ss]) 
				echo -e " A CONTINUACION INGRESE SUS NUEVAS RUTAS DE CERTIFICADO"
				echo -e " DEFAULT ( /data/cert.crt && /data/cert.key ) ." && echo ""
				read -p "$(echo -e " DATA CRT :")" -e -i "/data/cert.crt" newdataCERT
				tput cuu1 && tput dl1
				read -p "$(echo -e " DATA KEY :")" -e -i "/data/cert.key" newdataKEY
				sed -i "s%${dataCERT}%${newdataCERT}%g" $config
				sed -i "s%${dataKEY}%${newdataKEY}%g" $config
				break
				;;
                [Nn]) cancelar && sleep 0.5 && break;;
                *) echo -e "\n \033[1;49;37mSelecione (S) para si o (N) para no!\033[0m" && sleep 0.5 && continue
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
					;;
            esac
	done
			
		}

 
changeSNI () {
clear&&clear
unset opcion
			dataCERT=$(cat $config | jq -r .ssl.sni)
			msg -bar3 && echo ""
			echo -e " INGRESO INGRESA SNI VALIDO" && echo ""
			echo -e " SNI : ${dataCERT}" && echo "" && msg -bar3 && echo -e ""
	while :
    do
	echo -e " DESEAS CAMBIAR SNI ? "
			read -p " [SI / NO ] :" opcion
            case $opcion in
				0)break ;;
                [Yy]|[Ss])
				echo -e " A CONTINUACION INGRESE SU NUEVO SNI"
				read -p "$(echo -e " SNI Defauld : ")" -e -i "ssl.whatsapp.net" newdataKEY
				if sed -i "s%${dataCERT}%${newdataCERT}%g" $config ; then
				echo -e " EXITO AL CAMBIAR TU SNI"
				else
				newdataKEY='"sni": "${newdataKEY}",'
				sed -i "s%${dataCERT}%${newdataCERT}%g" $config
				echo -e " ERROR AL MODIFICAR SNI"
				fi
				break
				;;
                [Nn]) cancelar && sleep 0.5 && break;;
                *) echo -e "\n \033[1;49;37mSelecione (S) para si o (N) para no!\033[0m" && sleep 0.5 && continue
					;;
            esac
	done
			
		}

 
 

enon(){
echo "source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/trojango-sh/trojan-sh/mod-trojan.sh)" > /bin/troj.sh
chmod +x /bin/troj.sh
		clear
		msg -bar3
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		msg -bar3
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * troj.sh * !!!"
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
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de troj.sh"
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
	blanco "	  Ajustes e Entrasda Rapida de Menu TROJAN"
	msg -bar3
	col "1)" "Habilitar troj.sh, Como entrada Rapida"
	col "2)" "Eliminar troj.sh, Como entrada Rapida"
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
		*) blanco " solo numeros de 0 a 2" && sleep 0.3;;
	esac
    done

}


 
on_off_res(){
	if [[ $(cat $trojdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
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

	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m ➣   \033[1;37m${2}")
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
_check=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /etc/adm-lite/trojanports.txt && cat /etc/adm-lite/trojanports.txt` > /dev/null 2>&1 
#trojanports=$(echo $trojanports | awk {'print $1'})
trojanports=$(cat $config | jq -r .local_port)
#_tconex=$(netstat -nap | grep "$trojanports" | grep trojan  | grep ESTABLISHED| grep tcp6 | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq | wc -l)
_tconex=$(netstat -nap | grep "$trojanports" | grep trojan  | grep ESTABLISHED | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq | wc -l)
	v1=$(cat /etc/adm-lite/v-local.log)
	v2=$(cat /bin/ejecutar/v-new.log)
	#echo -e "\033[7;49;35m  =====>>►► 🐲 Menu TROJAN ChumoGH💥VPS 🐲 ◄◄<<=====    \033[0m"
	msg -bar3
	[[ $(uname -m 2> /dev/null) != x86_64 ]] && echo -e "	CPU : ARM64 - BINARIO : trojan-go"
	[[ ${v1} = ${v2} ]] && echo -e "      \e[97m\033[1;44mPROYECT TROJAN BY @ChumoGH  [$v1]  \033[0m" || echo -e "   \e[97m\033[1;44mProyecto Trojan by @ChumoGH [$v1] >> \033[1;92m[$v2]  \033[0m"
	echo -e "          ${cor[2]} ${pPIniT} \033[1;37mIP: \033[1;31m$(wget -qO- ifconfig.me) ${cor[2]}${pPIniT} \033[1;37m"
	[[ ! -z ${_check} ]] && echo -e "       \e[97m\033[1;44mPUERTO ACTIVO :\033[0m \033[3;32m$trojanports\033[0m   \e[97m\033[1;44m ACTIVOS:\033[0m \033[3;32m\e[97m\033[1;41m $_tconex " ||  echo -e "     \e[97m\033[1;41m  SERVICIO TROJAN NO INICIADO \033[3;32m"
}

title(){
	msg -bar3
	
	echo -e "     >>>>>>> Fecha Actual $(date '+%d-%m-%Y') <<<<<<<<<<<"
	blanco "$1"
	msg -bar3
}

userDat(){
	#echo -e "     >>>>>>> Fecha Actual $(date '+%d-%m-%Y') <<<<<<<<<<<"
	blanco "	N°    Usuarios 		  fech exp   dias"
	msg -bar3
}

log_traff () {
[[ $log0 -le 1 ]] && restroj && let log0++ && clear 
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
IP_tconex=$(netstat -nap | grep "$trojanports" | grep trojan | grep ESTABLISHED | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq)
#IP_tconex=$(netstat -nap | grep "$trojanports"| grep trojan | grep ESTABLISHED | grep tcp6 | awk {'print $5'}| awk -F ":" '{print $1}' | sort | uniq)
nick="$(cat $config | grep ',"')"
#users="$(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
users="$(cat $config | jq -r .password[])"
n=1
[[ -z $IP_tconex ]] && echo -e " NO HAY USUARIOS CONECTADOS!" && return
for i in $IP_tconex
do
	USERauth=$(cat $HOME/server.log | grep $i | cut -d: -f4 | grep authenticated |awk '{print $4}'| sort | uniq)
	#PORTauth=$(cat $HOME/server.log | grep $i | cut -d: -f4 | grep authenticated |awk '{print $1}')	
	#PORTdisco=$(cat $HOME/server.log | grep $i | cut -d: -f4 | grep authenticated |awk '{print $1}')
#	echo -e " $n) $USERauth - $i "
	Users+="$USERauth\n"
	#let n++
done
#echo -e "$Users"
echo -e " N) USER | CONEXIONES "|column -t -s '|'
for U in $users
	do
	CConT=$(echo -e "$Users" | grep $U |wc -l)
	[[ $CConT = 0 ]] && continue
	Usr="$(cat ${user_conf}|grep -w "${U}"|cut -d'|' -f1)"
	UConc+=" $n) $Usr |$CConT\n"
	let n++
done
echo -e "$UConc"|column -t -s '|' 
msg -bar3
continuar
read foo
#tail -f /usr/local/etc/trojan/config.json


}

fun_bar () {
#==comando a ejecutar==
comando="$1"
#==interfas==
in=' ['
en=' ] '
full_in="➛"
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
		sleep 0.1
	done
done
echo -e " $full_in $full_en"
sleep 0.1s
}



add_user(){
autoDel
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	nick="$(cat $config | grep ',"')"
	users="$(cat $config | jq -r .password[])"
	title "		CREAR USUARIO Trojan"
	userDat
	n=0
	for i in $users
	do
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = chumoghscript ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
		Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"

			col "$n)" "${Usr}" "$DateExp" "$exp"
		}
		let n++
	done
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "ESCRIBE TU USUARIO :" 0
	read usser
	usser=$(echo ${usser} |sed -e's/[^0-9a-z]//ig')
	[[ -z $usser ]] && vacio && sleep 0.3 && continue
	[[ $usser = 0 ]] && break
	[[ -z $(echo "$users" | grep -w $usser) ]] && {
	new_id=$(uuidgen)
	msg -bar3
	blanco "DURACION EN DIAS" 0
	read dias
	dias=$(echo ${dias} |sed -e's/[^0-9]//ig')
	espacios=$(echo "$usser" | tr -d '[[:space:]]')
	usser=$espacios
	mv $config $temp
	movetm=$(echo -e "$new_id" | sed 's/^/,"/;s/$/"/')
	sed "10i\        ${movetm}" $temp > $config
	#echo -e "$opcion" | sed 's/^/,"/;s/$/"/'
	sed -i "/${usser}/d" $user_conf
	echo "$usser | ${new_id} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
	chmod 777 $config
	rm $temp
	clear
	msg -bar3
	blanco "	Usuario $usser creado con exito"
	msg -bar3
	autoDel
	restroj
	} || echo " USUARIO YA EXISTE " && sleep 0.5s
    done
}

renew(){
	while :
	do
		unset user
		clear
		title "		RENOVAR USUARIOS"
		userDat
		userEpx=$(cut -d "|" -f2 $user_conf)
		n=1
		for i in $userEpx
		do
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			[[ "$seg" -gt "$seg_exp" ]] && {
				Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
				col "$n)" "$Usr" "$DateExp" "\033[0;31m[Exp]"
				uid[$n]="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
				user[$n]=$Usr
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
			sleep 0.3
		} || {
			[[ $opcion>=${n} ]] && {
				let n--
				blanco "solo numero entre 1 y $n"
				sleep 0.3
		} || {
			blanco "DURACION EN DIAS" 0
			read dias
			mv $config $temp
			movetm=$(echo -e "${uid[$opcion]}" | sed 's/^/,"/;s/$/"/')
			sed "10i\        $movetm" $temp > $config
			sed -i "/${uid[$opcion]}/d" $user_conf
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
			chmod 777 $config
			rm -f $temp
			clear
			msg -bar3
			blanco "	Usuario > ${user[$opcion]} renovado hasta $(date '+%y-%m-%d' -d " +$dias days")"
			sleep 5s
		  }
		}
	done
restroj
continuar
read foo
}


dell_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	nick="$(cat $config | grep ',"')"
	users="$(cat $config | jq -r .password[])"
	title "	ELIMINAR USUARIO TROJAN"
	userDat
	n=0
	for i in $users
	do
		userd[$n]=$i
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = chumoghscript ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"

			col "$n)" "${Usr}" "$DateExp" "$exp"
		}
		p=$n
		let n++
	done
	userEpx=$(cut -d "|" -f2 $user_conf)
	for i in $userEpx
	do	
		DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
		seg_exp=$(date +%s --date="$DateExp")
		[[ "$seg" -gt "$seg_exp" ]] && {
			Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
			col "$n)" "$Usr" "$DateExp" "\033[0;31m[Exp]"
			expUser[$n]=$i
			let n++
		}
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
		sleep 0.3
	} || {
		let n--
		[[ $opcion>=${n} ]] && {
			blanco "solo numero entre 1 y $n"
			sleep 0.3
		} || {
			
			[[ $opcion>=${p} ]] && {
			sed -i "/${expUser[$opcion]}/d" $user_conf
			} || {
			mv $config $temp 
			sed -i "/${expUser[$opcion]}/d" $user_conf
			sed "/${userd[$opcion]}/ d" $temp > $config
			chmod 777 $config
			rm $temp
			clear
			msg -bar3
			blanco "	Usuario ${userd[$opcion]}${expUser[$opcion]} eliminado"
			msg -bar3
			sleep 0.5s
			}
		}
	
	}
	done
	restroj
}

bakc() {
clear
	while :
	do
	clear
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		msg -bar3
		col "1)" "\033[1;33mRestaurar Copia"
		msg -bar3
		col "2)" "\033[1;33mCrear Copia"
		msg -bar3
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		msg -bar3
		blanco "opcion" 0
		read opcion
		case $opcion in
			1)[[ -e config.json ]] && cp config.json /usr/local/etc/trojan/config.json || echo "No existe Copia";;
			2)[[ -e /usr/local/etc/trojan/config.json ]] && cp /usr/local/etc/trojan/config.json config.json || echo "No existe Copia";;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 2" && sleep 0.3;;
		esac
	done


}

reintro() {
clear
	while :
	do
	clear
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		msg -bar3
		col "1)" "\033[1;33mReinstalar Servicio"
		msg -bar3
		col "2)" "\033[1;33mReiniciar Servicio"
		msg -bar3
		col "3)" "\033[1;33mEditar Manual ( nano )"
		msg -bar3
		col "4)" "\033[1;33mREGISTRAR DOMINIO "
		msg -bar3
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		msg -bar3
		blanco "opcion" 0
		read opcion
		case $opcion in
			1)
			trojan
			;;
			2)
			[[ -e /usr/local/etc/trojan/config.json ]] && {
			title "Fichero Interno Configurado"
			restroj
			} || echo -e  "Servicio No instalado Aun"
			;;
			3)
			nano /usr/local/etc/trojan/config.json
			;;
			4)
			dmn=$(echo "$(ls /root/.acme.sh | grep '_ecc')" | sed 's/_ecc//')
			echo -e " INGRESA TU DOMINIO REGISTRADO EN TU CERTIFICADO "
			echo -e "                +    OJO     +"
			echo -e "  Si validaste tu certificado con dominio ACME"
			echo -e "        Se tomara tu dominio automatico"
			read -p " DIGITA TU DOMINIO : " -e -i $dmn domain
			echo "$domain" > /etc/trojan/domain
			;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 3" && sleep 0.3;;
		esac
	done


continuar
read foo
}

cattro () {

clear
	while :
	do
	clear
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		msg -bar3
		col "1)" "\033[1;33mMostrar fichero de CONFIG "
		msg -bar3
		col "2)" "\033[1;33mEditar Config Manual ( Comando nano )"
		msg -bar3
		col "3)" "\033[1;33m Cambiar RUTA CERTIFICADO"
		msg -bar3
		col "4)" "\033[1;33m CAMBIAR SNI INTERNO"
		msg -bar3
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		msg -bar3
		blanco "opcion" 0
		read opcion
		case $opcion in
			1)
			title "Fichero Interno Configurado"
			cat /usr/local/etc/trojan/config.json
			blanco "Fin Fichero "
			continuar
			read foo
			;;
			2)
			[[ -e /usr/local/etc/trojan/config.json ]] && {
			title "Fichero Interno Configurado"
			nano /usr/local/etc/trojan/config.json
			restroj
			} || echo -e  "Servicio No instalado Aun"
			;;
			3)
			changeCERT
			restroj
			;;
			4)
			changeSNI
			restroj
			;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 2" && sleep 0.3;;
		esac
	done
continuar
}

log_ACCESS () {
clear&&clear
tail -f /root/server.log
continuar
return
}

view_user(){
unset opcion
	unset seg
	seg=$(date +%s)
	while :
	do

		clear
	nick="$(cat $config | grep ',"')"
	users="$(cat $config | jq -r .password[])"
		title "	VER USUARIO TROJAN"
		userDat


		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = chumoghscript ]] && {
				Usr="Admin"
				DateExp=" Ilimitado"
			} || {
			Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "${Usr}" "$DateExp" "$exp"
			let n++
		done

		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "VER DATOS DEL USUARIO" 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break
		n=1
		unset i
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp
				Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			#col "$n)" "$i" "$DateExp" "$exp"
		#[[ $n = $opcion ]] && trojanpass=$i && dataEX=$DateExp && dEX=$exp
		#[[ $n = $opcion ]] && trojanpass=$i && dataEX=$DateExp && dEX=$exp
				let n++
		done
		let opcion--
		addip=$(wget -qO- ifconfig.me)
		host=$(cat $config | jq -r .ssl.sni)
		trojanport=$(cat $config | jq -r .local_port)
		UUID=$(cat $config | jq -r .password[$opcion])
		DateExp="$(cat ${user_conf}|grep -w "${UUID}"|cut -d'|' -f3)"
		seg_exp=$(date +%s --date="$DateExp")
		exp="[$(($(($seg_exp - $seg)) / 86400))]"
		Usr="$(cat ${user_conf}|grep -w "${UUID}"|cut -d'|' -f1)"
		[[ $host = null ]] && read -p " Host / SNI : " host
		[[ -z $host ]] && host="null"
		clear&&clear
		blanco $barra
		blanco "              TROJAN LINK CONFIG"
		blanco $barra
		col "$opcion)" "${Usr}" "$DateExp" "$exp" #"${UUID}"
		trojan_conf
		blanco $barra
		continuar
		read foo
	done
}

trojan_conf (){
[[ -e /etc/trojan/domain ]] && domain=$(cat < /etc/trojan/domain)
		msg -bar3
		col2 " Remarks   : " "${Usr}"
		[[ -z $domain ]] || col2 " DOMAIN    : " "$domain"
		col2 " IP-Address: " "$addip"
		col2 " Port      : " "$trojanport"
		col2 " Password  : " "$UUID"
		[[ $(cat $config | jq -r .websocket.enabled) = "true" ]] && col2 " NetWork   : " "WS/TCP" || col2 " NetWork   : " "TCP"
		[[ ! -z $host ]] && col2 " Host/SNI  : " "$host"
		msg -bar3
		echo " CONFIG TCP NATIVA"
		echo -e "\033[3;32m trojan://$(echo $UUID@$addip:$trojanport?sni=$host#"${Usr}" )\033[3;32m"
		msg -bar3
		echo -ne "$(msg -verd "") $(msg -verm2 " ") "&& msg -bra "\033[1;41mEn APPS como HTTP Inyector,CUSTOM,Trojan,etc"
		[[ $(cat $config | jq -r .websocket.enabled) = "true" ]] && echo -e "\033[3;32m trojan://$UUID@$IP:$trojanport?path=%2F&security=tls&type=ws&sni=$host\033[3;32m" || echo -e "\033[3;32m trojan://$(echo $UUID@$addip:$trojanport?sni=$host#"${Usr}" )\033[3;32m"
		msg -bar3
		[[ -z $domain ]] || echo -e "\033[3;32m trojan://$(echo $UUID@$domain:$trojanport?sni=$host#"${Usr}" )\033[3;32m"

}

main(){
	[[ ! -e $config ]] && {
		clear
		msg -bar3
		blanco " No se encontro ningun archovo de configracion Trojan"
		msg -bar3
		blanco "	  No instalo Trojan o esta usando\n	     una vercion diferente!!!"
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi esta usando una vercion Trojan diferente"
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
		[[ -e /bin/troj.sh ]] && enrap="\033[1;92m[ ACT ]" || enrap="\033[0;31m[ DESC ]"
		[[ -e $configLOCK ]] && _v2LOCK="$(cat $configLOCK|wc -l)" || _v2LOCK=0
		clear
		title2
		title "   Ram: \033[1;32m$_usor  \033[0;31m<<< \033[1;37mMENU Trojan \033[0;31m>>>  \033[1;37mCPU: \033[1;32m$_usop"
		col "1)" "CREAR NUEVO USUARIO "
		col "2)" "\033[0;92mRENOVAR UN USUARIO "
		col "3)" "\033[0;31mREMOVER UN USUARIO "
		col "4)" "VER USUARIOS REGISTRADOS \033[1;32m( $(cat $user_conf | wc -l) )"
		col "5)" "VER USUARIOS CONECTADOS "
		col "b)" "LOCK/UNLOCK USUUARIO $_v2LOCK"
		msg -bar3
		col "6)" "\033[1;33mENTRAR CON  \033[1;31mtroj.sh $enrap"
		msg -bar3
		col "7)" "\033[1;33mMostrar/Editar Fichero interno"
		col "8)" "\033[1;33mMenu Avanzado Trojan"
		col "9)" "\033[1;33mConf. Copias de Respaldo"	
		col "10)" "\033[1;33m LOG DE ACTIVIDAD"	
		msg -bar3
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		msg -bar3
		blanco "SELECCION : " 0
		read opcion

		case $opcion in
			1)add_user;;
			2)renew;;
			3)dell_user;;
			4)view_user;;
			5)log_traff;;
			6)enttrada;;
			7)cattro;;
			8)reintro;;
			9)backups;;
			10)log_ACCESS;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 10" && sleep 0.3s;;
		esac
	done
}
#while [[ $? -eq 0 ]]; do
[[ $1 = "--restart" ]] && restroj
#[[ $? -eq 0 ]] && main
#done
main

