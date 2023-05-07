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
ipvps="/var/lib/arfvpn"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
clear

rm -fr $arfvpn/domain
rm -fr $arfvpn/mydomain
rm -fr $arfvpn/scdomain
rm -fr $arfvpn/domain_cf
rm -fr $arfvpn/arfvpn.key
rm -fr $arfvpn/arfvpn.crt
rm -fr $arfvpn/xray.key
rm -fr $arfvpn/xray.crt
rm -fr $ipvps/ipvps.conf
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      MAKE A CERT YOUR DOMAIN $NC"
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
    /usr/bin/cf
    else
    echo "$pp" > $arfvpn/domain
	echo "$pp" > $arfvpn/mydomain
    fi
clear

export domain=$(cat $arfvpn/domain)
export domain_cf=$(cat ${arfvpn}/domain_cf)
export mydomain=$(cat $arfvpn/mydomain)
export IP=$(cat $arfvpn/IP)
clear

echo -e "[ ${green}INFO$NC ] INSTALLING CERT SSL"
sleep 2
echo "starting...., Port 80 Akan di Hentikan Saat Proses install Cert"
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
sleep 2
clear
systemctl stop nginx

#domain="$pp"
if [[ "$domain" == "$mydomain" ]] ;then
	echo "$mydomain" > $arfvpn/domain
	echo "$mydomain" > $arfvpn/scdomain
	echo "IP=$mydomain" > $ipvps/ipvps.conf
## make a crt xray $domain
rm -rvf /root/.acme.sh
clear
mkdir -p /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath $arfvpn/xray.crt --keypath $arfvpn/xray.key --ecc
# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
' > /usr/local/bin/ssl_renew.sh

elif [[ $domain == "$domain_cf" ]] ;then
	echo "$domain_cf" > $arfvpn/domain
	echo "$domain_cf" > $arfvpn/scdomain
	echo "IP=$domain_cf" > $ipvps/ipvps.conf
## crt ssl cloudflare *.sg.d-jumper.me
wget -O $arfvpn/arfvpn.crt "$github/cert/arfvpn.crt"
wget -O $arfvpn/arfvpn.key "$github/cert/arfvpn.key"
# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
wget -O $arfvpn/arfvpn.crt "$github/cert/arfvpn.crt"
wget -O $arfvpn/arfvpn.key "$github/cert/arfvpn.key"
/etc/init.d/nginx start
' > /usr/local/bin/ssl_renew.sh

elif [[ $domain == "sg.d-jumper.me" ]] ;then
	echo "sg.d-jumper.me" > $arfvpn/domain
	echo "sg.d-jumper.me" > $arfvpn/scdomain
	echo "IP=sg.d-jumper.me" > $ipvps/ipvps.conf
## crt ssl cloudflare sg.d-jumper.me
wget -O $arfvpn/arfvpn.crt "$github/cert/arfvpn.crt"
wget -O $arfvpn/arfvpn.key "$github/cert/arfvpn.key"
# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
wget -O $arfvpn/arfvpn.crt "$github/cert/arfvpn.crt"
wget -O $arfvpn/arfvpn.key "$github/cert/arfvpn.key"
/etc/init.d/nginx start
' > /usr/local/bin/ssl_renew.sh
fi

if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/local/bin/ssl_renew.sh") | crontab;fi
chmod +x /usr/local/bin/ssl_renew.sh

clear
echo -e "[ ${green}INFO$NC ] MAKE CERT SSL SUCCESSFULLY ..."
sleep 3
clear

# rm -rvf *.sh && wget https://raw.githubusercontent.com/arfprsty810/lite/main/backup/renew-cert.sh && chmod +x renew-cert.sh && sed -i -e 's/\r$//' renew-cert.sh && ./renew-cert.sh