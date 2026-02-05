#!/bin/bash
set -e

cd /var/www/html/wordpress
mkdir -p /run/php

until mysqladmin ping -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
  echo "Waiting for MariaDB..."
  sleep 2
done

# force php-fpm à écouter sur TCP
sed -i "s|listen = .*|listen = 0.0.0.0:9000|g" /etc/php/8.2/fpm/pool.d/www.conf

if [ ! -f wp-config.php ]; then
  wp config create \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --allow-root

  wp core install \
    --url=https://manbengh.42.fr \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root

  wp user create "$WP_USER" "$WP_USER_EMAIL" \
    --user_pass="$WP_USER_PASSWORD" \
    --allow-root
fi

# Ajuster les permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

exec php-fpm8.2 -F 