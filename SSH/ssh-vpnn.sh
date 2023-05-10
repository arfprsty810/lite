#!/bin/bash
# ==================================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear

# ==================================================
# Link
sshlink="raw.githubusercontent.com/arfprsty810/lite/main/SSH"
stunnel5link="raw.githubusercontent.com/arfprsty810/lite/main/stunnel5"
websocketlink="raw.githubusercontent.com/arfprsty810/lite/main/SSH/websocket"

# source /etc/os-release
# ==================================================
export DEBIAN_FRONTEND=noninteractive
source /etc/os-release
ver=$VERSION_ID
arfvpn="/etc/arfvpn"
ipvps="/var/lib/arfvpn"
MYIP=$(cat $arfvpn/IP);
DOMAIN=$(cat $arfvpn/domain)
MYIP2="s/xxxxxxxxx/139.59.110.197/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');

# ----------------------------------------------------------------------------------------------------------------
# Setting sshd_config
# ----------------------------------------------------------------------------------------------------------------
echo "Configuring SSH."
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config

cd /etc/pam.d
[ -f "common-password" ] || mv common-password common-pass-old
cat << common > common-password
password  [success=1 default=ignore]  pam_unix.so obscure sha512
password  requisite     pam_deny.so
password  required      pam_permit.so
common
cd; systemctl restart sshd

# ----------------------------------------------------------------------------------------------------------------
# Install Dropbear
# ----------------------------------------------------------------------------------------------------------------
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# ----------------------------------------------------------------------------------------------------------------
# Install Banner
# ----------------------------------------------------------------------------------------------------------------
wget -O /etc/issue.net "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/issue.net"
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# ----------------------------------------------------------------------------------------------------------------
# Install BadVPN
# ----------------------------------------------------------------------------------------------------------------
cd
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
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

# ----------------------------------------------------------------------------------------------------------------
# Setting RC.Local
# ----------------------------------------------------------------------------------------------------------------
# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
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

chmod +x /etc/rc.local
systemctl enable rc-local >/dev/null 2>&1
systemctl start rc-local.service >/dev/null 2>&1

# ----------------------------------------------------------------------------------------------------------------
# Install Squid
# ----------------------------------------------------------------------------------------------------------------
cd
apt -y install squid3
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/squid3.conf"
sed -i "s/xxxxxxxxx/139.59.110.197/g" /etc/squid/squid.conf

# ----------------------------------------------------------------------------------------------------------------
# Install SSLH
# ----------------------------------------------------------------------------------------------------------------
apt -y install sslh

rm -f /etc/default/sslh
cat > /etc/default/sslh <<-END
# Default options for sslh initscript
# sourced by /etc/init.d/sslh

# Disabled by default, to force yourself
# to read the configuration:
# - /usr/share/doc/sslh/README.Debian (quick start)
# - /usr/share/doc/sslh/README, at "Configuration" section
# - sslh(8) via "man sslh" for more configuration details.
# Once configuration ready, you *must* set RUN to yes here
# and try to start sslh (standalone mode only)

RUN=yes

# binary to use: forked (sslh) or single-thread (sslh-select) version
# systemd users: don't forget to modify /lib/systemd/system/sslh.service
DAEMON=/usr/sbin/sslh

DAEMON_OPTS="--user sslh --listen 0.0.0.0:443 --ssl 127.0.0.1:777 --ssh 127.0.0.1:109 --openvpn 127.0.0.1:1194 --http 127.0.0.1:8880 --pidfile /var/run/sslh/sslh.pid -n"

END

# Restart Service SSLH
service sslh restart
systemctl restart sslh
/etc/init.d/sslh restart
/etc/init.d/sslh status
/etc/init.d/sslh restart

# ----------------------------------------------------------------------------------------------------------------
# Install VNSTAT
# ----------------------------------------------------------------------------------------------------------------
cd
#apt -y install vnstat
#/etc/init.d/vnstat restart
#apt -y install libsqlite3-dev
wget https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

# ----------------------------------------------------------------------------------------------------------------
# Install Stunnel5
# ----------------------------------------------------------------------------------------------------------------
cd /root/
wget -q -O stunnel5.zip "https://raw.githubusercontent.com/arfprsty810/lite/main/stunnel5/stunnel5.zip"
unzip -o stunnel5.zip
cd /root/stunnel
chmod +x configure
./configure
make
make install
cd /root
rm -r -f stunnel
rm -f stunnel5.zip
mkdir -p /etc/stunnel5
chmod 644 /etc/stunnel5

