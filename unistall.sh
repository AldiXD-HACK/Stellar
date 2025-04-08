#!/bin/bash

echo -e "                                                       "
echo -e "\033[34m[+] =============================================== [+]\033[0m"
echo -e "\033[34m[+]                 HADUH GAGAL COK               [+]\033[0m"
echo -e "\033[34m[+] =============================================== [+]\033[0m"
echo -e "                                                       "

# Hapus direktori tema dari Pterodactyl
sudo rm -rf /var/www/pterodactyl

# Kembalikan ke instalasi default (jika backup tersedia)
if [ -e /var/www/pterodactyl_backup ]; then
  sudo mv /var/www/pterodactyl_backup /var/www/pterodactyl
  echo -e "\033[32m[+] Backup ditemukan dan dikembalikan ke instalasi default.\033[0m"
else
  echo -e "\033[31m[-] Backup tidak ditemukan. Pastikan untuk menginstal ulang Pterodactyl jika diperlukan.\033[0m"
fi

# Hapus node_modules dan dependencies
sudo apt remove -y nodejs yarn
sudo apt autoremove -y

# Bersihkan cache
sudo php /var/www/pterodactyl/artisan view:clear

# Informasi selesai
echo -e "                                                       "
echo -e "\033[32m[+] =============================================== [+]\033[0m"
echo -e "\033[32m[+]              TAPI BOONG WKWKWKWK              [+]\033[0m"
echo -e "\033[32m[+] =============================================== [+]\033[0m"
echo -e ""

sleep 2
clear
exit 0
