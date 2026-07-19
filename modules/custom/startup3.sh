#!/bin/bash
# Redirect all output (stdout & stderr) to a persistent log
exec > /var/log/startup-script.log 2>&1
#set -eux

# Update system
dnf -y update

# Install Apache web server
dnf -y install httpd

# Enable and start Apache service
systemctl enable --now httpd

# Open port 80 in firewall (for safety if firewalld is active)
if systemctl is-active --quiet firewalld; then
    firewall-cmd --permanent --add-service=http
    firewall-cmd --reload
fi

# Create a simple index.html
echo "apache web server installed and started in VM $(hostname) !!! by Ahilan S" > /var/www/html/index.html

# Confirm Apache is running
systemctl status httpd
