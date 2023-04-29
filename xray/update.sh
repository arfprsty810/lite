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

trgo="/etc/arf/trojango"
ipvps="/var/lib/arf"
logtrgo="/var/log/arf/trojango"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"

cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

clear
echo -e "[ ${green}INFO$NC ] Remove old file"
sleep 1

#vmess
rm -rvf /usr/bin/menu-vmess
rm -rvf /usr/bin/add-ws
rm -rvf /usr/bin/cek-ws
rm -rvf /usr/bin/del-ws
rm -rvf /usr/bin/renew-ws

#vless
rm -rvf /usr/bin/menu-vless
rm -rvf /usr/bin/add-vless
rm -rvf /usr/bin/cek-vless
rm -rvf /usr/bin/del-vless
rm -rvf /usr/bin/renew-vless

#trojan
rm -rvf /usr/bin/menu-trojan
rm -rvf /usr/bin/add-tr
rm -rvf /usr/bin/cek-tr
rm -rvf /usr/bin/del-tr
rm -rvf /usr/bin/renew-tr

#--
rm -rvf /usr/bin/menu
rm -rvf /usr/bin/cert
rm -rvf /usr/bin/speedtest
rm -rvf /usr/bin/update
rm -rvf /usr/bin/restart
rm -rvf /usr/bin/running
rm -rvf /bin/cek-bandwidth
rm -rvf /usr/bin/renew-config
rm -rvf /usr/bin/backup-user

clear
echo -e "[ ${green}INFO$NC ] Update Script"
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

#--
wget -q -O /usr/bin/restart "$github/xray/restart.sh"
chmod +x /usr/bin/restart

wget -q -O /usr/bin/running "$github/xray/running.sh"
chmod +x /usr/bin/running

wget -q -O /usr/bin/cek-bandwidth "$github/xray/cek-bandwidth.sh"
chmod +x /usr/bin/cek-bandwidth

wget -q -O /usr/bin/menu "$github/xray/menu.sh"
chmod +x /usr/bin/menu

wget -q -O /usr/bin/cert "$github/xray/cert.sh"
chmod +x /usr/bin/cert

wget -q -O /usr/bin/speedtest "$github/xray/speedtest_cli.py"
chmod +x /usr/bin/speedtest

wget -q -O /usr/bin/update "$github/xray/update.sh"
chmod +x /usr/bin/update

wget -q -O /usr/bin/renew-config "$github/backup/renew-config.sh"
chmod +x /usr/bin/renew-config

wget -q -O /usr/bin/backup-user "$github/backup/backup-user.sh"
chmod +x /usr/bin/backup-user

clear
echo -e "[ ${green}INFO$NC ] Install New Script ..."
sleep 2

sed -i -e 's/\r$//' /bin/menu
sed -i -e 's/\r$//' /bin/cert
sed -i -e 's/\r$//' /bin/update
sed -i -e 's/\r$//' /bin/restart
sed -i -e 's/\r$//' /bin/running
sed -i -e 's/\r$//' /bin/cek-bandwidth
sed -i -e 's/\r$//' /bin/renew-config
sed -i -e 's/\r$//' /bin/backup-user

sed -i -e 's/\r$//' /bin/menu-vmess
sed -i -e 's/\r$//' /bin/add-ws
sed -i -e 's/\r$//' /bin/cek-ws
sed -i -e 's/\r$//' /bin/del-vmess
sed -i -e 's/\r$//' /bin/renew-ws

sed -i -e 's/\r$//' /bin/menu-vless
sed -i -e 's/\r$//' /bin/add-vless
sed -i -e 's/\r$//' /bin/cek-vless
sed -i -e 's/\r$//' /bin/del-vless
sed -i -e 's/\r$//' /bin/renew-ws

sed -i -e 's/\r$//' /bin/menu-trojan
sed -i -e 's/\r$//' /bin/add-tr
sed -i -e 's/\r$//' /bin/cek-tr
sed -i -e 's/\r$//' /bin/del-tr
sed -i -e 's/\r$//' /bin/renew-tr

clear
sleep 1
echo -e "[ ${green}INFO$NC ] Update successfully!"
clear
echo -e "[ ${green}ok${NC} ] Enable & restart xray "
sleep 2
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
sleep 1
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
clear
menu