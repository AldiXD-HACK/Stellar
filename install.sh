#!/bin/bash

# Pterodactyl Panel Theme Installer
# Author: Your Name
# Description: Script untuk menginstall custom theme pada Pterodactyl Panel

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Variables
THEME_NAME="modern-theme"
PANEL_DIR="/var/www/pterodactyl"
THEME_DIR="$PANEL_DIR/public/themes/$THEME_NAME"
BACKUP_DIR="/tmp/pterodactyl_backup"

echo -e "${YELLOW}=== Pterodactyl Panel Theme Installer ===${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Error: Script harus dijalankan sebagai root${NC}"
  exit 1
fi

# Check if panel directory exists
if [ ! -d "$PANEL_DIR" ]; then
  echo -e "${RED}Error: Direktori Pterodactyl tidak ditemukan di $PANEL_DIR${NC}"
  echo -e "Silakan sesuaikan path instalasi Pterodactyl Anda"
  exit 1
fi

# Create backup directory
echo -e "${YELLOW}Membuat backup konfigurasi...${NC}"
mkdir -p "$BACKUP_DIR"
cp "$PANEL_DIR/resources/scripts/layouts/main.css" "$BACKUP_DIR/main.css.backup"
cp "$PANEL_DIR/resources/scripts/main.js" "$BACKUP_DIR/main.js.backup"
echo -e "${GREEN}Backup berhasil disimpan di $BACKUP_DIR${NC}"

# Create theme directory
echo -e "${YELLOW}Membuat direktori theme...${NC}"
mkdir -p "$THEME_DIR"
if [ ! -d "$THEME_DIR" ]; then
  echo -e "${RED}Gagal membuat direktori theme!${NC}"
  exit 1
fi

# Create theme files
echo -e "${YELLOW}Membuat file theme...${NC}"

# theme.css
cat > "$THEME_DIR/theme.css" << 'EOL'
/* Modern Pterodactyl Panel Theme */
:root {
    --primary: #6777ef;
    --primary-light: #8a9af1;
    --secondary: #7e74da;
    --success: #47c363;
    --info: #3abaf4;
    --warning: #ffa426;
    --danger: #fc544b;
    --dark: #191d21;
    --light: #e3eaef;
    --gray: #6c757d;
    --bg-color: #f5f7fb;
    --sidebar-bg: #2a3042;
    --sidebar-hover: #3a4055;
    --card-bg: #ffffff;
    --text-color: #4d5259;
    --text-light: #9aa1b9;
}

/* Base Styles */
body {
    font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background-color: var(--bg-color);
    color: var(--text-color);
    line-height: 1.6;
}

/* Sidebar */
.sidebar {
    background-color: var(--sidebar-bg);
    box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
}

