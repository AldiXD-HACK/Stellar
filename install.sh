#!/bin/bash

# Direktori instalasi Pterodactyl
PTERO_DIR="/var/www/pterodactyl"

# Nama file tema
THEME_ZIP="stellar.zip"

# Periksa apakah skrip dijalankan sebagai root
if [ "$(id -u)" -ne 0 ]; then
  echo "Harap jalankan skrip ini sebagai root atau gunakan sudo."
  exit 1
fi

# Periksa apakah file tema ada
if [ ! -f "$THEME_ZIP" ]; then
  echo "File $THEME_ZIP tidak ditemukan!"
  exit 1
fi

# Backup file dan folder yang akan ditimpa
echo "Membuat backup file yang ada..."
cp -r "$PTERO_DIR/resources" "$PTERO_DIR/resources_backup_$(date +%F_%T)"
cp -r "$PTERO_DIR/routes" "$PTERO_DIR/routes_backup_$(date +%F_%T)"
cp "$PTERO_DIR/tailwind.config.js" "$PTERO_DIR/tailwind.config.js_backup_$(date +%F_%T)"

# Ekstrak tema ke direktori Pterodactyl
echo "Menyalin file tema ke direktori Pterodactyl..."
unzip -o "$THEME_ZIP" -d "$PTERO_DIR"

# Instal dependensi dan build ulang frontend
echo "Menginstal dependensi dan membangun ulang frontend..."
cd "$PTERO_DIR" || exit
npm install
npm run build

echo "Instalasi tema Stellar selesai. Silakan refresh panel Pterodactyl Anda."
