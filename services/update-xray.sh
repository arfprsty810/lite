## Update Xray
xray --version > now
log=$(cat now)
now_version=( $log | grep 'Xray' | cut -d ' ' -f 2 | sort )
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

if [[ $now_version == $lastest_version ]]; then
echo -e " Now Version : Xray v$now_version "
echo -e " Lastest Version : Xray v$lastest_version "
echo -e " Your Xray is Lastest Version"
else
echo -e " Now Version : Xray v$now_version "
echo -e " Lastest Version : Xray v$lastest_version "
echo -e " Your Xray is old version"
echo -e " Auto Update Xray ..."
sleep 2
clear

mkdir /etc/arfvpn/backup/xray
cp /etc/xray/config.json /etc/arfvpn/backup/xray
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version
clear

cp /etc/arfvpn/backup/xray/config.json /etc/xray
chmod +x /etc/xray/config.json
systemctl daemon-reload
systemctl restart xray
clear

echo -e " XRAY SUCCESSFULLY UPDATE !"
echo ""
echo -e " Your Xray Version is :"
echo -e " Xray $lastest_version"
fi

echo -ne "[ ${yell}WARNING${NC} ] Reboot ur VPS ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi