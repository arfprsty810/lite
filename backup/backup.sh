#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
date=$(date +"%Y-%m-%d")
IP=$(cat /etc/arfvpn/IP);
domain=$(cat /etc/arfvpn/domain)
email=$(cat /home/email)
clear

if [[ "$email" = "" ]]; then
mkdir -p /home/email
echo "Masukkan Email Untuk Menerima Backup"
read -rp "Email : " -e email
cat <<EOF>>/home/email
$email
EOF
fi
email=$(cat /home/email)
clear

echo "Please Wait, Backup Process is in progress!!"
sleep 2
cd /root
rm -rvf /root/backup
mkdir /root/backup
cp /etc/arfvpn /root/backup
#cp /etc/passwd backup/
#cp /etc/group backup/
#cp /etc/shadow backup/
#cp /etc/gshadow backup/
#cp -r /etc/wireguard backup/wireguard
#cp /etc/ppp/chap-secrets backup/chap-secrets
#cp /etc/ipsec.d/passwd backup/passwd1
#cp /etc/shadowsocks-libev/akun.conf backup/ss.conf
#cp -r /var/lib/gl33ch3rvpn/ backup/gl33ch3rvpn
#cp -r /home/sstp backup/sstp
#cp -r /etc/xray backup/xray/
#cp -r /etc/trojan-go backup/trojan-go
#cp -r /usr/local/shadowsocksr/ backup/shadowsocksr
#cp -r /home/vps/public_html backup/public_html
clear

cd /root
zip -r $IP-$date-backup.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date-backup.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date-backup.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
clear

echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Domain        : $domain
Link Backup   : $link
Date          : $date
==================================
" | mail -s "Backup Data" $email
clear

rm -rf /root/backup
rm -r /root/*.zip
clear

echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Domain        : $domain
Link Backup   : $link
Date          : $date
==================================
"
read -n 1 -s -r -p "Please check the Inbox/Spam $email"
clear