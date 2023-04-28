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

# --- cek akun --- #
# vless
datavl=( `cat /etc/xray/config.json | grep '#vl#' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${datavl[@]}"
do
# vmess
datavm=( `cat /etc/xray/config.json | grep '#vm#' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${datavm[@]}"
do
# trojan
datatr=( `cat /etc/xray/config.json | grep '#tr#' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${datavm[@]}"
do

# --- delete akun --- #
exp=$(grep -wE "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#& $akun $exp/,/^},{/d" /etc/xray/config.json

# --- tambah akun --- #
# vless
AKUN_VLESS_1="vless_asu"
UID_VLESS_1="6ab17040-6eef-45ee-864d-36f4c758241d"
EXP_VLESS_1="2024-03-23"
sed -i '/#vless$/a\#vl# '"$AKUN_VLESS_1 $EXP_VLESS_1"'\
},{"id": "'""$UID_VLESS_1""'","email": "'""$AKUN_VLESS_1""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#vl# '"$AKUN_VLESS_1 $exp"'\
},{"id": "'""$UID_VLESS_1""'","email": "'""$AKUN_VLESS_1""'"' /etc/xray/config.json

# vmess
AKUN_VMESS_1="vmess_asu"
UID_VMESS_1="f1a53fef-8533-457b-ab2f-aa915f167519"
EXP_VMESS_1="2024-03-23"
sed -i '/#vmess$/a\#vl# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\#vl# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
systemctl restart xray
sleep 1
clear