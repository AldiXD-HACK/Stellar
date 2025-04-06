#!/bin/bash

# Pastikan skrip dijalankan sebagai root
if [ "$(id -u)" -ne 0 ]; then
  echo "Harap jalankan skrip ini sebagai root atau menggunakan sudo."
  exit 1
fi

# Update dan instal dependensi yang diperlukan
apt update && apt install -y git curl wget zip unzip nodejs npm

# Instal Yarn jika belum terinstal
if ! command -v yarn &> /dev/null; then
  npm install -g yarn
fi

# Tentukan direktori instalasi Pterodactyl
PTERO_DIR="/var/www/pterodactyl"

# Periksa apakah direktori Pterodactyl ada
if [ ! -d "$PTERO_DIR" ]; then
  echo "Direktori Pterodactyl tidak ditemukan di $PTERO_DIR. Harap periksa path instalasi Anda."
  exit 1
fi

# Pindah ke direktori Pterodactyl
cd "$PTERO_DIR"

# Backup panel saat ini
cp -r "$PTERO_DIR" "${PTERO_DIR}_backup_$(date +%F_%T)"

# Unduh dan ekstrak Stellar Theme versi gratis
curl -Lo stellar-free.zip https://github.com/GriffinStellar/Stellar/releases/latest/download/Stellar-Free.zip
unzip -o stellar-free.zip
rm stellar-free.zip

# Instal dependensi dan build ulang panel
npm install
npm run build:production

echo "Instalasi tema Stellar selesai. Silakan periksa panel Anda."
