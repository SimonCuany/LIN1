#! /bin/bash
# Source Simony Cuany et David Roulet 
# 07.09.2023
apt update -y
apt upgrade -y
apt install libz-dev libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext cmake gcc git -y

git clone https://github.com/SimonCuany/LIN1.git

chmod +x Lin1/debianInstall/testEnvironnement.sh

Lin1/debianInstall/testEnvironnement.sh

rm -r Lin1

reboot
