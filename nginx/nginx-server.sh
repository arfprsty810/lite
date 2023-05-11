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
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
domain=$(cat $arfvpn/domain)
DOMAIN2="s/domainxxx/$domain/g";
IP=$(cat $arfvpn/IP)
MYIP2="s/ipxxx/$IP/g";
sleep 1
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING NGINX SERVER $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 3
echo -e "[ ${green}INFO$NC ] INSTALLING NGINX SERVER"
cd
apt install nginx php php-fpm php-cli php-mysql libxml-parser-perl -y
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
#wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/nginx/nginx.conf"
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/nginx/web-server/nginx.conf"
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/nginx/vps.conf"
sed -i 's/listen = \/run\/php\/php7.2-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.2/fpm/pool.d/www.conf
useradd -m vps;
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
cd /home/vps/public_html
wget -O /home/vps/public_html/index.html "$github/nginx/index.html"

openssl dhparam -out /etc/nginx/dhparam.pem 2048

cd /etc/nginx
wget -O /etc/nginx/sites-available/$domain.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/nginx/web-server/domain.conf"
sed -i "$MYIP2" /etc/nginx/sites-available/$domain.conf
sed -i "$DOMAIN2" /etc/nginx/sites-available/$domain.conf
sudo ln -s /etc/nginx/sites-available/$domain.conf /etc/nginx/sites-enabled

mkdir -p /etc/nginx/nginxconfig.io
wget -O /etc/nginx/nginxconfig.io/general.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/nginx/web-server/general.conf"
wget -O /etc/nginx/nginxconfig.io/security.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/nginx/web-server/security.conf"

cd
sudo nginx -t && sudo systemctl reload nginx
/etc/init.d/nginx restart