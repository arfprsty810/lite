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

cd /root
source /etc/os-release
arfvpn="/etc/arfvpn"
nginx="/etc/nginx"
ipvps="/var/lib/arfvpn"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
rm -rvf domain scdomain IP ISP
apt install curl jq -y
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Add Domain for Server VPN $NC"
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
    wget -q -O /usr/bin/cf "$github/services/cf.sh"
    chmod +x /usr/bin/cf
    sed -i -e 's/\r$//' /usr/bin/cf
    cf
    else
	echo "$pp" > $arfvpn/domain
	echo "$pp" > $arfvpn/scdomain
    echo "IP=$pp" > $ipvps/ipvps.conf
    curl -s ipinfo.io/org/ > ${arfvpn}/ISP
    curl -s https://ipinfo.io/ip/ > ${arfvpn}/IP
    fi
clear

domain=$(cat $arfvpn/domain)
DOMAIN2="s/domainxxx/$domain/g";
IP=$(cat $arfvpn/IP)
MYIP2="s/ipxxx/$IP/g";

wget -O /usr/bin/cert https://raw.githubusercontent.com/arfprsty810/lite/main/cert/cert.sh && chmod +x /usr/bin/cert && sed -i -e 's/\r$//' /usr/bin/cert && cert
clear

cd $nginx
wget -O $nginx/sites-available/$domain.conf "$github/nginx/web-server/domain.conf"
sed -i "$MYIP2" $nginx/sites-available/$domain.conf
sed -i "$DOMAIN2" $nginx/sites-available/$domain.conf
sudo ln -s $nginx/sites-available/$domain.conf $nginx/sites-enabled

mkdir -p $nginx/nginxconfig.io
wget -O $nginx/nginxconfig.io/general.conf "$github/nginx/web-server/general.conf"
wget -O $nginx/nginxconfig.io/security.conf "$github/nginx/web-server/security.conf"
wget -O $nginx/nginxconfig.io/proxy.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/nginx/web-server/proxy.conf"

cd
systemctl restart nginx
sudo nginx -t && sudo systemctl reload nginx
sleep 5
rm *.sh