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

trgo="/etc/trojan-go"
logtrgo="/var/log/trojan-go"
ipvps="/var/lib/arf"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
clear

echo -e "[ ${green}INFO$NC ] Remove old file ..."
sleep 1
#vmess
rm -rvf /usr/bin/menu-vmess
rm -rvf /usr/bin/add-ws
rm -rvf /usr/bin/cek-ws
rm -rvf /usr/bin/del-ws
rm -rvf /usr/bin/renew-ws
clear

#vless
rm -rvf /usr/bin/menu-vless
rm -rvf /usr/bin/add-vless
rm -rvf /usr/bin/cek-vless
rm -rvf /usr/bin/del-vless
rm -rvf /usr/bin/renew-vless
clear

#trojan
rm -rvf /usr/bin/menu-trojan
rm -rvf /usr/bin/add-tr
rm -rvf /usr/bin/cek-tr
rm -rvf /usr/bin/del-tr
rm -rvf /usr/bin/renew-tr
clear

#shadowsocks-libev
rm -rvf /usr/bin/menu-ss
rm -rvf /usr/bin/addss
rm -rvf /usr/bin/cekss
rm -rvf /usr/bin/delss
rm -rvf /usr/bin/renewss
clear

#--
rm -rvf /usr/bin/menu
rm -rvf /usr/bin/speedtest
rm -rvf /usr/bin/update
rm -rvf /usr/bin/restart
rm -rvf /usr/bin/running
rm -rvf /bin/cek-bandwidth
rm -rvf /usr/bin/renew-config
rm -rvf /usr/bin/backup-user
rm -rvf /usr/bin/cekuser
rm -rvf /usr/bin/xp
rm -rvf /usr/bin/cf
clear

echo -e "[ ${green}INFO$NC ] Update New Script ..."
sleep 1
#vmess
wget -q -O /usr/bin/menu-vmess "$github/xray/vmess/menu-vmess.sh"
chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/add-ws "$github/xray/vmess/add-ws.sh"
chmod +x /usr/bin/add-ws
wget -q -O /usr/bin/cek-ws "$github/xray/vmess/cek-ws.sh"
chmod +x /usr/bin/cek-ws
wget -q -O /usr/bin/del-ws "$github/xray/vmess/del-ws.sh"
chmod +x /usr/bin/del-ws
wget -q -O /usr/bin/renew-ws "$github/xray/vmess/renew-ws.sh"
chmod +x /usr/bin/renew-ws
clear

#vless
wget -q -O /usr/bin/menu-vless "$github/xray/vless/menu-vless.sh"
chmod +x /usr/bin/menu-vless
wget -q -O /usr/bin/add-vless "$github/xray/vless/add-vless.sh"
chmod +x /usr/bin/add-vless
wget -q -O /usr/bin/cek-vless "$github/xray/vless/cek-vless.sh"
chmod +x /usr/bin/cek-vless
wget -q -O /usr/bin/del-vless "$github/xray/vless/del-vless.sh"
chmod +x /usr/bin/del-vless
wget -q -O /usr/bin/renew-vless "$github/xray/vless/renew-vless.sh"
chmod +x /usr/bin/renew-vless
clear

#trojan
wget -q -O /usr/bin/menu-trojan "$github/xray/trojan/menu-trojan.sh"
chmod +x /usr/bin/menu-trojan
wget -q -O /usr/bin/add-tr "$github/xray/trojan/add-tr.sh"
chmod +x /usr/bin/add-tr
wget -q -O /usr/bin/cek-tr "$github/xray/trojan/cek-tr.sh"
chmod +x /usr/bin/cek-tr
wget -q -O /usr/bin/del-tr "$github/xray/trojan/del-tr.sh"
chmod +x /usr/bin/del-tr
wget -q -O /usr/bin/renew-tr "$github/xray/trojan/renew-tr.sh"
chmod +x /usr/bin/renew-tr
clear

#shadowsocks-libev
wget -q -O /usr/bin/menu-ss "$github/shadowsocks/menu-ss.sh"  
chmod +x /usr/bin/menu-ss
wget -q -O /usr/bin/addss "$github/shadowsocks/addss.sh"
chmod +x /usr/bin/addss
wget -q -O /usr/bin/cekss "$github/shadowsocks/cekss.sh"
chmod +x /usr/bin/cekss
wget -q -O /usr/bin/delss "$github/shadowsocks/delss.sh"
chmod +x /usr/bin/delss
wget -q -O /usr/bin/renewss "$github/shadowsocks/renewss.sh"
chmod +x /usr/bin/renewss
clear

