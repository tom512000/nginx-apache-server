#!/bin/bash
set -e

apt-get update -y && apt-get install -y apache2-utils openssl

bash /docker-entrypoint-init.d/generate_certs.sh

# Créer htpasswd s'il n'existe pas
if [ ! -f /etc/apache2/.htpasswd ]; then
    htpasswd -b -c /etc/apache2/.htpasswd user1 password123
fi

a2enmod rewrite headers ssl proxy proxy_http proxy_balancer lbmethod_byrequests cache cache_disk deflate

# désactiver d'abord les sites pour garantir un état propre
for s in 000-default.conf site1.conf site2.conf; do
    a2dissite "$s" >/dev/null 2>&1 || true
done

# activer dans l'ordre souhaité (000-default en priorité)
a2ensite 000-default.conf
a2ensite site1.conf
a2ensite site2.conf

# vérifier la configuration avant démarrage
apache2ctl configtest

echo "✅ Apache prêt. Lancement du serveur..."
apache2-foreground
