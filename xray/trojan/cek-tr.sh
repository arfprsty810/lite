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
echo -n > /tmp/other.txt
data=( `cat $xray/config.json | grep '#tr#' | cut -d ' ' -f 2 | sort | uniq`);
echo "------------------------------------";
echo "-----=[ XRAY User Login ]=-----";
echo "------------------------------------";
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptr.txt
data2=( `cat $log/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);

for ip in "${data2[@]}"
do
jum=$(cat $log/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/iptr.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/iptr.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/iptr.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/iptr.txt | nl)
lastlogin=$(cat $log/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)

#trojango
echo -n > /tmp/other.txt
datatr=( `cat $trgo/akun.conf | grep '^#tr#' | cut -d ' ' -f 2`);
for akun in "${datatr[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptr.txt
datatr2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep trojan-go | awk '{print $5}' | cut -d: -f1 | sort | uniq`);

for ip in "${datatr2[@]}"
do
jumtr=$(cat $logtrgo/trojan-go.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jumtr" = "$ip" ]]; then
echo "$jumtr" >> /tmp/iptr.txt
else
echo "$ip" >> /tmp/other.txt
fi
jumtr2=$(cat /tmp/iptr.txt)
sed -i "/$jumtr2/d" /tmp/other.txt > /dev/null 2>&1
done

jumtr=$(cat /tmp/iptr.txt)
if [[ -z "$jumtr" ]]; then
echo > /dev/null
else
jumtr2=$(cat /tmp/iptr.txt | nl)
lastlogintr=$(cat $logtrgo/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)

echo -e "user :${GREEN} ${akun} ${NC}
${RED}Online Jam ${NC}: ${lastlogin} wib";
echo -e "$jum2";
echo "-------------------------------"
fi
rm -rf /tmp/iptr.txt
rm -rf /tmp/other.txt
done
done
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu