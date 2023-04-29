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

xray="/etc/arf/xray"

ipvps="/var/lib/arf"
log="/var/log/arf/xray"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
# set random pwd
openssl rand -base64 16 > $xray/passwd
pwd=$(cat $xray/passwd)
# set random uuid
uuid=$(cat /proc/sys/kernel/random/uuid)

mkdir -p $xray
mkdir -p $ipvps >/dev/null 2>&1
echo "IP=" >> $ipvps/ipvps.conf
touch $xray/domain
touch $xray/scdomain

secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}

clear
echo " Vmess / Vless Trojan "
echo "IN Progress ..."
sleep 3
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
echo -e ""

date
echo ""
read -rp "Input ur domain : " -e pp
    if [ -z $pp ]; then
        echo -e "
        Nothing input for domain!
        Then a random domain will be created"
    else
	echo "$pp" > $xray/domain
	echo "$pp" > $xray/scdomain
	echo "$pp" > /root/domain
    echo "$pp" > /root/scdomain
    echo "IP=$pp" > $ipvps/ipvps.conf
    curl -s ipinfo.io/org/ > $xray/ISP
    curl -s https://ipinfo.io/ip/ > $xray/IP
    fi
domain=$(cat $xray/domain)
sleep 1

cd /root/
apt update && apt upgrade -y
clear
apt clean all && apt update
clear
apt install iptables iptables-persistent -y
clear
apt install cron bash-completion -y
clear
apt install pwgen openssl netcat -y
clear
apt install lsb-release -y 
clear
apt install zip -y
clear
apt install net-tools -y
clear
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils -y
clear
apt-get --reinstall --fix-missing install -y sudo dpkg psmisc jq ruby wondershaper python2 tmux nmap bzip2 gzip coreutils iftop htop unzip vim nano gcc g++ automake make autoconf perl m4 dos2unix libreadline-dev zlib1g-dev git
clear
apt-get --reinstall --fix-missing install -y libssl-dev screen rsyslog sed bc build-essential dirmngr libxml-parser-perl neofetch screenfetch lsof easy-rsa fail2ban vnstat libsqlite3-dev dropbear
gem install lolcat
clear

echo -e "[ ${green}INFO$NC ] Disable ipv6"
sleep 1
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6 >/dev/null 2>&1
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local >/dev/null 2>&1
apt update -y
apt upgrade -y
apt dist-upgrade -y
clear
echo -e "[ ${green}INFO${NC} ] Checking... "
apt install iptables iptables-persistent -y
sleep 1
clear
echo -e "[ ${green}INFO$NC ] Setting ntpdate"
apt install ntpdate -y
ntpdate -u pool.ntp.org
ntpdate pool.ntp.org 
timedatectl set-ntp true
timedatectl set-timezone Asia/Jakarta
sleep 1
clear
echo -e "[ ${green}INFO$NC ] Enable chronyd"
apt -y install chrony
systemctl enable chronyd
systemctl restart chronyd
sleep 1
clear
echo -e "[ ${green}INFO$NC ] Enable chrony"
systemctl enable chrony
systemctl restart chrony
clear
sleep 1
clear
echo -e "[ ${green}INFO$NC ] Setting chrony tracking"
chronyc sourcestats -v
chronyc tracking -v
clear
echo -e "[ ${green}INFO$NC ] Setting service"
apt update -y
apt upgrade -y
clear
echo " "

# install xray
sleep 1
echo -e "[ ${green}INFO$NC ] Downloading & Installing xray core"
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir
clear

# Make Folder XRay
mkdir -p $log
chown www-data.www-data $log
chmod +x $log
touch $log/access.log
touch $log/error.log
touch $log/access2.log
touch $log/error2.log
# / / Ambil Xray Core Version Terbaru
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 1.5.6

echo -e "[ ${green}INFO$NC ] INSATLL NGINX SERVER"
# install webserver
cd
apt -y install nginx
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "$github/xray/nginx.conf"
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
cd /home/vps/public_html
wget -O /home/vps/public_html/index.html "$github/xray/index.html"
/etc/init.d/nginx restart
cd
clear

echo -e "[ ${green}INFO$NC ] INSATLL CERT SSL"
## crt xray
systemctl stop nginx
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath $xray/xray.crt --keypath $xray/xray.key --ecc
clear

echo -e "[ ${green}INFO$NC ] RENEW CERT SSL"
# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
' > /usr/local/bin/ssl_renew.sh
chmod +x /usr/local/bin/ssl_renew.sh
if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/local/bin/ssl_renew.sh") | crontab;fi
clear

# Random Port Xray
trojanws=$((RANDOM + 10000))
ssws=$((RANDOM + 10000))
ssgrpc=$((RANDOM + 10000))
vless=$((RANDOM + 10000))
vlessgrpc=$((RANDOM + 10000))
vmess=$((RANDOM + 10000))
worryfree=$((RANDOM + 10000))
kuotahabis=$((RANDOM + 10000))
vmessgrpc=$((RANDOM + 10000))
trojangrpc=$((RANDOM + 10000))

# xray config
cat > $xray/config.json << END
{
  "log" : {
    "access": "$log/access.log",
    "error": "$log/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
      {
      "listen": "127.0.0.1",
      "port": 10085,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
    },
    {
      "listen": "127.0.0.1",
      "port": "$trojanws",
      "protocol": "trojan",
      "settings": {
          "decryption":"none",		
           "clients": [
              {
                 "password": "${uuid}"
#trojanws
              }
          ],
         "udp": true
       },
       "streamSettings":{
           "network": "ws",
           "wsSettings": {
               "path": "/trojan-ws"
            }
         }
     },
     {
        "listen": "127.0.0.1",
        "port": "$trojangrpc",
        "protocol": "trojan",
        "settings": {
          "decryption":"none",
             "clients": [
               {
                 "password": "${uuid}"
#trojangrpc
               }
           ]
        },
         "streamSettings":{
         "network": "grpc",
           "grpcSettings": {
               "serviceName": "trojan-grpc"
         }
      }
   },
   {
     "listen": "127.0.0.1",
     "port": "$vless",
     "protocol": "vless",
      "settings": {
          "decryption":"none",
            "clients": [
               {
                 "id": "${uuid}"
#vless
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/vless"
          }
        }
     },
      {
        "listen": "127.0.0.1",
        "port": "$vlessgrpc",
        "protocol": "vless",
        "settings": {
         "decryption":"none",
           "clients": [
             {
               "id": "${uuid}"
#vlessgrpc
             }
          ]
       },
          "streamSettings":{
             "network": "grpc",
             "grpcSettings": {
                "serviceName": "vless-grpc"
           }
        }
     },
     {
     "listen": "127.0.0.1",
     "port": "$vmess",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmess
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/vmess"
          }
        }
     },
     {
      "listen": "127.0.0.1",
      "port": "$vmessgrpc",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmessgrpc
             }
          ]
       },
       "streamSettings":{
         "network": "grpc",
            "grpcSettings": {
                "serviceName": "vmess-grpc"
          }
        }
     },
     {
     "listen": "127.0.0.1",
     "port": "$worryfree",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmessworry
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/worryfree"
          }
        }
     },
     {
     "listen": "127.0.0.1",
     "port": "$kuotahabis",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmesskuota
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/kuota-habis"
          }
        }
     }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true,
      "statsOutboundUplink" : true,
      "statsOutboundDownlink" : true
    }
  }
}
END

rm -rf /etc/systemd/system/xray.service.d
cat <<EOF> /etc/systemd/system/xray.service
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE                                 AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config $xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF
cat > /etc/systemd/system/runn.service <<EOF
[Unit]
Description=Mampus-Anjeng
After=network.target

[Service]
Type=simple
ExecStartPre=-/usr/bin/mkdir -p /var/run/xray
ExecStart=/usr/bin/chown www-data:www-data /var/run/xray
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF
clear

#nginx config
cat >/etc/nginx/conf.d/xray.conf <<EOF
    server {
             listen 80;
             listen [::]:80;
             listen 443 ssl http2 reuseport;
             listen [::]:443 http2 reuseport;	
             server_name $domain;
             ssl_certificate $xray/xray.crt;
             ssl_certificate_key $xray/xray.key;
             ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
             ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
             root /home/vps/public_html;
        }
EOF

sed -i '$ ilocation /' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:700'';' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /vless' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$vless"';' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /vmess' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$vmess"';' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /worryfree' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$worryfree"';' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /kuota-habis' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$kuotahabis"';' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /trojan-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$trojanws"';' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"$vlessgrpc"';' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"$vmessgrpc"';' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"$trojangrpc"';' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#sleep 1
#echo -e "[ ${green}INFO$NC ] Installing bbr.."
#wget -q -O /usr/bin/bbr "wget -q $github/file/bbr.sh"
#chmod +x /usr/bin/bbr
#bbr >/dev/null 2>&1
#rm /usr/bin/bbr >/dev/null 2>&1

echo -e "$yell[SERVICE]$NC Restart All service"
systemctl daemon-reload
sleep 1
clear

echo -e "[ ${green}ok${NC} ] Enable & restart xray "
systemctl enable xray
systemctl restart xray
systemctl restart nginx
systemctl enable runn
systemctl restart runn
clear
sleep 1

