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

github="https://raw.githubusercontent.com/arfprsty810/lite/main"
#domain=$(cat $arfvpn/domain)
#IP=$(cat $arfvpn/IP)
sleep 1
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING NGINX SERVER $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 3
echo -e "[ ${green}INFO$NC ] INSTALLING NGINX SERVER"
# install webserver
#apt-get remove --purge -y nginx #php php-fpm php-cli php-mysql libxml-parser-perl
#rm -rvf /etc/nginx
#apt autoremove -y
#systemctl daemon-reload
apt-get -y install nginx
#apt-get -y install php
#apt-get -y install php-fpm
#apt-get -y install php-cli
#apt-get -y install php-mysql
#apt-get -y install libxml-parser-perl
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "$github/nginx/nginx.conf"
#wget -O /etc/nginx/conf.d/vps.conf "$github/nginx/vps.conf"
mkdir -p /home/vps/public_html
#sed -i 's/listen = \/run\/php\/php7.2-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.2/fpm/pool.d/www.conf
#useradd -m vps;
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
wget -O /home/vps/public_html/index.html "$github/nginx/index.html"
/etc/init.d/nginx restart
clear