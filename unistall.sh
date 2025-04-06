#!/bin/bash

PTERO_DIR="/var/www/pterodactyl"

echo "===> Copot theme Stellar..."

if [ "$(id -u)" -ne 0 ]; then
  echo "Run nganggo root lah rek!"
  exit 1
fi

# Golek backup paling anyar
LAST_RESOURCES_BACKUP=$(ls -td "$PTERO_DIR"/resources_backup_* 2>/dev/null | head -1)
LAST_ROUTES_BACKUP=$(ls -td "$PTERO_DIR"/routes_backup_* 2>/dev/null | head -1)
LAST_TAILWIND_BACKUP=$(ls -t "$PTERO_DIR"/tailwind.config_backup_*.js 2>/dev/null | head -1)

echo "[1/3] Mulihke resources..."
if [ -d "$LAST_RESOURCES_BACKUP" ]; then
  rm -rf "$PTERO_DIR/resources"
  cp -r "$LAST_RESOURCES_BACKUP" "$PTERO_DIR/resources"
else
  echo "  => Gak nemu backup resources."
fi

echo "[2/3] Mulihke routes..."
if [ -d "$LAST_ROUTES_BACKUP" ]; then
  rm -rf "$PTERO_DIR/routes"
  cp -r "$LAST_ROUTES_BACKUP" "$PTERO_DIR/routes"
else
  echo "  => Gak nemu backup routes."
fi

echo "[3/3] Mulihke tailwind.config.js..."
if [ -f "$LAST_TAILWIND_BACKUP" ]; then
  cp "$LAST_TAILWIND_BACKUP" "$PTERO_DIR/tailwind.config.js"
else
  echo "  => Gak nemu backup tailwind.config.js."
fi

echo "[+] Build ulang asset ben normal maneh..."
cd "$PTERO_DIR" || exit
npm install --legacy-peer-deps
npm run build

echo "===> Theme Stellar wes dicopot. Panel mulih normal."
