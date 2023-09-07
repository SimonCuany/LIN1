#!/bin/bash
# Auteurs : Simony Cuany et David Roulet
# Date : 07.09.2023

# Mise à jour et installation de packages
apt update -y
apt upgrade -y
apt install libz-dev libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext cmake gcc git -y

# Clonage du référentiel Git
git clone https://github.com/SimonCuany/LIN1.git

# Rendre le script exécutable
chmod +x LIN1/debianInstall/testEnvironnement.sh

# Exécuter le script
./LIN1/debianInstall/testEnvironnement.sh

# Nettoyer après l'exécution
rm -r LIN1

# Redémarrer le système
reboot
