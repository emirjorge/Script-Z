#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)

_mssBOT () {
xyz=$(curl -sSL "https://www.dropbox.com/s/jzkd6fzey2u0m0g/token.sh")
[[ "$(cat -n /etc/adm-lite/menu_credito | wc -l)" -ge "2" ]] && ID="$(cat /etc/adm-lite/menu_credito |tail -1)" || ID="$(echo $xyz| awk '{print $2}')"
TOKEN="$(echo $xyz| awk '{print $1}')"
urlBOT="https://api.telegram.org/bot$TOKEN/sendMessage"
data=$1
MENSAJE="${TTini}${m3ssg}MSG RECIVIDO${m3ssg}${TTfin}\n"
			MENSAJE+="$(msg -br)\n"
			MENSAJE+=" $data \n"
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



rootpass () {
[[ -e /etc/version_instalacion ]] && service ssh stop && exit
clear
[[ "$(whoami)" != "root" ]] && {
	clear
	echo -e "\033[1;31mEXECULTE COMO USUARIO ROOT, \033[1;32m(\033[1;33msudo -i\033[1;32m)\033[0m"
	exit
}
unset yesno
[[ -e /root/name ]] && figlet -p -f smslant < /root/name | lolcat || echo -e "\033[7;49;35m    ${TTini} New ChumoGH${TTcent}VPS  ${TTfin}      "
msg -bar
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
msg -bar
echo -e "			PROCESADOR ARM DETECTADO "
msg -bar
echo
echo -e " SE RECOMIENDA REINICIAR ESTE VPS \n LUEGO DE TERMINAR ESTE PROCESO !!!"
echo
msg -bar
}
echo -e "${cor[5]} ESTA HERRAMIENTA LIBERA ACCESO root EN VPS "
echo -e "${cor[4]}    ESPECIAL PARA (AWS,GOOGLE,AZURE,ETC)
PRESIONA S, CASO CONTRARIO, PRESIONA N"
echo -ne "\033[1;32m   ESTAS SEGURO? [S/N]: "; read yesno
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
#Parametros Aplicados
echo " RESPALDANDO AJUSTES PREVIOS "
echo '#######CONFIG NATURAL' >> /bin/ejecutar/sshd_config
cat /etc/ssh/sshd_config >> /bin/ejecutar/sshd_config
#Inicia Procedimentos
echo -e "\033[1;33mAPLICANDO CONFIGURACIONES"
fun_bar
#[[ $(uname -m 2> /dev/null) != x86_64 ]] && 
apt purge netfilter-persistent -y &> /dev/null
[[ $(grep -c "prohibit-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/prohibit-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "without-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PermitRootLogin" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PermitRootLogin/PermitRootLogin/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication" /etc/ssh/sshd_config) = '0' ]] && {
	echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
#sed -i "s;#PasswordAuthentication;PasswordAuthentication yes;g" /etc/ssh/sshd_config
echo -e ' '
echo -ne " \033[1;31m[ ! ] Services ssh restart"
service ssh restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e ' '
echo -e " INGRESA TU PASS PARA LIBERAR ROOT"
read  -p " NUEVA CONTRASEÑA : " pass
tput cuu1 && tput dl1
tput cuu1 && tput dl1
echo -e " INGRESA NUEVAMENTE TU CONTRASEÑA "
read  -p " REPITE TU PASSWD : " pass1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ $pass != $pass1 ]] && echo "CONTRASEÑAS INVALIDAS, REINTENTA !!" && return
(echo $pass; echo $pass)|passwd 2>/dev/null 
_mssBOT " LIBERASTE ACCESO ROOT EXITOSAMENTE!!"
fun_bar
echo -e "${cor[3]}  Configuraciones aplicadas con exito !"
echo -e " Recuerda Acceder con la identidad ROOT la proxima Entrada"
echo -e "${cor[2]} Su contraseña root ahora es : ${cor[4]}$pass"
service ssh restart > /dev/null 2>&1
service sshd restart > /dev/null 2>&1
fi
msg -bar 
read -p "PRESIONA ENTER PARA FINALIZAR"
msg -bar
}
rootpass