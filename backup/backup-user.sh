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

datass=( `cat /etc/shadowsocks-libev/akun.conf | grep '#ss#' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${datass[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
exp=$(grep -wE "^#ss# $akun" "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#ss# $akun $exp/,/^port_http/d" "/etc/shadowsocks-libev/akun.conf"
service cron restart
systemctl disable shadowsocks-libev-server@$akun-tls.service
systemctl disable shadowsocks-libev-server@$akun-http.service
systemctl stop shadowsocks-libev-server@$akun-tls.service
systemctl stop shadowsocks-libev-server@$akun-http.service
rm -f "/etc/shadowsocks-libev/$akun-tls.json"
rm -f "/etc/shadowsocks-libev/$akun-http.json"
done
clear

# -------------------------------------- tambah akun -------------------------------------- #
# vmess
AKUN_VMESS_1="vmess_arf"
UID_VMESS_1="f1a53fef-8533-457b-ab2f-aa915f167519"
EXP_VMESS_1="2030-01-01"
# Vmess
sed -i '/#vmess$/a\#vm# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
# Vmess Worry
sed -i '/#vmessworry$/a\#vm# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","alterId": '"0"',"email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
# Vmess Kuota
sed -i '/#vmesskuota$/a\#vm# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","alterId": '"0"',"email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
# Vmess gRPC
sed -i '/#vmessgrpc$/a\#vm# '"$AKUN_VMESS_1 $EXP_VMESS_1"'\
},{"id": "'""$UID_VMESS_1""'","email": "'""$AKUN_VMESS_1""'"' /etc/xray/config.json
clear

# vless
AKUN_VLESS_1="vless_arf"
UID_VLESS_1="77f6e656-649b-4caf-9beb-6e9f32290aac"
EXP_VLESS_1="2030-01-01"
# Vless
sed -i '/#vless$/a\#vl# '"$AKUN_VLESS_1 $EXP_VLESS_1"'\
},{"id": "'""$UID_VLESS_1""'","email": "'""$AKUN_VLESS_1""'"' /etc/xray/config.json
# Vless gRPC
sed -i '/#vlessgrpc$/a\#vl# '"$AKUN_VLESS_1 $EXP_VLESS_1"'\
},{"id": "'""$UID_VLESS_1""'","email": "'""$AKUN_VLESS_1""'"' /etc/xray/config.json
clear

# trojan
AKUN_TROJAN_1="trojan_arf"
PASSWORD_TROJAN_GO_1="trojan_arf"
UID_TROJAN_1="8394ff55-d075-4d1d-a65a-c82f16dc62d1"
UID_TROJAN_GO=$(cat /etc/trojan-go/uuid)
EXP_TROJAN_1="2030-01-01"
EXP_TROJAN_GO1="2030-01-01"
# Trojan-WS
sed -i '/#trojanws$/a\#tr# '"$AKUN_TROJAN_1 $EXP_TROJAN_1"'\
},{"password": "'""$UID_TROJAN_1""'","email": "'""$AKUN_TROJAN_1""'"' /etc/xray/config.json
# Trojan gRPC
sed -i '/#trojangrpc$/a\#tr# '"$AKUN_TROJAN_1 $EXP_TROJAN_1"'\
},{"password": "'""$UID_TROJAN_1""'","email": "'""$AKUN_TROJAN_1""'"' /etc/xray/config.json
# Trojan-GO
sed -i '/"'""$UID_TROJAN_GO""'"$/a\,"'""$PASSWORD_TROJAN_GO_1""'"' /etc/trojan-go/config.json
echo -e "#trgo# $PASSWORD_TROJAN_GO_1 $EXP_TROJAN_GO1" >> /etc/trojan-go/akun.conf
clear

# ShadowSocks
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
METHOD="aes-256-cfb"
AKUN_SS_1="ss_arf"
PASSWORD_SS_1="ss_arf"
EXP_SS_1="2030-01-01"
cat > /etc/shadowsocks-libev/$AKUN_SS_1-tls.json<<END
{   
    "server":"0.0.0.0",
    "server_port":$tls,
    "password":"$PASSWORD_SS_1",
    "timeout":60,
    "method":"$METHOD",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}
END
cat > /etc/shadowsocks-libev/$AKUN_SS_1-http.json <<-END
{
    "server":"0.0.0.0",
    "server_port":$http,
    "password":"$PASSWORD_SS_1",
    "timeout":60,
    "method":"$METHOD",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=http"
}
END
chmod +x /etc/shadowsocks-libev/$AKUN_SS_1-tls.json
chmod +x /etc/shadowsocks-libev/$AKUN_SS_1-http.json
echo -e "#ss# $PASSWORD_SS_1 $EXP_SS_1
port_tls $tls
port_http $http">>"/etc/shadowsocks-libev/akun.conf"
service cron restart
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
systemctl stop trojan-go
systemctl start trojan-go
systemctl enable trojan-go
systemctl restart trojan-go
systemctl enable shadowsocks-libev-server@$akun-tls.service
systemctl start shadowsocks-libev-server@$akun-tls.service
systemctl enable shadowsocks-libev-server@$akun-http.service
systemctl start shadowsocks-libev-server@$akun-http.service
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

echo ""
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
clear
exit

# rm -rvf /usr/bin/backup-user && wget -q -O /usr/bin/backup-user "https://raw.githubusercontent.com/arfprsty810/lite/main/backup/backup-user.sh" && chmod +x /usr/bin/backup-user && sed -i -e 's/\r$//' /bin/backup-user && /bin/backup-user
