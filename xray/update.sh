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
sleep 3
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

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

#shadowshocks
rm -rvf /usr/bin/menu-ssws
rm -rvf /usr/bin/add-ssws
rm -rvf /usr/bin/cek-ssws
rm -rvf /usr/bin/del-ssws
rm -rvf /usr/bin/renew-ssws

rm -rvf /usr/bin/menu
rm -rvf /usr/bin/cert
rm -rvf /usr/bin/speedtest
rm -rvf /usr/bin/update
rm -rvf /usr/bin/restart
rm -rvf /usr/bin/running
rm -rvf /etc/issue.net

clear
echo -e "[ ${green}INFO$NC ] Update Script"
sleep 1

#shadowshock
wget -q -O /usr/bin/menu-ssws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/shadowshock/menu-ssws.sh" && chmod +x /usr/bin/menu-ssws
wget -q -O /usr/bin/add-ssws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/shadowshock/add-ssws.sh" && chmod +x /usr/bin/add-ssws
wget -q -O /usr/bin/cek-ssws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/shadowshock/cek-ssws.sh" && chmod +x /usr/bin/cek-ssws
wget -q -O /usr/bin/del-ssws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/shadowshock/del-ssws.sh" && chmod +x /usr/bin/del-ssws
wget -q -O /usr/bin/renew-ssws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/shadowshock/renew-ssws.sh" && chmod +x /usr/bin/renew-ssws

#vmess
wget -q -O /usr/bin/menu-vmess "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vmess/menu-vmess.sh" && chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/add-ws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vmess/add-ws.sh" && chmod +x /usr/bin/add-ws
wget -q -O /usr/bin/cek-ws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vmess/cek-ws.sh" && chmod +x /usr/bin/cek-ws
wget -q -O /usr/bin/del-ws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vmess/del-ws.sh" && chmod +x /usr/bin/del-ws
wget -q -O /usr/bin/renew-ws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vmess/renew-ws.sh" && chmod +x /usr/bin/renew-ws

#vless
wget -q -O /usr/bin/menu-vless "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vless/menu-vless.sh" && chmod +x /usr/bin/menu-vless
wget -q -O /usr/bin/add-vless "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vless/add-vless.sh" && chmod +x /usr/bin/add-vless
wget -q -O /usr/bin/cek-vless "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vless/cek-vless.sh" && chmod +x /usr/bin/cek-vless
wget -q -O /usr/bin/del-vless "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vless/del-vless.sh" && chmod +x /usr/bin/del-vless
wget -q -O /usr/bin/renew-vless "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vless/renew-vless.sh" && chmod +x /usr/bin/renew-vless

#trojan
wget -q -O /usr/bin/menu-trojan "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/trojan/menu-trojan.sh" && chmod +x /usr/bin/menu-trojan
wget -q -O /usr/bin/add-tr "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/trojan/add-tr.sh" && chmod +x /usr/bin/add-tr
wget -q -O /usr/bin/cek-tr "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/trojan/cek-tr.sh" && chmod +x /usr/bin/cek-tr
wget -q -O /usr/bin/del-tr "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/trojan/del-tr.sh" && chmod +x /usr/bin/del-tr
wget -q -O /usr/bin/renew-tr "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/trojan/renew-tr.sh" && chmod +x /usr/bin/renew-tr

#--
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/running.sh" && chmod +x /usr/bin/running
wget -q -O /etc/issue.net "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/issue.net" && chmod +x /etc/issue.net
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/cert "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/cert.sh" && chmod +x /usr/bin/cert
wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/update.sh" && chmod +x /usr/bin/update

clear
echo -e "[ ${green}INFO$NC ] Install New Script ..."
sleep 1

sed -i -e 's/\r$//' /bin/menu
sed -i -e 's/\r$//' /bin/cert
sed -i -e 's/\r$//' /bin/update
sed -i -e 's/\r$//' /bin/restart
sed -i -e 's/\r$//' /bin/running

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

sed -i -e 's/\r$//' /bin/menu-ssws
sed -i -e 's/\r$//' /bin/add-ssws
sed -i -e 's/\r$//' /bin/cek-ssws
sed -i -e 's/\r$//' /bin/del-ssws
sed -i -e 's/\r$//' /bin/renew-ssws

clear
sleep 1
echo -e "[ ${green}INFO$NC ] Update successfully!"
sleep 1
echo -e "[ ${green}INFO$NC ] Reboot VPS ..."
sleep 5
reboot