wget -O /etc/arfvpn/stunnel.pem "https://raw.githubusercontent.com/arfprsty810/lite/main/cert/client.pem"
chmod 600 /etc/arfvpn/stunnel.pem

# Download Config Stunnel5
cat > /etc/stunnel5/stunnel5.conf <<-END
cert = /etc/arfvpn/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 445
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
After=syslog.target network-online.target

[Service]
ExecStart=/usr/local/bin/stunnel5 /etc/stunnel5/stunnel5.conf
Type=forking

[Install]
WantedBy=multi-user.target
END

# Service Stunnel5 /etc/init.d/stunnel5
wget -q -O /etc/init.d/stunnel5 "https://raw.githubusercontent.com/arfprsty810/lite/main/stunnel5/stunnel5.init"

# Ubah Izin Akses
chmod 600 /etc/stunnel5/stunnel5.pem
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
wget https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

# ----------------------------------------------------------------------------------------------------------------
# Install Ddos
# ----------------------------------------------------------------------------------------------------------------
rm -fr /usr/local/ddos
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
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

# ----------------------------------------------------------------------------------------------------------------
# Install BBR
# ----------------------------------------------------------------------------------------------------------------
wget https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/bbr.sh && chmod +x bbr.sh && ./bbr.sh

# ----------------------------------------------------------------------------------------------------------------
# Install Blockir Torrent
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
# Install WebSocket
# ----------------------------------------------------------------------------------------------------------------
#cd
#wget "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/websocket/edu.sh"
#chmod +x edu.sh
#./edu.sh

# ----------------------------------------------------------------------------------------------------------------
# Download Script
# ----------------------------------------------------------------------------------------------------------------
cd /usr/bin
wget -O addhost "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/addhost.sh"
wget -O about "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/about.sh"
wget -O menuvpn "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/menu.sh"
wget -O addssh "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/addssh.sh"
wget -O trialssh "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/trialssh.sh"
wget -O delssh "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/delssh.sh"
wget -O member "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/member.sh"
wget -O delexp "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/delexp.sh"
wget -O cekssh "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/cekssh.sh"
wget -O restart "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/info.sh"
wget -O ram "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/ram.sh"
wget -O renewssh "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/renewssh.sh"
wget -O autokill "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/tendang.sh"
wget -O clearlog "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/clearlog.sh"
wget -O changeport "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/changeport.sh"
wget -O portovpn "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/portovpn.sh"
wget -O portwg "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/portwg.sh"
wget -O porttrojan "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/porttrojan.sh"
wget -O portsstp "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/portsstp.sh"
wget -O portsquid "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/portsquid.sh"
wget -O portvlm "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/portvlm.sh"
wget -O wbmn "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/webmin.sh"
wget -O xp "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/xp.sh"
wget -O swapkvm "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/swapkvm.sh"
wget -O certsslh "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/certsslh.sh"
wget -O cfnhost "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/cfnhost.sh"

wget -O portsshws "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/websocket/portsshws.sh"
wget -O portsshnontls "https://raw.githubusercontent.com/arfprsty810/lite/main/SSH/websocket/portsshnontls.sh"

chmod +x addhost
chmod +x menuvpn
chmod +x addssh
chmod +x trialssh
chmod +x delssh
chmod +x member
chmod +x delexp
chmod +x cekssh
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renewssh
chmod +x clearlog
chmod +x changeport
chmod +x portovpn
chmod +x portwg
chmod +x porttrojan
chmod +x portsstp
chmod +x portsquid
chmod +x portvlm
chmod +x wbmn
chmod +x xp
chmod +x swapkvm

chmod +x portsshws
chmod +x portsshnontls
chmod +x cfnhost
chmod +x certsslh
echo "0 5 * * * root clearlog && reboot" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
echo "5 0 * * * root delexp && restart " >> /etc/crontab

# ----------------------------------------------------------------------------------------------------------------
# Remove Unnecessary Files
# ----------------------------------------------------------------------------------------------------------------
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y

# ----------------------------------------------------------------------------------------------------------------
# Finisihing
# ----------------------------------------------------------------------------------------------------------------
cd
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/vnstat restart
/etc/init.d/fail2ban restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
clear