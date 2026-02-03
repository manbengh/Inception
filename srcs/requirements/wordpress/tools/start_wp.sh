#!/bin/bash
set -e

DB_PASS=$(cat "$MYSQL_PASSWORD_FILE")
ADMIN_PASS=$(cat "$WP_ADMIN_PASSWORD_FILE")
USER_PASS=$(cat "$WP_USER_PASSWORD_FILE")

mkdir -p /run/php
cd /var/www/html

# Attendre MariaDB avant d'installer WordPress
until php -r "
\$mysqli = new mysqli('mariadb', '$MYSQL_USER', '$DB_PASS', '$MYSQL_DATABASE');
exit(\$mysqli->connect_errno);
"; do
    echo ">> En attente de MariaDB..."
    sleep 2
done

# Installer wp-config.php si absent
if [ ! -f wp-config.php ]; then
    echo ">> Configuration WordPress"

    wp config create \
        --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASS" \
        --dbhost="mariadb"

    wp core install \
        --allow-root \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL"

    wp user create \
        "$WP_USER" "$WP_USER_EMAIL" \
        --allow-root \
        --user_pass="$USER_PASS"
fi

echo ">> WordPress prêt"
exec php-fpm8.2 -F
