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

# -------------------------------------- delete akun -------------------------------------- #
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
clear

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
clear

# trojan
datatr=( `cat /etc/xray/config.json | grep '#tr#' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${datatr[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
exp=$(grep -wE "^#tr# $akun" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#tr# $akun $exp/,/^},{/d" /etc/xray/config.json
sed -i "/^,#trgo# $akun $exp/,/^/d" /etc/trojan-go/config.json
sed -i "/^#trgo# $akun $exp/d" /etc/trojan-go/akun.conf
done
clear

# -------------------------------------- tambah akun -------------------------------------- #
# vmess
AKUN_VMESS_1="vmess_arf"
UID_VMESS_1="f1a53fef-8533-457b-ab2f-aa915f167519"
EXP_VMESS_1="2030-01-01"
sed -i '/#vmess$/a\#vm# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
sed -i '/#vmessworry$/a\#vm# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","alterId": '"0"',"email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
sed -i '/#vmesskuota$/a\#vm# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","alterId": '"0"',"email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\#vm# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
clear

# vless
AKUN_VLESS_1="vless_arf"
UID_VLESS_1="77f6e656-649b-4caf-9beb-6e9f32290aac"
EXP_VLESS_1="2030-01-01"
sed -i '/#vless$/a\#vl# '"$AKUN_VLESS_1 $EXP_VLESS_1"'\
},{"id": "'""$UID_VLESS_1""'","email": "'""$AKUN_VLESS_1""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#vl# '"$AKUN_VLESS_1 $EXP_VLESS_1"'\
},{"id": "'""$UID_VLESS_1""'","email": "'""$AKUN_VLESS_1""'"' /etc/xray/config.json
clear

# trojan
AKUN_TROJAN_1="trojan_arf"
UID_TROJAN_1="8394ff55-d075-4d1d-a65a-c82f16dc62d1"
EXP_TROJAN_1="2030-01-01"
sed -i '/#trojanws$/a\#tr# '"$AKUN_TROJAN_1 $EXP_TROJAN_1"'\
},{"password": "'""$UID_TROJAN_1""'","email": "'""$AKUN_TROJAN_1""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#tr# '"$AKUN_TROJAN_1 $EXP_TROJAN_1"'\
},{"password": "'""$UID_TROJAN_1""'","email": "'""$AKUN_TROJAN_1""'"' /etc/xray/config.json
sed -i '/"'""$uuid""'"$/a\,#trgo# '"$AKUN_TROJAN_1 $EXP_TROJAN_1"'\
"'""$UID_TROJAN_1""'"' /etc/trojan-go/config.json
echo -e "#trgo# $AKUN_TROJAN_1 $EXP_TROJAN_1" >> /etc/trojan-go/akun.conf
clear

# -------------------------------------- restart service -------------------------------------- #
echo -e "$yell[SERVICE]$NC Restart All service"
systemctl daemon-reload
sleep 1
clear

echo -e "[ ${green}ok${NC} ] Enable & restart xray "
sleep 1
systemctl enable xray
systemctl restart xray
systemctl restart nginx
systemctl enable runn
systemctl restart runn
clear

echo ""
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
clear
exit

# rm -rvf /usr/bin/backup-user && wget -q -O /usr/bin/backup-user "https://raw.githubusercontent.com/arfprsty810/lite/main/backup/backup-user.sh" && chmod +x /usr/bin/backup-user && sed -i -e 's/\r$//' /bin/backup-user && /bin/backup-user
