#!/bin/bash

THEME_URL="https://raw.githubusercontent.com/AldiXD-HACK/Stellar/main/stellar.zip"

# Cek jika folder /root/pterodactyl ada
if [ -e /root/pterodactyl ]; then
  sudo rm -rf /root/pterodactyl
fi

# Unduh tema
wget -q "$THEME_URL"

# Ekstrak tema
sudo unzip -o "$(basename "$THEME_URL")"

# Proses instalasi tema
echo -e "                                                       "
echo -e "\033[34m[+] =============================================== [+]\033[0m"
echo -e "\033[34m[+]                 INSTA THEME By AldiXD                [+]\033[0m"
echo -e "\033[34m[+] =============================================== [+]\033[0m"
echo -e "                                                       "

sudo cp -rfT /root/pterodactyl /var/www/pterodactyl
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm i -g yarn
cd /var/www/pterodactyl
yarn add react-feather
php artisan migrate
yarn build:production
php artisan view:clear
sudo rm /root/stellar.zip
sudo rm -rf /root/pterodactyl

echo -e "                                                       "
echo -e "\033[32m[+] =============================================== [+]\033[0m"
echo -e "\033[32m[+]             SUCCES COOK ASU               [+]\033[0m"
echo -e "\033[32m[+] =============================================== [+]\033[0m"
echo -e ""

sleep 2
clear
exit 0
