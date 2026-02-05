#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialiser si data dir vide
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo ">> Initialisation MariaDB data dir"
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Lancer MariaDB en background
mysqld --user=mysql --bind-address=0.0.0.0 &

# Attendre qu'il soit prêt
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Init DB + user
echo ">> Initialisation SQL"

mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo ">> MariaDB prêt"

# garder process principal
wait
