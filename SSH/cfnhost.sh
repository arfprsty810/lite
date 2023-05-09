#!/bin/bash
# My Telegram : https://t.me/Akbar218
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

error1="${RED}[ERROR]${NC}"
success="${GREEN}[SUCCESS]${NC}"

# Getting
MYIP=$(wget -qO- ipinfo.io/ip);

clear

echo -e "========================="
read -rp "Input Domain/Host : " -e domain
echo -e "========================="
echo -e "${success}\nDomain : ${domain} Added.."
# Delete Files
rm /var/lib/gl33ch3rvpn/cfndomain
# Done
echo "${domain}" >> /var/lib/gl33ch3rvpn/cfndomain
sleep 5
