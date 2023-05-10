#!/bin/bash
## Update Xray

red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
clear

now_version=$(xray --version | grep 'Xray' | cut -d ' ' -f 2 | sort)
clear
lastest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          XRAY CORE UPDATE $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
sleep 2

echo -e " Checking Now Version ..."
echo ""
sleep 2

echo -e " Checking Lastest Version ..."
echo ""
sleep 2

echo -e " Result :"
echo -e " Now Version : Xray v$now_version "
echo -e " Lastest Version : Xray v$lastest_version "
echo ""
sleep 2

if [[ $now_version == $lastest_version ]]; then
echo -e " Your Xray is Lastest Version!"
echo -e " Your Xray Version is :"
echo -e " Xray v$lastest_version"
sleep 2
else
echo -e " Your Xray is old version"
echo -e " Auto Update Xray ..."
sleep 2

mkdir -p /etc/arfvpn/backup/xray
cp /etc/xray/config.json /etc/arfvpn/backup/xray
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $lastest_version
sleep 2

cp /etc/arfvpn/backup/xray/config.json /etc/xray
chmod +x /etc/xray/config.json
systemctl daemon-reload >/dev/null 2>&1
systemctl restart xray >/dev/null 2>&1
sleep 2

echo ""
echo -e " XRAY SUCCESSFULLY UPDATE !"
echo ""
echo -e " Your Xray Version is :"
echo -e " Xray v$lastest_version"
sleep 5
fi
clear