#!/bin/bash
set -e

apt-get update -y && apt-get install -y apache2-utils

# Créer htpasswd s'il n'existe pas
if [ ! -f /etc/apache2/.htpasswd ]; then
    htpasswd -b -c /etc/apache2/.htpasswd user1 password123
fi

# Activer modules et sites
a2enmod rewrite
a2ensite site1.conf site2.conf
a2dissite 000-default.conf || true

# Redémarrer Apache
apache2-foreground