.sidebar-brand {
    padding: 1.5rem 1rem;
    color: white;
    font-weight: 700;
    font-size: 1.2rem;
    text-align: center;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sidebar-divider {
    border-color: rgba(255, 255, 255, 0.1);
}

.nav-sidebar .nav-item .nav-link {
    color: var(--text-light);
    padding: 0.75rem 1rem;
    margin: 0.25rem 0.75rem;
    border-radius: 4px;
    transition: all 0.3s ease;
}

.nav-sidebar .nav-item .nav-link:hover {
    color: white;
    background-color: var(--sidebar-hover);
}

.nav-sidebar .nav-item .nav-link.active {
    color: white;
    background-color: var(--primary);
}

.nav-sidebar .nav-item .nav-link i {
    margin-right: 0.5rem;
    width: 20px;
    text-align: center;
}

/* Top Navigation */
.navbar {
    background-color: white;
    box-shadow: 0 1px 15px rgba(0, 0, 0, 0.04);
}

.navbar .navbar-nav .nav-link {
    color: var(--text-color);
}

.navbar .navbar-nav .nav-link:hover {
    color: var(--primary);
}

/* Cards */
.card {
    border: none;
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
    background-color: var(--card-bg);
    margin-bottom: 1.5rem;
}

.card-header {
    background-color: transparent;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    padding: 1.25rem 1.5rem;
}

.card-body {
    padding: 1.5rem;
}

/* Buttons */
.btn {
    border-radius: 4px;
    padding: 0.5rem 1.25rem;
    font-weight: 600;
    transition: all 0.2s;
}

.btn-primary {
    background-color: var(--primary);
    border-color: var(--primary);
}

.btn-primary:hover {
    background-color: var(--primary-light);
    border-color: var(--primary-light);
}

/* Tables */
.table {
    color: var(--text-color);
}

.table thead th {
    border-bottom-width: 1px;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.75rem;
    letter-spacing: 0.5px;
    border-color: rgba(0, 0, 0, 0.05);
}

/* Forms */
.form-control {
    border: 1px solid #e4e6fc;
    border-radius: 4px;
    padding: 0.5rem 0.75rem;
    transition: all 0.3s;
}

.form-control:focus {
    border-color: var(--primary-light);
    box-shadow: 0 0 0 0.2rem rgba(103, 119, 239, 0.25);
}

/* Server List */
.server-list-item {
    transition: transform 0.2s;
}

.server-list-item:hover {
    transform: translateY(-2px);
}

/* Responsive Design */
@media (max-width: 768px) {
    .sidebar {
        position: fixed;
        z-index: 1000;
        height: 100vh;
        transform: translateX(-100%);
        transition: transform 0.3s ease;
    }
    
    .sidebar.show {
        transform: translateX(0);
    }
    
    .main-content {
        margin-left: 0 !important;
    }
}
EOL

# theme.js
cat > "$THEME_DIR/theme.js" << 'EOL'
document.addEventListener('DOMContentLoaded', function() {
    // Toggle sidebar on mobile
    const sidebarToggle = document.querySelector('.sidebar-toggle');
    const sidebar = document.querySelector('.sidebar');
    
    if (sidebarToggle && sidebar) {
        sidebarToggle.addEventListener('click', function() {
            sidebar.classList.toggle('show');
        });
    }
    
    // Add animation to server cards
    const serverCards = document.querySelectorAll('.server-list-item');
    serverCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transition = 'transform 0.2s';
        });
    });
    
    // Improve dropdown menus
    const dropdownToggles = document.querySelectorAll('.dropdown-toggle');
    dropdownToggles.forEach(toggle => {
        toggle.addEventListener('click', function(e) {
            e.preventDefault();
            const dropdownMenu = this.nextElementSibling;
            dropdownMenu.classList.toggle('show');
        });
    });
    
    // Close dropdowns when clicking outside
    document.addEventListener('click', function(e) {
        if (!e.target.matches('.dropdown-toggle')) {
            const dropdowns = document.querySelectorAll('.dropdown-menu');
            dropdowns.forEach(dropdown => {
                if (dropdown.classList.contains('show')) {
                    dropdown.classList.remove('show');
                }
            });
        }
    });
});
EOL

# index.php
cat > "$THEME_DIR/index.php" << 'EOL'
<?php

return [
    'name' => 'CDX',
    'description' => 'Tema modern untuk Pterodactyl Panel dengan desain yang bersih dan responsif',
    'version' => '1.0.0',
    
    'author' => [
        'name' => 'AldiXDCodeX',
        'email' => 'admi@aldixdcode.con',
    ],
    
    'css' => [
        'theme.css',
    ],
    
    'js' => [
        'theme.js',
    ],
];
EOL

echo -e "${GREEN}File theme berhasil dibuat di $THEME_DIR${NC}"

# Set permissions
echo -e "${YELLOW}Mengatur permission...${NC}"
chown -R www-data:www-data "$THEME_DIR"
chmod -R 755 "$THEME_DIR"

# Clear cache
echo -e "${YELLOW}Membersihkan cache...${NC}"
sudo -u www-data php artisan view:clear
sudo -u www-data php artisan cache:clear

echo -e "${GREEN}Instalasi tema berhasil!${NC}"
echo -e "Silakan aktifkan tema melalui pengaturan panel Pterodactyl Anda"
echo -e "Path tema: $THEME_DIR"
