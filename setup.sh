#!/bin/bash
# setup.sh - Portable setup script for Webpage-VM-nginx
set -e

# Ensure script is run as root or with sudo
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Try: sudo bash $0" >&2
  exit 1
fi

# Update and upgrade system
apt update && apt upgrade -y

# Install required packages
apt install -y nginx nodejs npm

# Show node and npm versions
node -v
npm -v

# Clone the repository if not already present
if [ ! -d "/opt/Webpage-VM-nginx" ]; then
  git clone https://github.com/SysSyncer/Webpage-VM-nginx.git /opt/Webpage-VM-nginx
fi
cd /opt/Webpage-VM-nginx

# Install dependencies and build
npm install
npm run build

# Configure nginx
rm -f /etc/nginx/sites-enabled/default
cat >/etc/nginx/sites-available/Webpage-VM-nginx <<EOF
server {
    listen 80;
    listen [::]:80;
    root /opt/Webpage-VM-nginx/dist;
    index index.html index.htm;
    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

ln -s /etc/nginx/sites-available/Webpage-VM-nginx /etc/nginx/sites-enabled

# Test and restart nginx
nginx -t
systemctl restart nginx
systemctl enable nginx
systemctl status nginx --no-pager