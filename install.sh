#!/bin/bash

PTERO_DIR="/var/www/pterodactyl"
THEME_ZIP="stellar.zip"
ZIP_URL="https://github.com/AldiXD-HACK/Stellar/raw/main/stellar.zip"

echo "===> Stellar Theme Installer"

if [ "$(id -u)" -ne 0 ]; then
  echo "Jalankan skrip ini sebagai root!"
  exit 1
fi

echo "[1/4] Mendownload theme..."
wget -q --show-progress "$ZIP_URL" -O "$THEME_ZIP"

echo "[2/4] Backup file lama..."
cp -r "$PTERO_DIR/resources" "$PTERO_DIR/resources_backup_$(date +%F_%T)"
cp -r "$PTERO_DIR/routes" "$PTERO_DIR/routes_backup_$(date +%F_%T)"
cp "$PTERO_DIR/tailwind.config.js" "$PTERO_DIR/tailwind.config_backup_$(date +%F_%T).js"

echo "[3/4] Ekstrak theme..."
unzip -o "$THEME_ZIP" -d "$PTERO_DIR"

echo "[4/4] Build ulang asset..."
cd "$PTERO_DIR" || exit

# Ini bagian penting: install npm dengan flag biar gak error
npm install --legacy-peer-deps
npm run build

echo "Theme Stellar berhasil diinstall!"
