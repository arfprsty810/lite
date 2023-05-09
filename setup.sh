#!/bin/bash
#########################
# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"
clear

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

secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
clear

cd /root
source /etc/os-release
arfvpn="/etc/arfvpn"
xray="/etc/xray"
logxray="/var/log/xray"
trgo="/etc/arfvpn/trojan-go"
logtrgo="/var/log/arfvpn/trojan-go"
nginx="/etc/nginx"
ipvps="/var/lib/arfvpn"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
start=$(date +%s)
clear

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi
mkdir -p $arfvpn
mkdir -p $ipvps
mkdir -p $xray
mkdir -p $trgo
mkdir -p $nginx
clear

echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green                 AUTOSCRIPT VPS XRAY v.1.0 $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 3
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Add Domain for XRAY VPN $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " "
echo -e "[ ${green}INFO$NC ]* BLANK INPUT FOR RANDOM SUB-DOMAIN ! "
read -rp "Input ur domain / sub-domain : " -e pp
    if [ -z $pp ]; then
    echo -e "
    Nothing input for domain!
    Then a random sub-domain will be created"
    sleep 2
    clear
    apt install curl jq -y
    wget -q -O /usr/bin/cf "$github/services/cf.sh"
    chmod +x /usr/bin/cf
    sed -i -e 's/\r$//' /usr/bin/cf
    /usr/bin/cf
    else
    apt install curl jq -y
	echo "$pp" > $arfvpn/domain
	echo "$pp" > $arfvpn/scdomain
    echo "IP=$pp" > $ipvps/ipvps.conf
    curl -s ipinfo.io/org/ > ${arfvpn}/ISP
    curl -s https://ipinfo.io/ip/ > ${arfvpn}/IP
    fi
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING SCRIPT $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "[ ${green}SCRIPT${NC} ] install .... "
sleep 2
cd

#apete
wget $github/services/apete.sh
chmod +x apete.sh
sed -i -e 's/\r$//' apete.sh
./apete.sh
clear
sleep 2

# NGINX-SERVER
wget $github/nginx/nginx-server.sh
chmod +x nginx-server.sh
sed -i -e 's/\r$//' nginx-server.sh
./nginx-server.sh

#SSL CERT
wget -O /usr/bin/cert $github/cert/cert.sh && chmod +x /usr/bin/cert && sed -i -e 's/\r$//' /usr/bin/cert
/usr/bin/cert

#Instal Xray
wget $github/xray/ins-xray.sh
chmod +x ins-xray.sh
sed -i -e 's/\r$//' ins-xray.sh
./ins-xray.sh
clear
sleep 2

#Instal Trojan-GO
wget $github/xray/trojan/trojan-go.sh
chmod +x trojan-go.sh
sed -i -e 's/\r$//' trojan-go.sh
./trojan-go.sh
clear
sleep 2

#Instal Shadowsocks
wget $github/shadowsocks/shadowsocks.sh
chmod +x shadowsocks.sh 
sed -i -e 's/\r$//' shadowsocks.sh
./shadowsocks.sh
clear
sleep 2

#Instal SSH-vpn
#wget $github/ssh/ssh-vpn.sh
#chmod +x ssh-vpn.sh
#sed -i -e 's/\r$//' ssh-vpn.sh
#./ssh-vpn.sh
#clear
#sleep 2

#Instal SSH-vpn2
#wget $github/ssh/ssh-vpn2.sh
#chmod +x ssh-vpn2.sh
#sed -i -e 's/\r$//' ssh-vpn2.sh
#./ssh-vpn2.sh
#clear
#sleep 2

#Instal Bbr
wget $github/bbr/bbr.sh
chmod +x bbr.sh
sed -i -e 's/\r$//' bbr.sh
screen -S bbr ./bbr.sh
clear
sleep 2

