#!/bin/bash
set -e

apt-get update -y && apt-get install -y apache2-utils

if [ ! -f /etc/nginx/.htpasswd ]; then
    htpasswd -b -c /etc/nginx/.htpasswd user1 password123
fi

nginx -t
nginx -g "daemon off;"
