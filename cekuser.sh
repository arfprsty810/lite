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

if [ "${EUID}" -ne 0 ]; then
echo -e "${EROR} Please Run This Script As Root User !"
exit 1
fi
export IP=$( curl -s https://ipinfo.io/ip/ )
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"
if [[ -r /etc/xray/domain ]]; then

clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '###' | cut -d ' ' -f 2 | sort | uniq`);
echo "------------------------------------";
echo "-----=[ XRAY User Login ]=-----";
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
#echo -e "user :${GREEN} ${akun} ${NC}
#${RED}Online Jam ${NC}: ${lastlogin} wib";
#echo -e "$jum2";

#curl "https://api.telegram.org/bot6233747947:AAFDo-lXjoiw5BN1ysK-K5g8v-RjFktO99A/getUpdates"

#{"ok":true,"result":[{"update_id":258336815,
#"message":{"message_id":2,"from":{"id":1761935484,"is_bot":false,"first_name":"ARF.PRSTY","username":"arfprsty","language_code":"id"},"chat":{"id":1761935484,"first_name":"ARF.PRSTY","username":"arfprsty","type":"private"},"date":1682606768,"text":"/start","entities":[{"offset":0,"length":6,"type":"bot_command"}]}}]}

token=6233747947:AAFDo-lXjoiw5BN1ysK-K5g8v-RjFktO99A
chatid=1761935484

curl -s -X POST "https://api.telegram.org/bot$token/sendMessage" -d chat_id="$chatid" -d text="user : ${akun} online pada jam ${lastlogin} wib" > /dev/null 2>&1

echo -e "Berhasil mengirim info Login ke Telegram !";
echo "-------------------------------"

#clear
fi
rm -rf /tmp/ipxray.txt
done
rm -rf /tmp/other.txt

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
rm -rvf /root/cekuser.sh
clear
