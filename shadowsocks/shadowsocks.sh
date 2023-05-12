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
# set random pwd
#openssl rand -base64 16 > $arfvpn/passwd
</dev/urandom tr -dc a-z0-9 | head -c16 > $arfvpn/passwd
pwd=$(cat $arfvpn/passwd)
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING SHADOWSOCKS $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
#Server konfigurasi
echo -e "[ ${green}INFO$NC ] MENGINSTALL SAHDOWSOCKS-LIBEV"
sleep 2
clear

echo -e "[ ${green}INFO$NC ] MEMBUAT CONFIG SHADOWSOCKS"
sleep 1
cat > /etc/shadowsocks-libev/config.json <<END
{   
    "server":"0.0.0.0",
    "server_port":8488,
    "password":"$pwd",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
}
END
clear

echo -e "[ ${green}INFO$NC ] MEMBUAT CLIENT CONFIG"
sleep 1
cat > /etc/shadowsocks-libev.json <<END
{
    "server":"127.0.0.1",
    "server_port":8388,
    "local_port":1080,
    "password":"$pwd",
    "timeout":60,
    "method":"chacha20-ietf-poly1305",
    "mode":"tcp_and_udp",
    "fast_open":true,
    "plugin":"/usr/bin/obfs-local",
    "plugin_opts":"obfs=tls;failover=127.0.0.1:1443;fast-open"
}
END
chmod +x /etc/shadowsocks-libev.json
echo -e "">>"/etc/shadowsocks-libev/akun.conf"
clear

echo -e "[ ${green}INFO$NC ] INSTALL SCRIPT ..."
sleep 1
wget -q -O /usr/bin/menu-ss "$github/shadowsocks/menu-ss.sh" && chmod +x /usr/bin/menu-ss
wget -q -O /usr/bin/addss "$github/shadowsocks/addss.sh" && chmod +x /usr/bin/addss
wget -q -O /usr/bin/cekss "$github/shadowsocks/cekss.sh" && chmod +x /usr/bin/cekss
wget -q -O /usr/bin/delss "$github/shadowsocks/delss.sh" && chmod +x /usr/bin/delss
wget -q -O /usr/bin/renewss "$github/shadowsocks/renewss.sh" && chmod +x /usr/bin/renewss
sed -i -e 's/\r$//' /usr/bin/menu-ss
sed -i -e 's/\r$//' /usr/bin/addss
sed -i -e 's/\r$//' /usr/bin/cekss
sed -i -e 's/\r$//' /usr/bin/delss
sed -i -e 's/\r$//' /usr/bin/renewss
clear

sleep 1
echo -e "[ ${green}INFO$NC ] Restart Service/s ..."
systemctl daemon-reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Daemon-Reload"
systemctl restart nginx >/dev/null 2>&1
systemctl enable nginx >/dev/null 2>&1
systemctl start nginx >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Nginx "
systemctl restart shadowsocks-libev.service >/dev/null 2>&1
systemctl enable shadowsocks-libev.service >/dev/null 2>&1
systemctl start shadowsocks-libev.service >/dev/null 2>&1
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2443:3543 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2443:3543 -j ACCEPT
iptables-save > /etc/iptables.up.rules
ip6tables-save > /etc/ip6tables.up.rules
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting ShadowSocks-OBFS"
echo ""
echo -e "[ ${green}INFO$NC ] SETTING SHADOWSOCKS SUKSES !!!"
sleep 1
clear