#!/bin/bash
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
NUMBER_OF_CLIENTS=$(grep -c -E "^#vm# " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
        echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e "           Renew Vmess             "
        echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
		echo ""
		echo "You have no existing clients!"
		echo ""
		echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        menu
	fi

	clear
	echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "           Renew Vmess             "
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
  	grep -E "^#vm# " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
    echo ""
    red "tap enter to go back"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	read -rp "Input Username : " user
    if [ -z $user ]; then
    menu
    else
    read -p "Expired (days): " masaaktif
    exp=$(grep -wE "^#vm# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$(($exp2 + $masaaktif))
    exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
    sed -i "/#vm# $user/c\#vm# $user $exp4" /etc/xray/config.json
    systemctl restart xray > /dev/null 2>&1
    clear
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " VMESS Account Was Successfully Renewed"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo " Client Name : $user"
    echo " Expired On  : $exp4"
    echo ""
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
    fi
