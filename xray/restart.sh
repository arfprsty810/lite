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
echo -e "[ ${green}INFO$NC ] Restart All Service ..."
sleep 1
clear
service cron restart
systemctl daemon-reload
systemctl enable xray
systemctl restart xray
systemctl restart nginx
systemctl enable runn
systemctl restart runn
systemctl stop trojan-go
systemctl start trojan-go
systemctl enable trojan-go
systemctl restart trojan-go
#systemctl restart ws-dropbear.service >/dev/null 2>&1
#systemctl restart ws-stunnel.service >/dev/null 2>&1
systemctl restart xray.service >/dev/null 2>&1
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
#/etc/init.d/stunnel5 restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
systemctl restart rc-local.service
clear
cat /root/log-install.txt
echo "      All Service/s Successfully Restarted         "
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
clear
menu