#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH
#clear
config="/usr/local/etc/trojan/config.json"
temp="/etc/trojan/temp.json"
trojdir="/etc/trojan" && [[ ! -d $trojdir ]] && mkdir $trojdir
user_conf="/etc/trojan/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/trojan/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"

barra="\033[0;31m=====================================================\033[0m"
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')


autoDel(){
	seg=$(date +%s)
	while :
	do
		unset users
		users="$(cat $config | jq -r .password[])"
		for i in $users
		do
			[[ ! $i = null ]] && {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				[[ "$seg" -ge "$seg_exp" ]] && {
				Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
					mv $config $temp
					sed "/$i/ d" $temp > $config
					echo "Usuario ${Usr} eliminado $i" >> trojan-log
					chmod 777 $config
					kill $(ps x | grep trojan| grep -v grep | cut -d " " -f1)
					[[ -e /etc/systemd/system/trojan.service ]] && systemctl restart trojan &>/dev/null || screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json -l /root/server.log &
				}
			}
			done
			break
		done
		
}
autoDel

