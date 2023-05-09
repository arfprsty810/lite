#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
#Getting
MYIP=$(wget -qO- ipinfo.io/ip);
error1="${RED}[ERROR]${NC}"
success="${GREEN}[SUCCESS]${NC}"
clear
echo -e "========================="
read -rp "Input Domain/Host : " -e domain
echo -e "========================="
echo -e "${success} Please wait..."
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
echo $domain >> /etc/xray/domain
echo $domain >> /root/domain
echo "IP=$domain" >> /var/lib/gl33ch3rvpn/ipvps.conf
echo "none" >> /var/lib/gl33ch3rvpn/cfndomain
sleep 5
