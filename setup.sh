#!/bin/bash
#########################
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGREEN='\033[1;92m'      # GREEN
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGREEN='\033[0;92m'       # GREEN
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'

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
xray="/etc/xray"
logxray="/var/log/xray"
trgo="/etc/trojan-go"
logtrgo="/var/log/trojan-go"
nginx="/etc/nginx"
ipvps="/var/lib/arf"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
start=$(date +%s)
clear

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

echo ""
echo ""
echo -e "[ ${green}INFO$NC ] INSTALLER AUTO SCRIPT "
echo " - XRAY => VMESS - VLESS "
echo " - TROJAN => TROJAN WS - TROJAN-GO "
echo " - SHADOWSOCKS => SHADOWSOCKS-LIBEV "
sleep 3
echo -e ""
clear

# // Remove File & Directory
rm -fr /usr/local/bin/stunnel
rm -fr /usr/local/bin/stunnel5
rm -fr $nginx
rm -fr $ipvps
rm -fr $xray
rm -fr $logxray
rm -fr /usr/local/bin/xray
rm -fr $trgo
rm -fr $logtrgo
rm -fr /usr/bin/trojan-go
clear

echo ""
date
echo ""
echo -e "[ ${green}INFO$NC ] INSTALLING REQUIREMENTS TOOLS"
sleep 1
clear
cd
# // Remove
apt-get remove --purge nginx* -y
apt-get remove --purge apache2* -y
#apt autoremove -y
clear

cd /root/
apt update && apt upgrade -y
clear
apt clean all && apt update
clear
apt install jq curl -y
clear
apt install iptables iptables-persistent -y
clear
apt install cron bash-completion -y
clear
apt install pwgen openssl netcat -y
clear
apt install lsb-release -y 
clear
apt install zip -y
clear
apt install net-tools -y
clear
apt install -y openvpn
clear
apt install socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils -y
clear
apt-get --reinstall --fix-missing install -y sudo dpkg psmisc ruby wondershaper python2 tmux nmap bzip2 gzip coreutils iftop htop unzip vim nano gcc g++ perl m4 dos2unix libreadline-dev zlib1g-dev git 
clear
apt-get --reinstall --fix-missing install -y screen rsyslog sed bc dirmngr neofetch screenfetch lsof easy-rsa libsqlite3-dev
gem install lolcat
clear
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto -y
clear

#apt -y install php php-fpm php-cli php-mysql libxml-parser-perl

apt install make cmake automake -y
apt install libz-dev -y
apt install libssl1.0-dev -y
apt install dos2unix -y
clear

apt-get install software-properties-common -y
if [[ $OS == 'ubuntu' ]]; then
apt install shadowsocks-libev -y
apt install simple-obfs -y
clear
elif [[ $OS == 'debian' ]]; then
if [[ "$ver" = "9" ]]; then
echo "deb http://deb.debian.org/debian stretch-backports main" | tee /etc/apt/sources.list.d/stretch-backports.list
apt update
apt -t stretch-backports install shadowsocks-libev -y
apt -t stretch-backports install simple-obfs -y
clear
elif [[ "$ver" = "10" ]]; then
echo "deb http://deb.debian.org/debian buster-backports main" | tee /etc/apt/sources.list.d/buster-backports.list
apt update
apt -t buster-backports install shadowsocks-libev -y
apt -t buster-backports install simple-obfs -y
clear
fi
fi
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
apt install iptables iptables-persistent -y
sleep 1
clear
echo -e "[ ${green}INFO$NC ] SETTING NTPDATE"
apt install ntpdate -y
ntpdate -u pool.ntp.org
ntpdate pool.ntp.org 
timedatectl set-ntp true
timedatectl set-timezone Asia/Jakarta
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sleep 1
clear
echo -e "[ ${green}INFO$NC ] ENABLE CHRONYD"
apt -y install chrony
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

echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green                 AUTOSCRIPT VPS XRAY v.1.0 $NC"
echo -e "$green               MULTI PORT XRAY 443 + 80 & RANDOM $NC"
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
    rm -rvf /usr/bin/cf
    wget -q -O /usr/bin/cf "$github/services/cf.sh"
    chmod +x /usr/bin/cf
    sed -i -e 's/\r$//' /usr/bin/cf
    /usr/bin/cf
    else
    mkdir -p $ipvps >/dev/null 2>&1
    mkdir -p $xray
    mkdir -p $nginx
    touch $xray/domain
    touch $xray/scdomain
    touch /root/domain
    touch /root/scdomain
	echo "$pp" > $xray/domain
	echo "$pp" > $xray/scdomain
	echo "$pp" > /root/domain
    echo "$pp" > /root/scdomain
    echo "IP=$pp" > $ipvps/ipvps.conf
    touch $xray/ISP
    touch $xray/IP
    curl -s ipinfo.io/org/ > $xray/ISP
    curl -s https://ipinfo.io/ip/ > $xray/IP
    fi
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING SCRIPT $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "[ ${green}SCRIPT${NC} ] install .... "
sleep 2
cd
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

#Instal SSH-vpn
wget https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ssh-vpn.sh
chmod +x ssh-vpn.sh
sed -i -e 's/\r$//' ssh-vpn.sh
./ssh-vpn.sh
clear
sleep 2

#Instal Bbr
wget https://raw.githubusercontent.com/arfprsty810/lite/main/bbr/bbr.sh
chmod +x bbr.sh
sed -i -e 's/\r$//' bbr.sh
screen -S bbr ./bbr.sh
clear
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
sed -i -e 's/\r$//' /bin/menu
sed -i -e 's/\r$//' /bin/cek-bandwidth
sed -i -e 's/\r$//' /bin/update
sed -i -e 's/\r$//' /bin/restart
sed -i -e 's/\r$//' /bin/running
sed -i -e 's/\r$//' /bin/renew-config
sed -i -e 's/\r$//' /bin/backup-user
sed -i -e 's/\r$//' /bin/cf
clear

