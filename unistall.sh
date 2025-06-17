#!/bin/bash

# Pterodactyl Panel Theme Uninstaller
# Author: AldiXDCodeX
# Description: Script untuk menghapus custom theme pada Pterodactyl Panel

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Variables
THEME_NAME="modern-theme"
PANEL_DIR="/var/www/pterodactyl"
THEME_DIR="$PANEL_DIR/public/themes/$THEME_NAME"

echo -e "${YELLOW}=== Pterodactyl Panel Theme Uninstaller ===${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Error: Script harus dijalankan sebagai root${NC}"
  exit 1
fi

# Check if theme directory exists
if [ ! -d "$THEME_DIR" ]; then
  echo -e "${RED}Error: Direktori theme tidak ditemukan di $THEME_DIR${NC}"
  echo -e "Theme mungkin sudah diuninstall atau nama theme berbeda"
  exit 1
fi

# Confirmation
read -p "Apakah Anda yakin ingin menghapus theme $THEME_NAME? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Uninstall dibatalkan${NC}"
    exit 0
fi

# Remove theme directory
echo -e "${YELLOW}Menghapus direktori theme...${NC}"
rm -rf "$THEME_DIR"

if [ -d "$THEME_DIR" ]; then
  echo -e "${RED}Gagal menghapus direktori theme!${NC}"
  exit 1
fi

# Clear cache
echo -e "${YELLOW}Membersihkan cache...${NC}"
sudo -u www-data php artisan view:clear
sudo -u www-data php artisan cache:clear

echo -e "${GREEN}Uninstall berhasil!${NC}"
echo -e "Theme $THEME_NAME telah dihapus dari sistem"
