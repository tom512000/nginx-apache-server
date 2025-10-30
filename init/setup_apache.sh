#!/bin/bash
set -e

apt-get update -y && apt-get install -y apache2-utils openssl

bash /docker-entrypoint-init.d/generate_certs.sh

# Créer htpasswd s'il n'existe pas
if [ ! -f /etc/apache2/.htpasswd ]; then
    htpasswd -b -c /etc/apache2/.htpasswd user1 password123
fi

a2enmod rewrite headers ssl
a2ensite site1.conf site2.conf
a2dissite 000-default.conf || true

echo "✅ Apache prêt. Lancement du serveur..."
apache2-foreground
