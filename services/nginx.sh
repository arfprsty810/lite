#!/bin/bash

cd /root
source /etc/os-release
nginx="/etc/nginx"
arfserver="/etc/arfserver"
arfportal="/home/arfportal/public_html"
github="raw.githubusercontent.com/arfprsty810/lite/main"
sleep 5
clear

mkdir -p ${arfserver}
mkdir -p ${nginx}
touch ${arfserver}/IP
touch ${arfserver}/domain
touch ${arfserver}/scdomain
clear

cd /root
apt-get update
apt update
apt upgrade -y
apt install curl jq -y
apt install cron fail2ban vnstat -y
apt install lolcat -y
sleep 5
clear

read -rp "Input ur domain / sub-domain : " -e pp
	echo "${pp}" > ${arfserver}/domain
	echo "${pp}" > ${arfserver}/scdomain
    curl -s https://ipinfo.io/ip/ > ${arfserver}/IP
sleep 5
clear

domain=$(cat ${arfserver}/domain)
DOMAIN2="s/domainxxx/${domain}/g";
IP=$(cat ${arfserver}/IP)
MYIP2="s/ipxxx/${IP}/g";
clear

apt install nginx php php-fpm php-cli php-mysql libxml-parser-perl -y
sleep 5
clear

systemctl stop nginx
apt-get remove --purge apache apache* -y
rm ${nginx}/sites-enabled/*
rm ${nginx}/sites-available/*
wget -O ${nginx}/nginx.conf "https://${github}/nginx/nginx.conf"
wget -O ${nginx}/conf.d/arf.conf "https://${github}/nginx/arf.conf"
sed -i 's/listen = \/run\/php\/php7.2-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/8.1/fpm/pool.d/www.conf
useradd -m arfportal;
mkdir -p ${arfportal}
echo "<?php phpinfo() ?>" > ${arfportal}/info.php
chown -R www-data:www-data ${arfportal}
chmod -R g+rw ${arfportal}
wget -O ${arfportal}/index.html "https://${github}/nginx/index.html"
sleep 5
clear

cd /root
## make a crt xray $domain
systemctl stop nginx
apt install pwgen openssl socat -y
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue --force -d ${domain} --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d ${domain} --fullchainpath ${arfserver}/arfvpn.crt --keypath ${arfserver}/arfvpn.key --ecc
sleep 5
clear

# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
' > /usr/bin/ssl_renew.sh
chmod +x /usr/bin/ssl_renew.sh
if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/bin/ssl_renew.sh") | crontab;fi
sleep 5
clear

sudo openssl dhparam -out ${nginx}/dhparam.pem 2048
sleep 5
clear

cd ${nginx}
wget -O ${nginx}/sites-available/${domain}.conf "https://${github}/nginx/domain.conf"
sed -i "${MYIP2}" ${nginx}/sites-available/${domain}.conf
sed -i "${DOMAIN2}" ${nginx}/sites-available/${domain}.conf
sudo ln -s ${nginx}/sites-available/${domain}.conf ${nginx}/sites-enabled
sleep 5
clear

cd
systemctl restart nginx
sudo nginx -t && sudo systemctl reload nginx
read -n 1 -s -r -p "Press any key to back on menu"
sleep 5
clear
