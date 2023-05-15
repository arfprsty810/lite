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
xray="/etc/xray"
logxray="/var/log/xray"
nginx="/etc/nginx"
vps="/home/vps/public_html"
ipvps="/var/lib/arfvpn"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"

cd $arfvpn
rm -rvf domain scdomain IP ISP
cd && clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Renew your Domain for Server VPN $NC"
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

systemctl stop nginx
rm $nginx/sites-enabled/*
rm $nginx/sites-available/*
wget -O $nginx/nginx.conf "$github/nginx/nginx.conf"
cd $vps
chown -R www-data:www-data $vps
chmod -R g+rw $vps
wget -O $vps/index.html "$github/nginx/index.html"

cd
wget -O /usr/bin/cert $github/cert/cert.sh && chmod +x /usr/bin/cert && sed -i -e 's/\r$//' /usr/bin/cert && cert
clear

cd $nginx
wget -O $nginx/sites-available/$domain.conf "$github/nginx/domain.conf"
sed -i "$MYIP2" $nginx/sites-available/$domain.conf
sed -i "$DOMAIN2" $nginx/sites-available/$domain.conf
sudo ln -s $nginx/sites-available/$domain.conf $nginx/sites-enabled

cd
systemctl restart nginx
sudo nginx -t && sudo systemctl reload nginx
sleep 5

# Random Port Xray
trojanws=$((RANDOM + 10000))
ssws=$((RANDOM + 10000))
ssgrpc=$((RANDOM + 10000))
vless=$((RANDOM + 10000))
vlessgrpc=$((RANDOM + 10000))
vmess=$((RANDOM + 10000))
worryfree=$((RANDOM + 10000))
kuotahabis=$((RANDOM + 10000))
vmessgrpc=$((RANDOM + 10000))
trojangrpc=$((RANDOM + 10000))
sed -i '$ ilocation /' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ itry_files $uri $uri/ /index.html;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /vless' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$vless"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /vmess' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$vmess"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /worryfree' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$worryfree"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /kuota-habis' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$kuotahabis"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /trojan-ws' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$trojanws"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"$vlessgrpc"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"$vmessgrpc"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"$trojangrpc"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

rm *.sh
clear