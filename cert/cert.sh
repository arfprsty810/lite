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
MYIP=$(cat $arfvpn/IP)
clear
#mkdir -p $arfvpn/nginx
apt install socat cron -y
clear
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                  ⇱ \e[32;1mSSL CERT MENU SELECTION/s\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e "    ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}SSL CERT CLOUDFLARE$NC"

echo -e "    ${BICyan}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}SSL CERT ACME ( *Recomended )$NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e ""

read -p "                    Select Menu : " menu
case $menu in

1)
clear
systemctl stop nginx
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
## crt ssl cloudflare sg.d-jumper.me *.sg.d-jumper.me
wget -O $arfvpn/arfvpn.crt "$github/cert/arfvpn.crt"
wget -O $arfvpn/arfvpn.key "$github/cert/arfvpn.key"
sleep 3

echo -e "[ ${green}INFO$NC ] RENEW CERT SSL"
# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
wget -O $arfvpn/arfvpn.crt "$github/cert/arfvpn.crt"
wget -O $arfvpn/arfvpn.key "$github/cert/arfvpn.key"
/etc/init.d/nginx start
' > /usr/bin/ssl_renew.sh
chmod +x /usr/bin/ssl_renew.sh
if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/bin/ssl_renew.sh") | crontab;fi
;;

2)
clear
## make a crt xray $domain
systemctl stop nginx
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath $arfvpn/arfvpn.crt --keypath $arfvpn/arfvpn.key --ecc
sleep 3

echo -e "[ ${green}INFO$NC ] RENEW CERT SSL"
# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
' > /usr/bin/ssl_renew.sh
chmod +x /usr/bin/ssl_renew.sh
if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/bin/ssl_renew.sh") | crontab;fi
;;

*)
invalid selected !
cert
;;

esac