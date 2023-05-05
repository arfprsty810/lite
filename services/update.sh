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
wget -q -O /usr/bin/xp "$github/xray/xp.sh"
chmod +x /usr/bin/xp
wget -q -O /usr/bin/cf "$github/services/cf.sh"
chmod +x /usr/bin/cf
wget -q -O /usr/bin/restart "$github/services/restart.sh"
chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "$github/services/running.sh"
chmod +x /usr/bin/running
wget -q -O /usr/bin/cek-bandwidth "$github/services/cek-bandwidth.sh"
chmod +x /usr/bin/cek-bandwidth
wget -q -O /usr/bin/menu "$github/services/menu.sh"
chmod +x /usr/bin/menu
wget -q -O /usr/bin/speedtest "$github/services/speedtest_cli.py"
chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "$github/services/update.sh"
chmod +x /usr/bin/update
wget -q -O /usr/bin/cekuser "$github/services/cekuser.sh"
chmod +x /usr/bin/cekuser
wget -q -O /usr/bin/renew-config "$github/backup/renew-config.sh"
chmod +x /usr/bin/renew-config
wget -q -O /usr/bin/backup-user "$github/backup/backup-user.sh"
chmod +x /usr/bin/backup-user
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

echo "      Update Successfully ..."
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu