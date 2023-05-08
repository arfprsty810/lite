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

export DEBIAN_FRONTEND=noninteractive
arfvpn="/etc/arfvpn"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
source /etc/os-release
OS=$ID
ver=$VERSION_ID

echo ""
echo ""
echo -e "[ ${green}INFO$NC ] INSTALLER AUTO SCRIPT "
#echo " - SSH => OVPN "
echo " - XRAY => VMESS - VLESS "
echo " - TROJAN => TROJAN WS - TROJAN-GO "
echo " - SHADOWSOCKS => SHADOWSOCKS-LIBEV "
sleep 3
echo -e ""
clear

echo -e "[ ${green}INFO$NC ] INSTALLING REQUIREMENTS"
sleep 3
clear
apt update && apt upgrade -y
clear
apt clean all && apt update
clear
apt install iptables iptables-persistent -y
clear
apt install bash-completion -y
clear
apt install pwgen openssl netcat -y
clear
apt install lsb-release -y 
clear
apt install zip -y
clear
apt install net-tools -y
clear
apt install socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils -y
clear
apt-get --reinstall --fix-missing install -y sudo dpkg psmisc ruby wondershaper python2 tmux nmap bzip2 gzip coreutils iftop htop unzip vim nano gcc g++ make perl m4 dos2unix libreadline-dev zlib1g-dev git 
clear
apt-get --reinstall --fix-missing install -y screen rsyslog sed bc dirmngr libxml-parser-perl neofetch screenfetch lsof easy-rsa libsqlite3-dev 
#apt install -y openvpn dropbear squid
apt install -y fail2ban vnstat cron
gem install lolcat
clear
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake -y
clear

# Install Requirements Tools
apt install ruby -y
apt install python -y
apt install make -y
apt install cmake -y
apt install coreutils -y
apt install rsyslog -y
apt install net-tools -y
apt install zip -y
apt install unzip -y
apt install nano -y
apt install sed -y
apt install gnupg -y
apt install gnupg1 -y
apt install bc -y
apt install jq -y
apt install apt-transport-https -y
apt install build-essential -y
apt install dirmngr -y
apt install libxml-parser-perl -y
apt install neofetch -y
apt install git -y
apt install lsof -y
apt install libsqlite3-dev -y
apt install libz-dev -y
apt install gcc -y
apt install g++ -y
apt install libreadline-dev -y
apt install zlib1g-dev -y
apt install libssl-dev -y
apt install libssl1.0-dev -y
apt install dos2unix -y

# install
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof
echo "clear" >> .profile
echo "neofetch" >> .profile

apt-get install software-properties-common -y
clear
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