#! /bin/bash

apt update -y
apt update -y
apt install libz-dev libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext cmake gcc git -y

git clone https://github.com/SimonCuany/LIN1.git

chmod +x Lin1/debianInstall/testEnvironnement.sh

cd Lin1/debianInstall/

./testEnvironnement.sh

cd ../../

rm -r Lin1

reboot
