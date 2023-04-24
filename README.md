# Autoscript Xray VPS

Ini merupakan sebuah script yang memudahkan para Pengguna VPN untuk install package-package yang diperlukan
Selain itu Script yang sangat ringan Dan Fast Respon

### Service & Port:
  Service Port
 - XRAY  Vmess TLS + gRPC  : 443
 - XRAY  Vless TLS + gRPC  : 443
 - Trojan WS + gRPC        : 443
 - XRAY  Vmess None TLS    : 80
 - XRAY  Vless None TLS    : 80
 - Nginx                   : 81

### Other Services:
Speedtest CLI

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
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && rm -rf setup.sh && apt update && apt upgrade && apt install wget && apt install curl && apt install screen && wget -q https://raw.githubusercontent.com/arfprsty810/lite/main/xray/menu.sh && chmod +x setup.sh && ./setup.sh
```
**Link Copy script:**

BBR Booster untuk Trojan, V2Ray dan XRay
```
wget https://raw.githubusercontent.com/arfprsty810/lite/main/file/bbr.sh chmod +x bbr.sh && sed -i -e 's/\r$//' bbr.sh && screen -S bbr ./bbr.sh
```
## NOT FOR SALE !