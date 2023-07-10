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
domain=$(cat ${arfvpn}/domain)
DOMAIN2="s/domainxxx/${domain}/g";
IP=$(cat ${arfvpn}/IP)
MYIP2="s/ipxxx/${IP}/g";
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
systemctl stop nginx
apt-get remove --purge apache apache* -y
rm ${nginx}/sites-enabled/*
rm ${nginx}/sites-available/*
wget -O ${nginx}/nginx.conf "${github}/nginx/nginx.conf"
wget -O ${nginx}/conf.d/vps.conf "${github}/nginx/vps.conf"
sed -i 's/listen = \/run\/php\/php7.2-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/8.1/fpm/pool.d/www.conf
useradd -m vps;
mkdir -p ${vps}
echo "<?php phpinfo() ?>" > ${vps}/info.php
chown -R www-data:www-data ${vps}
chmod -R g+rw ${vps}
cd ${vps}
wget -O ${vps}/index.html "${github}/nginx/index.html"

cd
wget -O /usr/bin/cert https://raw.githubusercontent.com/arfprsty810/lite/main/cert/cert.sh && chmod +x /usr/bin/cert && sed -i -e 's/\r$//' /usr/bin/cert && cert
sudo openssl dhparam -out ${nginx}/dhparam.pem 2048

cd ${nginx}
wget -O ${nginx}/sites-available/${domain}.conf "${github}/nginx/domain.conf"
sed -i "${MYIP2}" ${nginx}/sites-available/${domain}.conf
sed -i "${DOMAIN2}" ${nginx}/sites-available/${domain}.conf
sudo ln -s ${nginx}/sites-available/${domain}.conf ${nginx}/sites-enabled

cd
systemctl restart nginx
sudo nginx -t && sudo systemctl reload nginx
sleep 5
clear
