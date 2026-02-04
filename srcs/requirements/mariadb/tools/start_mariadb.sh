#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

ROOT_PASS=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
USER_PASS=$(cat "$MYSQL_PASSWORD_FILE")

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo ">> Initialisation MariaDB"

  mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql

  mysqld_safe &
  until mysqladmin ping --silent; do
    sleep 1
  done

  mysql <<EOF

ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

DROP USER IF EXISTS '${MYSQL_USER}'@'%';
DROP USER IF EXISTS '${MYSQL_USER}'@'localhost';

CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${USER_PASS}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;


EOF

  mysqladmin shutdown
fi

echo ">> MariaDB prêt"
exec mysqld_safe --user=mysql --bind-address=0.0.0.0 \
--datadir=/var/lib/mysql


