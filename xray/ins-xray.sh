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

source /etc/os-release
arfvpn="/etc/arfvpn"
xray="/etc/xray"
logxray="/var/log/xray"
github="https://raw.githubusercontent.com/arfprsty810/lite/main"
OS=$ID
ver=$VERSION_ID
# set random uuid
uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat $arfvpn/domain)
IP=$(cat $arfvpn/IP)
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING XRAY $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 2
# install xray
echo -e "[ ${green}INFO$NC ] INSTALLING XRAY VMESS - VLESS"
sleep 1
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir
clear

# Make Folder XRay
echo -e "[ ${green}INFO$NC ] MEMBUAT FOLDER XRAY"
mkdir -p $logxray
chown www-data.www-data $logxray
chmod +x $logxray
touch $logxray/access.log
touch $logxray/error.log
touch $logxray/access2.log
touch $logxray/error2.log

# / / Install Xray Core << Every >> Lastest Version
wget $github/services/update-xray.sh && chmod +x update-xray.sh && ./update-xray.sh
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
clear

# xray config
echo -e "[ ${green}INFO$NC ] MEMBUAT CONFIG XRAY"
sleep 1
cat > $xray/config.json << END
{
  "log" : {
    "access": "$logxray/access.log",
    "error": "$logxray/error.log",
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
sleep 1

clear

sed -i '$ ilocation /' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ try_files $uri $uri/ /index.html;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:700'';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ include nginxconfig.io/proxy.conf;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /vless' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$vless"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ include nginxconfig.io/proxy.conf;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /vmess' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$vmess"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ include nginxconfig.io/proxy.conf;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /worryfree' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$worryfree"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ include nginxconfig.io/proxy.conf;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /kuota-habis' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$kuotahabis"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ include nginxconfig.io/proxy.conf;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation = /trojan-ws' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"$trojanws"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ include nginxconfig.io/proxy.conf;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"$vlessgrpc"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ include nginxconfig.io/proxy.conf;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"$vmessgrpc"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ include nginxconfig.io/proxy.conf;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf

sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/sites-available/$domain.conf
sed -i '$ i{' /etc/nginx/sites-available/$domain.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/sites-available/$domain.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"$trojangrpc"';' /etc/nginx/sites-available/$domain.conf
sed -i '$ include nginxconfig.io/proxy.conf;' /etc/nginx/sites-available/$domain.conf
sed -i '$ i}' /etc/nginx/sites-available/$domain.conf
clear
sleep 2

echo -e "[ ${green}INFO$NC ] DOWNLOAD SCRIPT ..."
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
sed -i -e 's/\r$//' /usr/bin/xp

sed -i -e 's/\r$//' /usr/bin/menu-vmess
sed -i -e 's/\r$//' /usr/bin/add-ws
sed -i -e 's/\r$//' /usr/bin/cek-ws
sed -i -e 's/\r$//' /usr/bin/del-vmess
sed -i -e 's/\r$//' /usr/bin/renew-ws

sed -i -e 's/\r$//' /usr/bin/menu-vless
sed -i -e 's/\r$//' /usr/bin/add-vless
sed -i -e 's/\r$//' /usr/bin/cek-vless
sed -i -e 's/\r$//' /usr/bin/del-vless
sed -i -e 's/\r$//' /usr/bin/renew-ws

sed -i -e 's/\r$//' /usr/bin/menu-trojan
sed -i -e 's/\r$//' /usr/bin/add-tr
sed -i -e 's/\r$//' /usr/bin/cek-tr
sed -i -e 's/\r$//' /usr/bin/del-tr
sed -i -e 's/\r$//' /usr/bin/renew-tr
clear

sleep 1
echo -e "[ ${green}INFO$NC ] Restart Service/s ..."
systemctl daemon-reload >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Daemon-Reload"
systemctl restart nginx >/dev/null 2>&1
systemctl enable nginx >/dev/null 2>&1
systemctl start nginx >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Nginx "
systemctl restart xray >/dev/null 2>&1
systemctl enable xray >/dev/null 2>&1
systemctl start xray >/dev/null 2>&1
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting Xray - VMESS / VLESS / TROJAN"
echo ""

echo -e "[ ${green}INFO$NC ] SETTING XRAY VMESS & VLESS  SUKSES !!!"
sleep 2
clear