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

# --- delete akun --- #
# vless
datavl=( `cat /etc/xray/config.json | grep '#vl#' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${datavl[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
exp=$(grep -wE "^#vl# $akun" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#vl# $akun $exp/,/^},{/d" /etc/xray/config.json
done

# vmess
datavm=( `cat /etc/xray/config.json | grep '#vm#' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${datavm[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
exp=$(grep -wE "^#vm# $akun" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#vm# $akun $exp/,/^},{/d" /etc/xray/config.json
done

# trojan
datatr=( `cat /etc/xray/config.json | grep '#tr#' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${datatr[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
exp=$(grep -wE "^#tr# $akun" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#tr# $akun $exp/,/^},{/d" /etc/xray/config.json
done
systemctl restart xray

# --- tambah akun --- #
# vless
AKUN_VLESS_1="vless_asu"
UID_VLESS_1="6ab17040-6eef-45ee-864d-36f4c758241d"
EXP_VLESS_1="2024-03-23"
sed -i '/#vless$/a\#vl# '"$AKUN_VLESS_1 $EXP_VLESS_1"'\
},{"id": "'""$UID_VLESS_1""'","email": "'""$AKUN_VLESS_1""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#vl# '"$AKUN_VLESS_1 $exp"'\
},{"id": "'""$UID_VLESS_1""'","email": "'""$AKUN_VLESS_1""'"' /etc/xray/config.json

systemctl restart xray
sleep 1

rm -rvf /usr/bin/backup-user
clear
echo ""
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
exit

# wget -q -O /usr/bin/backup-user "https://raw.githubusercontent.com/arfprsty810/lite/main/backup/backup-user.sh" && chmod +x /usr/bin/backup-user && sed -i -e 's/\r$//' /bin/backup-user && /bin/backup-user
