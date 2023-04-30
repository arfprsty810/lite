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

trgo="/etc/trojan-go"
ipvps="/var/lib/arf"
logtrgo="/var/log/trojan-go"

clear
source $ipvps/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat $xray/domain)
else
domain=$IP
fi

clear
echo "------------------------------------";
echo "-----=[ Trojan-Go User Login ]=-----";
echo "------------------------------------";
echo -n > /tmp/other.txt
data=( `cat $trgo/akun.conf | grep '^#trgo#' | cut -d ' ' -f 2`);
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptrojango.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep trojan-go | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat $logtrgo/trojan-go.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/iptrojango.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/iptrojango.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/iptrojango.txt)
oth=$(cat /tmp/other.txt | sort | uniq | nl)
lastlogin=$(cat $logtrgo/trojan-go.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
if [[ -z "$jum" ]]; then
echo > /dev/null
#else
jum2=$(cat /tmp/iptrojango.txt | nl)
echo "user : $akun";
echo "Login dengan IP:"
echo "$oth $lastlogin";
#echo "$jum2";
echo "------------------------------------";
fi
done

rm -rf /tmp/iptrojango.txt
rm -rf /tmp/other.txt