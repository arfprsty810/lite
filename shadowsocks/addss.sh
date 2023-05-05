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
arfvpn="/etc/arfvpn"
IP=$(cat $arfvpn/IP)
ISP=$(cat $arfvpn/ISP)
DOMAIN=$(cat $arfvpn/domain)

lastport1=$(grep "port_tls" /etc/shadowsocks-libev/akun.conf | tail -n1 | awk '{print $2}')
lastport2=$(grep "port_http" /etc/shadowsocks-libev/akun.conf | tail -n1 | awk '{print $2}')
if [[ $lastport1 == '' ]]; then
tls=2443
else
tls="$((lastport1+1))"
fi
if [[ $lastport2 == '' ]]; then
http=3443
else
http="$((lastport2+1))"
fi
method="aes-256-cfb"
clear

echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;36m    Add Shadowsocks OBFS Account    \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Password : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/shadowsocks-libev/akun.conf | wc -l)
		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;36m    Add Shadowsocks OBFS Account    \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo "A client with the specified name was already created, please choose another name."
echo ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
addss
		fi
	done
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
cat > /etc/shadowsocks-libev/$user-tls.json<<END
{   
    "server":"0.0.0.0",
    "server_port":$tls,
    "password":"$user",
    "timeout":60,
    "method":"$method",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}
END
cat > /etc/shadowsocks-libev/$user-http.json <<-END
{
    "server":"0.0.0.0",
    "server_port":$http,
    "password":"$user",
    "timeout":60,
    "method":"$method",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=http"
}
END
chmod +x /etc/shadowsocks-libev/$user-tls.json
chmod +x /etc/shadowsocks-libev/$user-http.json
clear

systemctl enable shadowsocks-libev-server@$user-tls.service
systemctl start shadowsocks-libev-server@$user-tls.service
systemctl enable shadowsocks-libev-server@$user-http.service
systemctl start shadowsocks-libev-server@$user-http.service
clear

tmp1=$(echo -n "${method}:${user}@${IP}:$tls" | base64 -w0)
tmp2=$(echo -n "${method}:${user}@${IP}:$http" | base64 -w0)
linkss1="ss://${tmp1}?plugin=obfs-local;obfs=tls;obfs-host=bing.com"
linkss2="ss://${tmp2}?plugin=obfs-local;obfs=http;obfs-host=bing.com"
clear

echo -e "#ss# $user $exp
port_tls $tls
port_http $http">>"/etc/shadowsocks-libev/akun.conf"
service cron restart
clear

echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "\\E[0;41;36m        Shadowsocks Account        \E[0m" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Remarks   : $user" | tee -a /etc/log-create-user.log
echo -e "IP/Host   : $IP" | tee -a /etc/log-create-user.log
echo -e "Domain    : $DOMAIN" | tee -a /etc/log-create-user.log
echo -e "Port TLS  : $tls" | tee -a /etc/log-create-user.log
echo -e "Port NTLS : $http" | tee -a /etc/log-create-user.log
echo -e "Method    : $method" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link TLS : $linkss1" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link none TLS : $linkss2" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Expired On : $exp" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"

menu
