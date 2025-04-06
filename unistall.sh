#!/bin/bash

PTERO_DIR="/var/www/pterodactyl"

echo "===> Uninstall Theme Stellar, tak balekno file asli..."

# Cek nek dadi root
if [ "$(id -u)" -ne 0 ]; then
  echo "Kudu nglakokne script iki nganggo root!"
  exit 1
fi

# Golek backup paling akhir
BACKUP_RESOURCES=$(ls -td $PTERO_DIR/resources_backup_* 2>/dev/null | head -n 1)
BACKUP_ROUTES=$(ls -td $PTERO_DIR/routes_backup_* 2>/dev/null | head -n 1)
BACKUP_TAILWIND=$(ls -t $PTERO_DIR/tailwind.config_backup_*.js 2>/dev/null | head -n 1)

if [ -z "$BACKUP_RESOURCES" ] || [ -z "$BACKUP_ROUTES" ] || [ -z "$BACKUP_TAILWIND" ]; then
  echo "Ora ketemu file backup. Ra iso di-uninstall!"
  exit 1
fi

# Balekno file backup
echo "[1/3] Tak balekno folder resources..."
rm -rf "$PTERO_DIR/resources"
cp -r "$BACKUP_RESOURCES" "$PTERO_DIR/resources"

echo "[2/3] Tak balekno folder routes..."
rm -rf "$PTERO_DIR/routes"
cp -r "$BACKUP_ROUTES" "$PTERO_DIR/routes"

echo "[3/3] Tak balekno tailwind.config.js..."
cp "$BACKUP_TAILWIND" "$PTERO_DIR/tailwind.config.js"

# Rebuild ulang
echo "[4/4] Tak rebuild asset..."
cd "$PTERO_DIR" || exit
npm install --legacy-peer-deps
npm run build

echo "Theme wis dicopot. Pterodactyl wis dibalekno kaya semula."
