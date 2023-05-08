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
source /etc/os-release
export DEBIAN_FRONTEND=noninteractive
arfvpn="/etc/arfvpn"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
DOMAIN=$(cat $arfvpn/domain)
MYIP=$(cat $arfvpn/IP)
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
OS=$ID
ver=$VERSION_ID

if [ "$(id -u)" -ne 0 ]; then
  echo -ne "\nPlease execute this script as root.\n"
  exit 1; fi
if [ ! -f /etc/debian* ]; then
  echo -ne "\nFor DEBIAN and UBUNTU only.\n"
  exit 1; fi

# remove --purge package
apt-get remove --purge ufw* -y
apt-get remove --purge firewalld* -y
apt-get remove --purge exim4* -y
apt autoremove -y
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING SSH $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

# ----------------------------------------------------------------------------------------------------------------
# Setting sshd_config
# ----------------------------------------------------------------------------------------------------------------
echo "Configuring SSH."
cd /etc/ssh
needpass=`grep '^TrustedUserCAKeys' sshd_config`
[ -f "sshd_config-old" ] || mv sshd_config sshd_config-old
cat << ssh > sshd_config
Port 22
PermitRootLogin yes
PubkeyAuthentication no
PasswordAuthentication yes
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem sftp  /usr/lib/openssh/sftp-server
ClientAliveInterval 120
Banner /etc/issue.net
ssh

cd /etc/pam.d
[ -f "common-password" ] || mv common-password common-pass-old
cat << common > common-password
password  [success=1 default=ignore]  pam_unix.so obscure sha512
password  requisite     pam_deny.so
password  required      pam_permit.so
common

sed -i '/\/bin\/false/d;/\/usr\/sbin\/nologin/d' /etc/shells
echo -e "/bin/false\n/usr/sbin/nologin" >> /etc/shells
cd; systemctl restart sshd

echo "Installing required packages."
if [[ ! `type -P docker` ]]; then
APT="apt-get -y"
$APT install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/$ID/gpg | apt-key add - 
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$ID $(lsb_release -cs) stable"
$APT update
apt-cache policy docker-ce
$APT install docker-ce
$APT clean; fi

# ----------------------------------------------------------------------------------------------------------------
# Install Dropbear
# ----------------------------------------------------------------------------------------------------------------
echo "Dropbear"
apt -y install dropbear
cat << drb > /etc/default/dropbear
NO_START=0
DROPBEAR_PORT=444
DROPBEAR_EXTRA_ARGS="-p 109"
DROPBEAR_RSAKEY="/etc/dropbear/dropbear_rsa_host_key"
DROPBEAR_DSSKEY="/etc/dropbear/dropbear_dss_host_key"
DROPBEAR_ECDSAKEY="/etc/dropbear/dropbear_ecdsa_host_key"
DROPBEAR_BANNER="/etc/issue.net"
DROPBEAR_RECEIVE_WINDOW=65536
drb
systemctl restart dropbear

# ----------------------------------------------------------------------------------------------------------------
# Setting Banner
# ----------------------------------------------------------------------------------------------------------------
rm -fr /etc/issue.net
rm -fr /etc/issue.net.save
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Settings banner"
wget -q -O /etc/issue.net "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/issue.net"
chmod +x /etc/issue.net

# ----------------------------------------------------------------------------------------------------------------
# Install Stunnel
# ----------------------------------------------------------------------------------------------------------------
systemctl stop stunnel4
apt-get remove --purge stunnel stunnel* -y
rm -rvf /etc/stunnel*
rm -rvf /etc/systemd/system/stunnel*.*
rm -rvf /etc/init.d/stunnel*
rm -rvf /usr/local/share/doc/stunnel*
rm -rvf /usr/local/etc/stunnel*
rm -rvf /usr/local/bin/stunnel*
apt autoremove -y
systemctl daemon-reload

apt install stunnel4 -y
country=ID
state=Indonesia
locality=Indonesia
organization=™D-JumPer™
organizationalunit=™D-JumPer™
commonname=sg.d-jumper.me
email=arfprsty@my.id

## make a client certificate
#openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
#-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
#cat key.pem cert.pem >> /etc/arfvpn/stunnel.pem

## client cert cloudflare
wget -O /etc/arfvpn/stunnel.pem "https://raw.githubusercontent.com/arfprsty810/lite/main/cert/client.pem"
chmod 600 /etc/arfvpn/stunnel.pem

cat << stnnl4 > /etc/default/stunnel4
ENABLED=1
FILES="/etc/stunnel/*.conf"
OPTIONS=""
BANNER="/etc/banner"
PPP_RESTART=0
# RLIMITS="-n 4096 -d unlimited"
RLIMITS=""
stnnl4
systemctl daemon-reload
/etc/init.d/stunnel4 restart

#cert = /etc/arfvpn/arfvpn.crt
#key = /etc/arfvpn/arfvpn.key
# Config Stunnel
cat > /etc/stunnel/stunnel.conf <<-END
pid = /var/run/stunnel.pid
cert = /etc/arfvpn/stunnel.pem
client = no
options = NO_SSLv2
options = NO_SSLv3
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 221
connect = 127.0.0.1:444

[openssh]
accept = 222
connect = 127.0.0.1:22

[openvpn]
accept = 223
connect = 127.0.0.1:111
END

systemctl restart stunnel4
#systemctl status stunnel4

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
#wget -q -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/badvpn-udpgw64"
wget -q -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/archive/newudpgw"
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
# Install OpenVPN
# ----------------------------------------------------------------------------------------------------------------
#wget https://raw.githubusercontent.com/arfprsty810/lite/main/ssh/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

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
rm -fr /usr/local/ddos
mkdir -p /usr/local/ddos >/dev/null 2>&1
#clear
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Install DOS-Deflate"
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Downloading source files..."
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos  >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Create cron script every minute...."
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Install successfully..."
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Config file at /usr/local/ddos/ddos.conf"

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

cd
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
sleep 1
yellow "SSH & OVPN install successfully"
sleep 5
clear