#shadowshock
wget -q -O /usr/bin/menu-ssws "$github/xray/shadowshock/menu-ssws.sh" && chmod +x /usr/bin/menu-ssws
wget -q -O /usr/bin/add-ssws "$github/xray/shadowshock/add-ssws.sh" && chmod +x /usr/bin/add-ssws
wget -q -O /usr/bin/cek-ssws "$github/xray/shadowshock/cek-ssws.sh" && chmod +x /usr/bin/cek-ssws
wget -q -O /usr/bin/del-ssws "$github/xray/shadowshock/del-ssws.sh" && chmod +x /usr/bin/del-ssws
wget -q -O /usr/bin/renew-ssws "$github/xray/shadowshock/renew-ssws.sh" && chmod +x /usr/bin/renew-ssws

#vmess
wget -q -O /usr/bin/menu-vmess "$github/xray/vmess/menu-vmess.sh" && chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/add-ws "$github/xray/vmess/add-ws.sh" && chmod +x /usr/bin/add-ws
wget -q -O /usr/bin/cek-ws "$github/xray/vmess/cek-ws.sh" && chmod +x /usr/bin/cek-ws
wget -q -O /usr/bin/del-ws "$github/xray/vmess/del-ws.sh" && chmod +x /usr/bin/del-ws
wget -q -O /usr/bin/renew-ws "$github/xray/vmess/renew-ws.sh" && chmod +x /usr/bin/renew-ws

#vless
wget -q -O /usr/bin/menu-vless "$github/xray/vless/menu-vless.sh" && chmod +x /usr/bin/menu-vless
wget -q -O /usr/bin/add-vless "$github/xray/vless/add-vless.sh" && chmod +x /usr/bin/add-vless
wget -q -O /usr/bin/cek-vless "$github/xray/vless/cek-vless.sh" && chmod +x /usr/bin/cek-vless
wget -q -O /usr/bin/del-vless "$github/xray/vless/del-vless.sh" && chmod +x /usr/bin/del-vless
wget -q -O /usr/bin/renew-vless "$github/xray/vless/renew-vless.sh" && chmod +x /usr/bin/renew-vless

#trojan
wget -q -O /usr/bin/menu-trojan "$github/xray/trojan/menu-trojan.sh" && chmod +x /usr/bin/menu-trojan
wget -q -O /usr/bin/add-tr "$github/xray/trojan/add-tr.sh" && chmod +x /usr/bin/add-tr
wget -q -O /usr/bin/cek-tr "$github/xray/trojan/cek-tr.sh" && chmod +x /usr/bin/cek-tr
wget -q -O /usr/bin/del-tr "$github/xray/trojan/del-tr.sh" && chmod +x /usr/bin/del-tr
wget -q -O /usr/bin/renew-tr "$github/xray/trojan/renew-tr.sh" && chmod +x /usr/bin/renew-tr

#--
wget -q -O /usr/bin/restart "$github/xray/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "$github/xray/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/cek-bandwidth "$github/xray/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
wget -q -O /usr/bin/menu "$github/xray/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/cert "$github/xray/cert.sh" && chmod +x /usr/bin/cert
wget -q -O /usr/bin/speedtest "$github/xray/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "$github/xray/update.sh" && chmod +x /usr/bin/update
wget -q -O /usr/bin/renew-config "$github/backup/renew-config.sh" && chmod +x /usr/bin/renew-config
wget -q -O /usr/bin/backup-user "$github/backup/backup-user.sh" && chmod +x /usr/bin/backup-user
sleep 1
clear

echo -e "[ ${green}INFO$NC ] Install Script ..."
sleep 1
sed -i -e 's/\r$//' /bin/menu
sed -i -e 's/\r$//' /bin/cek-bandwidth
sed -i -e 's/\r$//' /bin/cert
sed -i -e 's/\r$//' /bin/update
sed -i -e 's/\r$//' /bin/restart
sed -i -e 's/\r$//' /bin/running
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

sed -i -e 's/\r$//' /bin/menu-ssws
sed -i -e 's/\r$//' /bin/add-ssws
sed -i -e 's/\r$//' /bin/cek-ssws
sed -i -e 's/\r$//' /bin/del-ssws
sed -i -e 's/\r$//' /bin/renew-ssws

clear
sleep 2

yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
yellow "xray/Vmess"
yellow "xray/Vless"
clear
echo -e "[ ${green}INFO$NC ] SETTING SERVER SUKSES"
sleep 2

#mv /root/domain $xray
#if [ -f /root/scdomain ];then
#rm /root/scdomain > /dev/null 2>&1
#fi
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e "[ ${green}INFO$NC ] Re-INSTALL FINISHED !"
read -n 1 -s -r -p "Press any key to Reboot System..."
clear
rm -f ins-xray.sh
clear
reboot

# rm -rvf /usr/bin/renew-config && wget -q -O /usr/bin/renew-config "https://raw.githubusercontent.com/arfprsty810/lite/main/backup/renew-config.sh" && chmod +x /usr/bin/renew-config && /usr/bin/renew-config