#--
wget -q -O /usr/bin/cf "$github/xray/cf.sh"
chmod +x /usr/bin/cf
wget -q -O /usr/bin/xp "$github/xray/xp.sh"
chmod +x /usr/bin/xp
wget -q -O /usr/bin/restart "$github/xray/restart.sh"
chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "$github/xray/running.sh"
chmod +x /usr/bin/running
wget -q -O /usr/bin/cek-bandwidth "$github/xray/cek-bandwidth.sh"
chmod +x /usr/bin/cek-bandwidth
wget -q -O /usr/bin/menu "$github/xray/menu.sh"
chmod +x /usr/bin/menu
wget -q -O /usr/bin/speedtest "$github/xray/speedtest_cli.py"
chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "$github/xray/update.sh"
chmod +x /usr/bin/update
wget -q -O /usr/bin/renew-config "$github/backup/renew-config.sh"
chmod +x /usr/bin/renew-config
wget -q -O /usr/bin/backup-user "$github/backup/backup-user.sh"
chmod +x /usr/bin/backup-user
wget -q -O /usr/bin/cekuser "$github/xray/cekuser.sh"
chmod +x /usr/bin/cekuser
clear

echo -e "[ ${green}INFO$NC ] Install New Script ..."
sleep 2
sed -i -e 's/\r$//' /bin/cf
sed -i -e 's/\r$//' /bin/xp
sed -i -e 's/\r$//' /bin/menu
sed -i -e 's/\r$//' /bin/update
sed -i -e 's/\r$//' /bin/restart
sed -i -e 's/\r$//' /bin/running
sed -i -e 's/\r$//' /bin/cek-bandwidth
sed -i -e 's/\r$//' /bin/renew-config
sed -i -e 's/\r$//' /bin/backup-user
sed -i -e 's/\r$//' /bin/cekuser
clear

sed -i -e 's/\r$//' /bin/menu-vmess
sed -i -e 's/\r$//' /bin/add-ws
sed -i -e 's/\r$//' /bin/cek-ws
sed -i -e 's/\r$//' /bin/del-vmess
sed -i -e 's/\r$//' /bin/renew-ws
clear

sed -i -e 's/\r$//' /bin/menu-vless
sed -i -e 's/\r$//' /bin/add-vless
sed -i -e 's/\r$//' /bin/cek-vless
sed -i -e 's/\r$//' /bin/del-vless
sed -i -e 's/\r$//' /bin/renew-ws
clear

sed -i -e 's/\r$//' /bin/menu-trojan
sed -i -e 's/\r$//' /bin/add-tr
sed -i -e 's/\r$//' /bin/cek-tr
sed -i -e 's/\r$//' /bin/del-tr
sed -i -e 's/\r$//' /bin/renew-tr
clear

sed -i -e 's/\r$//' /bin/menu-ss
sed -i -e 's/\r$//' /bin/addss
sed -i -e 's/\r$//' /bin/cekss
sed -i -e 's/\r$//' /bin/delss
sed -i -e 's/\r$//' /bin/renewss
clear

rm -rvf /bin/autodel
wget -q -O /usr/bin/autodel "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/autodel.sh"
chmod +x /usr/bin/autodel
sed -i -e 's/\r$//' /bin/autodel

rm -rvf /bin/autokill
wget -q -O /usr/bin/autokill "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/autokill.sh"
chmod +x /usr/bin/autokill
sed -i -e 's/\r$//' /bin/autokill

rm -rvf /bin/cek
wget -q -O /usr/bin/cek "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/cek.sh"
chmod +x /usr/bin/cek
sed -i -e 's/\r$//' /bin/cek

rm -rvf /bin/ceklim
wget -q -O /usr/bin/ceklim "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ceklim.sh"
chmod +x /usr/bin/ceklim
sed -i -e 's/\r$//' /bin/ceklim

rm -rvf /bin/del
wget -q -O /usr/bin/del "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/del.sh"
chmod +x /usr/bin/del
sed -i -e 's/\r$//' /bin/del

rm -rvf /bin/member
wget -q -O /usr/bin/member "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/member.sh"
chmod +x /usr/bin/member
sed -i -e 's/\r$//' /bin/member

rm -rvf /bin/menu-ssh
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/menu-ssh.sh"
chmod +x /usr/bin/menu-ssh
sed -i -e 's/\r$//' /bin/menu-ssh

rm -rvf /bin/renew
wget -q -O /usr/bin/renew "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/renew.sh"
chmod +x /usr/bin/renew
sed -i -e 's/\r$//' /bin/renew

rm -rvf /bin/tendang
wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/tendang.sh"
chmod +x /usr/bin/tendang
sed -i -e 's/\r$//' /bin/tendang

rm -rvf /bin/usernew
wget -q -O /usr/bin/usernew "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/usernew.sh"
chmod +x /usr/bin/usernew
sed -i -e 's/\r$//' /bin/usernew
clear

