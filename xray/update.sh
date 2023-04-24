#!/bin/bash
#########################

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
rm -rvf /usr/bin/add-tr
rm -rvf /usr/bin/add-vless
rm -rvf /usr/bin/add-ws
rm -rvf /usr/bin/cek-tr
rm -rvf /usr/bin/cek-vless
rm -rvf /usr/bin/cek-ws
rm -rvf /usr/bin/del-tr
rm -rvf /usr/bin/del-vless
rm -rvf /usr/bin/del-ws
rm -rvf /usr/bin/renew-tr
rm -rvf /usr/bin/renew-vless
rm -rvf /usr/bin/renew-ws
rm -rvf /usr/bin/menu
rm -rvf /usr/bin/cert
rm -rvf /usr/bin/speedtest
rm -rvf /usr/bin/update
clear
echo -e "[ ${green}INFO$NC ] Update Script"
sleep 1
wget -q -O /usr/bin/add-tr "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/add-tr.sh" && chmod +x /usr/bin/add-tr
wget -q -O /usr/bin/add-vless "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/add-vless.sh" && chmod +x /usr/bin/add-vless
wget -q -O /usr/bin/add-ws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/add-ws.sh" && chmod +x /usr/bin/add-ws
wget -q -O /usr/bin/cek-tr "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/cek-tr.sh" && chmod +x /usr/bin/cek-tr
wget -q -O /usr/bin/cek-vless "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/cek-vless.sh" && chmod +x /usr/bin/cek-vless
wget -q -O /usr/bin/cek-ws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/cek-ws.sh" && chmod +x /usr/bin/cek-ws
wget -q -O /usr/bin/del-tr "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/del-tr.sh" && chmod +x /usr/bin/del-tr
wget -q -O /usr/bin/del-vless "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/del-vless.sh" && chmod +x /usr/bin/del-vless
wget -q -O /usr/bin/del-ws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/del-ws.sh" && chmod +x /usr/bin/del-ws
wget -q -O /usr/bin/renew-tr "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/renew-tr.sh" && chmod +x /usr/bin/renew-tr
wget -q -O /usr/bin/renew-vless "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/renew-vless.sh" && chmod +x /usr/bin/renew-vless
wget -q -O /usr/bin/renew-ws "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/renew-ws.sh" && chmod +x /usr/bin/renew-ws
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/cert "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/cert.sh" && chmod +x /usr/bin/cert
wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/update.sh" && chmod +x /usr/bin/update
sleep 1
clear
echo -e "[ ${green}INFO$NC ] Update successfully!"
sleep 1
echo -e "[ ${green}INFO$NC ] Reboot VPS ..."
sleep 5
reboot