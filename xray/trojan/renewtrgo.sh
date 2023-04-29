#!/bin/bash
# 
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================

xray="/etc/arf/xray"
trgo="/etc/arf/trojango"
ipvps="/var/lib/arf"
log="/var/log/arf/xray"
logtrgo="/var/log/arf/trojango"
# set random pwd
openssl rand -base64 16 > $xray/passwd
pwd=$(cat $xray/passwd)
# set random uuid
uuid=$(cat /proc/sys/kernel/random/uuid)

clear
source $ipvps/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat $xray/domain)
else
domain=$IP
fi

clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#tr# " "$trgo/akun.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#tr# " "$trgo/akun.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (Days) : " masaaktif
user=$(grep -E "^#tr# " "$trgo/akun.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#tr# " "$trgo/akun.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/#tr# $user $exp/#tr# $user $exp4/g" $trgo/akun.conf
clear
echo ""
echo "============================"
echo "  TrojanGo Account Renewed  "
echo "============================"
echo "Username : $user"
echo "Expired  : $exp4"
echo "=========================="
