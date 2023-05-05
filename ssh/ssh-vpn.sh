#!/bin/bash
#########################
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGREEN='\033[1;92m'      # GREEN
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGREEN='\033[0;92m'       # GREEN
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"
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

cd /root/
MYIP=$(cat $xray/IP)
DOMAIN=$(cat $xray/domain)
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
export DEBIAN_FRONTEND=noninteractive
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID
clear

# remove --purge package
apt-get remove --purge ufw* -y
apt-get remove --purge firewalld* -y
apt-get remove --purge exim4* -y
apt autoremove -y
clear

# ----------------------------------------------------------------------------------------------------------------
# Getting SSH_PASSWORD
# ----------------------------------------------------------------------------------------------------------------
cd
# simple password minimal
wget -q -O /etc/pam.d/common-password "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/password"
chmod +x /etc/pam.d/common-password

# ----------------------------------------------------------------------------------------------------------------
# Setting rc.local
# ----------------------------------------------------------------------------------------------------------------
# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

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

# Ubah izin akses
chmod +x /etc/rc.local
echo -e " "
date
echo ""
# enable rc local
sleep 1
echo -e "[ ${GREEN}INFO${NC} ] Checking... "
sleep 2
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Enable system rc local"
systemctl enable rc-local >/dev/null 2>&1
systemctl start rc-local.service >/dev/null 2>&1

# ----------------------------------------------------------------------------------------------------------------
# Setting sshd_config
# ----------------------------------------------------------------------------------------------------------------
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 88' /etc/ssh/sshd_config
#echo "X11Forwarding yes" >> /etc/ssh/sshd_config
#echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config
#echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
#echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
#echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
#sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
#sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
systemctl daemon-reload >/dev/null 2>&1
systemctl start ssh >/dev/null 2>&1
systemctl restart ssh >/dev/null 2>&1

# ----------------------------------------------------------------------------------------------------------------
# Install Dropbear
# ----------------------------------------------------------------------------------------------------------------
# Setting & Install Dropbear
apt-get remove --purge dropbear* -y
apt -y install dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i '/DROPBEAR_PORT=143/a DROPBEAR_PORT=69' /etc/default/dropbear
sed -i '/DROPBEAR_PORT=143/a DROPBEAR_PORT=1194' /etc/default/dropbear
sed -i '/DROPBEAR_PORT=143/a DROPBEAR_PORT=109' /etc/default/dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# ----------------------------------------------------------------------------------------------------------------
# Instalasi Websocket#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------

# Dropbear WebSocket
#port 69 ( Dropbear) to 8880 (HTTPS Websocket)
#DEFAULT_HOST = '127.0.0.1:69'
#LISTENING_PORT = 8880
cd
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-dropbear/https.py && chmod +x /usr/local/bin/ws-dropbear
wget -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-dropbear/https.service && chmod +x /etc/systemd/system/ws-dropbear.service

systemctl daemon-reload
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service

# OpenSSH Websocket
#port 88 (OpenSSH) to 80/2082 (HTTP Websocket)
#DEFAULT_HOST = '127.0.0.1:88'
#LISTENING_PORT = 80
cd
wget -O /usr/local/bin/edu-proxy https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-openssh/http.py && chmod +x /usr/local/bin/edu-proxy
wget -O /etc/systemd/system/edu-proxy.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-openssh/http.service && chmod +x /etc/systemd/system/edu-proxy.service

systemctl daemon-reload
systemctl enable edu-proxy.service
systemctl start edu-proxy.service
systemctl restart edu-proxy.service

# OpenVPN WebSocket
#port 1194 ( Dropbear) to 2086 (HTTP Websocket)
#DEFAULT_HOST = '127.0.0.1:1194'
#LISTENING_PORT = 2086  
wget -O /usr/local/bin/edu-proxyovpn https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-openvpn/ovpn.py && chmod +x /usr/local/bin/edu-proxyovpn
wget -O /etc/systemd/system/edu-proxyovpn.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-openvpn/ovpn.service && chmod +x /etc/systemd/system/edu-proxyovpn.service

systemctl daemon-reload
systemctl enable edu-proxyovpn.service
systemctl start edu-proxyovpn.service
systemctl restart edu-proxyovpn.service