echo -e "[ ${green}INFO$NC ] DOWNLOAD SCRIPT"
sleep 2
wget -q -O /usr/bin/restart "$github/services/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "$github/services/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/cek-bandwidth "$github/services/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
wget -q -O /usr/bin/menu "$github/services/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/speedtest "$github/services/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "$github/services/update.sh" && chmod +x /usr/bin/update
wget -q -O /usr/bin/renew-config "$github/backup/renew-config.sh" && chmod +x /usr/bin/renew-config
wget -q -O /usr/bin/backup-user "$github/backup/backup-user.sh" && chmod +x /usr/bin/backup-user
wget -q -O /usr/bin/cf "$github/services/cf.sh" && chmod +x /usr/bin/cf
sed -i -e 's/\r$//' /usr/bin/menu
sed -i -e 's/\r$//' /usr/bin/cek-bandwidth
sed -i -e 's/\r$//' /usr/bin/update
sed -i -e 's/\r$//' /usr/bin/restart
sed -i -e 's/\r$//' /usr/bin/running
sed -i -e 's/\r$//' /usr/bin/renew-config
sed -i -e 's/\r$//' /usr/bin/backup-user
sed -i -e 's/\r$//' /usr/bin/cf
clear

# ----------------------------------------------------------------------------------------------------------------
# Restart Service
# ----------------------------------------------------------------------------------------------------------------
sleep 1
echo -e "[ ${green}INFO$NC ] Restart All Service ..."
systemctl daemon-reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Daemon-Reload"
systemctl restart rc-local.service >/dev/null 2>&1
systemctl enable rc-local.service >/dev/null 2>&1
systemctl start rc-local.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting RC.Local"
systemctl restart runn >/dev/null 2>&1
systemctl enable runn >/dev/null 2>&1
systemctl start runn >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Runn"
systemctl restart nginx >/dev/null 2>&1
systemctl enable nginx >/dev/null 2>&1
systemctl start nginx >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Nginx "
/etc/init.d/openvpn restart >/dev/null 2>&1
/etc/init.d/openvpn enable >/dev/null 2>&1
/etc/init.d/openvpn start >/dev/null 2>&1
systemctl restart --now openvpn-server@server-tcp  >/dev/null 2>&1
systemctl enable --now openvpn-server@server-tcp  >/dev/null 2>&1
systemctl start --now openvpn-server@server-tcp  >/dev/null 2>&1
systemctl restart --now openvpn-server@server-udp >/dev/null 2>&1
systemctl enable --now openvpn-server@server-udp >/dev/null 2>&1
systemctl start --now openvpn-server@server-udp >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting OpenVpn"
/etc/init.d/dropbear restart >/dev/null 2>&1
/etc/init.d/dropbear enable >/dev/null 2>&1
/etc/init.d/dropbear start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Dropbear"
/etc/init.d/stunnel5 restart >/dev/null 2>&1
/etc/init.d/stunnel5 enable >/dev/null 2>&1
/etc/init.d/stunnel5 start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Stunnel5"
/etc/init.d/squid restart >/dev/null 2>&1
/etc/init.d/squid enable >/dev/null 2>&1
/etc/init.d/squid start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Squid "
/etc/init.d/fail2ban restart >/dev/null 2>&1
/etc/init.d/fail2ban enable >/dev/null 2>&1
/etc/init.d/fail2ban start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Fail2ban"
/etc/init.d/cron restart >/dev/null 2>&1
/etc/init.d/cron enable >/dev/null 2>&1
/etc/init.d/cron start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Cron"
/etc/init.d/vnstat restart >/dev/null 2>&1
/etc/init.d/vnstat enable >/dev/null 2>&1
/etc/init.d/vnstat start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Vnstat "
/etc/init.d/ssh restart >/dev/null 2>&1
/etc/init.d/ssh enable >/dev/null 2>&1
/etc/init.d/ssh start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting SSH"
systemctl restart xray >/dev/null 2>&1
systemctl enable xray >/dev/null 2>&1
systemctl start xray >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Xray - VMESS / VLESS / TROJAN"
systemctl restart trojan-go >/dev/null 2>&1
systemctl enable trojan-go >/dev/null 2>&1
systemctl start trojan-go >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Trojan-GO"
systemctl restart shadowsocks-libev.service >/dev/null 2>&1
systemctl enable shadowsocks-libev.service >/dev/null 2>&1
systemctl start shadowsocks-libev.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting ShadowSocks-OBFS"
systemctl restart ws-dropbear.service >/dev/null 2>&1
systemctl enable ws-dropbear.service >/dev/null 2>&1
systemctl start ws-dropbear.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting WS-Dropbear"
systemctl restart edu-proxy.service >/dev/null 2>&1
systemctl enable edu-proxy.service >/dev/null 2>&1
systemctl start edu-proxy.service>/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting WS-OpenSSH"
systemctl restart edu-proxyovpn.service >/dev/null 2>&1
systemctl enable edu-proxyovpn.service >/dev/null 2>&1
systemctl start edu-proxyovpn.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting WS-OpenVPN"
systemctl restart ws-stunnel.service >/dev/null 2>&1
systemctl enable ws-stunnel.service >/dev/null 2>&1
systemctl start ws-stunnel.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting WS-SSL "
systemctl restart edu-tls.service >/dev/null 2>&1
systemctl enable edu-tls.service >/dev/null 2>&1
systemctl start edu-tls.service >/dev/null 2>&1
systemctl restart ws-tls.service >/dev/null 2>&1
systemctl enable ws-tls.service >/dev/null 2>&1
systemctl start ws-tls.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting WS-SSL/TLS"
#/etc/init.d/sslh restart >/dev/null 2>&1
#/etc/init.d/sslh enable >/dev/null 2>&1
#/etc/init.d/sslh start >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting Sslh "
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500 >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting badvpn "
echo ""

cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile
clear

history -c
echo "unset HISTFILE" >> /etc/profile
#echo -e "[ ${green}INFO$NC ] CORN EXPIRED USER ..."
echo "0 0 * * * root xp" >> /etc/crontab
rm -rvf /root/*.sh
rm -rvf /root/*.sh.*
clear

echo "" | tee -a log-install.txt
echo "======================-[ SCRIPT INFO ]-=====================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "------------------------------------------------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22, 88 "  | tee -a log-install.txt
echo "   - SSH Websocket           : 80 " | tee -a log-install.txt
echo "   - SSH SSL Websocket       : 443 " | tee -a log-install.txt
echo "   - OVPN Websocket          : 2086 "  | tee -a log-install.txt
echo "   - Stunnel Websocket       : 700 " | tee -a log-install.txt
echo "   - Stunnel5                : 447, 777, 990 " | tee -a log-install.txt
echo "   - Dropbear                : 69, 109, 1194 " | tee -a log-install.txt
echo "   - Badvpn                  : 7100-7900 " | tee -a log-install.txt
echo "   - Nginx                   : 81" | tee -a log-install.txt
echo "   - XRAY Vmess TLS          : 443" | tee -a log-install.txt
echo "   - XRAY Vmess None TLS     : 80" | tee -a log-install.txt
echo "   - XRAY Vless TLS          : 443" | tee -a log-install.txt
echo "   - XRAY Vless None TLS     : 80" | tee -a log-install.txt
echo "   - Trojan TLS              : 443" | tee -a log-install.txt
echo "   - Trojan GRPC             : 443" | tee -a log-install.txt
echo "   - Trojan GO               : 443" | tee -a log-install.txt
#echo "   - Trojan GFW              : 443" | tee -a log-install.txt
echo "   - Shadowsocks-Libev       : 443" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
#echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "------------------------------------------------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "=========-[ Script Created By @arf.prsty_ ]-==========" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "" | tee -a log-install.txt
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e "" | tee -a log-install.txt

echo -ne "[ ${yell}WARNING${NC} ] Reboot ur VPS ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi