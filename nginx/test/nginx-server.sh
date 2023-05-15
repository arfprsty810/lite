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

cd /root
source /etc/os-release
arfvpn="/etc/arfvpn"
nginx="/etc/nginx"
vps="/home/vps/public_html"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"

ipvps="/var/lib/arfvpn"
mkdir -p $arfvpn
mkdir -p $ipvps
mkdir -p $xray
mkdir -p $nginx
clear
apt install curl jq -y
clear
echo ""
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
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y
clear
#apete
wget $github/services/apete.sh && chmod +x apete.sh && sed -i -e 's/\r$//' apete.sh && ./apete.sh
clear
sleep 2

domain=$(cat $arfvpn/domain)
DOMAIN2="s/domainxxx/$domain/g";
IP=$(cat $arfvpn/IP)
MYIP2="s/ipxxx/$IP/g";
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING NGINX SERVER $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 3
echo -e "[ ${green}INFO$NC ] INSTALLING NGINX SERVER"
cd
apt install pwgen openssl socat -y
clear
apt install nginx php php-fpm php-cli php-mysql libxml-parser-perl -y
rm $nginx/sites-enabled/*
rm $nginx/sites-available/*
wget -O $nginx/nginx.conf "$github/nginx/test/nginx.conf"
wget -O $nginx/conf.d/vps.conf "$github/nginx/vps.conf"
sed -i 's/listen = \/run\/php\/php7.2-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.2/fpm/pool.d/www.conf
useradd -m vps;
mkdir -p $vps
echo "<?php phpinfo() ?>" > $vps/info.php
chown -R www-data:www-data $vps
chmod -R g+rw $vps
cd $vps
wget -O $vps/index.html "$github/nginx/index.html"

cd
wget -O $arfvpn/arfvpn.crt "$github/cert/arfvpn.crt"
wget -O $arfvpn/arfvpn.key "$github/cert/arfvpn.key"
sudo openssl dhparam -out $nginx/dhparam.pem 2048

cd $nginx
wget -O $nginx/sites-available/$domain.conf "$github/nginx/test/domain.conf"
sed -i "$MYIP2" $nginx/sites-available/$domain.conf
sed -i "$DOMAIN2" $nginx/sites-available/$domain.conf
sudo ln -s $nginx/sites-available/$domain.conf $nginx/sites-enabled

cd
systemctl restart nginx
sudo nginx -t && sudo systemctl reload nginx
sleep 5
rm *.sh

read -n 1 -s -r -p "Press any key to next installation"
wget -q -O /usr/bin/menu "$github/services/menu.sh" && chmod +x /usr/bin/menu && sed -i -e 's/\r$//' /usr/bin/menu
#Instal Xray
wget $github/xray/ins-xray.sh && chmod +x ins-xray.sh && sed -i -e 's/\r$//' ins-xray.sh && ./ins-xray.sh
clear
sleep 2