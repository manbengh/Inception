#!/bin/bash
set -e

SSL_DIR="/etc/nginx/ssl"

if [ ! -f "$SSL_DIR/server.crt" ]; then
  openssl req -x509 -nodes -days 365 \
    -newkey rsa:4096 \
    -keyout "$SSL_DIR/server.key" \
    -out "$SSL_DIR/server.crt" \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=manbengh.42.fr"
fi

# until getent hosts wordpress; do
#   echo ">> En attente de WordPress..."
#   sleep 1
# done


exec nginx -g "daemon off;"