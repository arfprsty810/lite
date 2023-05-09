## Update Xray
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          XRAY UPDATE $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""

echo -e " Checking Now Version ...*
echo ""
sleep 2
xray --version > now
cat now | grep 'Xray' | cut -d ' ' -f 2 | sort > nowv
now_version=$(cat nowv)
sleep 2

echo -e " Checking Lastest Version ...*
echo ""
sleep 2
curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1 > lastv
latest_version=$(cat lastv)

sleep 2
echo ""
echo -e " Result :"
echo -e " Now Version : Xray v$now_version "
echo -e " Lastest Version : Xray v$lastest_version "

if [[ $now_version == $lastest_version ]]; then
echo -e " Your Xray is old version"
echo -e " Auto Update Xray ..."
sleep 2

mkdir /etc/arfvpn/backup/xray
cp /etc/xray/config.json /etc/arfvpn/backup/xray
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version
sleep 2

cp /etc/arfvpn/backup/xray/config.json /etc/xray
chmod +x /etc/xray/config.json
systemctl daemon-reload
systemctl restart xray
sleep 2

echo -e " XRAY SUCCESSFULLY UPDATE !"
echo ""
echo -e " Your Xray Version is :"
echo -e " Xray $lastest_version"
else
echo -e " Your Xray is Lastest Version"
fi

echo -ne "[ ${yell}WARNING${NC} ] Reboot ur VPS ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit
else
exit
fi