# SSL/TLS WebSocket
#port 1194 ( Dropbear) to 443/2086 (HTTP Websocket)
#DEFAULT_HOST = '127.0.0.1:1194'
#LISTENING_PORT = 443  
wget -O /usr/local/bin/edu-tls https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-ssltls/edu-tls.py && chmod +x /usr/local/bin/edu-tls
wget -O /etc/systemd/system/edu-tls.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-ssltls/edu-tls.service && chmod +x /etc/systemd/system/edu-tls.service
cd
wget -O /usr/local/bin/ws-tls https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-ssltls/ws-tls.py && chmod +x /usr/local/bin/ws-tls
wget -O /etc/systemd/system/ws-tls.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-ssltls/ws-tls.service && chmod +x  /etc/systemd/system/ws-tls.service

systemctl daemon-reload.service
systemctl enable edu-tls.service
systemctl start edu-tls.service
systemctl restart edu-tls.service
systemctl enable ws-tls.service
systemctl start ws-tls.service
systemctl restart ws-tls.service

# Stunnel WebSocket
#port 109 ( Dropbear) to 700/2086 (HTTP Websocket)
#DEFAULT_HOST = '127.0.0.1:109'
#LISTENING_PORT = 700
cd
wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-stunnel/ws-stunnel.py && chmod +x /usr/local/bin/ws-stunnel
wget -O /etc/systemd/system/ws-stunnel.service https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ws-stunnel/ws-stunnel.service && chmod +x /etc/systemd/system/ws-stunnel.service

systemctl daemon-reload
systemctl enable ws-stunnel
systemctl status ws-stunnel
systemctl restart ws-stunnel

#installer OHP
wget https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/ohp/ohp.sh && chmod +x ohp.sh && ./ohp.sh


# ----------------------------------------------------------------------------------------------------------------
# Install BadVPN
# ----------------------------------------------------------------------------------------------------------------
# install badvpn
tesmatch=`screen -list | awk  '{print $1}' | grep -ow "badvpn" | sort | uniq`
if [ "$tesmatch" = "badvpn" ]; then
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Screen badvpn detected"
rm /root/screenlog > /dev/null 2>&1
    runningscreen=( `screen -list | awk  '{print $1}' | grep -w "badvpn"` ) # sed 's/\.[^ ]*/ /g'
    for actv in "${runningscreen[@]}"
    do
        cek=( `screen -list | awk  '{print $1}' | grep -w "badvpn"` )
        if [ "$cek" = "$actv" ]; then
        for sama in "${cek[@]}"; do
            sleep 1
            screen -XS $sama quit > /dev/null 2>&1
            echo -e "[ ${red}CLOSE$NC ] Closing screen $sama"
        done 
        fi
    done
else
echo -ne
fi
cd
echo -e "[ ${GREEN}INFO$NC ] Installing badvpn for game support..."
wget -q -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/badvpn-udpgw64"
#wget -q -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/newudpgw"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500 >/dev/null 2>&1

# ----------------------------------------------------------------------------------------------------------------
# Install Squid
# ----------------------------------------------------------------------------------------------------------------
#cd
#apt -y install squid
#wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/squid3.conf"
#sed -i $MYIP2 /etc/squid/squid.conf

# ----------------------------------------------------------------------------------------------------------------
# Install SSLH
# ----------------------------------------------------------------------------------------------------------------
#apt -y install sslh
#rm -f /etc/default/sslh
#cat > /etc/default/sslh <<-END
# Default options for sslh initscript
# sourced by /etc/init.d/sslh

# Disabled by default, to force yourself
# to read the configuration:
# - /usr/share/doc/sslh/README.Debian (quick start)
# - /usr/share/doc/sslh/README, at "Configuration" section
# - sslh(8) via "man sslh" for more configuration details.
# Once configuration ready, you *must* set RUN to yes here
# and try to start sslh (standalone mode only)
#RUN=yes

# binary to use: forked (sslh) or single-thread (sslh-select) version
# systemd users: don't forget to modify /lib/systemd/system/sslh.service
#DAEMON=/usr/sbin/sslh

