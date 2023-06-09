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
arfvpn="/etc/arfvpn"
xray="/etc/xray"
trgo="/etc/arfvpn/trojan-go"
ipvps="/var/lib/arfvpn"
uuid=$(cat /proc/sys/kernel/random/uuid)
uuidtrgo=$(cat ${trgo}/uuid)
source ${ipvps}/ipvps.conf
if [[ "${IP}" = "" ]]; then
domain=$(cat ${arfvpn}/domain)
else
domain=${IP}
fi
clear 

tr="$(cat ~/log-install.txt | grep -w "Trojan TLS " | cut -d: -f2|sed 's/ //g')"
trgo="$(cat ~/log-install.txt | grep -w "Trojan GO " | cut -d: -f2|sed 's/ //g')"
until [[ ${user} =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;36m        Add Trojan Account      \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w ${user} ${xray}/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
            echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo -e "\\E[0;41;36m      Add Trojan Account      \E[0m"
            echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
add-tr
		fi
	done
 
read -p "Expired (days): " masaaktif
exp=`date -d "${masaaktif} days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\#tr# '"${user} ${exp}"'\
},{"password": "'""${uuid}""'","email": "'""${user}""'"' ${xray}/config.json
sed -i '/#trojangrpc$/a\#tr# '"${user} ${exp}"'\
},{"password": "'""${uuid}""'","email": "'""${user}""'"' ${xray}/config.json
sed -i '/"'""${uuidtrgo}""'"$/a\,"'""${user}""'"' /etc/arfvpn/trojan-go/config.json
echo -e "#trgo# ${user} ${exp}" >>  /etc/arfvpn/trojan-go/akun.conf
systemctl restart xray
systemctl restart trojan-go.service
trojanlink1="trojan://${uuid}@${domain}:${tr}?path=%2Ftrojan-ws&security=tls&host=bug.com&type=ws&sni=bug.com#${user}"
trojanlink2="trojan://${uuid}@${domain}:${tr}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink3="trojan-go://${uuid}@${domain}:${tr}?path=%2Ftrojan-ws&security=tls&host=bug.com&type=ws&sni=bug.com#${user}"
trojanlink4="trojan-go://${user}@${domain}:${trgo}/?sni=${domain}&type=ws&host=${domain}&path=/trojango&encryption=none#${user}"
clear
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "\\E[0;41;36m        Trojan Account        \E[0m" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Remarks   : ${user}" | tee -a /etc/log-create-user.log
echo -e "Domain    : ${domain}" | tee -a /etc/log-create-user.log
echo -e "Port      : 80 / ${tr}" | tee -a /etc/log-create-user.log
echo -e "Port GO 1 : ${tr}" | tee -a /etc/log-create-user.log
echo -e "Port GO 2 : ${trgo}" | tee -a /etc/log-create-user.log
echo -e "Password  : ${uuid}" | tee -a /etc/log-create-user.log
echo -e "Trojan Go : ${user}" | tee -a /etc/log-create-user.log
echo -e "Network   : ws/grpc" | tee -a /etc/log-create-user.log
echo -e "Path      : /trojan-ws" | tee -a /etc/log-create-user.log
echo -e "Path GO   : /trojango" | tee -a /etc/log-create-user.log
echo -e "SerName   : trojan-grpc" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link WS : ${trojanlink1}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link GRPC : ${trojanlink2}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link GO 1 : ${trojanlink3}" | tee -a /etc/log-create-user.log
echo -e "Link GO 2 : ${trojanlink4}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Expired On : ${exp}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"
menu 
