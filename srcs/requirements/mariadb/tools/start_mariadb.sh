#!/bin/bash
set -e

ROOT_PASS=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
USER_PASS=$(cat "$MYSQL_PASSWORD_FILE")

# Initialisation UNIQUEMENT si la base n'existe pas
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo ">> Initialisation de MariaDB"

    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    mysqld_safe &
    until mysqladmin ping --silent; do
        sleep 1
    done

    mysql -u root <<EOF
ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password BY '${ROOT_PASS}';

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%'
IDENTIFIED BY '${USER_PASS}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    mysqladmin -u root -p"${ROOT_PASS}" shutdown
fi

echo ">> MariaDB prêt"
exec mysqld_safe
