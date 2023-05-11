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
cat /root/log-install.txt
echo ""

# ----------------------------------------------------------------------------------------------------------------
# Restart Service
# ----------------------------------------------------------------------------------------------------------------
sleep 1
echo -e "[ ${green}INFO$NC ] Restart All Service ..."
systemctl daemon-reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Daemon-Reload"
systemctl restart rc-local.service >/dev/null 2>&1
systemctl enable rc-local.service >/dev/null 2>&1
systemctl start rc-local.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting RC.Local"
systemctl restart runn >/dev/null 2>&1
systemctl enable runn >/dev/null 2>&1
systemctl start runn >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Runn"
systemctl restart nginx >/dev/null 2>&1
systemctl enable nginx >/dev/null 2>&1
systemctl start nginx >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Nginx "
/etc/init.d/openvpn restart >/dev/null 2>&1
/etc/init.d/openvpn enable >/dev/null 2>&1
/etc/init.d/openvpn start >/dev/null 2>&1
systemctl restart --now openvpn-server@server-tcp  >/dev/null 2>&1
systemctl enable --now openvpn-server@server-tcp  >/dev/null 2>&1
systemctl start --now openvpn-server@server-tcp  >/dev/null 2>&1
systemctl restart --now openvpn-server@server-udp >/dev/null 2>&1
systemctl enable --now openvpn-server@server-udp >/dev/null 2>&1
systemctl start --now openvpn-server@server-udp >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting OpenVpn"
/etc/init.d/dropbear restart >/dev/null 2>&1
/etc/init.d/dropbear enable >/dev/null 2>&1
/etc/init.d/dropbear start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Dropbear"
/etc/init.d/stunnel5 restart >/dev/null 2>&1
/etc/init.d/stunnel5 enable >/dev/null 2>&1
/etc/init.d/stunnel5 start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Stunnel5"
/etc/init.d/squid restart >/dev/null 2>&1
/etc/init.d/squid enable >/dev/null 2>&1
/etc/init.d/squid start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Squid "
/etc/init.d/fail2ban restart >/dev/null 2>&1
/etc/init.d/fail2ban enable >/dev/null 2>&1
/etc/init.d/fail2ban start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Fail2ban"
/etc/init.d/cron restart >/dev/null 2>&1
/etc/init.d/cron enable >/dev/null 2>&1
/etc/init.d/cron start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Cron"
/etc/init.d/vnstat restart >/dev/null 2>&1
/etc/init.d/vnstat enable >/dev/null 2>&1
/etc/init.d/vnstat start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Vnstat "
/etc/init.d/ssh restart >/dev/null 2>&1
/etc/init.d/ssh enable >/dev/null 2>&1
/etc/init.d/ssh start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting SSH"
systemctl restart xray >/dev/null 2>&1
systemctl enable xray >/dev/null 2>&1
systemctl start xray >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Xray - VMESS / VLESS / TROJAN"
systemctl restart trojan-go >/dev/null 2>&1
systemctl enable trojan-go >/dev/null 2>&1
systemctl start trojan-go >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Trojan-GO"
systemctl restart shadowsocks-libev.service >/dev/null 2>&1
systemctl enable shadowsocks-libev.service >/dev/null 2>&1
systemctl start shadowsocks-libev.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting ShadowSocks-OBFS"
/etc/init.d/sslh restart >/dev/null 2>&1
/etc/init.d/sslh enable >/dev/null 2>&1
/etc/init.d/sslh start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Sslh "
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500 >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting badvpn "
echo ""

echo "      All Service/s Successfully Restarted         "
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
clear
menu