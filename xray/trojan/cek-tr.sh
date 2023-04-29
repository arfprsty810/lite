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

trgo="/etc/arf/trojango"
ipvps="/var/lib/arf"
logtrgo="/var/log/arf/trojango"

clear
source $ipvps/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat $xray/domain)
else
domain=$IP
fi

clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '#trgo#' | cut -d ' ' -f 2 | sort | uniq`);
echo "------------------------------------";
echo "-----=[ Trojan User Login ]=-----";
echo "------------------------------------";
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipxray.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipxray.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipxray.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipxray.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipxray.txt | nl)
lastlogin=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
echo " Trojan-Ws & Trojan GRPC :
echo -e "user :${GREEN} ${akun} ${NC}
${RED}Online Jam ${NC}: ${lastlogin} wib";
echo -e "$jum2";
echo "-------------------------------"
fi
rm -rf /tmp/ipxray.txt
done
rm -rf /tmp/other.txt

echo -n > /tmp/other.txt
datatrgo=( `cat $trgo/akun.conf | grep '^#trgo#' | cut -d ' ' -f 2`);
for akun in "${datatrgo[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptrojango.txt
datatrgo2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep trojan-go | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${datatrgo2[@]}"
do
jumtrgo=$(cat $logtrgo/trojan-go.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jumtrgo" = "$ip" ]]; then
echo "$jumtrgo" >> /tmp/iptrojango.txt
else
echo "$ip" >> /tmp/other.txt
fi
jumtrgo2=$(cat /tmp/iptrojango.txt)
sed -i "/$jumtrgo2/d" /tmp/other.txt > /dev/null 2>&1
done
jumtrgo=$(cat /tmp/iptrojango.txt)
if [[ -z "$jumtrgo" ]]; then
echo > /dev/null
else
jumtrgo2=$(cat /tmp/iptrojango.txt | nl)
lastlogintrgo=$(cat $logtrgo/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
echo "------------------------------------";
echo " Trojan-Go :
echo -e "user :${GREEN} ${akun} ${NC}
${RED}Online Jam ${NC}: ${lastlogintrgo} wib";
echo "$jumtrgo2";
echo "------------------------------------";
fi
rm -rf /tmp/iptrojango.txt
done
rm -rf /tmp/other.txt

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu