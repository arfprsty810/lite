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

echo ""
echo ""
echo -e "[ ${green}INFO$NC ] INSTALLER AUTO SCRIPT "
echo " - XRAY => VMESS - VLESS "
echo " - TROJAN => TROJAN WS - TROJAN-GO "
echo " - SHADOWSOCKS => SHADOWSOCKS-LIBEV "
sleep 3
echo -e ""
clear

echo -e "[ ${green}INFO$NC ] INSTALLING KONFIGURASI"
sleep 1

source /etc/os-release
xray="/etc/xray"
trgo="/etc/trojan-go"
logtrgo="/var/log/trojan-go"
ipvps="/var/lib/arf"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
OS=$ID
ver=$VERSION_ID
# set random pwd
openssl rand -base64 16 > $xray/passwd
pwd=$(cat $xray/passwd)
# set random uuid
uuid=$(cat /proc/sys/kernel/random/uuid)

date
echo ""
domain=$(cat $xray/domain)
sleep 1
clear

echo -e "[ ${green}INFO$NC ] INSTALLING REQRUITMENT"
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
apt-get --reinstall --fix-missing install -y sudo dpkg psmisc jq ruby wondershaper python2 tmux nmap bzip2 gzip coreutils iftop htop unzip vim nano gcc g++ make perl m4 dos2unix libreadline-dev zlib1g-dev git 
clear
apt-get --reinstall --fix-missing install -y screen rsyslog sed bc dirmngr libxml-parser-perl neofetch screenfetch lsof easy-rsa fail2ban vnstat libsqlite3-dev #dropbear openvpn squid
gem install lolcat
clear
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake -y
clear

apt-get install software-properties-common -y
clear
if [[ $OS == 'ubuntu' ]]; then
apt install shadowsocks-libev -y
apt install simple-obfs -y
clear
elif [[ $OS == 'debian' ]]; then
if [[ "$ver" = "9" ]]; then
echo "deb http://deb.debian.org/debian stretch-backports main" | tee /etc/apt/sources.list.d/stretch-backports.list
apt update
apt -t stretch-backports install shadowsocks-libev -y
apt -t stretch-backports install simple-obfs -y
clear
elif [[ "$ver" = "10" ]]; then
echo "deb http://deb.debian.org/debian buster-backports main" | tee /etc/apt/sources.list.d/buster-backports.list
apt update
apt -t buster-backports install shadowsocks-libev -y
apt -t buster-backports install simple-obfs -y
clear
fi
fi

echo -e "[ ${green}INFO$NC ] DISABLE IPV6"
sleep 1
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6 >/dev/null 2>&1
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local >/dev/null 2>&1
apt update -y
apt upgrade -y
apt dist-upgrade -y
clear
echo -e "[ ${green}INFO${NC} ] CHECKING... "
apt install iptables iptables-persistent -y
sleep 1
clear
echo -e "[ ${green}INFO$NC ] SETTING NTPDATE"
apt install ntpdate -y
ntpdate -u pool.ntp.org
ntpdate pool.ntp.org 
timedatectl set-ntp true
timedatectl set-timezone Asia/Jakarta
sleep 1
clear
echo -e "[ ${green}INFO$NC ] ENABLE CHRONYD"
apt -y install chrony
systemctl enable chronyd
systemctl restart chronyd
sleep 1
clear
echo -e "[ ${green}INFO$NC ] ENABLE CHRONY"
systemctl enable chrony
systemctl restart chrony
clear
sleep 1
clear
echo -e "[ ${green}INFO$NC ] SETTING CHRONY TRACKING"
chronyc sourcestats -v
chronyc tracking -v
clear
echo -e "[ ${green}INFO$NC ] SETTING SERVICE"
apt update -y
apt upgrade -y
clear
echo " "

# install xray
echo -e "[ ${green}INFO$NC ] INSTALLING XRAY VMESS - VLESS"
sleep 1
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir
clear

# Make Folder XRay
echo -e "[ ${green}INFO$NC ] MEMBUAT FOLDER XRAY"
mkdir -p /var/log/xray
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
touch /var/log/xray/access2.log
touch /var/log/xray/error2.log
# / / Ambil Xray Core Version Terbaru
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 1.5.6
clear

echo -e "[ ${green}INFO$NC ] INSTALLING NGINX SERVER"
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

echo -e "[ ${green}INFO$NC ] INSATLLING CERT SSL"
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

