#!/bin/bash
set -e

CERT_DIR="/etc/ssl/site2"
OPENSSL_CONF="/etc/ssl/openssl.cnf"

# Fallback si le fichier n'existe pas
if [ ! -f "$OPENSSL_CONF" ]; then
  mkdir -p /etc/ssl
  echo "[ req ]
distinguished_name = req_distinguished_name
[ req_distinguished_name ]
" > "$OPENSSL_CONF"
fi

mkdir -p "$CERT_DIR"

if [ ! -f "$CERT_DIR/site2.crt" ] || [ ! -f "$CERT_DIR/site2.key" ]; then
  echo "🔐 Génération du certificat auto-signé pour site2.local..."
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -config "$OPENSSL_CONF" \
    -keyout "$CERT_DIR/site2.key" \
    -out "$CERT_DIR/site2.crt" \
    -subj "/C=FR/ST=France/L=Paris/O=Local/OU=Dev/CN=site2.local"
else
  echo "✅ Certificat déjà présent, aucune régénération nécessaire."
fi
