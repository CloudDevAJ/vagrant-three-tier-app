#!/bin/bash
set -e

echo "=== Installing Apache on Web VM ==="

apt-get update
apt-get install -y apache2

a2enmod proxy
a2enmod proxy_http

cat > /etc/apache2/sites-available/000-default.conf <<'EOF'
<VirtualHost *:80>
    ServerName web-server

    ProxyPreserveHost On

    ProxyPass / http://192.168.56.11:5000/
    ProxyPassReverse / http://192.168.56.11:5000/

    ErrorLog ${APACHE_LOG_DIR}/web-error.log
    CustomLog ${APACHE_LOG_DIR}/web-access.log combined
</VirtualHost>
EOF

systemctl enable apache2
systemctl restart apache2

echo "=== Web VM ready ==="