#DAEMON_OPTS="--user sslh --listen 0.0.0.0:443 --ssl 127.0.0.1:777 --ssh 127.0.0.1:109 --openvpn 127.0.0.1:1194 --http 127.0.0.1:8880 --pidfile /var/run/sslh/sslh.pid -n"

#END

# Restart Service SSLH
#service sslh restart
#systemctl restart sslh
#/etc/init.d/sslh restart
#/etc/init.d/sslh status
#/etc/init.d/sslh restart

# ----------------------------------------------------------------------------------------------------------------
# Install Stunnel
# ----------------------------------------------------------------------------------------------------------------
cd /root/
#apt-get install stunnel5 -y
#wget -q -O /usr/bin/ssh_ssl "https://raw.githubusercontent.com/arfprsty810/lite/main/stunnel5/ssh-ssl.sh"
#chmod +x /usr/bin/ssh_ssl
#sed -i -e 's/\r$//' /bin/ssh_ssl
#/usr/bin/ssh_ssl
#rm -rvf /usr/bin/ssh_ssl
systemctl stop stunnel5
apt-get remove --purge stunnel stunnel* -y
rm -rvf /etc/stunnel5
rm -rvf /etc/systemd/system/stunnel5.service
rm -rvf /etc/init.d/stunnel5
rm -rvf /usr/local/share/doc/stunnel
rm -rvf /usr/local/etc/stunnel
rm -rvf /usr/local/bin/stunnel
rm -rvf /usr/local/bin/stunnel3
rm -rvf /usr/local/bin/stunnel4
rm -rvf /usr/local/bin/stunnel5
apt autoremove -y
systemctl daemon-reload
#apt-get install stunnel5 -y
wget -q -O stunnel5.zip "https://raw.githubusercontent.com/arfprsty810/lite/main/stunnel5/stunnel5.zip"
unzip -o stunnel5.zip
cd /root/stunnel
chmod +x configure
./configure
make
make install
cd
rm -r -f stunnel
rm -f stunnel5.zip
mkdir -p /etc/stunnel5
chmod 644 /etc/stunnel5

#detail nama perusahaan
#country=ID
#state=Indonesia
#locality=Indonesia
#organization=™D-JumPer™
#organizationalunit=™D-JumPer™
#commonname=188.166.221.220 # name host / ip droplet
#email=arfprsty@my.id

# make a certificate
#openssl genrsa -out key.pem 2048
#openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
#-subj "/C=ID/ST=Indonesia/L=Indonesia/O=™D-JumPer™/OU=™D-JumPer™/CN=188.166.221.220/emailAddress=arfprsty@my.id"
#cat key.pem cert.pem >> /etc/stunnel5/stunnel5.pem

#cd /etc/xray/
rm -rvf /etc/stunnel5/stunnel5.pem
#cat xray.key xray.crt >> /etc/stunnel5/stunnel5.pem
#cd

cd
#buat directory
mkdir -p /etc/arfvpn
chmod +x /etc/arfvpn
wget https://raw.githubusercontent.com/arfprsty810/lite/main/cert/arfvpn.crt
wget https://raw.githubusercontent.com/arfprsty810/lite/main/cert/arfvpn.key
#wget -O /etc/arfvpn/stunnel.pem "https://raw.githubusercontent.com/arfprsty810/lite/main/cert/arfvpn.pem"
cat arfvpn.key arfvpn.crt >> /etc/arfvpn/stunnel.pem
chmod 600 /etc/arfvpn/stunnel.pem

# Config Stunnel5
cat > /etc/stunnel5/stunnel5.conf <<-END
cert = /etc/arfvpn/stunnel.pem
#cert = /etc/xray/xray.crt
#key = /etc/xray/xray.key
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 447
connect = 127.0.0.1:109

[openssh]
accept = 777
connect = 127.0.0.1:443

[openvpn]
accept = 990
connect = 127.0.0.1:1194

END

# Service Stunnel5 systemctl restart stunnel5
cat > /etc/systemd/system/stunnel5.service << END
[Unit]
Description=Stunnel5 Service
Documentation=https://stunnel.org
Documentation=https://github.com/arfprsty810
After=syslog.target network-online.target

[Service]
ExecStart=/usr/local/bin/stunnel5 /etc/stunnel5/stunnel5.conf
Type=forking

