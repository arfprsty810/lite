#!/bin/bash
apt install git -y
clear
# https://github.com/arfprsty810/backup.git
cd
mkdir -p /root/github
echo " ex. : https://github.com/your_github/backup.git
read -rp " Input your github username : " -e username
#echo "$username" > /root/github/username
read -rp " Input your github project : " -e project
#echo "$username" > /root/github/project
echo "https://github.com/$username/$project.git" > /root/github.git
github=$(cat /root/github.git)
clear

cd /root
rm -rvf /root/backup
mkdir -p /root/backup
#cp /etc/arfvpn/* /root/backup/
cp /root/github.git /root/backup/

cd /root/backup
#git remote add origin $github
#git branch -M main
#git push -u origin main

echo "# backup" > README.md
git init
git remote add origin $github
git commit -m "backup"
#git push -u origin master
git push -u origin main
read -n 1 -s -r -p "Press any key to back on menu"