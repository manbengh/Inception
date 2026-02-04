FROM debian:bookworm

# met a jour la liste des paquets
RUN apt update && apt install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# prepare le dossier necessaire pour MariaDB
#RUN mkdir -p /run/mysqld && chown -R mysql:mysql /var/run/mysqld

COPY tools/start_mariadb.sh /start_mariadb.sh

RUN chmod +x /start_mariadb.sh

#RUN printf "[mysqld]\nbind-address=0.0.0.0\nport=3306\n" \
   # > /etc/mysql/mariadb.conf.d/50-server.cnf


EXPOSE 3306

#USER mysql

CMD ["/start_mariadb.sh"]

