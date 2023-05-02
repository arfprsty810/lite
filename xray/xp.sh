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

##----- Auto Remove Vmess
data=( `cat /etc/xray/config.json | grep '^#vm#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vm# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#vm# $user $exp/,/^},{/d" /etc/xray/config.json
sed -i "/^#vm# $user $exp/,/^},{/d" /etc/xray/config.json
rm -f /etc/xray/$user-tls.json /etc/xray/$user-none.json
fi
done
clear

#----- Auto Remove Vless
data=( `cat /etc/xray/config.json | grep '^#vl#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vl# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#vl# $user $exp/,/^},{/d" /etc/xray/config.json
sed -i "/^#vl# $user $exp/,/^},{/d" /etc/xray/config.json
fi
done
clear

#----- Auto Remove Trojan
data=( `cat /etc/xray/config.json | grep '^#tr#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#tr# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#tr# $user $exp/,/^},{/d" /etc/xray/config.json
sed -i "/^#tr# $user $exp/,/^},{/d" /etc/xray/config.json
sed -i "/^#trgo# $user $exp/d" /etc/trojan-go/akun.conf
#sed -i "/^,#trgo# $user $exp/,/^/d" /etc/trojan-go/config.json
sed -i "/^#trgo# $user $exp/d" /etc/trojan-go/akun.conf
#sed -i "/^,#trgo# $user $exp/,/^/d" /etc/trojan-go/config.json
fi
done
clear

#----- Auto Remove Shadowsocks
data=( `cat /etc/shadowsocks-libev/akun.conf | grep '^#ss#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#ss# $user" "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#ss# $user $exp/,/^port_http/d" "/etc/shadowsocks-libev/akun.conf"
sed -i "/^#ss# $user $exp/,/^port_http/d" "/etc/shadowsocks-libev/akun.conf"
service cron restart
systemctl disable shadowsocks-libev-server@$user-tls.service
systemctl disable shadowsocks-libev-server@$user-http.service
systemctl stop shadowsocks-libev-server@$user-tls.service
systemctl stop shadowsocks-libev-server@$user-http.service
rm -f "/etc/shadowsocks-libev/$user-tls.json"
rm -f "/etc/shadowsocks-libev/$user-tls.json"
rm -f "/etc/shadowsocks-libev/$user-http.json"
rm -f "/etc/shadowsocks-libev/$user-http.json"
fi
done
clear

#----- Restart Service
service cron restart
systemctl daemon-reload
systemctl enable xray
systemctl restart xray
systemctl restart nginx
systemctl enable runn
systemctl restart runn
systemctl stop trojan-go
systemctl start trojan-go
systemctl enable trojan-go
systemctl restart trojan-go
#systemctl restart ws-dropbear.service >/dev/null 2>&1
#systemctl restart ws-stunnel.service >/dev/null 2>&1
systemctl restart xray.service >/dev/null 2>&1
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
#/etc/init.d/stunnel5 restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
systemctl restart rc-local.service
clear