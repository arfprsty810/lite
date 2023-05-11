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
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
domain=$(cat $arfvpn/domain)
DOMAIN2="s/domainxxx/$domain/g";
IP=$(cat $arfvpn/IP)
MYIP2="s/ipxxx/$IP/g";
mkdir -p $arfvpn
mkdir -p $nginx
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
rm $nginx/sites-enabled/default
rm $nginx/sites-available/default
#wget -O $nginx/nginx.conf "$github/nginx/nginx.conf"
wget -O $nginx/nginx.conf "$github/nginx/web-server/nginx.conf"
wget -O $nginx/conf.d/vps.conf "$github/nginx/vps.conf"
sed -i 's/listen = \/run\/php\/php7.2-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.2/fpm/pool.d/www.conf
useradd -m vps;
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
cd /home/vps/public_html
wget -O /home/vps/public_html/index.html "$github/nginx/index.html"

cd
systemctl stop nginx
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath $arfvpn/nginx.crt --keypath $arfvpn/nginx.key --ecc
sudo openssl dhparam -out $nginx/dhparam.pem 2048

cd $nginx
wget -O $nginx/sites-available/$domain.conf "$github/nginx/web-server/domain.conf"
sed -i "$MYIP2" $nginx/sites-available/$domain.conf
sed -i "$DOMAIN2" $nginx/sites-available/$domain.conf
sudo ln -s $nginx/sites-available/$domain.conf $nginx/sites-enabled

mkdir -p $nginx/nginxconfig.io
wget -O $nginx/nginxconfig.io/general.conf "$github/nginx/web-server/general.conf"
wget -O $nginx/nginxconfig.io/security.conf "$github/nginx/web-server/security.conf"

cd
systemctl restart
sudo nginx -t && sudo systemctl reload nginx
clear