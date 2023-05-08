#!/bin/bash
#date january 2022
# created bye hidessh.com
# Simple
# port Stunnel and Websocket 443 
# ==================================================

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ifconfig.me/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID
arfprsty810="raw.githubusercontent.com/arfprsty810/lite/main"

#detail nama perusahaan
country=ID
state=Indonesia
locality=Indonesia
organization=sg.d-jumper.me
organizationalunit=sg.d-jumper.me
commonname=sg.d-jumper.me
email=arfprsty@my.id

# simple password minimal
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/password"
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END


# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

#update
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

# install wget and curl
apt -y install wget curl
apt -y install python

# install python
cd
gem install lolcat
apt -y install figlet

# install
apt-get -y bzip2 gzip wget screen htop net-tools zip unzip wget curl nano sed screen

# Install Requirements Tools
apt install python -y
apt install make -y
apt install cmake -y
apt install jq -y
apt install apt-transport-https -y
apt install neofetch -y
apt install git -y
apt install gcc -y
apt install g++ -y

#tambahan package nettools
apt-get install net-tools -y

#hapus apache
apt-get remove apache2 -y
apt-get purge apache2* -y

# install webserver
#apt -y install nginx
cd
#rm /etc/nginx/sites-enabled/default
#rm /etc/nginx/sites-available/default
#wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/nginx.conf"
#mkdir -p /home/vps/public_html
#wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/xray/vps.conf"
/etc/init.d/nginx restart

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/badvpn-udpgw64"
#wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/newudpgw"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-


# setting port ssh
sed -i '/Port 22/a Port 88' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart
/etc/init.d/ssh restart


# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=44/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 69 -p 77 -p 300"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install stunnel
systemctl stop stunnel4
apt-get remove --purge stunnel stunnel* -y
rm -rvf /etc/stunnel4
rm -rvf /etc/systemd/system/stunnel5.service
rm -rvf /etc/init.d/stunnel4
rm -rvf /usr/local/share/doc/stunnel
rm -rvf /usr/local/etc/stunnel
rm -rvf /usr/local/bin/stunnel
rm -rvf /usr/local/bin/stunnel3
rm -rvf /usr/local/bin/stunnel4
rm -rvf /usr/local/bin/stunnel5
apt autoremove -y
systemctl daemon-reload
apt install stunnel4 -y
#certi stunnel
#wget -O /etc/stunnel/hidessh.pem https://gitlab.com/hidessh/baru/-/raw/main/certi/stunel && chmod +x /etc/stunnel/hidessh.pem

#installer SSL Cloudflare 
cd
#buat directory
mkdir -p /etc/arfvpn
chmod +x /etc/arfvpn
wget https://raw.githubusercontent.com/arfprsty810/lite/main/cert/arfvpn.crt
wget https://raw.githubusercontent.com/arfprsty810/lite/main/cert/arfvpn.key
#wget -O /etc/arfvpn/stunnel.pem "https://raw.githubusercontent.com/arfprsty810/lite/main/cert/arfvpn.pem"
cat arfvpn.crt arfvpn.key >> /etc/hidessh/stunnel.pem

cd
chmod +x /etc/arfvpn/stunnel.pem

#konfigurasi stunnel4
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/arfvpn/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 222
connect = 127.0.0.1:22

[dropbear]
accept = 444
connect = 127.0.0.1:300

[dropbear]
accept = 777
connect = 127.0.0.1:77

[openvpn]
accept = 442
connect = 127.0.0.1:1194

[slws]
accept = 8443
connect = 127.0.0.1:443

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

cd
#install sslh
apt-get install sslh -y
#konfigurasi
#port 333 to 44 and 777
wget -O /etc/default/sslh "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/sslh.conf"
service sslh restart


# install squid
#cd
#apt -y install squid3
#wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/squid.conf"
#sed -i $MYIP2 /etc/squid/squid.conf
#/etc/init.d/squid restart

#install badvpncdn
wget https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/badvpn-master.zip
unzip badvpn-master.zip
cd badvpn-master
mkdir build
cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
sudo make install

END


# install fail2ban
apt -y install fail2ban


# install ddos
rm -rvf /usr/local/ddos
mkdir -p /usr/local/ddos
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# blockir torrent
apt install iptables-persistent -y
#wget https://raw.githubusercontent.com/4hidessh/hidessh/main/security/torrent && chmod +x torrent && ./torrent
#iptables-save > /etc/iptables.up.rules
#iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

cd
# Custom Banner SSH
echo "================  Banner ======================"
wget -O /etc/issue.net "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/issue.net"
chmod +x /etc/issue.net

echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
echo "DROPBEAR_BANNER="/etc/issue.net"" >> /etc/default/dropbear

#OpenVPN
cd
wget https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/vpn.sh && chmod +x vpn.sh && ./vpn.sh

# ----------------------------------------------------------------------------------------------------------------
# Install Script
# ----------------------------------------------------------------------------------------------------------------
wget -q -O /usr/bin/autodel "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/autodel.sh"
chmod +x /usr/bin/autodel
sed -i -e 's/\r$//' /bin/autodel

wget -q -O /usr/bin/autokill "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/autokill.sh"
chmod +x /usr/bin/autokill
sed -i -e 's/\r$//' /bin/autokill

wget -q -O /usr/bin/cek "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/cek.sh"
chmod +x /usr/bin/cek
sed -i -e 's/\r$//' /bin/cek

wget -q -O /usr/bin/ceklim "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ceklim.sh"
chmod +x /usr/bin/ceklim
sed -i -e 's/\r$//' /bin/ceklim

wget -q -O /usr/bin/del "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/del.sh"
chmod +x /usr/bin/del
sed -i -e 's/\r$//' /bin/del

wget -q -O /usr/bin/member "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/member.sh"
chmod +x /usr/bin/member
sed -i -e 's/\r$//' /bin/member

wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/menu-ssh.sh"
chmod +x /usr/bin/menu-ssh
sed -i -e 's/\r$//' /bin/menu-ssh

wget -q -O /usr/bin/renew "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/renew.sh"
chmod +x /usr/bin/renew
sed -i -e 's/\r$//' /bin/renew

wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/tendang.sh"
chmod +x /usr/bin/tendang
sed -i -e 's/\r$//' /bin/tendang

wget -q -O /usr/bin/usernew "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/usernew.sh"
chmod +x /usr/bin/usernew
sed -i -e 's/\r$//' /bin/usernew

#auto reboot cronjob
#echo "0 5 * * * root clear-log && reboot" >> /etc/crontab
#echo "0 17 * * * root clear-log && reboot" >> /etc/crontab
echo "50 * * * * root xp" >> /etc/crontab

# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/stunnel4 restart
#/etc/init.d/squid restart


history -c
echo "unset HISTFILE" >> /etc/profile

#hapus file instalasi
cd
rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh
rm -f /root/ihide
rm -rf /root/vpnku.sh

# remove unnecessary files
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y



#instalasi Websocket#!/bin/bash
#instalasi Websocket

# Websocket OpenSSH
#port 88 (OpenSSH) to 2082 (HTTP Websocket)
cd
wget -O /usr/local/bin/edu-proxy https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-openssh/http.py && chmod +x /usr/local/bin/edu-proxy
wget -O /etc/systemd/system/edu-proxy.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-openssh//http.service && chmod +x /etc/systemd/system/edu-proxy.service

systemctl daemon-reload
systemctl enable edu-proxy.service
systemctl start edu-proxy.service
systemctl restart edu-proxy.service

clear

# Dropbear WebSocket
#port 69 ( Dropbear) to 8880 (HTTPS Websocket)
cd
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-dropbear/https.py && chmod +x /usr/local/bin/ws-dropbear
wget -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-dropbear/https.service && chmod +x /etc/systemd/system/ws-dropbear.service
#reboot service
systemctl daemon-reload
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service
clear

# OpenVPN WebSocket
#port 1194 ( Dropbear) to 2086 (HTTP Websocket)
wget -O /usr/local/bin/edu-proxyovpn https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-openvpn/ovpn.py && chmod +x /usr/local/bin/edu-proxyovpn
wget -O /etc/systemd/system/edu-proxyovpn.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-openvpn/ovpn.service && chmod +x /etc/systemd/system/edu-proxyovpn.service
#reboot service
systemctl daemon-reload
systemctl enable edu-proxyovpn.service
systemctl start edu-proxyovpn.service
systemctl restart edu-proxyovpn.service
clear


# SSL/TLS WebSocket
#port 1194 ( Dropbear) to 2086 (HTTP Websocket)
wget -O /usr/local/bin/edu-tls https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-ssltls/edu-tls.py && chmod +x /usr/local/bin/edu-tls
wget -O /etc/systemd/system/edu-tls.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-ssltls/edu-tls.service && chmod +x /etc/systemd/system/edu-tls.service
#reboot service
systemctl daemon-reload
systemctl enable edu-tls
systemctl start edu-tls
systemctl restart edu-tls
clear

cd
wget -O /usr/local/bin/ws-tls https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-ssltls/ws-tls && chmod +x /usr/local/bin/ws-tls
wget -O /etc/systemd/system/ws-tls.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-ssltls/ws-tls.service && chmod +x  /etc/systemd/system/ws-tls.service

systemctl daemon-reload
systemctl enable ws-tls
systemctl restart ws-tls

# finihsing
clear
#installer OHP
wget https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ohp/ohp.sh && chmod +x ohp.sh && ./ohp.sh

#installer host
#wget https://raw.githubusercontent.com/arfprsty810/lite/main/services/cf.sh && chmod +x cf.sh && ./cf.sh


#remove file 
cd
rm -rf hideinstall-websocket.sh
rm -rf hidehost.sh
rm -rf ohp.sh

cd
apt-get install zip unzip -y
#index httml
cd /home/vps/public_html
zip config.zip client-udp-2200.ovpn client-tcp-1194.ovpn client-tcp-ssl.ovpn
wget https://raw.githubusercontent.com/arfprsty810/lite/main/xray/index.html


#
cd
