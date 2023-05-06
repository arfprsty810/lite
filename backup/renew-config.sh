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
cd
echo ""
echo ""
echo -e "[ ${green}INFO$NC ] RE-INSTALLER AUTO SCRIPT "
echo " - SSH => OPENVPN "
echo " - XRAY => VMESS - VLESS "
echo " - TROJAN => TROJAN WS - TROJAN-GO "
echo " - SHADOWSOCKS => SHADOWSOCKS-LIBEV "
sleep 3
echo -e ""
clear

echo -e "[ ${green}INFO$NC ] RE-INSTALLING KONFIGURASI"
sleep 1
secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)

source /etc/os-release
arfvpn="/etc/arfvpn"
xray="/etc/arfvpn/xray"
logxray"/var/log/arfvpn/xray"
trgo="/etc/arfvpn/trojan-go"
logtrgo="/var/log/arfvpn/trojan-go"
ipvps="/var/lib/arfvpn"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
OS=$ID
ver=$VERSION_ID
clear

echo -e "[ ${green}INFO$NC ] DISABLE IPV6"
sleep 1
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6 >/dev/null 2>&1
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local >/dev/null 2>&1
apt update -y
apt upgrade -y
apt dist-upgrade -y
clear
echo -e "[ ${green}INFO${NC} ] CHECKING... "
sleep 1
clear
echo -e "[ ${green}INFO$NC ] SETTING NTPDATE"
ntpdate -u pool.ntp.org
ntpdate pool.ntp.org 
timedatectl set-ntp true
timedatectl set-timezone Asia/Jakarta
sleep 1
clear
echo -e "[ ${green}INFO$NC ] ENABLE CHRONYD"
systemctl enable chronyd
systemctl restart chronyd
sleep 1
clear
echo -e "[ ${green}INFO$NC ] ENABLE CHRONY"
systemctl enable chrony
systemctl restart chrony
clear
sleep 1
clear
echo -e "[ ${green}INFO$NC ] SETTING CHRONY TRACKING"
chronyc sourcestats -v
chronyc tracking -v
clear
echo -e "[ ${green}INFO$NC ] SETTING SERVICE"
apt update -y
apt upgrade -y
clear
echo " "

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                  ⇱ \e[32;1mRE-INSTALLING SCRIPT/s\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e "    ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}Re-install XRAY $NC"
echo -e "    ${BICyan}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}Re-install Tojan-GO $NC"
echo -e "    ${BICyan}[${BIWhite}03${BICyan}]${RED} •${NC} ${CYAN}Re-install Shadowsocks-OBFS $NC"
echo -e "    ${BICyan}[${BIWhite}04${BICyan}]${RED} •${NC} ${CYAN}Re-install ALL Tunnel $NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e ""

read -p "                    Select Menu : " menu
case $menu in

1)
# // Remove File & Directory
rm -fr $xray
rm -fr $logxray
rm -fr /usr/local/bin/xray
mkdir -p $xray
clear
#Instal Xray
wget https://raw.githubusercontent.com/arfprsty810/lite/main/xray/ins-xray.sh
chmod +x ins-xray.sh
sed -i -e 's/\r$//' ins-xray.sh
./ins-xray.sh
clear
sleep 2

systemctl daemon-reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Daemon-Reload"
systemctl restart nginx >/dev/null 2>&1
systemctl enable nginx >/dev/null 2>&1
systemctl start nginx >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Nginx "
systemctl restart xray >/dev/null 2>&1
systemctl enable xray >/dev/null 2>&1
systemctl start xray >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Xray - VMESS / VLESS / TROJAN"