[Install]
WantedBy=multi-user.target
END

# Service Stunnel5 /etc/init.d/stunnel5
wget -q -O /etc/init.d/stunnel5 "https://raw.githubusercontent.com/arfprsty810/lite/main/stunnel5/stunnel5.init"
#chmod 600 /etc/stunnel5/stunnel5.pem
chmod +x /etc/init.d/stunnel5
cp /usr/local/bin/stunnel /usr/local/bin/stunnel5

# Remove File
rm -r -f /usr/local/share/doc/stunnel/
rm -r -f /usr/local/etc/stunnel/
rm -f /usr/local/bin/stunnel
rm -f /usr/local/bin/stunnel3
rm -f /usr/local/bin/stunnel4
#rm -f /usr/local/bin/stunnel5

# Restart Stunnel 5
systemctl stop stunnel5
systemctl enable stunnel5
systemctl start stunnel5
systemctl restart stunnel5
/etc/init.d/stunnel5 restart
/etc/init.d/stunnel5 status
/etc/init.d/stunnel5 restart

# ----------------------------------------------------------------------------------------------------------------
# Install OpenVPN
# ----------------------------------------------------------------------------------------------------------------
wget https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

# ----------------------------------------------------------------------------------------------------------------
# Install Fail2Ban
# ----------------------------------------------------------------------------------------------------------------
apt install fail2ban -y

# ----------------------------------------------------------------------------------------------------------------
# Setting VNSTAT
# ----------------------------------------------------------------------------------------------------------------
apt -y install vnstat
#/etc/init.d/vnstat restart
#wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
#tar zxvf vnstat-2.6.tar.gz
#cd vnstat-2.6
#./configure --prefix=/usr --sysconfdir=/etc && make && make install
#cd
#vnstat -u -i $NET
#sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
#chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
#rm -f /root/vnstat-2.6.tar.gz
#rm -rf /root/vnstat-2.6

# ----------------------------------------------------------------------------------------------------------------
# Install DDos Flate
# ----------------------------------------------------------------------------------------------------------------
#rm -fr /usr/local/ddos
#mkdir -p /usr/local/ddos >/dev/null 2>&1
#clear
#sleep 1
#echo -e "[ ${GREEN}INFO$NC ] Install DOS-Deflate"
#sleep 1
#echo -e "[ ${GREEN}INFO$NC ] Downloading source files..."
#wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
#wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
#wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
#wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
#chmod 0755 /usr/local/ddos/ddos.sh
#cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos  >/dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}INFO$NC ] Create cron script every minute...."
#/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
#sleep 1
#echo -e "[ ${GREEN}INFO$NC ] Install successfully..."
#sleep 1
#echo -e "[ ${GREEN}INFO$NC ] Config file at /usr/local/ddos/ddos.conf"

# ----------------------------------------------------------------------------------------------------------------
# Setting Banner
# ----------------------------------------------------------------------------------------------------------------
rm -fr /etc/issue.net
rm -fr /etc/issue.net.save
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Settings banner"
wget -q -O /etc/issue.net "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/issue.net"
chmod +x /etc/issue.net
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# ----------------------------------------------------------------------------------------------------------------
# Setting Block Torrent
# ----------------------------------------------------------------------------------------------------------------
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# ----------------------------------------------------------------------------------------------------------------
# Remove Unnecessary Files
# ----------------------------------------------------------------------------------------------------------------
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Clearing trash"
apt autoclean -y >/dev/null 2>&1

if dpkg -s unscd >/dev/null 2>&1; then
apt -y remove --purge unscd >/dev/null 2>&1
fi

# apt-get -y --purge remove samba* >/dev/null 2>&1
# apt-get -y --purge remove apache2* >/dev/null 2>&1
# apt-get -y --purge remove bind9* >/dev/null 2>&1
# apt-get -y remove sendmail* >/dev/null 2>&1
#apt autoremove -y >/dev/null 2>&1

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

# ----------------------------------------------------------------------------------------------------------------
# Finish
# ----------------------------------------------------------------------------------------------------------------
history -c
echo "unset HISTFILE" >> /etc/profile

cd
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
sleep 1
yellow "SSH & OVPN install successfully"
sleep 5
clear