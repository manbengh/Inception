#!/bin/bash
set -e

# -------------------------------
# Script de démarrage MariaDB
# -------------------------------

# Variables par défaut si pas passées
: "${MYSQL_DATABASE:=wordpress}"
: "${MYSQL_USER:=wp_user}"
: "${MYSQL_PASSWORD:=wp_pass}"
: "${MYSQL_ROOT_PASSWORD:=root_pass}"

#  Préparer les dossiers nécessaires
mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

#  Initialiser la base si nécessaire
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo ">> Initialisation de MariaDB..."
    
    # Initialise la base sans mot de passe root
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql

    # Démarrage temporaire en arrière-plan
    mysqld --user=mysql --bind-address=0.0.0.0 &
    MARIADB_PID=$!

    # Attendre que MariaDB soit prêt
    until mysqladmin ping --silent; do
        echo ">> En attente que MariaDB démarre..."
        sleep 1
    done

    echo ">> Création de la base et des utilisateurs..."
    mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Arrêt propre du serveur temporaire
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
    wait $MARIADB_PID || true
fi

#  Lancement MariaDB en foreground
echo ">> MariaDB prêt, lancement en foreground..."
exec mysqld_safe --user=mysql --bind-address=0.0.0.0
