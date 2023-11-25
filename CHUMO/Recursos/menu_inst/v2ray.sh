#!/bin/bash
# Author: Jrohy
# github: https://github.com/Jrohy/multi-v2ray

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
Key="$(cat /etc/cghkey)"
_Key='/etc/cghkey'
[[ -e /file ]] && _double=$(cat < /file) ||  {
wget -q -O /file https://www.dropbox.com/s/5hr0wv1imo35j1e/Control-Bot.txt
_double=$(curl -sSL "https://www.dropbox.com/s/5hr0wv1imo35j1e/Control-Bot.txt")
echo -e "$(echo -e "$_double" | grep ${IiP})" > /file
}
_check2="$(echo -e "$_double" | grep ${IiP})"
[[ ! -e /etc/folteto ]] && {
wget --no-check-certificate -O /etc/folteto $IiP:81/ChumoGH/checkIP.log 
cheklist="$(cat /etc/folteto)"
echo -e "$(echo -e "$cheklist" | grep ${IP})" > /etc/folteto
}
[[ -z ${_check2} ]] && {
[[ ! -d /bin/ejecutar/Ubam ]] && mkdir /bin/ejecutar/Ubam
mss_='\n BotGEN NO AUTORIZADO POR @ChumoGH '
echo 'clear&&clear
echo -e "\n\n\n \033[0;31m==================================================
   ¡ 🚫 KEY BANEADA  🚫 ! CONTACTE Su ADMINISTRADOR
 ================================================== \n\n ${mss_} \n\n
 SI CONSIDERA QUE FUE UN ERROR, TECLEA ** cgh **
 " 
' > /bin/menu 
rm -f /etc/folteto
mv etc/adm-lite/* /bin/ejecutar/Ubam
 			MENSAJE="${TTini}${m3ssg}MSG RECIVIDO${m3ssg}${TTfin}\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" IP Clon: ${IP} Rechazada\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" ${lLaM} INSECTO DETECTADO EN INSTALL V2RAY ${lLaM}\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+="       ${rUlq} Bot generador de key ${rUlq}\n"
			MENSAJE+="           ${pUn5A} By @ChumoGH ${pUn5A} \n"
			MENSAJE+=" ---------------------------------------------\n"	
			curl -s --max-time 10 -d "chat_id=$ID&disable_web_page_preview=1&text=$(echo -e "$MENSAJE")" $urlBOT &>/dev/null 	
exit && exit
}
}



apt install jq -y
BEIJING_UPDATE_TIME=3
BEGIN_PATH=$(pwd)
INSTALL_WAY=0
HELP=0
REMOVE=0
CHINESE=0
BASE_SOURCE_PATH="https://multi.netlify.app"
UTIL_PATH="/etc/v2ray_util/util.cfg"
UTIL_CFG="$BASE_SOURCE_PATH/v2ray_util/util_core/util.cfg"
BASH_COMPLETION_SHELL="$BASE_SOURCE_PATH/v2ray"
CLEAN_IPTABLES_SHELL="$BASE_SOURCE_PATH/v2ray_util/global_setting/clean_iptables.sh"
#Centos 临时取消别名
[[ -f /etc/redhat-release && -z $(echo $SHELL|grep zsh) ]] && unalias -a
[[ -z $(echo $SHELL|grep zsh) ]] && ENV_FILE=".bashrc" || ENV_FILE=".zshrc"
#######color code########
RED="31m"
GREEN="32m"
YELLOW="33m"
BLUE="36m"
FUCHSIA="35m"

colorEcho(){
    COLOR=$1
    echo -e "\033[${COLOR}${@:2}\033[0m"
}

#######get params#########
while [[ $# > 0 ]];do
    key="$1"
    case $key in
        --remove)
        REMOVE=1
        ;;
        -h|--help)
        HELP=1
        ;;
        -k|--keep)
        INSTALL_WAY=1
        colorEcho ${BLUE} "keep config to update\n"
        ;;
        --zh)
        CHINESE=0
        colorEcho ${BLUE} "VERSION CHINA..\n"
        ;;
        *)
                # unknown option
        ;;
    esac
    shift # past argument or value
done
#############################

help(){
    echo "bash v2ray.sh [-h|--help] [-k|--keep] [--remove]"
    echo "  -h, --help           Show help"
    echo "  -k, --keep           keep the config.json to update"
    echo "      --remove         remove v2ray,xray && multi-v2ray"
    echo "                       no params to new install"
    return 0
}

removeV2Ray() {
    #卸载V2ray脚本
    bash <(curl -L -s https://multi.netlify.app/go.sh) --remove >/dev/null 2>&1
    rm -rf /etc/v2ray >/dev/null 2>&1
    rm -rf /var/log/v2ray >/dev/null 2>&1

    #卸载Xray脚本
    bash <(curl -L -s https://multi.netlify.app/go.sh) --remove -x >/dev/null 2>&1
    rm -rf /etc/xray >/dev/null 2>&1
    rm -rf /var/log/xray >/dev/null 2>&1

    #清理v2ray相关iptable规则
    bash <(curl -L -s $CLEAN_IPTABLES_SHELL)

    #卸载multi-v2ray
    pip uninstall v2ray_util -y
    rm -rf /usr/share/bash-completion/completions/v2ray.bash >/dev/null 2>&1
    rm -rf /usr/share/bash-completion/completions/v2ray >/dev/null 2>&1
    rm -rf /usr/share/bash-completion/completions/xray >/dev/null 2>&1
    rm -rf /etc/bash_completion.d/v2ray.bash >/dev/null 2>&1
    rm -rf /usr/local/bin/v2ray >/dev/null 2>&1
    rm -rf /etc/v2ray_util >/dev/null 2>&1
    rm -rf /etc/profile.d/iptables.sh >/dev/null 2>&1
    rm -rf /root/.iptables >/dev/null 2>&1

    #删除v2ray定时更新任务
    crontab -l|sed '/SHELL=/d;/v2ray/d'|sed '/SHELL=/d;/xray/d' > crontab.txt
    crontab crontab.txt >/dev/null 2>&1
    rm -f crontab.txt >/dev/null 2>&1

    if [[ ${PACKAGE_MANAGER} == 'dnf' || ${PACKAGE_MANAGER} == 'yum' ]];then
        systemctl restart crond >/dev/null 2>&1
    else
        systemctl restart cron >/dev/null 2>&1
    fi

    #删除multi-v2ray环境变量
    sed -i '/v2ray/d' ~/$ENV_FILE
    sed -i '/xray/d' ~/$ENV_FILE
    source ~/$ENV_FILE

    RC_SERVICE=`systemctl status rc-local|grep loaded|egrep -o "[A-Za-z/]+/rc-local.service"`

    RC_FILE=`cat $RC_SERVICE|grep ExecStart|awk '{print $1}'|cut -d = -f2`

    sed -i '/iptables/d' ~/$RC_FILE

    colorEcho ${GREEN} "uninstall success!"
}

closeSELinux() {
    #禁用SELinux
    if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
        sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
        setenforce 0
    fi
}

checkSys() {
    #检查是否为Root
    [ $(id -u) != "0" ] && { colorEcho ${RED} "Error: Porfavor ejecute este SCRIP como root"; exit 1; }

    if [[ `command -v apt-get` ]];then
        PACKAGE_MANAGER='apt-get'
    elif [[ `command -v dnf` ]];then
        PACKAGE_MANAGER='dnf'
    elif [[ `command -v yum` ]];then
        PACKAGE_MANAGER='yum'
    else
        colorEcho $RED "Sistema No Soportado!"
        exit 1
    fi
}

#安装依赖
installDependent(){
    if [[ ${PACKAGE_MANAGER} == 'dnf' || ${PACKAGE_MANAGER} == 'yum' ]];then
        ${PACKAGE_MANAGER} install socat crontabs bash-completion which -y
    else
        ${PACKAGE_MANAGER} update
        ${PACKAGE_MANAGER} install socat cron bash-completion ntpdate gawk -y
    fi

    #install python3 & pip
    source <(curl -sL https://python3.netlify.app/install.sh)
}

updateProject() {
    [[ ! $(type pip 2>/dev/null) ]] && colorEcho $RED "pip no install!" && exit 1

    [[ -e /etc/profile.d/iptables.sh ]] && rm -f /etc/profile.d/iptables.sh

    RC_SERVICE=`systemctl status rc-local|grep loaded|egrep -o "[A-Za-z/]+/rc-local.service"`

    RC_FILE=`cat $RC_SERVICE|grep ExecStart|awk '{print $1}'|cut -d = -f2`

    if [[ ! -e $RC_FILE || -z `cat $RC_FILE|grep iptables` ]];then
        LOCAL_IP=`curl -s http://api.ipify.org 2>/dev/null`
        [[ `echo $LOCAL_IP|grep :` ]] && IPTABLE_WAY="ip6tables" || IPTABLE_WAY="iptables" 
        if [[ ! -e $RC_FILE || -z `cat $RC_FILE|grep "/bin/bash"` ]];then
            echo "#!/bin/bash" >> $RC_FILE
        fi
        if [[ -z `cat $RC_SERVICE|grep "\[Install\]"` ]];then
            cat >> $RC_SERVICE << EOF

[Install]
WantedBy=multi-user.target
EOF
            systemctl daemon-reload
        fi
        echo "[[ -e /root/.iptables ]] && $IPTABLE_WAY-restore -c < /root/.iptables" >> $RC_FILE
        chmod +x $RC_FILE
        systemctl restart rc-local
        systemctl enable rc-local

        $IPTABLE_WAY-save -c > /root/.iptables
    fi

    pip install -U v2ray_util

    if [[ -e $UTIL_PATH ]];then
        [[ -z $(cat $UTIL_PATH|grep lang) ]] && echo "lang=en" >> $UTIL_PATH
    else
        mkdir -p /etc/v2ray_util
        curl $UTIL_CFG > $UTIL_PATH
    fi

    [[ $CHINESE == 1 ]] && sed -i "s/lang=en/lang=zh/g" $UTIL_PATH

    rm -f /usr/local/bin/v2ray >/dev/null 2>&1
    ln -s $(which v2ray-util) /usr/local/bin/v2ray
    rm -f /usr/local/bin/xray >/dev/null 2>&1
    ln -s $(which v2ray-util) /usr/local/bin/xray

    #移除旧的v2ray bash_completion脚本
    [[ -e /etc/bash_completion.d/v2ray.bash ]] && rm -f /etc/bash_completion.d/v2ray.bash
    [[ -e /usr/share/bash-completion/completions/v2ray.bash ]] && rm -f /usr/share/bash-completion/completions/v2ray.bash

    #更新v2ray bash_completion脚本
    curl $BASH_COMPLETION_SHELL > /usr/share/bash-completion/completions/v2ray
    curl $BASH_COMPLETION_SHELL > /usr/share/bash-completion/completions/xray
    if [[ -z $(echo $SHELL|grep zsh) ]];then
        source /usr/share/bash-completion/completions/v2ray
        source /usr/share/bash-completion/completions/xray
    fi
    
    #安装V2ray主程序
    [[ ${INSTALL_WAY} == 0 ]] && bash <(curl -L -s https://multi.netlify.app/go.sh) --version v4.45.2
}

#时间同步
timeSync() {
    if [[ ${INSTALL_WAY} == 0 ]];then
        echo -e "${Info} Sincronizando tiempo!.. ${Font}"
        if [[ `command -v ntpdate` ]];then
            ntpdate pool.ntp.org
        elif [[ `command -v chronyc` ]];then
            chronyc -a makestep
        fi

        if [[ $? -eq 0 ]];then 
            echo -e "${OK} Tiempo Sync Exitosamente ${Font}"
            echo -e "${OK} Ahora: `date -R`${Font}"
        fi
    fi
}

profileInit() {

    #清理v2ray模块环境变量
    [[ $(grep v2ray ~/$ENV_FILE) ]] && sed -i '/v2ray/d' ~/$ENV_FILE && source ~/$ENV_FILE

    #解决Python3中文显示问题
    [[ -z $(grep PYTHONIOENCODING=utf-8 ~/$ENV_FILE) ]] && echo "export PYTHONIOENCODING=utf-8" >> ~/$ENV_FILE && source ~/$ENV_FILE

    #全新安装的新配置
    [[ ${INSTALL_WAY} == 0 ]] && v2ray new || v2ray new

    echo ""
}

installFinish() {
#if [[ ${INSTALL_WAY} == 0 ]]; then
clear&&clear
#v2ray new
#v2ray info
#echo -e "porfavor dijite 'v2ray' para administrar v2ray\n"
#fi
	config='/etc/v2ray/config.json'
    tmp='/etc/v2ray/temp.json'
    #jq 'del(.inbounds[].streamSettings.kcpSettings[])' < $config >> $tmp
    #rm -rf /etc/v2ray/config.json
    #jq '.inbounds[].streamSettings += {"network":"ws","wsSettings":{"path": "/ADMcgh/","headers": {"Host": "ejemplo.com"}}}' < $tmp >> $config
    chmod 777 $config
    msg -bar
    if [[ $(v2ray restart|grep success) ]]; then
    	[[ $(which v2ray) ]] && v2ray info
    	msg -bar
        echo -e "\033[1;32mINSTALACION FINALIZADA"
    else
    	[[ $(which v2ray) ]] && v2ray info
    	msg -bar
        print_center -verm2 "INSTALACION FINALIZADA"
        echo -e "\033[1;31m "  'Pero fallo el reinicio del servicio v2ray'
	echo -e " LEA DETALLADAMENTE LOS MENSAJES "
	echo -e ""
    fi
	cd ${BEGIN_PATH}
    [[ ${INSTALL_WAY} == 0 ]] && WAY="install" || WAY="update"
    colorEcho  ${GREEN} "multi-v2ray ${WAY} success!\n"
    echo -e  "Por favor verifique el log"
    read -p " presiona enter"
	#chekKEY &> /dev/null 2>&1
    #回到原点
}


main() {

    [[ ${HELP} == 1 ]] && help && return

    [[ ${REMOVE} == 1 ]] && colorEcho ${BLUE} " REMOVE BY @ChumoGH " && removeV2Ray && return

    [[ ${INSTALL_WAY} == 0 ]] && colorEcho ${BLUE} " INSTALACION NUEVA NATIVA By @ChumoGH\n"

    checkSys

    installDependent

    closeSELinux

    timeSync

    updateProject

    profileInit

    installFinish
}

main