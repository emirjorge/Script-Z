#!/bin/bash
set -euo pipefail

function prompt() {
    while true; do
        read -p "$1 [y/N] " yn
        case $yn in
            [Yy] ) return 0;;
            [Nn]|"" ) return 1;;
        esac
    done
}

if [[ $(id -u) != 0 ]]; then
    echo Please run this script as root.
    exit 1
fi

if [[ $(uname -m 2> /dev/null) != x86_64 ]]; then
    echo Please run this script on x86_64 machine.
fi
NAME=trojan
NAMEDOWN=trojan-go
VERSION=$(curl -fsSL https://api.github.com/repos/p4gefau1t/trojan-go/releases/latest | grep tag_name | sed -E 's/.*"v(.*)".*/\1/')
#TARBALL="$NAMEDOWN-linux-arm.zip"
[[ $(uname -m 2> /dev/null) != x86_64 ]] && TARBALL="$NAMEDOWN-linux-arm64.zip" || TARBALL="$NAMEDOWN-linux-amd64.zip"
DOWNLOADURL="https://github.com/p4gefau1t/$NAMEDOWN/releases/download/v$VERSION/$TARBALL"
TMPDIR="$(mktemp -d)"
INSTALLPREFIX=/usr/local
DIRSHAREGEO=/usr/share/trojan-go
SYSTEMDPREFIX=/etc/systemd/system

BINARYPATH="$INSTALLPREFIX/bin/$NAME"
CONFIGPATH="$INSTALLPREFIX/etc/$NAME/config.json"
SYSTEMDPATH="$SYSTEMDPREFIX/$NAME.service"

echo Entering temp directory $TMPDIR...
cd "$TMPDIR"

echo Downloading $NAME $VERSION...
curl -LO --progress-bar "$DOWNLOADURL" || wget -q --show-progress "$DOWNLOADURL"
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || apt-get install unzip -y &>/dev/null
#if wget -q --show-progress https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-arm.zip ; then
#echo Downloading $NAME $VERSION...
#fi


echo Unpacking $NAME $VERSION...
unzip "$TARBALL"
[[ -d $DIRSHAREGEO ]] && rm -f $DIRSHAREGEO/* || mkdir $DIRSHAREGEO
mv geoip.dat $DIRSHAREGEO/geoip.dat
mv geosite.dat $DIRSHAREGEO/geosite.dat

echo INSTALANDO $NAMEDOWN $VERSION to $BINARYPATH...
install -Dm755 "$NAMEDOWN" "$BINARYPATH"

echo INSTALANDO $NAMEDOWN FICHERO DE CONFIG $CONFIGPATH...
if ! [[ -f "$CONFIGPATH" ]] || prompt "La configuración del servidor ya existe en $CONFIGPATH, ¿sobrescribir?"; then
    install -Dm644 example/server.json "$CONFIGPATH"
else
    echo OMITIENDO $NAMEDOWN server config...
fi

if [[ -d "$SYSTEMDPREFIX" ]]; then
    echo Installing $NAME systemd service to $SYSTEMDPATH...
    if ! [[ -f "$SYSTEMDPATH" ]] || prompt "El servicio systemd ya existe en $SYSTEMDPATH, ¿sobrescribir?"; then
        cat > "$SYSTEMDPATH" << EOF
[Unit]
Description=$NAME
Documentation=https://trojan-gfw.github.io/$NAME/config https://github.com/p4gefau1t/$NAME/
After=network.target network-online.target nss-lookup.target mysql.service mariadb.service mysqld.service

[Service]
Type=simple
StandardError=journal
ExecStart="$BINARYPATH" --config "$CONFIGPATH"
ExecReload=/bin/kill -HUP \$MAINPID
LimitNOFILE=51200
Restart=on-failure
RestartSec=1s

[Install]
WantedBy=multi-user.target
EOF

# 

        echo Reloading systemd daemon...
        systemctl daemon-reload
    else
        echo Skipping installing $NAME systemd service...
    fi
fi

echo Deleting temp directory $TMPDIR...
rm -rf "$TMPDIR"

echo Done!
