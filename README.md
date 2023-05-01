# Autoscript Xray VPS

Ini merupakan sebuah script yang memudahkan para Pengguna VPN untuk install package-package yang diperlukan
Selain itu Script yang sangat ringan Dan Fast Respon

### Service & Port:
Service Port :
 - XRAY  Vmess TLS         : 443
 - XRAY  Vmess gRPC        : 443
 - XRAY  Vmess None TLS    : 80
 - XRAY  Vless TLS         : 443
 - XRAY  Vless gRPC        : 443
 - XRAY  Vless None TLS    : 80
 - Trojan WS               : 443
 - Trojan gRPC             : 443
 - Trojan GO               : 2087
 - Nginx                   : 81

### Other Services:
 - Speedtest CLI
 - Reinstall Cert
```
rm -rvf /usr/bin/renew-config && wget -q -O /usr/bin/renew-config "https://raw.githubusercontent.com/arfprsty810/lite/main/backup/renew-config.sh" && chmod +x /usr/bin/renew-config && /usr/bin/renew-config
```

### Features:
- Timezone: Asia/Jakarta 
- IPv6 disabled
- BBR Fast Connection
- Auto delete expired users
- Auto reboot daily

## Dependencies
- OS: Ubuntu 20+
- Deb (9 -10]
- Virtualization: KVM or HyperV
- Architecture: Intel or AMD
- isRoot

## Installation

```
rm -rvf setup.sh && apt update && apt upgrade && wget -q https://raw.githubusercontent.com/arfprsty810/lite/main/xray/menu.sh && chmod +x setup.sh && ./setup.sh
```
**Link Copy script:**

BBR Booster untuk Trojan, V2Ray dan XRay
```
wget -q -O /usr/bin/bbr https://raw.githubusercontent.com/arfprsty810/lite/main/bbr/bbr.sh chmod +x /usr/bin/bbr && sed -i -e 's/\r$//' /usr/bin/bbr && screen -S bbr /bin/bbr
```
## NOT FOR SALE !