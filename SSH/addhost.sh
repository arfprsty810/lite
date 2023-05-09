#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
#Getting
arfvpn="/etc/arfvpn"
xray="/etc/xray"
ipvps="/var/lib/arfvpn"
MYIP=$(cat $arfvpn/IP);
error1="${RED}[ERROR]${NC}"
success="${GREEN}[SUCCESS]${NC}"
clear

echo -e "========================="
read -rp "Input Domain/Host : " -e domain
echo -e "========================="
echo -e "${success} Domain: ${domain} Added..."
# Delete Files
rm $arfvpn/domain
rm /root/domain
rm $ipvps
# Done
echo $domain >> $arfvpn/domain
echo $domain >> /root/domain
echo "IP=$domain" >> $ipvps

sleep 1

source $ipvps
if [[ "$IP" = "" ]]; then
domain=$(cat $arfvpn/domain)
else
domain=$IP
fi
clear

apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Jakarta
chronyc sourcestats -v
chronyc tracking -v
mkdir -p $arfvpn
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
cd /root/
wget https://raw.githubusercontent.com/acmesh-official/acme.sh/master/acme.sh
bash acme.sh --install
rm acme.sh
cd .acme.sh
bash acme.sh --register-account -m senowahyu62@gmail.com
bash acme.sh --issue --standalone -d $domain --force
bash acme.sh --installcert -d $domain --fullchainpath $arfvpn/arfvpn.crt --keypath $arfvpn/arfvpn.key
sleep 3
