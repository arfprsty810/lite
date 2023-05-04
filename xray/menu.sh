#!/bin/bash
#########################

# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

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

# / letssgoooo

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export Server_URL="https://github.com/arfprsty810/lite"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther="@arf.prsty_"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address,Domain&ISP
IP=$(cat /etc/xray/IP)
ISP=$(cat /etc/xray/ISP)
DOMAIN=$(cat /etc/xray/domain)

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
 status_nginx="${GREEN}ACTIVE${NC}"
else
 status_nginx="${RED}FAILED${NC}"
fi
clear

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                     ⇱ \e[32;1mInformasi VPS\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e "  ❇️ \e[32;1m Sever Uptime\e[0m     : $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "  ❇️ \e[32;1m Current Time\e[0m     : $( date -d "0 days" +"%d-%m-%Y | %X" ) "
echo -e "  ❇️ \e[32;1m Operating System\e[0m : $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) ) "
echo -e "  ❇️ \e[32;1m Current Domain\e[0m   : $DOMAIN "
echo -e "  ❇️ \e[32;1m Current Isp Name\e[0m : $ISP "
echo -e "  ❇️ \e[32;1m Server IP\e[0m        : $IP "
echo -e "  ❇️ \e[32;1m Time Reboot VPS\e[0m  : 00:00 ( Jam 12 Malam ) "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                     ⇱ \e[32;1mStatus Layanan\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e "       🟢🟡🔴  SERVER STATUS   : ${status_nginx}  🔴🟡🟢"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo""
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                     ⇱ \e[32;1mMenu Tunnel\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo ""

echo -e "    ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}SSH/OVPN     $NC  ${BICyan}[${BIWhite}04${BICyan}]${RED} • ${NC}${CYAN}TROJAN-WS/GO $NC"

echo -e "    ${BICyan}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}XRAY - VMESS $NC  ${BICyan}[${BIWhite}05${BICyan}]${RED} • ${NC}${CYAN}SHADOWSOCK-OBFS$NC"

echo -e "    ${BICyan}[${BIWhite}03${BICyan}]${RED} •${NC} ${CYAN}XRAY - VLESS $NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo""

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                     ⇱ \e[32;1mMenu Service\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e "    ${BICyan}[${BIWhite}06${BICyan}]${RED} •${NC} ${CYAN}SPEEDTEST    $NC  ${BICyan}[${BIWhite}10${BICyan}]${RED} • ${NC}${CYAN}CEK BANDWIDTH $NC"

echo -e "    ${BICyan}[${BIWhite}07${BICyan}]${RED} •${NC} ${CYAN}SCRIPT INFO  $NC  ${BICyan}[${BIWhite}11${BICyan}]${RED} • ${NC}${CYAN}CEK RUNNING SERVICE $NC"

echo -e "    ${BICyan}[${BIWhite}08${BICyan}]${RED} •${NC} ${CYAN}UPDATE SCRIPT$NC  ${BICyan}[${BIWhite}12${BICyan}]${RED} • ${NC}${CYAN}RESTART SERVICE $NC"

echo -e "    ${BICyan}[${BIWhite}09${BICyan}]${RED} •${NC} ${CYAN}REBOOT VPS   $NC  ${BICyan}[${BIWhite}xx${BICyan}]${RED} • ${NC}${CYAN}x TO EXIT $NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e ""

read -p "                 Select Menu : " menu
case $menu in

1)
clear
menu-ssh
;;

2)
clear
menu-vmess
;;

3)
clear
menu-vless
;;

4)
clear
menu-trojan
;;

5)
clear
menu-ss
;;

6)
clear
speedtest
sleep 2
echo "please wait ... "
sleep 3
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;

7)
clear
cat /root/log-install.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;

8)
clear
update
;;

9)
reboot
exit
;;

10)
clear
cek-bandwidth
;;

11)
clear
running
;;

12)
clear
restart
;;

x)
clear
exit
;;

*)
clear
menu
;;

esac