echo -e "[ ${green}INFO$NC ] Update Successfully!"
sleep 3
clear

echo -e "[ ${green}INFO$NC ] CHECK EXPIRED USER ..."
sleep 2
/usr/bin/xp
clear

sleep 1
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

sleep 1
echo -e "[ ${green}INFO$NC ] Restart All Service ..."
systemctl daemon-reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Daemon-Reload"
systemctl stop rc-local.service >/dev/null 2>&1
systemctl restart rc-local.service >/dev/null 2>&1
systemctl enable rc-local.service >/dev/null 2>&1
systemctl start rc-local.service >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting RC.Local"
systemctl stop runn >/dev/null 2>&1
systemctl restart runn >/dev/null 2>&1
systemctl enable runn >/dev/null 2>&1
systemctl start runn >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Run"
/etc/init.d/nginx stop >/dev/null 2>&1
/etc/init.d/nginx restart >/dev/null 2>&1
/etc/init.d/nginx enable >/dev/null 2>&1
/etc/init.d/nginx start >/dev/null 2>&1
chown -R www-data:www-data /home/vps/public_html >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Nginx "
/etc/init.d/ssh stop >/dev/null 2>&1
/etc/init.d/ssh restart >/dev/null 2>&1
/etc/init.d/ssh enable >/dev/null 2>&1
/etc/init.d/ssh start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting SSH"
/etc/init.d/openvpn stop >/dev/null 2>&1
/etc/init.d/openvpn restart >/dev/null 2>&1
/etc/init.d/openvpn enable >/dev/null 2>&1
/etc/init.d/openvpn start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting OpenVpn"
/etc/init.d/dropbear stop >/dev/null 2>&1
/etc/init.d/dropbear restart >/dev/null 2>&1
/etc/init.d/dropbear enable >/dev/null 2>&1
/etc/init.d/dropbear start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Dropbear"
/etc/init.d/stunnel5 stop >/dev/null 2>&1
/etc/init.d/stunnel5 restart >/dev/null 2>&1
/etc/init.d/stunnel5 enable >/dev/null 2>&1
/etc/init.d/stunnel5 start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Stunnel5"
/etc/init.d/squid stop >/dev/null 2>&1
/etc/init.d/squid restart >/dev/null 2>&1
/etc/init.d/squid enable >/dev/null 2>&1
/etc/init.d/squid start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Squid "
/etc/init.d/fail2ban stop >/dev/null 2>&1
/etc/init.d/fail2ban restart >/dev/null 2>&1
/etc/init.d/fail2ban enable >/dev/null 2>&1
/etc/init.d/fail2ban start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Fail2ban"
/etc/init.d/cron stop >/dev/null 2>&1
/etc/init.d/cron restart >/dev/null 2>&1
/etc/init.d/cron enable >/dev/null 2>&1
/etc/init.d/cron start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Cron"
/etc/init.d/vnstat stop >/dev/null 2>&1
/etc/init.d/vnstat restart >/dev/null 2>&1
/etc/init.d/vnstat enable >/dev/null 2>&1
/etc/init.d/vnstat start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Vnstat "
systemctl stop xray >/dev/null 2>&1
systemctl restart xray >/dev/null 2>&1
systemctl enable xray >/dev/null 2>&1
systemctl start xray >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Xray - VMESS / VLESS / TROJAN"
systemctl stop trojan-go >/dev/null 2>&1
systemctl restart trojan-go >/dev/null 2>&1
systemctl enable trojan-go >/dev/null 2>&1
systemctl start trojan-go >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Trojan-GO"
/etc/init.d/shadowsocks-libev stop >/dev/null 2>&1
/etc/init.d/shadowsocks-libev restart >/dev/null 2>&1
/etc/init.d/shadowsocks-libev enable >/dev/null 2>&1
/etc/init.d/shadowsocks-libev start >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting ShadowSocks-OBFS"
systemctl stop ws-stunnel.service
systemctl restart ws-stunnel.service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting WS-Stunnel "
#systemctl stop ws-dropbear.service >/dev/null 2>&1
#systemctl restart ws-dropbear.service >/dev/null 2>&1
#systemctl enable ws-dropbear.service >/dev/null 2>&1
#systemctl start ws-dropbear.service >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting WS-Dropbear"
#/etc/init.d/sslh stop >/dev/null 2>&1
#/etc/init.d/sslh restart >/dev/null 2>&1
#/etc/init.d/sslh enable >/dev/null 2>&1
#/etc/init.d/sslh start >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}ok${NC} ] Restarting Sslh "
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

echo "[      Update Successfully ..."
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu