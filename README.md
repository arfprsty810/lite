# Autoscript VPN

Ini merupakan sebuah script yang memudahkan para pengguna VPS untuk menginstall package-package yang diperlukan untuk membangun sebuah VPN Server.
Selain itu Script ini sangat ringan Dan Fast Respon.

## Tunnel Service & Port:
- XRAY Vmess TLS          : 443
- XRAY Vmess None TLS     : 80
- XRAY Vless TLS          : 443
- XRAY Vless None TLS     : 80
- Trojan TLS              : 443
- Trojan GRPC             : 443
- Trojan GO               : 2087
- Shadowsocks-Libev TLS   : 2443 - 3442
- Shadowsocks-Libev NTLS  : 3443 - 4442
 
## Features:
- Timezone: Asia/Jakarta 
- IPv6 disabled
- BBR Fast Connection
- Auto delete expired users
- Auto reboot daily

## Other Services:
 - Re-New Cert
 - Update Xray
 - Update Script
 - Speedtest Cli
 - Cek BandWidth
 - Cek Running Service/s
 - Restart Service/s
 - Install Webmin

## Dependencies
- OS: Ubuntu 18+
- Deb (9 -10]
- Virtualization: KVM or HyperV
- Architecture: Intel or AMD
- isRoot

## Installation
Pertama, update / upgrade semua package dan biarkan VPS reboot secara otomatis, pastekan kode berikut :
```
sudo apt update && apt upgrade -y && reboot
```
Buka/Login kembali ke VPS, dan pastekan kode berikut :
```
cd && wget -P /root -N --no-check-certificate "https://raw.githubusercontent.com/arfprsty810/lite/main/setup.sh" && chmod +x /root/setup.sh && ./setup.sh
```
Pada saat installasi, isi beberapa data yang di butuhkan seperti nama domain/subdomain dan pilihan unduhan untuk memasang sertifikat.
Setelah itu, tunggu hingga installasi selesai.

## NOT FOR SALE !
 - Base Script by @bhoikfost_yahya
 - Re-pack & Re-mod by @arfprsty810
 
Gunakan Sc free ni sebaiknya, **JANGAN DI JUAL**.
Jika menemukan bug, silahkan hubungi saya di Telegram [@arfprsty](https://t.me/arfprsty)