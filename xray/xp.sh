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

##----- Auto Remove Vmess
data=( `cat $xray/config.json | grep '^#vm#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vm# $user" "$xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#vm# $user $exp/,/^},{/d" $xray/config.json
sed -i "/^#vm# $user $exp/,/^},{/d" $xray/config.json
rm -f $xray/$user-tls.json $xray/$user-none.json
fi
done
clear

#----- Auto Remove Vless
data=( `cat $xray/config.json | grep '^#vl#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vl# $user" "$xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#vl# $user $exp/,/^},{/d" $xray/config.json
sed -i "/^#vl# $user $exp/,/^},{/d" $xray/config.json
fi
done
clear

#----- Auto Remove Trojan
data=( `cat $xray/config.json | grep '^#tr#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#tr# $user" "$xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#tr# $user $exp/,/^},{/d" $xray/config.json
sed -i "/^#tr# $user $exp/,/^},{/d" $xray/config.json
sed -i "/^#trgo# $user $exp/d" $trgo/akun.conf
#sed -i "/^,#trgo# $user $exp/,/^/d" $trgo/config.json
sed -i "/^#trgo# $user $exp/d" $trgo/akun.conf
#sed -i "/^,#trgo# $user $exp/,/^/d" $trgo/config.json
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