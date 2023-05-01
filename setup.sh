#!/bin/bash
#########################

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
cd /root

ipvps="/var/lib/arf"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
mkdir -p /etc/xray
mkdir -p $ipvps >/dev/null 2>&1
echo "IP=" >> $ipvps/ipvps.conf
touch /etc/xray/domain
touch /etc/xray/scdomain

secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

if [ -f "/etc/xray/domain" ]; then
clear
echo ""
echo -ne "[ ${yell}INFO${NC} ] INSTALL AUTOSCRIPT VPS XRAY v.1.0   ?  (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
rm setup.sh
sleep 5
exit 0
else
clear
fi
fi
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green             AUTOSCRIPT VPS XRAY v.1.0                          $NC"
echo -e "$green             MULTI PORT XRAY 443 + 80                       $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 3
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green        Add Domain for XRAY VPN              $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " "
read -rp "Input ur domain : " -e pp
    if [ -z $pp ]; then
        echo -e "
        Nothing input for domain!
        Then a random domain will be created"
    else
	echo "$pp" > /etc/xray/domain
	echo "$pp" > /etc/xray/scdomain
	echo "$pp" > /root/domain
    echo "$pp" > /root/scdomain
    echo "IP=$pp" > $ipvps/ipvps.conf
    curl -s ipinfo.io/org/ > /etc/xray/ISP
    curl -s https://ipinfo.io/ip/ > /etc/xray/IP
    fi
    
#Instal Xray
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          Install XRAY              $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "[ ${green}SCRIPT${NC} ] install .... "
sleep 2
clear
wget $github/xray/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
wget -q -O /usr/bin/bbr $github/bbr/bbr.sh chmod +x /usr/bin/bbr && sed -i -e 's/\r$//' /usr/bin/bbr && screen -S bbr /bin/bbr
clear

cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

clear
echo "" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "=====================-[ SCRIPT INFO ]-====================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "----------------------------------------------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - XRAY  Vmess TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess gRPC        : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess None TLS    : 80" | tee -a log-install.txt
echo "   - XRAY  Vless TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vless gRPC        : 443" | tee -a log-install.txt
echo "   - XRAY  Vless None TLS    : 80" | tee -a log-install.txt
echo "   - Trojan WS               : 443" | tee -a log-install.txt
echo "   - Trojan gRPC             : 443" | tee -a log-install.txt
echo "   - Trojan GO               : 2087" | tee -a log-install.txt
echo "   - Nginx                   : 81" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "------------------------------------------------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "=========-[ Script Created By @arf.prsty_ ]-==========" | tee -a log-install.txt
echo -e "" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "" | tee -a log-install.txt
rm /root/setup.sh >/dev/null 2>&1
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e "" | tee -a log-install.txt

echo -ne "[ ${yell}WARNING${NC} ] Reboot ur VPS ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi