#!/bin/bash
set -e

ROOT_PASS=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
USER_PASS=$(cat "$MYSQL_PASSWORD_FILE")

mysqld_safe &
until mysqladmin ping --silent; do
    sleep 1
done

DB_EXISTS=$(mysql -u root -e "SHOW DATABASES LIKE '${MYSQL_DATABASE}';" | grep ${MYSQL_DATABASE} || true)

if [ -z "$DB_EXISTS" ]; then
    echo ">> Initialisation de la base ${MYSQL_DATABASE}"

    mysql -u root <<EOF
ALTER USER 'root'@'localhost'
IDENTIFIED BY '${ROOT_PASS}';

CREATE DATABASE ${MYSQL_DATABASE};

CREATE USER '${MYSQL_USER}'@'%'
IDENTIFIED BY '${USER_PASS}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
fi

wait