echo -e "[ ${green}INFO$NC ] MEMBUAT PORT"
sleep 1
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
echo -e "[ ${green}INFO$NC ] MEMBUAT CONFIG XRAY"
sleep 1
cat > $xray/config.json << END
{
  "log" : {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
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
clear

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
clear

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
echo -e "[ ${green}INFO$NC ] MEMBUAT CONFIG NGINX"
sleep 1
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
clear

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
clear

echo -e "$yell[SERVICE]$NC RESTART ALL SERVICE"
systemctl daemon-reload
sleep 1
clear

echo -e "[ ${green}ok${NC} ] ENABLE & RESTART XRAY "
systemctl enable xray
systemctl restart xray
systemctl restart nginx
systemctl enable runn
systemctl restart runn
clear
sleep 1

#vmess
echo -e "[ ${green}INFO$NC ] DOWNLOAD SCRIPT"
sleep 1
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
wget -q -O /usr/bin/xp "$github/xray/xp.sh" && chmod +x /usr/bin/xp
sleep 1
clear

echo -e "[ ${green}INFO$NC ] INSTALL SCRIPT ..."
sleep 1
sed -i -e 's/\r$//' /bin/xp

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

echo -e "[ ${green}INFO$NC ] SETTING XRAY VMESS & VLESS  SUKSES !!!"
sleep 2
clear
#mv /root/domain $xray
#if [ -f /root/scdomain ];then
#rm /root/scdomain > /dev/null 2>&1
#fi

# Install Trojan Go
echo -e "[ ${green}INFO$NC ] INSTALLING TROJAN-GO"
sleep 1
latest_version="$(curl -s "https://api.github.com/repos/p4gefau1t/trojan-go/releases" | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
trojango_link="https://github.com/p4gefau1t/trojan-go/releases/download/v${latest_version}/trojan-go-linux-amd64.zip"
mkdir -p "/usr/bin/trojan-go"
mkdir -p "$trgo"
cd `mktemp -d`
curl -sL "${trojango_link}" -o trojan-go.zip
unzip -q trojan-go.zip && rm -rf trojan-go.zip
mv trojan-go /usr/local/bin/trojan-go
chmod +x /usr/local/bin/trojan-go
mkdir $logtrgo
touch $trgo/akun.conf
touch $logtrgo/trojan-go.log

# Buat Config Trojan Go
echo -e "[ ${green}INFO$NC ] MEMBUAT CONFIG TROJAN-GO"
sleep 1
cat > $trgo/config.json << END
{
  "run_type": "server",
  "local_addr": "0.0.0.0",
  "local_port": 2087,
  "remote_addr": "127.0.0.1",
  "remote_port": 89,
  "log_level": 1,
  "log_file": "$logtrgo/trojan-go.log",
  "password": [
      "$uuid"
  ],
  "disable_http_check": true,
  "udp_timeout": 60,
  "ssl": {
    "verify": false,
    "verify_hostname": false,
    "cert": "$xray/xray.crt",
    "key": "$xray/xray.key",
    "key_password": "",
    "cipher": "",
    "curves": "",
    "prefer_server_cipher": false,
    "sni": "$domain",
    "alpn": [
      "http/1.1"
    ],
    "session_ticket": true,
    "reuse_session": true,
    "plain_http_response": "",
    "fallback_addr": "127.0.0.1",
    "fallback_port": 0,
    "fingerprint": "firefox"
  },
  "tcp": {
    "no_delay": true,
    "keep_alive": true,
    "prefer_ipv4": true
  },
  "mux": {
    "enabled": false,
    "concurrency": 8,
    "idle_timeout": 60
  },
  "websocket": {
    "enabled": true,
    "path": "/trojango",
    "host": "$domain"
  },
    "api": {
    "enabled": false,
    "api_addr": "",
    "api_port": 0,
    "ssl": {
      "enabled": false,
      "key": "",
      "cert": "",
      "verify_client": false,
      "client_cert": []
    }
  }
}
END
clear

# Installing Trojan Go Service
cat > /etc/systemd/system/trojan-go.service << END
[Unit]
Description=Trojan-Go Service
Documentation=https://t.me/arfprsty
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/trojan-go -config $trgo/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END
clear

# Trojan Go Uuid
cat > $trgo/uuid << END
$uuid
END
clear
echo -e "[ ${green}INFO$NC ] SETTING TROJAN-GO SUKSES !!!"
sleep 1
clear

#Server konfigurasi
echo -e "[ ${green}INFO$NC ] MENGINSTALL SAHDOWSOCKS-LIBEV"
sleep 2
clear

echo -e "[ ${green}INFO$NC ] MEMBUAT CONFIG SHADOWSOCKS"
sleep 1
cat > /etc/shadowsocks-libev/config.json <<END
{   
    "server":"0.0.0.0",
    "server_port":8488,
    "password":"$pwd",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
}
END
clear

clear

echo -e "[ ${green}INFO$NC ] MEMBUAT CLIENT CONFIG"
sleep 1
cat > /etc/shadowsocks-libev.json <<END
{
    "server":"127.0.0.1",
    "server_port":8388,
    "local_port":1080,
    "password":"$pwd",
    "timeout":60,
    "method":"chacha20-ietf-poly1305",
    "mode":"tcp_and_udp",
    "fast_open":true,
    "plugin":"/usr/bin/obfs-local",
    "plugin_opts":"obfs=tls;failover=127.0.0.1:1443;fast-open"
}
END
chmod +x /etc/shadowsocks-libev.json
clear

echo -e "">>"/etc/shadowsocks-libev/akun.conf"
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2443:3543 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2443:3543 -j ACCEPT
iptables-save > /etc/iptables.up.rules
ip6tables-save > /etc/ip6tables.up.rules
clear
echo -e "[ ${green}INFO$NC ] SETTING SHADOWSOCKS SUKSES !!!"
sleep 1

# restart
echo -e "[ ${green}INFO$NC ] MEMULAI ULANG KONFIGURASI"
sleep 1
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
systemctl enable shadowsocks-libev.service
systemctl start shadowsocks-libev.service
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2086 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2087 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
clear

echo -e "[ ${green}INFO$NC ] INSTALL FINISHED !"
sleep 2
rm -f ins-xray.sh
clear