echo -e "[ ${green}INFO$NC ] INSTALL SCRIPT ..."
sleep 1
wget -q -O /usr/bin/restart "$github/services/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "$github/services/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/cek-bandwidth "$github/services/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
wget -q -O /usr/bin/menu "$github/services/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/speedtest "$github/services/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "$github/services/update.sh" && chmod +x /usr/bin/update
wget -q -O /usr/bin/renew-config "$github/backup/renew-config.sh" && chmod +x /usr/bin/renew-config
wget -q -O /usr/bin/backup-user "$github/backup/backup-user.sh" && chmod +x /usr/bin/backup-user
wget -q -O /usr/bin/cf "$github/services/cf.sh" && chmod +x /usr/bin/cf
sed -i -e 's/\r$//' /bin/menu
sed -i -e 's/\r$//' /bin/cek-bandwidth
sed -i -e 's/\r$//' /bin/update
sed -i -e 's/\r$//' /bin/restart
sed -i -e 's/\r$//' /bin/running
sed -i -e 's/\r$//' /bin/renew-config
sed -i -e 's/\r$//' /bin/backup-user
sed -i -e 's/\r$//' /bin/cf
clear

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

rm -rvf /root/*.sh
rm -rvf /root/*.sh.*
clear
;;

2)
# // Remove File & Directory
rm -fr $trgo
rm -fr $logtrgo
rm -fr /usr/bin/trojan-go
mkdir -p $trgo
clear
#Instal Trojan-GO
wget https://raw.githubusercontent.com/arfprsty810/lite/main/xray/trojan/trojan-go.sh
chmod +x trojan-go.sh
sed -i -e 's/\r$//' trojan-go.sh
./trojan-go.sh
clear
sleep 2

systemctl daemon-reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Daemon-Reload"
systemctl restart nginx >/dev/null 2>&1
systemctl enable nginx >/dev/null 2>&1
systemctl start nginx >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Nginx "
systemctl restart trojan-go >/dev/null 2>&1
systemctl enable trojan-go >/dev/null 2>&1
systemctl start trojan-go >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Trojan-GO"
clear

echo -e "[ ${green}INFO$NC ] INSTALL SCRIPT ..."
sleep 1
wget -q -O /usr/bin/restart "$github/services/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "$github/services/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/cek-bandwidth "$github/services/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
wget -q -O /usr/bin/menu "$github/services/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/speedtest "$github/services/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "$github/services/update.sh" && chmod +x /usr/bin/update
wget -q -O /usr/bin/renew-config "$github/backup/renew-config.sh" && chmod +x /usr/bin/renew-config
wget -q -O /usr/bin/backup-user "$github/backup/backup-user.sh" && chmod +x /usr/bin/backup-user
wget -q -O /usr/bin/cf "$github/services/cf.sh" && chmod +x /usr/bin/cf
sed -i -e 's/\r$//' /bin/menu
sed -i -e 's/\r$//' /bin/cek-bandwidth
sed -i -e 's/\r$//' /bin/update
sed -i -e 's/\r$//' /bin/restart
sed -i -e 's/\r$//' /bin/running
sed -i -e 's/\r$//' /bin/renew-config
sed -i -e 's/\r$//' /bin/backup-user
sed -i -e 's/\r$//' /bin/cf
clear

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

rm -rvf /root/*.sh
rm -rvf /root/*.sh.*
clear
;;

3)
# // Remove File & Directory
rm -fr /etc/shadowsocks-libev/*
clear
#Instal Shadowsocks
wget https://raw.githubusercontent.com/arfprsty810/lite/main/shadowsocks/shadowsocks.sh
chmod +x shadowsocks.sh 
sed -i -e 's/\r$//' shadowsocks.sh
./shadowsocks.sh
clear
sleep 2

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
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting ShadowSocks-OBFS"
clear

echo -e "[ ${green}INFO$NC ] INSTALL SCRIPT ..."
sleep 1
wget -q -O /usr/bin/restart "$github/services/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "$github/services/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/cek-bandwidth "$github/services/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
wget -q -O /usr/bin/menu "$github/services/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/speedtest "$github/services/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "$github/services/update.sh" && chmod +x /usr/bin/update
wget -q -O /usr/bin/renew-config "$github/backup/renew-config.sh" && chmod +x /usr/bin/renew-config
wget -q -O /usr/bin/backup-user "$github/backup/backup-user.sh" && chmod +x /usr/bin/backup-user
wget -q -O /usr/bin/cf "$github/services/cf.sh" && chmod +x /usr/bin/cf
sed -i -e 's/\r$//' /bin/menu
sed -i -e 's/\r$//' /bin/cek-bandwidth
sed -i -e 's/\r$//' /bin/update
sed -i -e 's/\r$//' /bin/restart
sed -i -e 's/\r$//' /bin/running
sed -i -e 's/\r$//' /bin/renew-config
sed -i -e 's/\r$//' /bin/backup-user
sed -i -e 's/\r$//' /bin/cf
clear

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

rm -rvf /root/*.sh
rm -rvf /root/*.sh.*
clear
;;


4)
clear
# // Remove File & Directory
rm -fr $xray
rm -fr $ipvps
rm -fr $logxray
rm -fr /usr/local/bin/xray
rm -fr $trgo
rm -fr $logtrgo
rm -fr /usr/bin/trojan-go
rm -fr /etc/shadowsocks-libev/*
clear
echo ""
echo -e "[ ${green}INFO$NC ]* BLANK INPUT FOR RANDOM SUB-DOMAIN ! "
read -rp "Input ur domain / sub-domain : " -e pp
    if [ -z $pp ]; then
    echo -e "
    Nothing input for domain!
    Then a random sub-domain will be created"
    sleep 2
    clear
    wget -q -O /usr/bin/cf "$github/services/cf.sh"
    chmod +x /usr/bin/cf
    sed -i -e 's/\r$//' /usr/bin/cf
    /usr/bin/cf
    else
    mkdir -p $ipvps >/dev/null 2>&1
    mkdir -p $xray
    mkdir -p $trgo
	echo "$pp" > $arfvpn/domain
	echo "$pp" > $arfvpn/scdomain
    echo "IP=$pp" > $ipvps/ipvps.conf
    curl -s ipinfo.io/org/ > $arfvpn/ISP
    curl -s https://ipinfo.io/ip/ > $arfvpn/IP
    wget -O $arfvpn/arfvpn.crt "$github/cert/arfvpn.crt"
    wget -O $arfvpn/arfvpn.key "$github/cert/arfvpn.key"
    fi
sleep 1
clear

#Instal Xray
wget https://raw.githubusercontent.com/arfprsty810/lite/main/xray/ins-xray.sh
chmod +x ins-xray.sh
sed -i -e 's/\r$//' ins-xray.sh
./ins-xray.sh
clear
sleep 2

#Instal Trojan-GO
wget https://raw.githubusercontent.com/arfprsty810/lite/main/xray/trojan/trojan-go.sh
chmod +x trojan-go.sh
sed -i -e 's/\r$//' trojan-go.sh
./trojan-go.sh
clear
sleep 2

#Instal Shadowsocks
wget https://raw.githubusercontent.com/arfprsty810/lite/main/shadowsocks/shadowsocks.sh
chmod +x shadowsocks.sh 
sed -i -e 's/\r$//' shadowsocks.sh
./shadowsocks.sh
clear
sleep 2

# ----------------------------------------------------------------------------------------------------------------
# Restart Service
# ----------------------------------------------------------------------------------------------------------------
sleep 1
echo -e "[ ${green}INFO$NC ] Restart All Service ..."
systemctl daemon-reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Daemon-Reload"
#systemctl restart rc-local.service >/dev/null 2>&1
#systemctl enable rc-local.service >/dev/null 2>&1
#systemctl start rc-local.service >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting RC.Local"
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
#/etc/init.d/openvpn restart >/dev/null 2>&1
#/etc/init.d/openvpn enable >/dev/null 2>&1
#/etc/init.d/openvpn start >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting OpenVpn"
#/etc/init.d/dropbear restart >/dev/null 2>&1
#/etc/init.d/dropbear enable >/dev/null 2>&1
#/etc/init.d/dropbear start >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting Dropbear"
#/etc/init.d/stunnel5 restart >/dev/null 2>&1
#/etc/init.d/stunnel5 enable >/dev/null 2>&1
#/etc/init.d/stunnel5 start >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting Stunnel5"
#/etc/init.d/squid restart >/dev/null 2>&1
#/etc/init.d/squid enable >/dev/null 2>&1
#/etc/init.d/squid start >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting Squid "
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
#/etc/init.d/ssh restart >/dev/null 2>&1
#/etc/init.d/ssh enable >/dev/null 2>&1
#/etc/init.d/ssh start >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting SSH"
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
#systemctl restart ws-dropbear.service >/dev/null 2>&1
#systemctl enable ws-dropbear.service >/dev/null 2>&1
#systemctl start ws-dropbear.service >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting WS-Dropbear"
#systemctl restart edu-proxy.service >/dev/null 2>&1
#systemctl enable edu-proxy.service >/dev/null 2>&1
#systemctl start edu-proxy.service>/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting WS-OpenSSH"
#systemctl restart edu-proxyovpn.service >/dev/null 2>&1
#systemctl enable edu-proxyovpn.service >/dev/null 2>&1
#systemctl start edu-proxyovpn.service >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting WS-OpenVPN"
#systemctl restart ws-stunnel.service >/dev/null 2>&1
#systemctl enable ws-stunnel.service >/dev/null 2>&1
#systemctl start ws-stunnel.service >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting WS-SSL "
#systemctl enable edu-tls.service >/dev/null 2>&1
#systemctl start edu-tls.service >/dev/null 2>&1
#systemctl restart edu-tls.service >/dev/null 2>&1
#systemctl enable ws-tls.service >/dev/null 2>&1
#systemctl start ws-tls.service >/dev/null 2>&1
#systemctl restart ws-tls.service >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting WS-SSL/TLS"
#/etc/init.d/sslh restart >/dev/null 2>&1
#/etc/init.d/sslh enable >/dev/null 2>&1
#/etc/init.d/sslh start >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting Sslh "
#screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500 >/dev/null 2>&1
#screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500 >/dev/null 2>&1
#screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500 >/dev/null 2>&1
#screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500 >/dev/null 2>&1
#screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500 >/dev/null 2>&1
#screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500 >/dev/null 2>&1
#screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500 >/dev/null 2>&1
#screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500 >/dev/null 2>&1
#screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500 >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting badvpn "
clear

echo -e "[ ${green}INFO$NC ] INSTALL SCRIPT ..."
sleep 1
wget -q -O /usr/bin/restart "$github/services/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "$github/services/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/cek-bandwidth "$github/services/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
wget -q -O /usr/bin/menu "$github/services/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/speedtest "$github/services/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "$github/services/update.sh" && chmod +x /usr/bin/update
wget -q -O /usr/bin/renew-config "$github/backup/renew-config.sh" && chmod +x /usr/bin/renew-config
wget -q -O /usr/bin/backup-user "$github/backup/backup-user.sh" && chmod +x /usr/bin/backup-user
wget -q -O /usr/bin/cf "$github/services/cf.sh" && chmod +x /usr/bin/cf
sed -i -e 's/\r$//' /bin/menu
sed -i -e 's/\r$//' /bin/cek-bandwidth
sed -i -e 's/\r$//' /bin/update
sed -i -e 's/\r$//' /bin/restart
sed -i -e 's/\r$//' /bin/running
sed -i -e 's/\r$//' /bin/renew-config
sed -i -e 's/\r$//' /bin/backup-user
sed -i -e 's/\r$//' /bin/cf
clear

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

rm -rvf /root/*.sh
rm -rvf /root/*.sh.*
clear

echo -e "[ ${green}INFO$NC ] RE-INSTALL FINISHED !"
sleep 2
echo -ne "[ ${yell}WARNING${NC} ] Reboot ur VPS ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
;;
esac

# rm -rvf /usr/bin/renew-config && wget -q -O /usr/bin/renew-config "https://raw.githubusercontent.com/arfprsty810/lite/main/backup/renew-config.sh" && chmod +x /usr/bin/renew-config 
#rm -rvf /usr/bin/cf && wget -q -O /usr/bin/cf "https://raw.githubusercontent.com/arfprsty810/lite/main/services/cf.sh" && chmod +x /usr/bin/cf && cf