# ----------------------------------------------------------------------------------------------------------------
# Restart Service
# ----------------------------------------------------------------------------------------------------------------
sleep 1
echo -e "[ ${green}INFO$NC ] Restart All Service ..."
systemctl daemon-reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Daemon-Reload"
systemctl stop rc-local.service >/dev/null 2>&1
systemctl restart rc-local.service >/dev/null 2>&1
systemctl enable rc-local.service >/dev/null 2>&1
systemctl start rc-local.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting RC.Local"
systemctl stop runn >/dev/null 2>&1
systemctl restart runn >/dev/null 2>&1
systemctl enable runn >/dev/null 2>&1
systemctl start runn >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Run"
/etc/init.d/nginx stop >/dev/null 2>&1
/etc/init.d/nginx restart >/dev/null 2>&1
/etc/init.d/nginx enable >/dev/null 2>&1
/etc/init.d/nginx start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Nginx "
/etc/init.d/openvpn stop >/dev/null 2>&1
/etc/init.d/openvpn restart >/dev/null 2>&1
/etc/init.d/openvpn enable >/dev/null 2>&1
/etc/init.d/openvpn start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting OpenVpn"
/etc/init.d/dropbear stop >/dev/null 2>&1
/etc/init.d/dropbear restart >/dev/null 2>&1
/etc/init.d/dropbear enable >/dev/null 2>&1
/etc/init.d/dropbear start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Dropbear"
/etc/init.d/stunnel5 stop >/dev/null 2>&1
/etc/init.d/stunnel5 restart >/dev/null 2>&1
/etc/init.d/stunnel5 enable >/dev/null 2>&1
/etc/init.d/stunnel5 start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Stunnel5"
/etc/init.d/squid stop >/dev/null 2>&1
/etc/init.d/squid restart >/dev/null 2>&1
/etc/init.d/squid enable >/dev/null 2>&1
/etc/init.d/squid start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Squid "
/etc/init.d/fail2ban stop >/dev/null 2>&1
/etc/init.d/fail2ban restart >/dev/null 2>&1
/etc/init.d/fail2ban enable >/dev/null 2>&1
/etc/init.d/fail2ban start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Fail2ban"
/etc/init.d/cron stop >/dev/null 2>&1
/etc/init.d/cron restart >/dev/null 2>&1
/etc/init.d/cron enable >/dev/null 2>&1
/etc/init.d/cron start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Cron"
/etc/init.d/vnstat stop >/dev/null 2>&1
/etc/init.d/vnstat restart >/dev/null 2>&1
/etc/init.d/vnstat enable >/dev/null 2>&1
/etc/init.d/vnstat start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Vnstat "
/etc/init.d/ssh stop >/dev/null 2>&1
/etc/init.d/ssh restart >/dev/null 2>&1
/etc/init.d/ssh enable >/dev/null 2>&1
/etc/init.d/ssh start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting SSH"
systemctl stop xray >/dev/null 2>&1
systemctl restart xray >/dev/null 2>&1
systemctl enable xray >/dev/null 2>&1
systemctl start xray >/dev/null 2>&1
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2086 -j ACCEPT >/dev/null 2>&1
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2087 -j ACCEPT >/dev/null 2>&1
iptables-save > /etc/iptables.up.rules >/dev/null 2>&1
iptables-restore -t < /etc/iptables.up.rules >/dev/null 2>&1
netfilter-persistent save >/dev/null 2>&1
netfilter-persistent reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Xray - VMESS / VLESS / TROJAN"
systemctl stop trojan-go >/dev/null 2>&1
systemctl restart trojan-go >/dev/null 2>&1
systemctl enable trojan-go >/dev/null 2>&1
systemctl start trojan-go >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Trojan-GO"
/etc/init.d/shadowsocks-libev stop >/dev/null 2>&1
/etc/init.d/shadowsocks-libev restart >/dev/null 2>&1
/etc/init.d/shadowsocks-libev enable >/dev/null 2>&1
/etc/init.d/shadowsocks-libev start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting ShadowSocks-OBFS"
systemctl stop ws-stunnel.service
systemctl restart ws-stunnel.service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting WS-Stunnel "
#systemctl stop ws-dropbear.service >/dev/null 2>&1
#systemctl restart ws-dropbear.service >/dev/null 2>&1
#systemctl enable ws-dropbear.service >/dev/null 2>&1
#systemctl start ws-dropbear.service >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting WS-Dropbear"
#/etc/init.d/sslh stop >/dev/null 2>&1
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

rm -rvf /root/*.sh
rm -rvf /root/*.sh.*
clear

echo "" | tee -a log-install.txt
echo "======================-[ SCRIPT INFO ]-=====================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "------------------------------------------------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - SSH Websocket           : 80" | tee -a log-install.txt
echo "   - SSH SSL Websocket       : 443" | tee -a log-install.txt
echo "   - Stunnel5                : 447, 777" | tee -a log-install.txt
echo "   - Dropbear                : 109, 143" | tee -a log-install.txt
echo "   - Badvpn                  : 7100-7300" | tee -a log-install.txt
echo "   - Nginx                   : 81" | tee -a log-install.txt
echo "   - XRAY  Vmess TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess None TLS    : 80" | tee -a log-install.txt
echo "   - XRAY  Vless TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vless None TLS    : 80" | tee -a log-install.txt
echo "   - Trojan GRPC             : 443" | tee -a log-install.txt
echo "   - Trojan WS               : 443" | tee -a log-install.txt
echo "   - Trojan GO               : 443" | tee -a log-install.txt
#echo "   - Trojan GFW              : 443" | tee -a log-install.txt
echo "   - Sodosok WS/GRPC         : 443" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "------------------------------------------------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "=========-[ Script Created By @arf.prsty_ ]-==========" | tee -a log-install.txt
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